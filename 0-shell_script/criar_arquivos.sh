#!/bin/bash

touch arquivo.txt

cat <<EOF > alunos_com_mais_linhas.txt
um teste com alunos
dois teste com alunos
tres teste com alunos
EOF

cat <<EOF >> alunos_com_mais_linhas.txt
Acrescentando em lote1
Acrescentando em lote2
Acrescentando em lote3
EOF

echo "vou substituir" > alunos_com_mais_linhas.txt
echo "vou crescentar" >> alunos_com_mais_linhas.txt

cat alunos_com_mais_linhas.txt 

vim alunos_com_mais_linhas.txt

rm alunos_com_mais_linhas.txt


