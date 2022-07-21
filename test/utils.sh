
conf="debug=1,rngseed=hex:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"

which zenroom > /dev/null
if [ $? != 0 ]; then
	echo "Error: zenroom interpreter not found in PATH"
	exit 1
fi
if ! ls src/*.zen >/dev/null 2>&1 ; then
	echo "Error: there is no zencode scripts in PWD to run"
	exit 1
fi

results=`mktemp`
echo "# Zenflows tests of zencode scripts" > $results
echo "# `date`" >> $results
echo "# " >> $results

function getscript() {
    if [ -r "src/${1}.zen" ]; then
	echo "src/${1}.zen"
	return
    elif [ -r "src/${1}.ts" ]; then
	tszen=`mktemp` # TODO: delete later
	awk '
BEGIN      {zen=0}
/return `/ { zen=1; next }
/^`}/      { exit }
           { if(zen==1) print $0 }
' src/${1}.ts > $tszen
	echo $tszen
	return
    fi
}

function testzen() {
    script=`getscript ${1}`
    expect="$2"
    input="$3"
    keys="$4"
    >&2 echo "#####################################################"
    >&2 echo "# ${script}"
    >&2 echo "#####################################################"

    tmpin=`mktemp`
    tmpkey=`mktemp`
    if [ -r "${input}" ]; then
	cp ${input} ${tmpin}
    else
	echo "$input" > $tmpin
    fi
    if [ -r "${keys}" ]; then
	cp ${keys} ${tmpkey}
    else
	echo "$keys" > $tmpkey
    fi

    if [ "$keys" != "" ]; then
	result=`cat $script | zenroom -z -c $conf -a $tmpin -k $tmpkey`
	rm -f $tmpin $tmpkey
    elif [ "$input" != "" ]; then
	result=`cat $script | zenroom -z -c $conf -a $tmpin`
	rm -f $tmpin
    else
	result=`cat $script | zenroom -z -c $conf`
    fi

    res=$?
    if [ $res != 0 ]; then
	echo "# [!] Parse error in $script" >> $results
	echo "# $result" >> $results
	error
    else
	# if [ "$result" != "$expect" ]; then
	#     echo "# [!] Error in $script" >> $results
	#     echo "# $result" >> $results
	#     error
	# else
	    echo "#  .  Success: $script" >> $results
	    echo "$result"
	# fi
    fi
}

error() {
    echo >> $results
    >&2 cat $results
    rm -f $results
    exit 1
}
