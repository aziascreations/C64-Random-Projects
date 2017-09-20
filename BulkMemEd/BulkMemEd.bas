1 rem Bulk Memory Editor 1.0.0
1 rem - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 rem This program allows you to quickly modify big chunks of the ram by
1 rem  entering hexadecimal code.
1 rem - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 rem See "BulkMemEd.md" for usage instructions.
1 rem See "BulkMemEd.min.bas" for a cleaned version.
1 rem - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 rem Source for hex <-> dec converter:
1 rem  http://www.lemon64.com/forum/viewtopic.php?t=8636
1 rem - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

1 rem Values:
1 rem  a  - Current address in decimal for poke command
1 rem  c$ - User input
1 rem  d  - h$ converted to decimal after a gosub 200
1 rem  e  - Temp value for the "command" prefix
1 rem  h$ - string made of (0-9|a-f){4} for conversion to decimal (d)

10 a=24576: rem $6000 (safe ram area)

30 print ""
31 print "you can only enter 76 characters"
32 print " => 2 rows - 1 char"

50 print ""
60 print "current address:"str$(a)
70 c$=""
80 input ""; c$

100 if c$="" goto 300; rem goto end
110 e$=left$(c$,1)
120 if e$="+" goto 150; rem next(right pointing angle)
125 if e$="-" goto 153; rem previous(left  pointing angle)
130 if e$="j" goto 160; rem jump somewhere
135 rem if e$="p" goto 9999; rem peek

140 if len(c$)/2 <> int(len(c$)/2) goto 290;
141 for x=1 to len(c$)/2
142 h$="00"+left$(c$,2)
143 c$=right$(c$,len(c$)-2)
144 gosub 200
145 rem print "#"a" = #$"right$(h$,2)" =>"d
145 print "#"right$(str$(a),len(str$(a))-1)" = #$"right$(h$,2)" =>"d
146 poke a,d
147 a=a+1
148 next x
149 goto 50

150 a=a+1
151 goto 50

153 a=a-1
154 goto 50

160 if len(c$)<>5 goto 291;
161 h$ = right$(c$, len(c$)-1)
162 gosub 200
163 a=d
164 goto 50

200 d=0
210 for i=0 to 3
220 n=asc(mid$(h$,i+1,1))-48
230 if n<10 then d=d+n*(16^(3-i))
240 if n>16 then d=d+(n-7)*(16^(3-i))
250 next i
260 return

290 print "error: you entered an odd number, not an even one": goto 50
291 print "error: the command wasn't 5 characters long.": goto 50

300 end
