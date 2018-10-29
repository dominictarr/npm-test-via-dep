set -e
dependent="$1"

commit=$(git show --format=format:%H -s)
project=$(node -p "require('./package.json').name")
depdir=$(pwd)
echo "$project"@"$commit"_vs_"$dependent"

testpath=/tmp/test_dependent/"$project"@"$commit"_vs_"$dependent"
rm -rf "$testpath"
mkdir -p "$testpath"

echo $testpath
cd $testpath

##npm show "$dependent" --json > package.json
mkdir node_modules
npm install "$dependent" --global-style
cd node_modules/$dependent
npm install #to get dev deps
cd node_modules
# error if the dep to be tested doesn't exist
test -e "$project" || {
  echo "cannot test $project using $dependent" >&2
  echo "$dependent does not depend on $project" >&2
  exit 1
}

rm -rf "$project"
ln -s "$depdir" "$project"
cd ..
npm test



