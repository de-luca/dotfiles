

function gen() {
    local -a fold range head

    zparseopts -D -E -F - \
        f:=fold -fold:=fold \
        r:=range -range:=range \
        h:=head -head:=head

    fold=${fold[-1]}
    range=${range[-1]:-"a-zA-Z0-9"}
    head=${head[-1]:-1}

    cat /dev/urandom | LC_ALL=C tr -dc $range | fold -w $fold | head -n $head
}

function prepend() {
    while read line; do 
        echo "${1}${line}"
    done;
}

function append() {
    while read line; do 
        echo "${line}${1}"
    done;
}

function preap() {
    while read line; do 
        echo "${1}${line}${2}"
    done;
}