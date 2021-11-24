/* including files */
:- [base].
:- [fonctions].
:- [part1].
:- [part2].
:- [part3].


/************* PROJECT *************/

/* ----FINAL PROG---- */
program :- premiere_etape(Tbox,Abi,Abr), 
           deuxieme_etape(Abi,Abi1,Tbox),
           troisieme_etape(Abi1,Abr).