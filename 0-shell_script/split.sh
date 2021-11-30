#!/bin/bash

IN="bla@some.com;john@home.com"
arrIN=(${IN//;/ })
echo ${arrIN[0]}