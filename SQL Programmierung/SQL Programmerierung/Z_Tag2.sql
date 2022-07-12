/*

Code --> Indizes

Hardware: 
1. HDD:   Seiten (8kb) Block aus 8 Seiten Seiten kommen 1:1 in RAM
2. RAM
3. CPU

todo HDD
1.  korrekter Datentyp date statt datetime
2. DB Redesign 


4100 pro DS

1 DS /Seite

1 DS 4000   1DS 100
2DS/Seite    80DS/Seite

bei 1 MIO DS
1 MIO Seiten  = 6GB
1 MIO mit 500.000   4 GB
1 MIO 12.500 Seiten  -- 110MB 

Kompression
das Mehr an RAM wird mit mehr CPU bezahlt.. eigtl ine Optimierung zuhgunsten anderer Tabellen

Partitionierung
Daten werden gestückelt   Part Sicht ., aber nicht so dolle

Indizes



todo CPU

Paral.. 
Kostenschwellwert: im Ausführungsplan: default 5
F() lasssen sich nicht paral...
MAXDOP: unter KstSchwWert dann 1, sonst der MAXDOP (vor SQL 2016 = 0 = alle, seit SQL 2016 Anzahl der Kerne nicht mahr als 8 im Setup

Tipp. rumspielen KstSchw: 25 
pro DB MAXDOP  Datawarehouse evtl höher und für OLTP (Shop) weniger Kerne

CXPACKET


*/









*/