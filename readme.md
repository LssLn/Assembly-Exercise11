STR[3][16] e N,R interi. Ciclo for di 3 in cui si stampa msg1 e scanf STR di numeri (STR[i]), stampa msg2 e scanf numero ad una cifra (N)
si chiama esegui, con arg STR[i], strlen, N, che ritorna R (int) e si stampa msg3 con argomenti di printf R ed N
La funz esegui prende in argomento str, strlen (d) e c (sarebbe N, secondo Scanf). Inizializza i e conta,
fa un ciclo for per la strlen con cui scorre la STR[i] (diverso da STR[i] con cui passo una tra le 3 stringhe nella chiamata ad esegui) e 
se coincidono (conversione di str[i] da char a int con -48) fa conta++; alla fine torna conta.
