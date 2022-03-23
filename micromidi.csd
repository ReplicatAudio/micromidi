<Cabbage>
form caption("Micromidi") size(400, 300), guiMode("queue"), pluginId("def1") colour("black")
label channel("ikey") bounds(0,0, 400,20) align("centre") fontSize(12)
label channel("itone") bounds(0,20, 400,20) align("centre") fontSize(12)
;label channel("icalc") bounds(0,40, 400,20) align("centre") fontSize(12)
label channel("inote") bounds(0,60, 400,20) align("centre") fontSize(12)
label channel("ipb") bounds(0,80, 400,20) align("centre") fontSize(12)
keyboard bounds(8, 180, 381, 95)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d -Q1 --midi-key-cps=4 --midi-velocity-amp=5
;-d -n -+rtmidi=null -m0d -Q0 --midi-key=4
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

giTpo = 24; tones per octave

giCfrq = 261.6256

;instrument will be triggered by keyboard widget
instr 1
Sdes = ""
itunedata[] init 24
iArri = 0
read:
Sline, iLineNum readfi "tunefile"
        printf_i  "\r\nLine %d: %s", iLineNum, iLineNum, Sline
        ipos strindex Sline, ";"
        if ipos == 1 igoto read
        if iLineNum == 1 then 
            Sdes = Sline
            igoto read
        endif
        if iLineNum == 2 then 
            Sstrip = strstrip(Sline)
            giTpo strtod Sstrip
            print giTpo
            igoto read
        endif
        if iLineNum != -1 then
            ilen strlen Sline
            print ilen
            Sstrip2 strsub Sline, 0, ilen-1
            prints Sstrip2
            prints "\r\n"
            ival strtod Sstrip2
            print ival
            
            ivalc = giCfrq * cent(ival) 
            print ivalc
            
            itunedata[iArri] = ivalc
            iArri = iArri + 1
            igoto read
        endif
ifreqs0[] init giTpo
ifreqs0[] ftom itunedata
;prints "\r\n"
;prints "itunedata"
;printarray itunedata
;prints "\r\n"
;prints "ifreqs0"
;printarray ifreqs0
kkey init 0	
kvel init 0	
ikey init 0
ivel init 0	

midinoteonkey kkey, kvel
midinoteonkey ikey, ivel
kkey = kkey % giTpo ; normalize
ikey = ikey % giTpo
itone = itunedata[ikey]
icalc = ifreqs0[ikey]
inote = int(icalc)
ipb = ((icalc - inote)*64)+64
outipb 1, ipb, 0, 127	;(= pitchbend)
noteoff 1, inote, ivel
midion 1, inote, kvel
;Sout sprintf "%d \r\n %d \r %d \r %d \r %d", ikey, itone, icalc, inote, ipb
Sikey sprintf "key in: %d", ikey
cabbageSet "ikey", "text", Sikey
Sitone sprintf "tone: %d", itone
cabbageSet "itone", "text", Sitone
;Sicalc sprintf "calc: %d", icalc
;cabbageSet "icalc", "text", Sicalc
Sinote sprintf "midi note: %d", inote
cabbageSet "inote", "text", Sinote
Sipb sprintf "bend: %d", ipb
cabbageSet "ipb", "text", Sipb
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
