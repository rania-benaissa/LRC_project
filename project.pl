/* including files */

:- [base].
:- [part1].
/************* PROJECT *************/

/*  ---- PARTIE 2 ---- */

/*deuxieme_etape(Abi,Abil,Tbox) :- saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox).*/

/* nl = new line, Abi1 = instances maj */

/*saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox) :-
nl,write('Entrez le numero du type de proposition que vous voulez demontrer :'),nl,
write('1 Une instance donnee appartient a un concept donne.'),nl,
write('2 Deux concepts n"ont pas d"elements en commun(ils ont une
intersection vide).'),nl, read(R), suite(R,Nca,Ni,Nr,Abi,Abi1,Tbox,Lcc).


suite(1,Abi,Abi1,Tbox) :-
acquisition_prop_type1(Abi,Abi1,Tbox),!.

suite(2,Abi,Abi1,Tbox) :-
acquisition_prop_type2(Abi,Abi1,Tbox),!.

suite(R,Abi,Abi1,Tbox) :-
nl,write('Cette reponse est incorrecte. Veuillez reessayer.'),nl,
saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox).*/


/* Verifier si instance existe idf */

instance(Instance):-  setof(X,iname(X),L), member(Instance,L).

/* Verifier si un role existe*/
role(Role):-  setof(X,rname(X),L), member(Role,L).

/* Verifier si un concept est correct grammaticalement et syntaxiquement*/
concept(Concept) :- setof(X,cnamea(X),L), member(Concept,L).
concept(Concept) :- setof(X,cnamena(X),L), member(Concept,L).

concept(not(Concept)) :- concept(Concept).
concept(and(Concept1,Concept2)):- concept(Concept1), concept(Concept2).
concept(or(Concept1,Concept2)):- concept(Concept1), concept(Concept2).
concept(all(role(_),Concept)) :- concept(Concept).
concept(some(role(_),Concept)):- concept(Concept).

/*
demander_proposition1(Instance,Concept) :-
nl,write('Entrez l"identificateur de l"instance :'),nl, read(instance),nl,

write('Entrez le concept'),nl, read(concept),concept(concept),transform(concept,).
*/

/*suite(R,Nca,Ni,Nr,Abi,Abi1,Tbox,Lcc) :- suite(1,Abi,Abi1,Tbox),demander_proposition1(i,c).
suite(R,Nca,Ni,Nr,Abi,Abi1,Tbox,Lcc) :- suite(2,Abi,Abi1,Tbox).
suite(R,Nca,Ni,Nr,Abi,Abi1,Tbox,Lcc) :- suite(R,Abi,Abi1,Tbox).*/





/* ----FINAL PROG---- */
/*program :- premiere_etape(Tbox,Abi,Abr), deuxieme_etape(Abi,Abil,Tbox).*/