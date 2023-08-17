#!/bin/bash

localhostname=`hostname`
numargs=$#
minsupportedargs=2
#printf "[+] $0 script is being executed on: $localhostname \n"

case $localhostname in
        ""server1"")
                   desthostname="server2"
           #printf "[+] Files will be copied to: $desthostname\n"
           ;;
        ""server2"")
                   desthostname="server1"
           #printf "[+] Files will be copied to: $desthostname\n"
           ;;
        *)
           #printf "[-] server is not supported by the script, files won't be copied\n"
                               desthostname="invalid_server"
                ;;
esac
sum_of_file_size_in_bytes=0
if [ ! "$desthostname" == ""invalid_server"" ] ; then
        if (($numargs >= $minsupportedargs)) ; then
                        destfolder=${!#}
                        #printf "[+] $0 is executing a copy process of local files from $localhostname to $destfolder on $desthostname:\n"
                        args=( "$@" )
                        argsarraylength=${#args[@]}
                        for (( i=0; i<${argsarraylength}-1; i++ ));
                        do
                                        file=${args[$i]}
                                                                        if [  -e "$file" ]
                                                                        then
                                                                                        #printf "\tscp -q $file $desthostname:$destfolder\n"
                                                                                        copyfile=$(scp -q $file $desthostname:$destfolder 2>&1)
																						if [ $? -eq 0 ]; then
																							file_size_in_bytes=$(ls -la $file | awk -F' ' '{print$5}')
																							#printf "\t\t$file file size ib bytes is $file_size_in_bytes\n"
																							sum_of_file_size_in_bytes=$(($sum_of_file_size_in_bytes+$file_size_in_bytes))
																						else
																							#printf "\tFile $file could not be copied due to an error\n"
																							sum_of_file_size_in_bytes=$(($sum_of_file_size_in_bytes+0))
																						fi
                                                                        else
                                                                                        #printf "\tFile $file does not exist, therefore, won't be copied\n"
																						sum_of_file_size_in_bytes=$(($sum_of_file_size_in_bytes+0))
                                                                        fi
                        done
        fi
fi
printf "$sum_of_file_size_in_bytes\n"

