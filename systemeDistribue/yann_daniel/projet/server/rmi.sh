#!/bin/bash
PID=$(pidof rmiregistry)
if [ -z $PID ] 
then
  echo "Pas de registry lance"
  rmiregistry &
else
  kill -9 $PID
  rmiregistry &
  echo "Relance du regisrty"
fi
