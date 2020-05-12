#!/bin/bash

NAME=ubuntu-cli
VERSION=0.0.1

files=`find docker.d/*.docker | sort`

echo "#################################################" > Dockerfile
echo "# DO NOT MODIFY THIS FILE" >> Dockerfile
echo "#################################################" >> Dockerfile

for file in $files; do
	cat $file >> Dockerfile
done


docker build -t $NAME:$VERSION .

docker save -o $NAME-$VERSION.tar $NAME:$VERSION
