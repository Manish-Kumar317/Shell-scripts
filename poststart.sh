#!/bin/bash
source_path="/tmp/bootstrap"
execute(){
echo "Execute Function"
setup_scripts=$1
IFS=',' read -r -a scripts <<< "$setup_scripts"

for script in "${scripts[@]}"
do
    echo "$source_path/$script"
done
}
copy(){
echo "Copy Function"
copy_scripts=$1
IFS=',' read -r -a files <<< "$copy_scripts" 
for file in "${files[@]}"
do
    echo "$source_path/$file"
done 
}

activated_products="ifastbase,desktop,sftp,hello"
IFS=',' read -r -a array <<< "$activated_products"

for element in "${array[@]}"
do
    
    case $element in
	       ifastbase)
		        
              echo "$element"
              execute "presetup_ifastbase,setup-ifastbase"
              copy "gensftp,gensftp.exp"
		          ;;
	       desktop)
		          echo  "$element"
              execute "setup_desktop"
		          
		          ;;
	       fundservfiles)
		          
              echo "$element"
              
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