
#!/bin/bash

F=fighter_base_skill.txt
if [ "$1" != "" ]
then
    F=$1
fi

function fighter_base_skill()
{
# 11,"302,2,3|303,1",0,40,"3,4"
    f=$1
    d=fighter_base_skill
    sed -i /LVL/d $f
    sed -i /lvl/d $f
    sed -i /REF/d $f
    sed -i /^$/d $f
    sed -i s/\"//g $f
    export lines=`wc -l $f | awk '{print $1}'`
    echo "Generating file $d, total lines $l"
    awk '
        BEGIN {
            print "INSERT INTO `fighter_base_skill` VALUES";
        } {
            printf("(%u,%d,%d)",$1,$2,$3);
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
        iconv2utf8 $d
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
    fighter_base_skill $F
else
    echo "File $F is not exists"
fi

