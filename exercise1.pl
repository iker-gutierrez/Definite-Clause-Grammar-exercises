% Author: Iker Gutierrez Fandiño.
% Exercise 1: Integrate the WordNet lexicon in some of the example grammars.
% --------------------------------------------------------------

:- discontiguous s/6.
:- discontiguous s/4.

:-consult('prolog/wn_s.pl').

sentence --> noun_phrase, verb_phrase.
noun_phrase --> det, noun.
verb_phrase --> verb, noun_phrase.

det --> [a].
det --> [the].
noun --> [Word], { s(_, _, Word, n, _, _) }.
verb --> [Word], { s(_, _, Word, v, _, _) }.


% --------------------------------------------------------------
% QUERY RESULTS:

% 102 ?- sentence(X,[]).
% X = [a, entity, breathe, a, entity] ;
% X = [a, entity, breathe, a, 'physical entity'] ;
% X = [a, entity, breathe, a, abstraction] ;
% X = [a, entity, breathe, a, 'abstract entity'] ;
% X = [a, entity, breathe, a, thing] ;
% X = [a, entity, breathe, a, object] ;
% X = [a, entity, breathe, a, 'physical object'] ;
% X = [a, entity, breathe, a, whole] 
% (...)

% 103 ?- sentence([the, eat, sheep, a, banana], []).
% false.

% 104 ?- sentence([the, sheep, eat, a, banana], []).
% true ;
% true ;
% true ;
% true ;
% true ;
% true ;
% true ;
% true ;
% true ;
% true ;
% true ;
% true ;
% true ;
% (...)
