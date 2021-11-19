/* including files */
:- [base].
:- [part1].
:- [part2].
/************* PROJECT *************/

/* ----FINAL PROG---- */
program :- premiere_etape(Tbox,Abi,Abr), 
           deuxieme_etape(Abi,Abi1,Tbox),write(Abr),write(Abi1).