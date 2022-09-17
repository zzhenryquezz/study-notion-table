#!/usr/bin/env sh

# abort on errors
set -e

# build
BASE_URL=/study-notion-table/ npm run build

# navigate into the build output directory
cd dist

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

git init
git remote add origin git@github.com:zzhenryquezz/study-notion-table.git
git add .
git commit -m "deploy `date +%d-%m-%Y" "%H:%M:%S`"
git branch -M gh-pages

git push -f git@github.com:zzhenryquezz/study-notion-table.git gh-pages

cd -
