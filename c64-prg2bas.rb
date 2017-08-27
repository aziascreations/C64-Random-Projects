# Source: http://www.schmid.dk/blog/2015-02-01-c64_development/
# Note: Will remove/ignore the 2 first bytes from the input file

d = File.binread(ARGV[0],10000,2).bytes
s = "10 bs=4096
20 read b
30 if b=-1 then sys(4096)
40 poke bs,b
50 bs=bs+1
60 goto 20"
x = 0
d.each { |b|
    if (x % 8) == 0
    s += "\n#{x/8*10+100} data "
    else
        s += ","
    end
    s += "%d" % b
    x+=1
}
puts s+"\n9999 data -1"