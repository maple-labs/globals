#!/usr/bin/env bash
set -e

while getopts v: flag
do
    case "${flag}" in
        v) version=${OPTARG};;
    esac
done

echo $version

./build.sh -c ./config/prod.json

rm -rf ./package
mkdir -p package

echo "{
  \"name\": \"@maplelabs/globals\",
  \"version\": \"${version}\",
  \"description\": \"Maple Globals Artifacts and ABIs\",
  \"author\": \"Maple Labs\",
  \"license\": \"AGPLv3\",
  \"repository\": {
    \"type\": \"git\",
    \"url\": \"https://github.com/maple-labs/globals.git\"
  },
  \"bugs\": {
    \"url\": \"https://github.com/maple-labs/globals/issues\"
  },
  \"homepage\": \"https://github.com/maple-labs/globals\"
}" > package/package.json

mkdir -p package/artifacts
mkdir -p package/abis

cat ./out/dapp.sol.json | jq '.contracts | ."contracts/MapleGlobals.sol" | .MapleGlobals' > package/artifacts/MapleGlobals.json
cat ./out/dapp.sol.json | jq '.contracts | ."contracts/MapleGlobals.sol" | .MapleGlobals | .abi' > package/abis/MapleGlobals.json

npm publish ./package --access public

rm -rf ./package
