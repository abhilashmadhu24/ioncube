#!/bin/bash

# Author Abhilash CloudStick.io

PHPVERSION=$2

if [ $PHPVERSION == 'php55' ]; then
        PHPVRS='php55cs'
        FOLDER='no-debug-non-zts-20121212'
        FILE='ioncube_loader_lin_5.5.so'

elif [ $PHPVERSION == 'php56' ]; then
        PHPVRS='php56cs'
        FOLDER='no-debug-non-zts-20131226'
        FILE='ioncube_loader_lin_5.6.so'

elif [ $PHPVERSION == 'php70' ]; then
        PHPVRS='php70cs'
        FOLDER='no-debug-non-zts-20151012'
        FILE='ioncube_loader_lin_7.0.so'

elif [ $PHPVERSION == 'php71' ]; then
        PHPVRS='php71cs'
        FOLDER='no-debug-non-zts-20160303'
        FILE='ioncube_loader_lin_7.1.so'

elif [ $PHPVERSION == 'php72' ]; then
       PHPVRS='php72cs'
       FOLDER='no-debug-non-zts-20170718'
       FILE='ioncube_loader_lin_7.2.so'

elif [ $PHPVERSION == 'php73' ]; then
       PHPVRS='php73cs'
       FOLDER='no-debug-non-zts-20180731'
       FILE='ioncube_loader_lin_7.3.so'

else
        echo "Bad argument"
fi

function ioncube ()
{
        cd
        wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
        tar xzf ioncube_loaders_lin_x86-64.tar.gz
        cp ioncube/$FILE /CloudStick/Packages/$PHPVRS/lib/php/extensions/$FOLDER/
        echo "zend_extension=/CloudStick/Packages/$PHPVRS/lib/php/extensions/$FOLDER/$FILE" > /etc/$PHPVRS/conf.d/ioncube.ini
        systemctl restart $PHPVRS-fpm.service
        rm -r ioncube*

        /CloudStick/Packages/$PHPVRS/bin/php -m | grep -i ioncube

        echo "Done!!!!"
}
function remioncube ()
{
        rm /etc/$PHPVRS/conf.d/ioncube.ini
        rm /CloudStick/Packages/$PHPVRS/lib/php/extensions/$FOLDER/$FILE
        systemctl restart $PHPVRS-fpm.service
        echo "Done!!!"
}
function main()
{
        if [ $# -lt 1 ];
        then
                echo "usage: --install phpXY | --remove phpXY"
                exit 1
        fi

        DEC=$1
        shift

        if [ $DEC = "--install" ]; then
                ioncube $@

        elif [ $DEC = "--remove" ]; then
                        remioncube $@
        else
                echo [$DEC] a bad argument.
        fi
}
main $@
