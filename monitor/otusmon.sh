#!/bin/bash

if  grep -i $1 $2 &> /dev/null
  then logger "$(date): key word was found!"
fi