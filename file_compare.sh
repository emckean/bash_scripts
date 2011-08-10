#!/bin/bash
# run this script with "bash -x file_compare.sh FILENAME1 FILENAME2 OUTPUTFILE"
# or chmod +x file_compare.sh
# files need to be sorted first; if it fails inexplicably, check the newline flavor (unix, mac, win)

#here's the first function I've written since 1999
test_file () {

	for filename in ${commandline_args[@]} ; do
		if   [ -d "${filename}" ]
			then echo "${filename} is a directory";
			exit 1
		elif [ -f "${filename}" ]
			then echo "${filename} is a file";
		elif [ ! -e "${filename}" ]
			then touch "${filename}";
		elif [ ! -w "${filename}" ]
			then echo "Can't write to ${filename}";
		else echo "${filename} is not valid";
     		exit 1
		fi
	done	
}
# push the command line args into an array, because some guy on StackOverflow said that it was easier to pass to a function that way

commandline_args=("$@")

# check for right # of command-line arguments
arg_length=("${#commandline_args[*]}")
#echo $arg_length

if [ "$arg_length" != 3 ]
	then echo "Sorry, wrong number of files! Arguments are FILENAME1 FILENAME2 OUTPUTFILE";
	exit 1
fi

# test if files are actually files and valid
test_file
echo  "comparing your two files: $1 and $2."
echo  "Output file: $3"


#okay, now compare the files
comm -23 <(sort $1) <(sort $2) > $3
echo  "$3 is ready"

#end