/* je met chaque element de ABI dans la bonne liste */

tri_Abox([],[],[],[],[],[]).

tri_Abox([(I,some(R,C))|Q],[(I,some(R,C))|Lie],Lpt,Li,Lu,Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,all(R,C))|Q],Lie,[(I,all(R,C))|Lpt],Li,Lu,Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,and(C1,C2))|Q],Lie,Lpt,[(I,and(C1,C2))|Li],Lu,Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,or(C1,C2))|Q],Lie,Lpt,Li,[(I,or(C1,C2))|Lu],Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,C)|Q],Lie,Lpt,Li,Lu,[(I,C)|Ls]) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,not(C))|Q],Lie,Lpt,Li,Lu,[(I,not(C))|Ls]) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).



/* affiche l evolution d'une d'un etat */

affiche_evolution_Abox(Ls1, Lie1, Lpt1, Li1, Lu1, Abr1, Ls2, Lie2,
Lpt2, Li2, Lu2, Abr2) :-

    write("Etat de depart"),nl,


    write("Etat de d'arrivée "),nl,




/* je parcours toutes les listes si y a aucun clash -> return true else false*/
test_clash([]).
test_clash([T|Q]):- not(member(not(T),Q)), test_clash(Q).



/* rajoute la nouvelle assertion a la liste adequate seulement si elle n'y 
existe pas deja */
add_new_element(X,L1,L2) :- not(member(X,L1)), concat([X],L1,L2).
add_new_element(X,L1,L2) :- member(X,L1), concat([],L1,L2).


get_all_new_elts(_,[],[]).
get_all_new_elts((I,all(R,C)),[(I1,I2,R1)|Q],[(I2,C)|New]) :- I == I1, R == R1, get_all_new_elts((I,all(R,C)),Q, New).
get_all_new_elts((I,all(R,C)),[_|Q],New) :- get_all_new_elts((I,all(R,C)),Q, New).


/* Ajoute la nouvelle assertion de concepts a la bonne liste */

evolue((I,some(R,C)), Lie, Lpt, Li, Lu, Ls, Lie1, Lpt1, Li1, Lu1, Ls1) :-

    add_new_element((I,some(R,C)),Lie,Lie1),
    concat([],Lpt,Lpt1),
    concat([],Li,Li1),
    concat([],Lu,Lu1),
    concat([],Ls,Ls1)
.

evolue((I,all(R,C)), Lie, Lpt, Li, Lu, Ls, Lie1, Lpt1, Li1, Lu1, Ls1) :-

    concat([],Lie,Lie1),
    add_new_element((I,all(R,C)),Lpt,Lpt1),
    concat([],Li,Li1),
    concat([],Lu,Lu1),
    concat([],Ls,Ls1)
.

evolue((I,and(C1,C2)), Lie, Lpt, Li, Lu, Ls, Lie1, Lpt1, Li1, Lu1, Ls1) :-

    concat([],Lie,Lie1),
    concat([],Lpt,Lpt1),
    add_new_element((I,and(C1,C2)),Li,Li1),
    concat([],Lu,Lu1),
    concat([],Ls,Ls1)
.

evolue((I,or(C1,C2)), Lie, Lpt, Li, Lu, Ls, Lie1, Lpt1, Li1, Lu1, Ls1) :-

    concat([],Lie,Lie1),
    concat([],Lpt,Lpt1),
    concat([],Li,Li1),
    add_new_element((I,or(C1,C2)),Lu,Lu1),
    concat([],Ls,Ls1)
.


evolue((I,not(C)), Lie, Lpt, Li, Lu, Ls, Lie1, Lpt1, Li1, Lu1, Ls1) :-

    concat([],Lie,Lie1),
    concat([],Lpt,Lpt1),
    concat([],Li,Li1),
    concat([],Lu,Lu1),
    add_new_element((I,not(C)),Ls,Ls1)
.

evolue((I,C), Lie, Lpt, Li, Lu, Ls, Lie1, Lpt1, Li1, Lu1, Ls1) :-

    concat([],Lie,Lie1),
    concat([],Lpt,Lpt1),
    concat([],Li,Li1),
    concat([],Lu,Lu1),
    add_new_element((I,C),Ls,Ls1)
.



/* Ajoute une liste de parcours la liste des nouvelles assertions
de concepts et les ajoute a la bonne liste */


evolue_all([],Lie, Lpt, Li, Lu, Ls,Lie, Lpt, Li, Lu, Ls).

evolue_all([T|Q], Lie, Lpt, Li, Lu, Ls, Lie1, Lpt1, Li1, Lu1, Ls1) :-

evolue(T, Lie, Lpt, Li, Lu, Ls, Lie2, Lpt2, Li2, Lu2, Ls2),

evolue_all(Q, Lie2, Lpt2, Li2, Lu2, Ls2, Lie1, Lpt1, Li1, Lu1, Ls1).


/* Application de la regle d'il existe */

complete_some(Lie,Lpt,Li,Lu,Ls,Abr) :-
            
    /* enleve la tete de liste de Lie*/
    enleve((I,some(R,C)),Lie,Q),

    /* ajout de des nouvelles assertions de concepts*/

    genere(B), 

    evolue((B,C), Q, Lpt, Li, Lu, Ls, Lie1, Lpt1, Li1, Lu1, Ls1),

    /* ajout de des nouvelles assertions de roles */
    concat([(I,B,R)],Abr,Abr1), 

    /* je met toutes les listes ensemble */
    flatten([Lie1, Lpt1, Li1, Lu1, Ls1,Abr1],Y),

    /* test de clash */
    test_clash(Y),
    write("resolution part"),
    
    resolution(Lie1,Lpt1,Li1,Lu1,Ls1,Abr1),nl,
    write(Lie1),nl,
    write(Lpt1),nl,
    write(Li1),nl,
    write(Lu1),nl,
    write(Ls1),nl,
    write(Abr1),nl
.

/* Application de la regle de qlq soit */
deduction_all(Lie,Lpt,Li,Lu,Ls,Abr) :- 
            
    /* enleve la tete de liste de Lpt */
    enleve((I,all(R,C)),Lpt,Q),

    /* reecupere toutes les assertions I2 : C possibles */
    get_all_new_elts((I,all(R,C)),Abr,New_assertions),

    evolue_all(New_assertions, Lie, Q, Li, Lu, Ls, Lie1, Lpt1, Li1, Lu1, Ls1),

    /* je met toutes les listes ensemble */
    flatten([Lie1, Lpt1, Li1, Lu1, Ls1],Y),


    /* test de clash */
    test_clash(Y),

    write("resolution part"),
    
    resolution(Lie1,Lpt1,Li1,Lu1,Ls1,Abr),nl,
    write(Lie1),nl,
    write(Lpt1),nl,
    write(Li1),nl,
    write(Lu1),nl,
    write(Ls1),nl,
    write(Abr),nl
.


/* transformation ET */
transformation_and(Lie,Lpt,Li,Lu,Ls,Abr) :- 
    /* enleve la tete de liste de Li et retourne le reste de la liste dans Q*/
    enleve((I,and(C1,C2)),Li,Q),

    /* ajout de des nouvelles assertions SI elles existent */
    evolue((I,C1), Lie, Lpt, Q, Lu, Ls, Lie1, Lpt1, Li1, Lu1, Ls1),
    evolue((I,C2), Lie1, Lpt1, Li1, Lu1, Ls1, Lie2, Lpt2, Li2, Lu2, Ls2),
    
    /* test de clash */
    flatten([Lie2, Lpt2, Li2, Lu2, Ls2],Y),
    test_clash(Y),
    write("resolution part"),
    
    resolution(Lie2,Lpt2,Li2,Lu2,Ls2,Abr),nl,
    write(Lie2),nl,
    write(Lpt2),nl,
    write(Li2),nl,
    write(Lu2),nl,
    write(Ls2),nl,
    write(Abr),nl
.

/* tranformation or */
transformation_or(Lie,Lpt,Li,Lu,Ls,Abr) :- 

    /* enleve la tete de liste de Lu et retourne le reste de la liste dans Q*/
    enleve((I,or(C1,C2)),Lu,Q),

    /* creation de la 1ere branche */
    evolue((I,C1),Lie, Lpt, Li,Q, Ls, Lie1, Lpt1, Li1, Lu1, Ls1), 

    /* test de clash */
    flatten([Lie1, Lpt1, Li1, Lu1, Ls1],Y),
    test_clash(Y),
    resolution(Lie1,Lpt1,Li1,Lu1,Ls1,Abr),nl,
    write(Lie1),nl,
    write(Lpt1),nl,
    write(Li1),nl,
    write(Lu1),nl,
    write(Ls1),nl,
    write(Abr),nl,

    /* Creation de la seconde branche */
    evolue((I,C2),Lie, Lpt, Li,Q,  Ls, Lie2, Lpt2, Li2, Lu2, Ls2), 

    /* test de clash */
    test_clash(Y),
    resolution(Lie2,Lpt2,Li2,Lu2,Ls2,Abr),nl,
    write(Lie2),nl,
    write(Lpt2),nl,
    write(Li2),nl,
    write(Lu2),nl,
    write(Ls2),nl,
    write(Abr),nl
.


/* Partie resolution */
resolution([],[],[],[],_,_).
resolution(Lie,Lpt,Li,Lu,Ls,Abr) :- member(_,Lie), complete_some(Lie,Lpt,Li,Lu,Ls,Abr).
resolution(Lie,Lpt,Li,Lu,Ls,Abr) :- member(_,Li),transformation_and(Lie,Lpt,Li,Lu,Ls,Abr).
resolution(Lie,Lpt,Li,Lu,Ls,Abr) :- member(_,Lu),transformation_or(Lie,Lpt,Li,Lu,Ls,Abr).
resolution(Lie,Lpt,Li,Lu,Ls,Abr) :- member(_,Lpt),deduction_all(Lie,Lpt,Li,Lu,Ls,Abr).


/* TROISIEME ETAPE CALL */

troisieme_etape(Abi,Abr) :- write(Abi), nl,nl,write(Abr),nl,nl,
    tri_Abox(Abi,Lie,Lpt,Li,Lu,Ls),!,
    write(Lie),nl,
    write(Lpt),nl,
    write(Li),nl,
    write(Lu),nl,
    write(Ls),nl,
    write(Abr),nl,
    write("------------------"),nl,
    resolution(Lie,Lpt,Li,Lu,Ls,Abr)
.

/*
nl,write('Youpiiiiii, on a demontre la
proposition initiale !!!')*/
