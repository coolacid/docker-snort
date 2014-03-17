CUSTOMRULES=""
OINKCODE=""
SUBSCRIBER="NO" # Set to YES if you are getting subscribed rules
SNORTVER=2960
BASEDIR=/etc/snort

if [ -n "$CUSTOMRULES" ]; then
    # If CustomRules is set, download them, and apply
    echo Downloading Custom rules
    wget "$CUSTOMRULES"  -O snortrules.tar.gz
    if [ ! -d "$BASEDIR" ]; then
	mkdir -p "$BASEDIR"
    fi
    tar xvfvz snortrules.tar.gz -C $BASEDIR
elif [ -z "$OINKCODE" ]; then
    # If Oinkcode is blank, just download the community rules
    #wget https://s3.amazonaws.com/snort-org/www/rules/community/community-rules.tar.gz -O community-rules.tar.gz
    echo TODO: Blank OINK Code
elif [ "$SUBSCRIBER" == "YES" ]; then
    # If a Subscriber, download the sub codes
    #wget http://www.snort.org/sub-rules/snortrules-snapshot-2931.tar.gz/$OINKCODE -O snortrules-snapshot-$SNORTVER.tar.gz
    echo TODO: Subscribed VRT rules
else
    # If Oinkcode has a value, download the reg rules and the community codes, applying the community codes over top.
    echo Downloading Registered VRT Rules
    wget http://www.snort.org/reg-rules/snortrules-snapshot-2931.tar.gz/$OINKCODE  -O snortrules-snapshot-$SNORTVER.tar.gz
    if [ ! -d "$BASEDIR" ]; then
	mkdir -p "$BASEDIR"
    fi
    tar xvfvz snortrules-snapshot-$SNORTVER.tar.gz -C $BASEDIR
fi
