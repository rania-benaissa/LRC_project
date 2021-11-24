




/* je prends le 1er element de la liste ABI et c est de type (I,C) */

tri_Abox([],[],[],[],[],[]).

tri_Abox([(I,some(R,C))|Q],[(I,some(R,C))|Lie],Lpt,Li,Lu,Ls) :-  tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,all(R,C))|Q],Lie,[(I,all(R,C))|Lpt],Li,Lu,Ls) :-  tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,and(C1,C2))|Q],Lie,Lpt,[(I,and(C1,C2))|Li],Lu,Ls) :-  tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,or(C1,C2))|Q],Lie,Lpt,Li,[(I,or(C1,C2))|Lu],Ls) :-  tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,C)|Q],Lie,Lpt,Li,Lu,[(I,C)|Ls]) :-  tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).
tri_Abox([(I,not(C))|Q],Lie,Lpt,Li,Lu,[(I,not(C))|Ls]) :- tri_Abox(Q,Lie,Lpt,Li,Lu,Ls).


/* TROISIEME ETAPE CALL */

/*  ABI1 = liste de ( instance, concept) etendue */
/*  ABR = liste de ( instance,instance, role) */

troisieme_etape(Abi,Abr) :- write(Abi), nl,nl,write(Abr),nl,nl,
tri_Abox(Abi,Lie,Lpt,Li,Lu,Ls),
write(Lie),nl,
write(Lpt),nl,
write(Li),nl,
write(Lu),nl,
write(Ls),nl.
/*
resolution(Lie,Lpt,Li,Lu,Ls,Abr),
nl,write('Youpiiiiii, on a demontre la
proposition initiale !!!')*/
