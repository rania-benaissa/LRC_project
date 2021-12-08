/* je met chaque element de ABI dans la bonne liste */

tri_Abox([],[],[],[],[],[]).

tri_Abox([(I,some(R,C))|Q],[(I,some(R,C))|Lie],Lpt,Li,Lu,Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,all(R,C))|Q],Lie,[(I,all(R,C))|Lpt],Li,Lu,Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,and(C1,C2))|Q],Lie,Lpt,[(I,and(C1,C2))|Li],Lu,Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,or(C1,C2))|Q],Lie,Lpt,Li,[(I,or(C1,C2))|Lu],Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,C)|Q],Lie,Lpt,Li,Lu,[(I,C)|Ls]) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,not(C))|Q],Lie,Lpt,Li,Lu,[(I,not(C))|Ls]) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).



/* je parcours toutes les listes si y a aucun clash -> return true else false*/
test_clash([]).
test_clash([T|Q]):- not(member(not(T),Q)), test_clash(Q).



/* rajoute la nouvelle assertion a la liste adequate seulement si elle n'y 
existe pas deja */
add_new_element(X,L1,L2) :- not(member(X,L1)), concat(X,L1,L2).
add_new_element(X,L1,L2) :- member(X,L1), concat([],L1,L2).





get_all_new_elts(_,[],[]).
get_all_new_elts((I,all(R,C)),[(I1,I2,R1)|Q],[(I2,C)|New]):- I == I1, R == R1, get_all_new_elts((I,all(R,C)),Q, New).
get_all_new_elts((I,all(R,C)),[_|Q],New):- get_all_new_elts((I,all(R,C)),Q, New).





evolue(A, Lie, Lpt, Li, Lu, Ls, Lie1, Lpt1, Li1, Lu1, Ls1) :-

/* Application de la regle d'il existe */

complete_some(Lie,Lpt,Li,Lu,Ls,Abr) :-
            
    /* enleve la tete de liste de Lie*/
    enleve((I,some(R,C)),Lie,Q),
    /* ajout de des nouvelles assertions -> elles existeront jamais deja puisque B est new */
    genere(B), 
    concat([(B,C)],Ls,Ls1), 
    concat([(I,B,R)],Abr,Abr1), 
    /* je met toutes les listes ensemble */

    flatten([Ls1,Abr1],Y),
    /* test de clash */
    test_clash(Y),
    write("resolution part"),
    
    resolution(Q,Lpt,Li,Lu,Ls1,Abr1),nl,
    write(Q),nl,
    write(Lpt),nl,
    write(Li),nl,
    write(Lu),nl,
    write(Ls1),nl,
    write(Abr1),nl
.


/* Application de la regle de qlq soit */
deduction_all(Lie,Lpt,Li,Lu,Ls,Abr) :- 
            
    /* enleve la tete de liste de Lie*/
    enleve((I,all(R,C)),Lpt,Q),

    /* reecupere toutes les assertions I2 : C possibles */
    get_all_new_elts((I,all(R,C)),Abr,New_assertions),


    add_new_element(New_assertions,Ls,Ls1),

    /* test de clash */
    test_clash(Ls1),

    write("resolution part"),
    
    resolution(Lie,Q,Li,Lu,Ls1,Abr1),nl,
    write(Lie),nl,
    write(Q),nl,
    write(Li),nl,
    write(Lu),nl,
    write(Ls1),nl,
    write(Abr1),nl
.


/* transformation ET */
transformation_and(Lie,Lpt,Li,Lu,Ls,Abr) :- 
            /* enleve la tete de liste de Li et retourne le reste de la liste dans Q*/
            enleve((I,and(C1,C2)),Li,Q),
            /* ajout de des nouvelles assertions SI elles existent */
        
            add_new_element([(I,C1)],Ls,Ls1), 
            add_new_element([(I,C2)],Ls1,Ls2), 
          
            /* test de clash */
            test_clash(Ls2),
            write("resolution part"),
            
            resolution(Lie,Lpt,Q,Lu,Ls2,Abr),nl,
            write(Lie),nl,
            write(Lpt),nl,
            write(Q),nl,
            write(Lu),nl,
            write(Ls2),nl,
            write(Abr),nl
.

/* tranformation or */
transformation_or(Lie,Lpt,Li,Lu,Ls,Abr) :- 
            /* enleve la tete de liste de Lu et retourne le reste de la liste dans Q*/
            enleve((I,or(C1,C2)),Lu,Q),

            /* creation de la 1ere branche */
            add_new_element([(I,C1)],Ls,Ls1), 
        
            /* test de clash */
            test_clash(Ls1),
            resolution(Lie,Lpt,Li,Q,Ls1,Abr),nl,
            write(Lie),nl,
            write(Lpt),nl,
            write(Li),nl,
            write(Q),nl,
            write(Ls1),nl,
            write(Abr),nl,

            /* Creation de la seconde branche */
            add_new_element([(I,C2)],Ls,Ls2), 
           
            /* test de clash */
            test_clash(Ls2),
            resolution(Lie,Lpt,Li,Q,Ls2,Abr),nl,
            write(Lie),nl,
            write(Lpt),nl,
            write(Li),nl,
            write(Q),nl,
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
