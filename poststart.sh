#!/bin/bash
source_path="/f/Wipro/bootstrap"
dest_path="/f/Wipro/copy"

check_file(){
	echo "Check File"
	file=$1
	if [ ! -f "$source_path/$file" ]
	then
    	echo "$0: File '${file}' not found."
    	exit 0
	fi
}


#Execute Function
execute(){
echo "Execute Function"
setup_scripts=$1
IFS=',' read -r -a scripts <<< "$setup_scripts"

for script in "${scripts[@]}"
do
    echo "$source_path/$script"
    check_file $script
    sh $source_path/$script
    if [ $? == 0 ]
    then
    	echo "Script $script has been executed successfully"
    else
    	echo  "Script $script execution failed"
    fi  	
done
}

copy(){
echo "Copy Function"
copy_scripts=$1
IFS=',' read -r -a files <<< "$copy_scripts" 
for file in "${files[@]}"
do
    echo "$source_path/$file"
    check_file $file
    cp $source_path/$file $dest_path/$file
    if [ $? == 0 ]
    then
    	echo "File $file has been copied successfully"
    else
    	echo  "File $file copy failed"
    fi
done 
}

activated_products="ifastbase,desktop,sftp,hello"
IFS=',' read -r -a array <<< "$activated_products"

for element in "${array[@]}"
do
    
    case $element in
	       ifastbase)
		        
              echo "$element"
              execute "presetup_ifastbase,setup_ifastbase"
              copy "gensftp,gensftp.exp"
		          ;;
	       desktop)
		          echo  "$element"
              execute "setup_desktop"
		          
		          ;;
	       fundservfiles)
		          
              echo "$element"
              execute "setup_fundservfiles"
              
		          ;;
	       fundservtrading)
		          
              echo "$element"
              execute "setup_fundservtrading"
              
		          ;;
	       swifttrading)
		          
              echo "$element"
              execute "setup_fundservfilesgit"
              
		          ;;

	       sftp)
		          
              echo "$element"
              copy "filetransfer.sh"
              
		          ;;                            
	       *)
		          echo "Product not configured"
		          ;;
  esac
done
