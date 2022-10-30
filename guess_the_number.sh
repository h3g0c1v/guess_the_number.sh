#!/bin/bash

#Colours
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "\n\n${red}[!] Saliendo ...${end}"
  exit 1
}

trap ctrl_c INT


function helpPanel(){
  
  echo -e "\n${yellow}[i] ${end}${gray}Uso:${end}"
  echo -e "\t${purple}-n ${end}${gray}Indicar el número de juegos que quieres jugar${end}"
}

function guess_number(){

  number=$1
  declare -a numbers_guessed=()

  if [ "$number" == "0" ]; then

    echo -e "\n${red}[!] No se pueden jugar 0 juegos${end}\n"
    exit 1
  fi

  echo -ne "\n\t${blue}[+] Introduce el número máximo del rango -> ${end}${yellow}" && read range

  for i in $(seq 1 $number); do
 
    echo -e "\n${end}${purple}[$i/$number]${end}${gray} Empezando juego. El rango es ${yellow}0-$range${end}"
 
    random_number=$((RANDOM%(range+1)))
    numbers_guessed+=$random_number
    numbers_guessed+=" "
     
    echo -ne "\n\t${blue}[+] Adivina el número del 0 al $range -> ${end}${yellow}" && read guess

    while [ "$guess" != "$random_number" ]; do

      echo -e "${end}\n\t${red}[!] ¡Incorrecto, vuelve a intentarlo!"
      echo -ne "\t${blue}[+] Adivina el número del 0 al $range -> ${end}${yellow}" && read guess
  done
  
  if [ "$guess" == "$random_number" ]; then
  
    echo -e "${end}\n\t${green}[✔] ¡Correcto!${end}"
  fi
  
  done
  
  echo -e "\n${green}[+] Todos los juegos han terminado${end}"

  echo -e "\n${blue}[+] Los números que has adivinado son: ${yellow}${numbers_guessed[@]}${end}"
  echo -e "${green}[+] Gracias por jugar!${end}"
}

declare -i parameter_counter=0

while getopts "hn:" arg; do
  case $arg in
    
    h);;
    n)number="$OPTARG"; let parameter_counter+=1;;
  esac
done

if [ $parameter_counter -eq 0 ]; then
  
  helpPanel
elif [ $parameter_counter -eq 1 ]; then
  
  guess_number "$number"
else
  
  helpPanel
fi
