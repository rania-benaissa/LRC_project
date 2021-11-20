
/*  ---- PARTIE 2 ---- */




/* NEGATION DE CONCEPTS */

nnf(not(and(C1,C2)),or(NC1,NC2)):- nnf(not(C1),NC1), nnf(not(C2),NC2),!.
nnf(not(or(C1,C2)),and(NC1,NC2)):- nnf(not(C1),NC1), nnf(not(C2),NC2),!.
nnf(not(all(R,C)),some(R,NC)) :- nnf(not(C),NC),!.
nnf(not(some(R,C)),all(R,NC)):- nnf(not(C),NC),!.
nnf(not(not(X)),X):-!.
nnf(not(X),not(X)):-!.
nnf(and(C1,C2),and(NC1,NC2)):- nnf(C1,NC1),nnf(C2,NC2),!.
nnf(or(C1,C2),or(NC1,NC2)):- nnf(C1,NC1), nnf(C2,NC2),!.
nnf(some(R,C),some(R,NC)):- nnf(C,NC),!.
nnf(all(R,C),all(R,NC)) :- nnf(C,NC),!.
nnf(X,X).


/* Verifier si instance existe idf */
instance(Instance) :- not(var(Instance)), setof(X,iname(X),L), member(Instance,L).

/* Verifier si un role existe*/
role(Role) :-  setof(X,rname(X),L), member(Role,L).

/* Verifier si un concept est correct grammaticalement et syntaxiquement*/

is_concept_atom(Concept) :- setof(X,cnamea(X),L), member(Concept,L).
is_concept_gen(Concept) :- setof(X,cnamena(X),L), member(Concept,L).

concept(Concept) :-  is_concept_atom(Concept).
concept(Concept) :- is_concept_gen(Concept).
concept(not(Concept)) :- concept(Concept).
concept(and(Concept1,Concept2)) :- concept(Concept1), concept(Concept2).
concept(or(Concept1,Concept2)) :- concept(Concept1), concept(Concept2).
concept(all(role(_),Concept)) :- concept(Concept).
concept(some(role(_),Concept)):- concept(Concept).


/* verifier si les propositions sont correctes */
is_correct_pro1(Instance,Concept) :- instance(Instance), concept(Concept).

/*tranformer un concept complexe avec sa definition */

transform_concept(_,Concept,Concept) :-  is_concept_atom(Concept).
transform_concept(Tbox,Concept,X) :- is_concept_gen(Concept), member((Concept,X),Tbox).
transform_concept(Tbox,not(Concept),not(X)) :- transform_concept(Tbox,Concept,X).
transform_concept(Tbox,and(Concept1,Concept2),and(X1,X2)) :- transform_concept(Tbox,Concept1,X1), transform_concept(Tbox,Concept2,X2).
transform_concept(Tbox,or(Concept1,Concept2),or(X1,X2)) :- transform_concept(Tbox,Concept1,X1), transform_concept(Tbox,Concept2,X2).
transform_concept(Tbox,all(role(_),Concept),all(role(_),X)) :- transform_concept(Tbox,Concept,X).
transform_concept(Tbox,some(role(_),Concept),some(role(_),X)) :- transform_concept(Tbox,Concept,X).



/* On demande a l utilisateur la proposition de type : I:C */
demander_proposition1(Instance,Concept) :-
        write('Entrez l"instance :'),nl, 
        read(Instance),nl,
        write('Entrez le concept :'),nl, 
        read(Concept).

acquisition_prop_type1(Abi,Abi1,Tbox) :- demander_proposition1(Instance,Concept),
                        is_correct_pro1(Instance,Concept),
                        transform_concept(Tbox,Concept,Prop_atomique),
                        nnf(not(Prop_atomique),Negation),
                        concat(Abi,[(Instance,Negation)],Abi1).



suite(1,Abi,Abi1,Tbox) :- acquisition_prop_type1(Abi,Abi1,Tbox),!.
/*suite(2,Abi,Abi1,Tbox) :- acquisition_prop_type2(Abi,Abi1,Tbox),!.
suite(R,Abi,Abi1,Tbox) :- nl,write('Cette reponse est incorrecte.'),nl,
saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox).*/

/* nl = new line, Abi1 = instances maj */

saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox) :-
nl,write('Entrez le numero du type de proposition que vous voulez demontrer :'),nl,
write('1 - Une instance donnee appartient a un concept donne.'),nl,
write('2 - Deux concepts n\'ont pas d\'elements en commun.'),nl, read(R), suite(R,Abi,Abi1,Tbox).




deuxieme_etape(Abi,Abi1,Tbox) :- saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox).
