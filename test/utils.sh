#!/bin/sh

conf="debug=1,rngseed=hex:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"

getscript() {
    tszen=`mktemp` # delete later
    if [ -r "${1}.zen" ]; then
	cat "${1}.zen" > $tszen
    elif [ -r "${1}.ts" ]; then
	awk '
BEGIN      {zen=0}
/return `/ { zen=1; next }
/^`}/      { exit }
	   { if(zen==1) print $0 }
' ${1}.ts > $tszen
    else
	>&2 echo "Script not found: $1"
	exit 1
    fi
    echo $tszen
    return
}

zexe() {
    script=`getscript ${1}`
    input="$2"
    keys="$3"

    tmpin=`mktemp`
    tmpkey=`mktemp`
    if [ -r "${input}" ]; then
	 cp ${input} ${tmpin}
    else echo "$input" > $tmpin
    fi
    if [ -r "${keys}" ]; then
	 cp ${keys} ${tmpkey}
    else echo "$keys" > $tmpkey
    fi

    if [ "$keys" != "" ]; then
	zenroom -z $script -c $conf -a $tmpin -k $tmpkey
	res=$?
	rm -f $tmpin $tmpkey
    elif [ "$input" != "" ]; then
	zenroom -z $script -c $conf -a $tmpin
	res=$?
	rm -f $tmpin
    else
	zenroom -z $script -c $conf
	res=$?
    fi
    rm -f $script # getscript() generates this mktemp
    return $res
}
