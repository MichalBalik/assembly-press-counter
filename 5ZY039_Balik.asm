		

;; definovanie konstat pouzivanych v programe  0-segment svieti 1- nesvieti
	byte 11000000b	; znak '0' 
	BYTE 11111001b 	; znak '1' 
	BYTE 10100100b 	; znak '2' 
	BYTE 10110000b	; znak '3' 	
	BYTE  10011001b	; znak '4' 
	BYTE 10010010b  ; znak '5' 
	BYTE 10000010b  ; znak '6' 
	BYTE 11111000b	; znak '7' 
	BYTE 10000000b   ; znak '8' 
	BYTE 10010000b  ; znak '9' 
	BYTE 10111111b ; ; znak '-' 

;; vypisanie pomlciek na  segmenty pri spusteny programu
	mvi b,10111111b  ; ulozenie znaku '-' do b
	out 1110b,b	;vypis na 1 displej
	out 1101b,b	;vypis na 2 displej
	out 1011b,b	;vypis na 3 displej
	out 0111b,b	;vypis na 4 displej

	;;Prikazy skoku
	;jcy = jl
	; jnc = jge
	; jzr = je
	; jnz = jne


;; hlavne menu kde kontrolujem stlacenie tlacidiel
start:
	

;;--------------------------kontrola 1 riadku tlacidiel----------------;;

	inn	a,1110b		;citanie stavu riadku 1
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,0111b		;je stlacene tlacidlo v prvom stlpci?
	jzr	nula
	
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1011b		;je stlacene tlacidlo v 2 stlpci?
	jzr	jedna


	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1101b		;je stlacene tlacidlo v 3 stlpci?
	jzr	dva

	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1110b		;je stlacene tlacidlo v 4 stlpci?
	jzr	tri


;;--------------------------kontrola 2 riadku tlacidiel----------------;;

	inn	a,1101b		;citanie riadku 2
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,0111b		;je stlacene tlacidlo v prvom stlpci?
	jzr	styri

	inn	a,1101b		;citanie riadku 2
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1011b		;je stlacene tlacidlo v 2 stlpci?
	jzr	pat

	inn	a,1101b		;citanie riadku 2
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1101b		;je stlacene tlacidlo v 3 stlpci?
	jzr	sest


	inn	a,1101b		;citanie riadku 2
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1110b		;je stlacene tlacidlo v 4 stlpci?
	jzr	sedem


;;--------------------------kontrola 3 riadku tlacidiel----------------;;


	inn	a,1011b		;citanie riadku 3
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1101b		;je stlacene tlacidlo v 3 stlpci?
	mvi c,0
	jzr	reset 


	inn	a,1011b		;citanie riadku 3
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,0111b		;je stlacene tlacidlo v prvom stlpci?
	mvi c,4
	mvi a,0
	jzr	scitanieCisiel 

	inn	a,1011b		;citanie riadku 3
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1110b		;je stlacene tlacidlo v 4 stlpci?
	jzr	koniec 

	inn	a,1011b		;citanie riadku 3
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1011b		;je stlacene tlacidlo v 2 stlpci?
	jzr	scitanie 

;;--------------------------kontrola 4 riadka klavesnice cdef ----------------;;

	;; sledovanie 4 riadka klavesnice cdef

	inn	a,0111b		;citanie riadku 4
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1110b		;je stlacene tlacidlo v 4 stlpci?
	jzr	pismenoF 

	;; pismeno e
	inn	a,0111b		;citanie riadku 4
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1101b		;je stlacene tlacidlo v 3 stlpci?
	jzr	pismenoE 

	;; pismeno d
	inn	a,0111b		;citanie riadku 4
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,1011b		;je stlacene tlacidlo v 2 stlpci?
	jzr	pismenoD

	;; pismeno d
	inn	a,0111b		;citanie riadku 4
	ani	a,00001111b	;vynulovanie hornych 4 bitov
	cmi	a,0111b		;je stlacene tlacidlo v 1 stlpci?
	jzr	pismenoC

	jmp	start
	


pismenoF:
	mvi b,10001110b  ; ulozenie znaku F do b
	out 1110b,b	;zobrazenie znaku F na prvom displeji

	mvi	b,10111111b		; ulozenie znaku - do b
	out	101b,b	;zobrazenie znaku - na prvom displeji


	mvi c, 3 ;; ulozenie pozicie pamate do c 
	LDR  b,c ;; nacitanie hodnoty do b  z mieste kam ukazuje c
	inc b	;;zvysim pocet stlaceny o 1
	STR  c,b ;; ulozenie do pamate
	
	ldr b,c ;; nacitanie hodnoty do b  z mieste kam ukazuje c
	cmi b,10 ;; porovnanie ci je cislo vacsie ako 10
	mvi a,0 ;; ulozenie 0 do a
	jnc pocitanieDesiatokaJednotiek ;; ak je tak skoci na navestie

	mmr a,b ;; ak je cislo do 9 tak  si nacitam cislicu  do a z pozicie ktora je ulozena na b
	out 0111b,a ;; vypis jednociferneho cisla na  displej

	mvi a,0	;; ulozenie  0 do registra
	mmr b,a ;; nacitanie znaku 0 z konstat
	out 1011b,b ;;vypisanie nuly na 3 displej
	
	jmp	cakaj ;; skok na navestie cakaj



reset:	

	mvi a ,0 ;; ulozenie 0 do a
	str c,a ;; ulozenie do pamate  
	inc c ;; inkrementacia pocitadla opakovany
	cmi c, 13 ;; ak sa este nevynulovaly vsetky hodnoty skok na reset
	jnz reset 

	;vypisanie pomlciek pri restarte
	mvi b,10111111b  ; ulozenie znaku - do b
	out 1110b,b ;; vypisanie na 1 displej
	out 1101b,b ;; vypisanie na 2 displej
	out 1011b,b;; vypisanie na 3 displej
	out 0111b,b;; vypisanie na 4 displej

	jmp cakaj ;; skok na cakaj

pismenoE:
	mvi b,10000110b  ; ulozenie znaku E do b
	out 1110b,b	;zobrazenie znaku E na prvom displeji

	mvi	b,10111111b; ulozenie znaku - do b
	out	101b,b	;zobrazenie znaku - na prvom displeji

	
	mvi c, 2 ;; pozicia 2 do c
	LDR  b,c ;; nacitanie z pamate do b
	inc b ;; zvysim pocet stlaceny
	

	STR  c,b ;; ulozenie b do pamate
	LDR  b,c ;; nacitanie z pamate

	cmi b,10 ;;je cislo desatine
	mvi a,0 ;; ulozenie 0 do a 
	jnc pocitanieDesiatokaJednotiek ;; ak je cislo desatine skok na pocitanieDesiatokaJednotiek

	mmr a, b	;;ak je cislo do 9 tak  si nacitam cislicu  do a z pozicie ktora je ulozena na b 
	out 0111b,a ;; vypis jednociferneho cisla na  displej 
	mvi a, 0 ;; ulozenie  0 do registra 
	mmr b,a ;; nacitanie znaku 0 z konstat 
	out 1011b,b ;;vypisanie nuly na 3 displej 


	jmp	cakaj ;; skok na navestie cakaj 

pismenoD:
	mvi b,11000000b  ; ulozenie znaku D do b
	out 1110b,b	;zobrazenie znaku D na prvom displeji

	mvi	b,10111111b; ulozenie znaku - do b
	out	1101b,b	;zobrazenie znaku - na prvom displeji

	mvi	b,11000000b 		; ulozenie znaku 0 do b
	out	1011b,b ;zobrazenie znaku D na 3 displeji

	mvi c, 1 ;; pozicia 1 do c
	LDR  b,c ;; nacitanie z pamate do b
	inc b;;zvysim pocet stlaceny o 1 
	

	STR  c,b ;; ulozenie do pamate 
	
	ldr b,c;; nacitanie hodnoty do b  z mieste kam ukazuje c 
	cmi b,10;; porovnanie ci je cislo vacsie ako 10 
	mvi a,0 ;; ulozenie 0 do a 
	jnc pocitanieDesiatokaJednotiek;; ak je tak skoci na navestie 

	mmr a,b;;ak je cislo do 9 tak  si nacitam cislicu  do a z pozicie ktora je ulozena na b 
	out 0111b,a;; vypis jednociferneho cisla na  displej 

        mvi a,0;; ulozenie  0 do registra 
	mmr b,a;; nacitanie znaku 0 z konstat 
	out 1011b,b;;vypisanie nuly na 3 displej 

	jmp cakaj;; skok na navestie cakaj 


pismenoC:

	mvi b,11000110b  ; znak C na prvy diisplej
	out 1110b,b ;zobrazenie znaku C na prvom displeji 

	mvi b,10111111b ; ulozenie znaku - do b 
	out 1101b,b;zobrazenie znaku - na prvom displeji 


	mvi c, 0 ;; ulozenie pozicie pamate do c  
	LDR  b,c;; nacitanie hodnoty do b  z mieste kam ukazuje c 
	inc b;;zvysim pocet stlaceny o 1 
	

	STR  c,b ;; ulozenie do pamate
	
	;; vypis poctu stlaceny

	ldr b,c	;; nacitanie hodnoty do b  z mieste kam ukazuje c 
	cmi b,10;; porovnanie ci je cislo vacsie ako 10 
	mvi a,0;; ulozenie 0 do a 
	jnc  pocitanieDesiatokaJednotiek ;; ak je vacie ako desat tak skoci na vypis dvojcifernych ciciesl

	mmr a,b;; ak je cislo do 9 tak  si nacitam cislicu  do a z pozicie ktora je ulozena na b 
	out 0111b,a;; vypis jednociferneho cisla na  displej 

	mvi a, 0	;; ulozenie  0 do registra 
	mmr b,a;; nacitanie znaku 0 z konstat 
	out 1011b, b;;vypisanie nuly na 3 displej 

	jmp	cakaj


scitanie:
	mvi a, 10010010b ; pismeno s do a
	out 1110b, a ; vypis pismena s na displej 1

	
	mvi a,0 ; v a je ulozeny celkkovy pocet stlaceny

	mvi b,0 ; ulozenie pozicie do b
	ldr c,b ;; nacitanie hodnoty do c  z mieste kam ukazuje b
	add a,c ;;priratanie do celkoveho poctu stlaceny

	mvi b,1; ulozenie pozicie do b
	ldr c,b;; nacitanie hodnoty do c  z mieste kam ukazuje b
	add a,c;;priratanie do celkoveho poctu stlaceny

	mvi b,2; ulozenie pozicie do b
	ldr c,b;; nacitanie hodnoty do c  z mieste kam ukazuje b
	add a,c;;priratanie do celkoveho poctu stlaceny

	mvi b,3; ulozenie pozicie do b
	ldr c,b;; nacitanie hodnoty do c  z mieste kam ukazuje b
	add a,c;;priratanie do celkoveho poctu stlaceny

	mov b,a ;; ulozenie hodnoty do b

	cmi b,10 ;; porovnanie ci je cislo vacsie ako 10 
	mvi a ,0;; ulozenie 0 do a 
	jnc  pocitanieDesiatokaJednotiek ;; ak je vacie ako desat tak skoci na vypis dvojcifernych ciciesl

	mmr a,b ;; ak je cislo do 9 tak  si nacitam cislicu  do a z pozicie ktora je ulozena na b 
	out 0111b,a ;; vypis jednociferneho cisla na  displej 

	mvi a, 0 ;; ulozenie  0 do registra 
	mmr b,a;; nacitanie znaku 0 z konstat 
	out 1011b, b ;;vypisanie nuly na 3 displej 

	jmp cakaj ;; skok na navestie cakaj 

vypisanieDvojCifernychCisiel:
	mmr d,b ;; nacitanie znaku  z konstat 
	out 0111b,d ;; vypis cisla na posledny displej
	mmr d,a ;; nacitanie znaku  z konstat 
	out 1011b,d ;; vypis cisla na 3 displej

	jmp cakaj;; skok na navestie cakaj 
	

pocitanieDesiatokaJednotiek:
	sbi b,10 ;; odcitanie 10 od b
	inc a ;; inkrementacia poctu desiatok
	cmi b,10 ;; porovnanie ci je cislo vacsie ako10
	jnc pocitanieDesiatokaJednotiek ;; ak je cislo vacsie ako desat tak skok na navestie
	jmp vypisanieDvojCifernychCisiel ;; skok na navestie vypisanieDvojCifernychCisiel

nula:
	mvi d,0 ;; ulozenie  0 do registra 
	mmr c,d ;; nacitanie znaku 0 z konstat 
	 
	out 1110b,c ;; vypis znaku 0 na 1 displej

	mvi d,10 ;; ulozenie  cisla do registra 
	mmr c,d	;; nacitanie znaku  z konstat 
	out 1101b,c ;; vypis znaku na 2 displeej


	mvi c, 5;; ulozenie  cisla do registra 
	jmp vypis ;; skok na navestie vypis 

jedna: 
	mvi d,1 ;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 
	
	out 1110b,c ;; vypis znaku  na  displej

	mvi d,10 ;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 
	out 1101b,c;; vypis znaku  na  displej

	
	mvi c, 6 ;; ulozenie  cisla do registra 
	jmp vypis ;; skok na navestie vypis 

tri: 
	mvi d,3 ;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 
	 
	out 1110b,c;; vypis znaku  na  displej

	mvi d,10 ;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 
	out 1101b,c;; vypis znaku  na  displej


	mvi c, 8 ;; ulozenie  cisla do registra 
	jmp vypis ;; skok na navestie vypis 

dva: 
	mvi d,2;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 

	out 1110b,c;; vypis znaku  na  displej

	mvi d,10;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 

	out 1101b,c;; vypis znaku  na  displej


	mvi c, 7 ;; ulozenie  cisla do registra 
	jmp vypis ;; skok na navestie vypis 

styri:
	mvi d,4;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 
	
	out 1110b,c;; vypis znaku  na  displej

	mvi d,10;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 
	
	out 1101b,c;; vypis znaku  na  displej

	
	mvi c, 9 ;; ulozenie  cisla do registra 
	jmp vypis;; skok na navestie vypis 
pat:
	mvi d,5 ;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 

	out 1110b,c;; vypis znaku  na  displej

	mvi d,10;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 

	out 1101b,c;; vypis znaku  na  displej


	mvi c, 10 ;; ulozenie  cisla do registra 
	jmp vypis;; skok na navestie vypis 

sest:
	mvi d,6 ;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 

	out 1110b,c;; vypis znaku  na  displej

	mvi d,10 ;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 

	out 1101b,c;; vypis znaku  na  displej


	mvi c, 11 ;; ulozenie  cisla do registra 
	jmp vypis;; skok na navestie vypis 
sedem:
	mvi d,7 ;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 

	out 1110b,c;; vypis znaku  na  displej

	mvi d,10;; ulozenie  cisla do registra 
	mmr c,d;; nacitanie znaku  z konstat 

	out 1101b,c;; vypis znaku  na  displej


	mvi c, 12 ;; ulozenie  cisla do registra 
	jmp vypis;; skok na navestie vypis 

scitanieCisiel:
	
	mvi d, 10010010b ;; ulozenie  S do registra 
	out 1110b, d ; vypis pismena s na displej

	ldr d,c ;; nacitanie cisla z pamate do registra
	add a,d ;; pripocitanie hodnoty z d do celkoveho poctu stlaceny
	inc c ;; inkrementacia c
	cmi c,13 ;; su scitane vsetky cisla do pozicie 12
	jnz scitanieCisiel ;; ak nie skok na scitanie cisiel
	mov b,a ;; ulozenie hodnoty do registra b


	cmi b,10 ;; je cislo vacsie ako 10
	mvi a ,0;; ulozenie  cisla do registra 
	jnc  pocitanieDesiatokaJednotiek ;; ak je vacie ako desat tak skoci na vypis dvojcifernych ciciesl

	mmr a,b;; nacitanie znaku  z konstat 
	out 0111b,a;; vypis znaku  na  displej

	mvi a, 0;; ulozenie  cisla do registra 
	mmr b,a;; nacitanie znaku  z konstat 
	out 1011b, b;; vypis znaku  na  displej

	jmp cakaj;; skok na navestie cakaj 

cakaj:
	inn	a,0	
	ani	a,00001111b	
	cmi	a,1111b	;; porovnanie a s 1111b
	jnz cakaj;; skok na navestie cakaj 
	jmp start;; skok na navestie start 

vypis:
	LDR  b,c;; nacitanie cisla z pamate do registra
	inc b ;; inkrementacia b
	

	STR  c,b ;; ulozenie do pamate
	
	ldr b,c	;; nacitanie cisla z pamate do registra
	cmi b,10 ;; porovnanie je cislo vacsie ako 10
	mvi a,0;; ulozenie  cisla do registra 
	jnc  pocitanieDesiatokaJednotiek ;; ak je vacie ako desat tak skoci na vypis dvojcifernych ciciesl

	mmr a,b;; nacitanie znaku  z konstat 
	out 0111b,a ;; vypis na displej

	mvi a, 0;; ulozenie  cisla do registra 
	mmr b,a;; nacitanie znaku  z konstat 
	out 1011b, b ;; vypis na displej
	jmp cakaj;; skok na navestie cakaj 

koniec:

