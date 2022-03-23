# Micromidi
Micromidi is a VST that enables you to experiment with, compose and preform microtonal (or even "macrotonal") music with nearly any hardware or software synth. 

## Features
* Divide an octave as many or as few times as you want
* Assign pitch bend values to any notes in the octave
* Remap midi input 

## What is "microtonal" music?
Modern western music divides an octave into 12 equally spaced tones. This tuning is known as 12tet or 12 tone equal temperament. In this system each tone in the octave can be considered to be separated by intervals called a semitone. 

The idea behind microtonal music is to explore the tones that we can get by using smaller intervals that a semitone. So for instance a popular microtuning is 24tet which involves splitting the octave into 24 equal tones instead of 12.

You can also use Micromidi divide an octave by unequally. For example, you could use something like [just intonation](https://en.wikipedia.org/wiki/Just_intonation) which attempts to to assign all notes to frequencies that can be represented as whole number ratios. 

## What is a VST?
A VST ([Virtual Studio Technology](https://en.wikipedia.org/wiki/Virtual_Studio_Technology)) is a plugin for DAWs ([Digital Audio Workstations](https://en.wikipedia.org/wiki/Digital_audio_workstation)). Examples of popular DAWs that this should work with are [Reaper](https://www.reaper.fm/)(tested) and [Ableton Live](https://www.ableton.com/en/). However this should work with just about any popular DAW. 

## Create a tuning file
Tuning files are roughly based on the Scala spec but this is not a complete implementation of that spec. A tuning file consists of 2 header lines. The first line is a description of the tuning. The second line is the amount of octave divisions we want. Lines after that each represent the pitch offset from the root for each interval in the octave (in cents). Unlike Scala, these tuning files do NOT imply that the first interval (root) is zero so this must be explicitly defined.

Below is an example of 24tet tuning which is included in this repo:
```
A basic 24tet example tuning
24
0
50
100
150
200
250
300
350
400
450
500
550
600
650
700
750
800
850
900
950
1000
1050
1100
1150
```

At this time you can only have one tuning file. It must be called `tunefile` and it must be in the same directory as this VST.

**Tip: there are 100 cents in a standard semitone!**

**Tip: You can keep multiple tuning files in the VST directory at once, but only one can have the name `tunefile`**

## Setting up pitch bend on your synth
In order for this to work as expected you need to make sure that the pitch bend setting on your synth is set to 1 semitone (the default is usually 2).

In the future, there should be a workaround for synths where changing the pitch bend range is not possible. 