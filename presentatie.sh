#!/bin/bash


function box() {
    clear
    printf "${1}\n" | boxes -d peek -s 80x2 -p "a2"
    printf "${2}" | boxes -d parchment -s 80x18 -p "a2"
    #printf "${1}\n\n${2}" | boxes -d scroll -s 80x24 -p "a2"
    #printf "${1}\n\n${2}" | boxes -d ian_jones -s 80x24 -p "a2"
    read invoer
}

telnet towel.blinkenlights.nl

box "Welkom" '
Welkom bij deze workshop over container images
----------------------------------------------

Het is de bedoeling dat jullie het meeste werk doen.
'
#
box "Even voorstellen" '
Ik ben Marco Verleun:
* Heb de THT datum nog  niet bereikt ook al ben ik ouder dan...
  * Kubernetes
  * Linux
  * Het internet
  * En zelfs Unix...

Voor de rekenwonders onder ons: 
Ik ben geboren op -158850000 (epoch)
'
#
box "Interesses" '
Mijn belangstelling gaat uit naar:
* Open source
* Kennis delen
* Nieuwe technieken
* DIR(*)
* DevOps/GitOps
* DIS(**)

* Do It Right (Het liefst de eerste keer)
* Do It Secure (By Design)
'

box "Agenda" '
We (Jullie) gaan op basis van een bestaand python image een eenvoudige 
service maken in een image.
Dit image gaan we stap voor stap verbeteren.

Ook zullen we dit image deployen in een Minikube kubernetes cluster.

Als het goed is heb je zowel Docker als Minikube werkend op je 
werkstation.  Zo niet, schuif dan aan bij een collega, we hebben nu 
geen tijd om dat alsnog te installeren.

Als je vragen hebt stel deze dan, als iets niet lukt meldt het dan. Ook 
ik kan een foutje maken waardoor iets niet lukt.
'
#
box "Zijn jullie er klaar voor" '
Het is heel eenvoudig. Ga naar GitHub en download een repository.
Je mag hem ook clonen als je wilt.

Als dat klaar is zullen we stap voor stap door de README heen gaan.
Op deze manier kun je het later nog een keer bekijken.

Download of clone de repo van:
https://github.com/mverleun/workshop-image-improvement
'
