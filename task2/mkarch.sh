#!/bin/bash
dir_path="";
name="";
usage="Usage: $(basename $0) -d dir_path -n script_name [-h for help]"
if [ -z "$1" ]; then
   echo "$usage"
   exit 1
fi
while getopts ':d:n:h' opt; do
  case "$opt" in
    d)
      dir_path="$OPTARG"
      ;;
    n)
      name="$OPTARG"
      ;;
    h)
      echo $usage
      exit 0
      ;;
    :)
      echo -e "option requires an argument.\n$usage"
      exit 1
      ;;
    ?)
      echo -e "Invalid command option.\n$usage"
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"
tar_file="$(pwd)/$name.tar.gz"
tar -czvf $tar_file -C $dir_path .
touch $name.sh
echo '#!/bin/bash' >> $name.sh
echo "tar_path=$tar_file" >> $name.sh
printf 'dir_path=$(pwd)
      usage="Usage: $(basename $0) [-o dir_path] [-h for help]"
      while getopts ':o:h' opt; do
        case "$opt" in
          o)
            dir_path="$OPTARG"
            ;;
          h)
            echo $usage
            exit 0
            ;;
          :)
            echo -e "option requires an argument.\n$usage"
            exit 1
            ;;
          ?)
            echo -e "Invalid command option.\n$usage"
            exit 1
            ;;
        esac
      done
      shift "$(($OPTIND -1))"
      tar -xzvf $tar_path -C $dir_path' >> $name.sh
chmod +x $name.sh


