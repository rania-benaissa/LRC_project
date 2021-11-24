/* je met chaque element de ABI dans la bonne liste */

tri_Abox([],[],[],[],[],[]).

tri_Abox([(I,some(R,C))|Q],[(I,some(R,C))|Lie],Lpt,Li,Lu,Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,all(R,C))|Q],Lie,[(I,all(R,C))|Lpt],Li,Lu,Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,and(C1,C2))|Q],Lie,Lpt,[(I,and(C1,C2))|Li],Lu,Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,or(C1,C2))|Q],Lie,Lpt,Li,[(I,or(C1,C2))|Lu],Ls) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,C)|Q],Lie,Lpt,Li,Lu,[(I,C)|Ls]) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,not(C))|Q],Lie,Lpt,Li,Lu,[(I,not(C))|Ls]) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).


/*   1- on verifie d'abord si la liste n'est pas vide
    - si elle est pas vide on supprime le 1er element 
    - On genere les assertions selon les regles

-----------------------------------------------------------

    - Si les assertions n existent pas deja on insere les nouvelles assertions
        - on verifie si y'a pas clash
        - Si y as pas clash ->  on appelle resolution
        Sinon -> on ferme le noeud
    - on choisit une noouvelle assertion

*/
Lie = [  (a, some(R,C)) ,(a, some(R,C))]

complete_some(Lie,Lpt,Li,Lu,Ls,Abr) :- 

(a, some(R,C)) ->   Abr <- (a,b,R) , Ls <- (b,C)

/* Partie resolution */
resolution(Lie,Lpt,Li,Lu,Ls,Abr) :- complete_some(Lie,Lpt,Li,Lu,Ls,Abr), resolution(Lie,Lpt,Li,Lu,Ls,Abr).


/*transformation_and(Lie,Lpt,Li,Lu,Ls,Abr),
deduction_all(Lie,Lpt,Li,Lu,Ls,Abr),
transformation_or(Lie,Lpt,Li,Lu,Ls,Abr)*/.


/* TROISIEME ETAPE CALL */

/*  ABI1 = liste de ( instance, concept) etendue */
/*  ABR = liste de ( instance,instance, role) */

troisieme_etape(Abi,Abr) :- write(Abi), nl,nl,write(Abr),nl,nl,
tri_Abox(Abi,Lie,Lpt,Li,Lu,Ls),
resolution(Lie,Lpt,Li,Lu,Ls,Abr),
write(Lie),nl,
write(Lpt),nl,
write(Li),nl,
write(Lu),nl,
write(Ls),nl.
/*
resolution(Lie,Lpt,Li,Lu,Ls,Abr),
nl,write('Youpiiiiii, on a demontre la
proposition initiale !!!')*/
