# $1 是否递归改文件后缀；
# $2 文件路径
# $3 旧文件后缀
# $4 新文件后缀
function changeFilesSuffix {
oldPath=`pwd`
suffix="*.$3"
cd $2;
subPath=`pwd`;
files=`ls`
for file in $files
do
	if [ -d $file ] ; then
		if [ $1 = true ] ; then
			changeFilesSuffix true $subPath/$file $3 $4; 
		fi
	else
		if [ ${file##*.} = $3 ] ; then
			echo "$file suffix changed!"
                	newFileName=${file%.*}.$4
                	mv $file $newFileName
		fi
	fi
done
cd $oldPath
}

# 脚本功能：批量修改文件名后缀
# 用法：-r 递归修改文件名后缀
#	-d 需要修改文件名后缀的文件夹
#	两个参数，第一个参数为需要修改的后缀，第二个参数为新的后缀
if [ $# -lt 2 ] ; then
    echo "usage: " + $0 + "targetDirectory oldSuffix newSuffix ";
	return;
fi
isRecursion=false;
path=`pwd`;
while getopts :rd: opt
do
    case "$opt" in
    r) isRecursion=true;;
    d) path=$OPTARG;;
    *) echo "Error: allow options: -r -d";;
    esac
done
shift $[$OPTIND - 1];
changeFilesSuffix $isRecursion $path $1 $2;

