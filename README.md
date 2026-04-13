# Definite-Clause-Grammar exercises

## Exercise 1: Integrate the WordNet lexicon in some of the example grammars.

### 1.1. Description
In this exercise, a Definite Clause Grammar (DCG) is extended by integrating lexical information from WordNet. The grammar accepts simple sentences of the form Determiner + Noun + Verb + Determiner + Noun. WordNet provides semantic categories for nouns, allowing the grammar to produce several possible noun combinations based on the lexical hierarchy. The queries test both sentence generation (e.g. query 102) and sentence validation (e.g. queries 103-104).

### 1.2. Query results

102 ?- sentence(X,[]).
X = [a, entity, breathe, a, entity] ;
X = [a, entity, breathe, a, 'physical entity'] ;
X = [a, entity, breathe, a, abstraction] ;
X = [a, entity, breathe, a, 'abstract entity'] ;
X = [a, entity, breathe, a, thing] ;
X = [a, entity, breathe, a, object] ;
X = [a, entity, breathe, a, 'physical object'] ;
X = [a, entity, breathe, a, whole] 
(...)

103 ?- sentence([the, eat, sheep, a, banana], []).
false.

104 ?- sentence([the, sheep, eat, a, banana], []).
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
(...)


## Exercise 2: Obtain the logical formula from a sentence.

### 2.1. Description
In this exercise, the DCG is extended to compute a logical form (LF) representing the semantic interpretation of a sentence. The grammar parses a sentence and returns a predicate structure in which the verb becomes the predicate and the subject and object become its arguments. Thus, a sentence such as `the rabbit eat a carrot` is mapped to the logical representation `eat(rabbit, carrot)`. The queries test whether the grammar correctly derives this logical form and rejects ill-formed sentences.


### 2.2. Query results
102 ?- sentence(LF, [the,rabbit,eat,a,carrot], []).
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
LF = eat(rabbit, carrot) ;
(...)

103 ?- sentence(LF, [the,eat,rabbit,a,carrot], []).
false.

104 ?- sentence(LF, [the,rabbit,eats,a,carrot], []).
false.

--------------------------------------------------------------
Query 104 is false because this grammar is not sensitive to verbal inflection ("eat-s").

## Exercise 3. Answer commonsense questions (syntagmatic relations). 

### 3.1. Description
Syntagmatic relations refer to the horizontal, combinatory relations between words in a sentence. In this exercise, the sentences are based on selectional restrictions imposed by the verb, which determine the semantic compatibility between the subject and the object. Each verb encodes expectations about the type of entities that can participate in the event it describes. Hence:
- With the verb "eats": the subject must be animate, the object must be edible.
- With the verb "reads":the subject must be human, the object must be readable.
These restrictions are implemented through semantic categories (Cat) associated with different word senses. The system checks all possible combinations of subject, verb, and object senses and verifies whether their semantic categories satisfy the restrictions required by the verb.

In sum, a sentence is considered well-formed only if at least one combination of word senses satisfies these selectional preferences.

### 3.2. Querying methodology
The following Prolog queries were used in order to test that the implemented predicates work as expected:

sentence([a,monkey,eats,a,banana], []).
explain([a,monkey,eats,a,banana]).

sentence([a,monkey,eats,a,book], []).
explain([a,monkey,eats,a,book]).

sentence([a,doctor,reads,a,book], []).
explain([a,doctor,reads,a,book]).

sentence([a,doctor,reads,a,banana], []).
explain([a,doctor,reads,a,banana]).

The “explain” predicate works as follows:
If the sentence is well-formed: it returns all valid interactions of word senses in the sentence.
If the sentence is not well-formed: it returns all invalid interactions of word senses in the sentence. Thus, it justifies the ill-formedness of the sentence by showing that all word sense interactions were checked and none is valid.

### 3.3. Query results
These are the query results:

101 ?- consult(['/Users/ikerguti/Desktop/comp_sem_part2/exercise3.pl']).
true.

102 ?- sentence([a,monkey,eats,a,banana], []).
true ;
true ;
false.

103 ?- explain([a,monkey,eats,a,banana]).
VALID INTERACTION: Subj(Cat 5) + Verb(Cat 34) + Obj(Cat 13).
VALID INTERACTION: Subj(Cat 18) + Verb(Cat 34) + Obj(Cat 13).
true.

104 ?- sentence([a,monkey,eats,a,book], []).
false.

105 ?- explain([a,monkey,eats,a,book]).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 30) + Obj(Cat 6).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 30) + Obj(Cat 10).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 30) + Obj(Cat 14).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 30) + Obj(Cat 21).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 34) + Obj(Cat 6).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 34) + Obj(Cat 10).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 34) + Obj(Cat 14).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 34) + Obj(Cat 21).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 37) + Obj(Cat 6).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 37) + Obj(Cat 10).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 37) + Obj(Cat 14).
INVALID INTERACTION: Subj(Cat 5) + Verb(Cat 37) + Obj(Cat 21).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 30) + Obj(Cat 6).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 30) + Obj(Cat 10).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 30) + Obj(Cat 14).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 30) + Obj(Cat 21).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 34) + Obj(Cat 6).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 34) + Obj(Cat 10).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 34) + Obj(Cat 14).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 34) + Obj(Cat 21).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 37) + Obj(Cat 6).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 37) + Obj(Cat 10).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 37) + Obj(Cat 14).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 37) + Obj(Cat 21).
true.

106 ?- sentence([a,doctor,reads,a,book], []).
true ;
true ;
true ;
true ;
false.

107 ?- explain([a,doctor,reads,a,book]).
VALID INTERACTION: Subj(Cat 18) + Verb(Cat 31) + Obj(Cat 6).
VALID INTERACTION: Subj(Cat 18) + Verb(Cat 31) + Obj(Cat 10).
VALID INTERACTION: Subj(Cat 18) + Verb(Cat 32) + Obj(Cat 6).
VALID INTERACTION: Subj(Cat 18) + Verb(Cat 32) + Obj(Cat 10).
true.

108 ?- sentence([a,doctor,reads,a,banana], []).
false.

109 ?- explain([a,doctor,reads,a,banana]).
INVALID INTERACTION: Subj(Cat 4) + Verb(Cat 31) + Obj(Cat 13).
INVALID INTERACTION: Subj(Cat 4) + Verb(Cat 31) + Obj(Cat 20).
INVALID INTERACTION: Subj(Cat 4) + Verb(Cat 32) + Obj(Cat 13).
INVALID INTERACTION: Subj(Cat 4) + Verb(Cat 32) + Obj(Cat 20).
INVALID INTERACTION: Subj(Cat 4) + Verb(Cat 36) + Obj(Cat 13).
INVALID INTERACTION: Subj(Cat 4) + Verb(Cat 36) + Obj(Cat 20).
INVALID INTERACTION: Subj(Cat 4) + Verb(Cat 42) + Obj(Cat 13).
INVALID INTERACTION: Subj(Cat 4) + Verb(Cat 42) + Obj(Cat 20).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 31) + Obj(Cat 13).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 31) + Obj(Cat 20).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 32) + Obj(Cat 13).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 32) + Obj(Cat 20).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 36) + Obj(Cat 13).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 36) + Obj(Cat 20).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 42) + Obj(Cat 13).
INVALID INTERACTION: Subj(Cat 18) + Verb(Cat 42) + Obj(Cat 20).
true.

### 3.4. Conclusion
The implemented “sentence” predicate has returned the expected answers for the queries:

sentence([a,monkey,eats,a,banana], []). → true.
sentence([a,monkey,eats,a,book], []). → false.
sentence([a,doctor,reads,a,book], []). → true.
sentence([a,doctor,reads,a,banana], []). → false.

Regarding the “explain” predicate, it returns the same number of valid interactions as the “sentence” predicate, suggesting that it is working properly:

sentence([a,monkey,eats,a,banana], []). → 2.
explain([a,monkey,eats,a,banana]). → 2.

sentence([a,doctor,reads,a,book], []). → 4.
explain([a,doctor,reads,a,book]). → 4.

Regarding invalid interactions, the “explain” predicate seems to check all possible interactions, but in this case we cannot do the numerical checking of results, because the “sentence” predicate stops when it returns a “false” (it does not return a “false” for every invalid interaction).

## Exercise 4: Answer simple commonsense questions (paradigmatic relations).

### 4.1. Description
Paradigmatic relations refer to the vertical, substitutionary relationship between words that belong to the same category and therefore can replace one another in similar contexts, such as class-subclass or part-whole relations. In this exercise, the system enforces selectional restrictions by mapping verbs to specific WordNet semantic relations. Hence:
- The verb "be": requires a valid class-membership relation (hypernymy), checked through hyp/2 via is_a/2.
- The verb "have": requires a part–whole relation (meronymy), checked through mm/2, ms/2, or mp/2 via has_part/2.
In sum, validity depends on the verb’s paradigmatic type and whether the corresponding paradigmatic relation holds between the arguments.

### 4.2. Querying methodology
The following Prolog queries were used in order to test that the implemented prolog script works as expected:

sentence([an,apple,is,a,fruit], []).
sentence([an,apple,is,an,animal], []).
sentence([an,apple,has,apples], []).
sentence([an,apple,has,fingers], []).
sentence([a,human,has,fingers], []).

### 4.3. Query results
These are the query results:

102 ?- sentence([an,apple,is,a,fruit], []).
true ;
true ;
false.

103 ?- sentence([an,apple,is,an,animal], []).
false.


104 ?- sentence([an,apple,has,apples], []).
true ;
true ;
true ;
true ;
false.

105 ?- sentence([an,apple,has,fingers], []).
false.

106 ?- sentence([a,human,has,fingers], []).
true ;
true ;
true ;
true ;
false.

### 4.4. Conclusion
The implemented prolog script has returned the expected answers for the queries:

sentence([an,apple,is,a,fruit], []). → true.
sentence([an,apple,is,an,animal], []). → false.
sentence([an,apple,has,apples], []). → true.
sentence([an,apple,has,fingers], []). → false.
sentence([a,human,has,fingers], []). → true.



