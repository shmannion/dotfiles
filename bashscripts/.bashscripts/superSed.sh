find . -type f -name '*.tex' -exec sed -i '' s%mark\=o%'mark\=\*\,mark\ options\=\{solid \,\ fill\=white\}'%g {} +
