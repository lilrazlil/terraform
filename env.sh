#!/bin/bash

environment="DEV";
sort example | uniq -c | awk '{$1="" ; print $0}' | sed -e '1d' > env;
name_secrets=$(sed -r 's/=.+//' env);
secrets=$(sed 's|.*=||' env);
echo "$name_secrets" > name_secrets.txt;
echo "$secrets" > secrets.txt;
echo -n > for_ansible_config.txt;
echo -n > for_ansible_env.txt;
echo -n > for_terraform_env.txt;
for name in $(cat name_secrets.txt)
do
echo $environment\_$name >> for_terraform_env.txt;
echo $name=\${{ secrets.$environment\_$name }} \\ >> for_ansible_config.txt;
echo $name={{ $name }} >> for_ansible_env.txt;
done

b=$(sed -e 's/\"/\\\"/g' -e 's/^/\"/g' -e 's/.$/\"/'  secrets.txt);
sec=$(echo -n $b | sed -e 's/\" \"/\",\"/g');
printf "variable \"secrets\" {
  default=[%s]
}" "$sec" > secrets.tf;

d=$(cat for_terraform_env.txt);
name=$(echo $d | sed -e 's/ /\",\"/g');
printf "variable \"name_secrets\" {
  default=[\"%s\"]
}" "$name" > name_secrets.tf;

terraform apply;