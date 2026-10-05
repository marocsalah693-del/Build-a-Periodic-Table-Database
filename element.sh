#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
  echo 'Please provide an element as an argument.'
  exit
fi 
if [[ $1 =~ ^[0-9]+$ ]]
then
  data=$($PSQL "select atomic_number,name,symbol,t.type,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius from elements e join properties p using(atomic_number) join types t using (type_id) where atomic_number='$1';")
else
  data=$($PSQL "select atomic_number,name,symbol,t.type,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius from elements e join properties p using(atomic_number) join types t using (type_id) where symbol='$1' or name='$1';")
fi
if [[ -z $data ]]
then
  echo "I could not find that element in the database."
else
echo "$data" | while IFS="|" read atomic_number name symbol  type atomic_mass melting_point_celsius boiling_point_celsius
do 
  echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
done
fi
