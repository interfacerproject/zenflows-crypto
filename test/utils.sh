#!/bin/sh

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
	>&2 echo "Zencode source not found: $1"
	return 1
    fi
    echo $tszen
    return 0
}

zexe() {
    conf="debug=1,rngseed=hex:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    script=`getscript ${1}`
    if [ $? != 0 ]; then return $?; fi
    input="$2"
    keys="$3"
    stdout="" # BATS compatible
    status=1 # BATS compatible
    tmpin=`mktemp`
    tmpkey=`mktemp`
    if [ -r "${input}" ]; then
	 cp ${input} ${tmpin}
    else
	echo "$input" | jq . # check that var is valid json
	if [ $? != 0 ]; then return $?; fi
	echo "$input" > $tmpin
    fi
    if [ -r "${keys}" ]; then
	 cp ${keys} ${tmpkey}
    else
	echo "$keys" | jq . # check that var is valid json
	if [ $? != 0 ]; then return $?; fi
	echo "$keys" > $tmpkey
    fi

    if [ "$keys" != "" ]; then
	output=`zenroom -z $script -c $conf -a $tmpin -k $tmpkey`
	status=$?
	rm -f $tmpin $tmpkey
    elif [ "$input" != "" ]; then
	output=`zenroom -z $script -c $conf -a $tmpin`
	status=$?
	rm -f $tmpin
    else
	output=`zenroom -z $script -c $conf`
	status=$?
    fi
    rm -f $script # getscript() generates this mktemp
    return $status
}

debug() {
    conf="debug=1,rngseed=hex:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    >&3 echo "Zencode: `getscript ${1}`"
    script=`getscript ${1}`
    >&3 cat $script
    if [ $? != 0 ]; then return $?; fi
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
	>&3 zenroom -z $script -c $conf -a $tmpin -k $tmpkey
	res=$?
	rm -f $tmpin $tmpkey
    elif [ "$input" != "" ]; then
	>&3 zenroom -z $script -c $conf -a $tmpin
	res=$?
	rm -f $tmpin
    else
	>&3 zenroom -z $script -c $conf
	res=$?
    fi
    rm -f $script # getscript() generates this mktemp
    return $res
}

# example:
# json_extract "Alice" petition_request.json > petition_keypair.json
function json_extract {
	if ! [ -r extract.jq ]; then
		cat <<EOF > extract.jq
# break out early
def filter(\$key):
  label \$out
  | foreach inputs as \$in ( null;
      if . == null
      then if \$in[0][0] == \$key then \$in
           else empty
           end
      elif \$in[0][0] != \$key then break \$out
      else \$in
      end;
      select(length==2) );
reduce filter(\$key) as \$in ({};
  setpath(\$in[0]; \$in[1]) )
EOF
	fi
	jq -n -c --arg key "$1" --stream -f extract.jq "$2"
}
# example:
# json_remove "Alice" petition_request.json
function json_remove {
	tmp=`mktemp`
	jq -M "del(.$1)" $2 > $tmp
	mv $tmp $2
	rm -f $tmp
}

function json_join {
	jq -s 'reduce .[] as $item ({}; . * $item)' $*
}

function save_json {
    # arg is file to save
    tee "$1" | >&3 jq .
}
