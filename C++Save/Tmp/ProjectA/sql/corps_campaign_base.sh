
#!/bin/bash

F=corps_campaign_base.txt
if [ "$1" != "" ]
then
    F=$1
fi

function corps_campaign_base()
{
# 11,"302,2,3|303,1",0,40,"3,4"
    f=$1
    d=corps_campaign_base
    sed -i /LVL/d $f
    sed -i /lvl/d $f
    sed -i /REF/d $f
    sed -i /^$/d $f
    sed -i s/\"//g $f
    export lines=`wc -l $f | awk '{print $1}'`
    echo "Generating file $d, total lines $l"
    awk '
        BEGIN {
            print "INSERT INTO `corps_campaign_base` VALUES";
        } {
              if(NR > 1)
              {
                printf("(%u,%u,%u,%u,%u)",$1,$2,$3,$4,$5);
                if (NR <= ENVIRON["lines"]-1)
                    printf(",");
                else if (NR >= ENVIRON["lines"])
                    printf(";");
                printf("\n");
              }
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
    corps_campaign_base $F
else
    echo "File $F is not exists"
fi

