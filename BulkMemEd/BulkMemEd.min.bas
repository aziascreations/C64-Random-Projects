10 a=24576

50 print "@:"str$(a)
60 c$=""
70 input ""; c$

100 if c$="" goto 300;
110 e$=left$(c$,1)
120 if e$="+" goto 150;
125 if e$="-" goto 153;
130 if e$="j" goto 160;

140 if len(c$)/2 <> int(len(c$)/2) goto 50;
141 for x=1 to len(c$)/2
142 h$="00"+left$(c$,2)
143 c$=right$(c$,len(c$)-2)
144 gosub 200
145 print a"= "h$" =>"d: poke a,d: a=a+1
148 next x
149 goto 50

150 a=a+1
151 goto 50

153 a=a-1
154 goto 50

160 if len(c$)<>5 goto 50;
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

300 end
