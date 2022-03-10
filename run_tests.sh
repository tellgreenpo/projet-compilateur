#!/bin/bash
for i in tests_ok/*; do
	cat $1 | ./analyseur
	echo "$? -O"
done
