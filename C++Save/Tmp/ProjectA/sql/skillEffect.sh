
#!/bin/bash

F=skillEffect.txt
if [ "$1" != "" ]
then
    F=$1
fi

function skillEffect()
{
# 11,"302,2,3|303,1",0,40,"3,4"
    f=$1
    d=skillEffect
    sed -i /LVL/d $f
    sed -i /lvl/d $f
    sed -i /REF/d $f
    sed -i /^$/d $f
    sed -i s/\"//g $f
    export lines=`wc -l $f | awk '{print $1}'`
    echo Generating file $d, total lines $l
    awk '
        BEGIN {
            print "INSERT INTO `skillEffect` VALUES";
        } {
            printf("(%u,\x27%s\x27,%d,%u,%u,%.2f,%u,%.2f,%.2f,%u,%u)",$1,$2,$3,$4,$5,$6,$7,$8,$9,$11,$12);
            if (NR <= ENVIRON["lines"]-1)
                printf(",");
            else if (NR >= ENVIRON["lines"])
                printf(";");
            printf("\n");
        }
        END {
        }
    ' $f > $d
    sed -i s/\\r//g $d
    if [ $? -eq 0 ]
    then
#        iconv2utf8 $d
        echo "OK"
    else
        echo "ERROR"
    fi
}

function iconv2utf8()
{
    iconv -f cp936 -t utf8 $1 -o $1.tmp
    rm $1
    mv $1.tmp $1
}

if [ -f $F  ]
then
    skillEffect $F
else
    echo "File $F is not exists"
fi

