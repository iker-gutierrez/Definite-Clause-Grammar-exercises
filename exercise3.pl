% Author: Iker Gutierrez Fandiño.
% Exercise 3. Answer commonsense questions (syntagmatic relations). 
% --------------------------------------------------------------

% To avoid warnings:
:- discontiguous s/4.
:- discontiguous s/6.

% Required for distinct/2:
:- use_module(library(solution_sequences)).

% Consult the relevant WordNet file:
:- consult('prolog/wn_sk_syntagmatic.pl'). % The "wn_sk_syntagmatic.pl" file has been obtained by preprocessing the "wn_sk.pl" file through the "wn_sk.py" script.

% 1. To allow verbal inflection (3rd person singular "-s"):
m(eats, eat). 
m(reads, read). 
m(W, W).

% 2. Interaction Rules: can_interact(VCat, SCat, OCat)
can_interact(34, SCat, 13) :- member(SCat, [5, 18]). % eat: [Animal/Person] + Food
can_interact(31, 18, OCat) :- member(OCat, [10, 6]). % read (verb.cognition): Person + [Communicative content/Artifact]
can_interact(32, 18, OCat) :- member(OCat, [10, 6]). % read (verb.communication): Person + [Communicative content/Artifact]

% 3. Main Sentence Predicate (uses distinct/2 to only succeed once for every unique category combination):
sentence(Words, []) :-
    distinct((S, V, O), phrase(sentence_dcg(S, V, O), Words)).

% 4. DCG Rules
sentence_dcg(SCat, VCat, OCat) --> 
    noun_phrase(SCat), 
    verb_phrase(SCat, VCat, OCat).

noun_phrase(Cat) --> 
    [Det], [Noun], 
    { member(Det, [a, an, the]), sk(_, _, Noun, 1, Cat, _) }.

verb_phrase(SCat, VCat, OCat) --> 
    [Verb], noun_phrase(OCat), 
    { m(Verb, VBase), 
      sk(_, _, VBase, 2, VCat, _), 
      can_interact(VCat, SCat, OCat) }.

% 5. Logic for the Explain Function (pulls categories without checking interaction first, so we can detect failures):
sentence_logic(SCat, VCat, OCat) --> 
    [DetS], [Subj], { member(DetS, [a, an, the]), sk(_, _, Subj, 1, SCat, _) },
    [Verb], { m(Verb, VBase), sk(_, _, VBase, 2, VCat, _) },
    [DetO], [Obj], { member(DetO, [a, an, the]), sk(_, _, Obj, 1, OCat, _) }.

% 6. EXTENSION: Explain results (by showing valid/invalid interactions).
explain(Words) :-
    % Case 1: The sentence is valid
    setof((S, V, O), (phrase(sentence_logic(S, V, O), Words), can_interact(V, S, O)), Results),
    !,
    print_results('VALID INTERACTION', Results).

explain(Words) :-
    % Case 2: The sentence is invalid (Integrated your requested logic)
    setof((S, V, O), (phrase(sentence_logic(S, V, O), Words), \+ can_interact(V, S, O)), Results),
    !,
    print_results('INVALID INTERACTION', Results).

explain(_) :- 
    % Case 3: OoV words or incorrect structure.
    write('ERROR: Unknown words or structure.'), nl.

% Helper function to print unique results.
print_results(_, []).
print_results(Prefix, [(S,V,O)|T]) :-
    format('~w: Subj(Cat ~w) + Verb(Cat ~w) + Obj(Cat ~w).~n', [Prefix, S, V, O]),
    print_results(Prefix, T).
