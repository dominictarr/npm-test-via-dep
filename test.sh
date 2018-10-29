
dependant="$1"

commit=`git show --format=format:%H -s`
project=`basename $(pwd)`

echo "$project"@"$commit"_vs_"$dependant"
