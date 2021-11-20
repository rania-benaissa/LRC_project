/* including files */
:- [base].
:- [fonctions].
:- [part1].
:- [part2].
/************* PROJECT *************/

/* ----FINAL PROG---- */
program :- premiere_etape(Tbox,Abi,Abr), 
           deuxieme_etape(Abi,Abi1,Tbox),nl,write(Tbox),nl,write(Abi1),nl,write(Abr).