#!/bin/sh

cd `dirname $0`

if [ $# != 2 ]; then
    printf '\033[91m%s\033[m\n' "usage: arg[0]:key_name arg[1]:element"
    exit 1
fi

aws ssm put-parameter \
--type SecureString \
--name $1 --value $2
