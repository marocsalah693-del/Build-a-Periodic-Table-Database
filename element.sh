#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

echo 'Please provide an element as an argument.'
read ELM
data=$($PSQL "select * from elements join properties using(atomic_number) where atomic_number='$ELM';")
echo $data["name"]
