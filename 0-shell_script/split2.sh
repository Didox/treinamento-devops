#!/bin/bash

# ======= outra forma de fazer um split ========

INPUT='someletters_12345_moreleters.ext'
SUBSTRING=$(echo $INPUT| cut -d'_' -f 2)
echo $SUBSTRING
