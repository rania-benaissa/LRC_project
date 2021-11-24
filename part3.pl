




/* je prends le 1er element de la liste ABI et c est de type (I,C) */

tri_Abox([],_,_,_,_,_).

tri_Abox([(I,some(R,C))|Q],Lie,Lpt,Li,Lu,Ls) :- concat([(I,some(R,C))],Lie,X), tri_Abox(Q,X,Lpt,Li,Lu,Ls).
tri_Abox([(I,all(R,C))|Q],Lie,Lpt,Li,Lu,Ls) :- concat([(I,all(R,C))],Lpt,X), tri_Abox(Q,Lie,X,Li,Lu,Ls).
tri_Abox([(I,and(C1,C2))|Q],Lie,Lpt,Li,Lu,Ls) :-  concat([(I,and(C1,C2))],Li,X), tri_Abox(Q,Lie,Lpt,X,Lu,Ls).
tri_Abox([(I,or(C1,C2))|Q],Lie,Lpt,Li,Lu,Ls) :-  concat([(I,or(C1,C2))],Lu,X), tri_Abox(Q,Lie,Lpt,Li,X,Ls).
tri_Abox([(I,C)|Q],Lie,Lpt,Li,Lu,Ls) :-  concat([(I,C)],Ls,X), tri_Abox(Q,Lie,Lpt,Li,Lu,X).
tri_Abox([(I,not(C))|Q],Lie,Lpt,Li,Lu,Ls) :- concat([(I,not(C))],Ls,X), tri_Abox(Q,Lie,Lpt,Li,Lu,X).
    

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
