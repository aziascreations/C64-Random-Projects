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

1 rem Notes:
1 rem  * You can't enter more than 2 rows at the same time. (76 chars)

1 rem Values:
1 rem  a  - Current address in decimal for poke command
1 rem  c$ - User input
1 rem  d  - h$ converted to decimal after a gosub 200
1 rem  e  - Temp value for the "command" prefix
1 rem  h$ - string made of (0-9|a-f){4} for conversion to decimal (d)

10 a=24576: rem $6000 (safe ram area)

50 print ""
60 print "current address:"str$(a)
70 c$=""
80 input ""; c$

100 if c$="" then end
110 e$=left$(c$,1)
120 if e$="+" then a=a+1: goto 50;
125 if e$="-" then a=a-1: goto 50;
130 if e$="j" goto 150;
135 rem if e$="p" goto 9999; rem peek

140 if len(c$)/2 <> int(len(c$)/2) goto 290;
141 for x=1 to len(c$)/2
142 h$="00"+left$(c$,2)
143 c$=right$(c$,len(c$)-2)
144 gosub 200
145 rem These 2 lines seem to cause problems on a real c64 with fc3.
145 rem Or i'm just bad at typing, idk.
145 rem print "#"a" = #$"right$(h$,2)" =>"d
145 print "#"right$(str$(a),len(str$(a))-1)" = #$"right$(h$,2)" <=>"d
146 poke a,d
147 a=a+1
148 next x
149 goto 50

150 if len(c$)<>5 goto 291;
151 h$ = right$(c$, len(c$)-1)
152 gosub 200
153 a=d
154 goto 50

200 d=0
201 for i=0 to 3
202 n=asc(mid$(h$,i+1,1))-48
203 if n<10 then d=d+n*(16^(3-i))
204 if n>16 then d=d+(n-7)*(16^(3-i))
205 next i
206 return

290 print "error: please enter an even number": goto 50
291 print "error: command not 5 characters long.": goto 50
