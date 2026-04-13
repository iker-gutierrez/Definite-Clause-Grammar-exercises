% Author: Iker Gutierrez Fandiño.
% Exercise 4: Answer simple commonsense questions (paradigmatic relations).
% --------------------------------------------------------------

% To avoid warnings:
:- discontiguous s/4.
:- discontiguous s/6.

% Consult relevant WordNet files:
:- consult('prolog/wn_s.pl'). % Synsets
:- consult('prolog/wn_hyp.pl'). % Hyponymy/Hypernymy
:- consult('prolog/wn_mm.pl'). % Member meronymy (e.g., a "leaf" is member of a "tree")
:- consult('prolog/wn_ms.pl'). % Substance meronymy (e.g., "oxygen" is substance of "water")
:- consult('prolog/wn_mp.pl'). % Part meronymy (e.g., a "wheel" is part of a "car")

% Sentence logic
sentence([_Det1, Subj, is, _Det2, Obj], []) :-
    word_to_synset(Subj, SubjID),
    word_to_synset(Obj, ObjID),
    is_a(SubjID, ObjID).

sentence([_Det1, Subj, has | ObjList], []) :-
    word_to_synset(Subj, SubjID),
    extract_noun(ObjList, Obj),
    word_to_synset(Obj, ObjID),
    has_part(SubjID, ObjID).

% Transitive relation with Hypernyms:
is_a(S, P) :- hyp(S, P).
is_a(S, P) :- hyp(S, I), is_a(I, P).

% Transitive relation with Meronyms:
has_part(S, P) :- check_meronym(P, S).
has_part(S, P) :- check_meronym(I, S), has_part(I, P). 
has_part(S, S). 

check_meronym(Part, Whole) :- 
    mm(Part, Whole) ;  % Member meronym
    ms(Part, Whole) ;  % Substance meronym 
    mp(Part, Whole).   % Part meronym 

extract_noun([Det, Noun], Noun) :- member(Det, [a, an, the]), !.
extract_noun([Noun], Noun).

% Considers Singular and Plural nouns:
word_to_synset(Word, ID) :- 
    s(ID, _, Word, n, _, _).
word_to_synset(Plural, ID) :- 
    atom_concat(Singular, s, Plural), 
    s(ID, _, Singular, n, _, _).
