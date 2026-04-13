% Author: Iker Gutierrez Fandiño.
% Exercise 2: Obtain the logical formula from a sentence
% --------------------------------------------------------------

:- discontiguous s/6.
:- discontiguous s/4.

:-consult('prolog/wn_s.pl').

sentence(LF) --> noun_phrase(Subj), verb_phrase(Verb, Obj), {LF =.. [Verb, Subj, Obj]}.
noun_phrase(Word) --> det, noun(Word).
verb_phrase(Verb, Noun) --> verb(Verb), noun_phrase(Noun).


det --> [a].
det --> [the].
noun(Word) --> [Word], { s(_, _, Word, n, _, _) }.
verb(Word) --> [Word], { s(_, _, Word, v, _, _) }.

% --------------------------------------------------------------
% QUERY RESULTS:
% 102 ?- sentence(LF, [the,rabbit,eat,a,carrot], []).
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% LF = eat(rabbit, carrot) ;
% (...)

% 103 ?- sentence(LF, [the,eat,rabbit,a,carrot], []).
% false.

% 104 ?- sentence(LF, [the,rabbit,eats,a,carrot], []).
% false.

% --------------------------------------------------------------
% Query 104 is false because this grammar is not sensitive to verbal inflection ("eat-s").