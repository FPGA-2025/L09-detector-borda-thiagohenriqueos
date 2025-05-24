#!/bin/sh

if [ -z "$1" ]; then
    echo "Erro: É preciso especificar o número do teste"
    exit 1
fi

iverilog -o tb *.v
rm -f saida.out
cp test/teste$1.txt teste.txt
./tb > saida.out
cp saida.out test/saida$1.out
cp saida.vcd test/saida$1.vcd

# Evita uso de <( ) substituindo com arquivo temporário
grep -v '\$finish' test/saida$1.out > tmp_saida_filtrada.out
if diff tmp_saida_filtrada.out test/saida$1.ok >/dev/null; then
    echo "OK"
    result=0
else
    echo "ERRO"
    result=1
fi

rm saida.out saida.vcd teste.txt tmp_saida_filtrada.out
exit $result
