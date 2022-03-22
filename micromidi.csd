<Cabbage>
form caption("Micromidi") size(400, 300), guiMode("queue"), pluginId("def1")
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

;giNoteMap[] fillarray 74,74,75,75,76,76,77,77,78,78,79,79
;giNoteOffMap[] fillarray 64,127,64,127,64,127,64,127,64,127,64,127
giNoteMap[] fillarray 72,72,73,73,74,74,75,75,76,76,77,77,    78,78,79,79,80,80,81,81,82,82,83,83
giNoteOffMap[] fillarray 64,92,64,92,64,92,64,92,64,92,64,92,    64,92,64,92,64,92,64,92,64,92,64,92

giTpo = 24; tones per octave

;instrument will be triggered by keyboard widget
instr 1
kkey init 0						;initialize key number
kvel init 0	
ikey init 0
ivel init 0					;initialize velocity
midinoteonkey kkey, kvel
midinoteonkey ikey, ivel
kkey = kkey % giTpo ; normalize				;MIDI note number value 
ikey = ikey % giTpo
;printk2 kkey
print ikey
;midiout 144, 1, kkey, kvel
ipb = giNoteOffMap[ikey]
outipb 1, ipb, 0, 127	;(= pitchbend)
noteoff 1, ikey, ivel
midion 1, giNoteMap[kkey], kvel
;noteondur 1, kkey, kvel, 1000
;midion2 1, 60, 100, 1
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
