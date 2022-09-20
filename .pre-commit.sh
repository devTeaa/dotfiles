#     "format-eslint": "eslint --fix",
#     "format-prettier-eslint": "prettier-eslint --log-level 'silent' --write --eslint-config-path .eslintrc.js",
#     "format-stylelint": "stylelint --config .stylelintrc.json --fix"\

#     "eslint": "^7.32.0",
#     "eslint-config-prettier": "^6.8.0",
#     "eslint-config-standard": "^6.2.1",
#     "eslint-friendly-formatter": "^2.0.7",
#     "eslint-loader": "^3.0.3",
#     "eslint-plugin-html": "^6.0.0",
#     "eslint-plugin-import": "^2.19.1",
#     "eslint-plugin-jest": "^23.1.1",
#     "eslint-plugin-node": "^10.0.0",
#     "eslint-plugin-only-warn": "^1.0.1",
#     "eslint-plugin-prettier": "^3.1.2",
#     "eslint-plugin-promise": "^4.2.1",
#     "eslint-plugin-sort-imports-es6-autofix": "^0.5.0",
#     "eslint-plugin-standard": "^4.0.1",
#     "eslint-plugin-vue": "^6.0.1",
#     "prettier": "^1.19.1",
#     "prettier-eslint": "^9.0.1",
#     "prettier-eslint-cli": "^5.0.0",
#     "stylelint": "^14.5.0",
#     "stylelint-config-recommended-scss": "^5.0.2",
#     "stylelint-config-recommended-vue": "^1.3.0",
#     "stylelint-config-sass-guidelines": "^9.0.1",
#     "stylelint-config-standard": "^25.0.0",
#     "stylelint-config-standard-vue": "^1.0.0",

#!/bin/bash
PASS=true
STAGED_FILES=$(git diff --diff-filter=d --cached --name-only | grep -E '.*\.(js|vue|ts)$' | grep -v 'api-types')

if [[ "$STAGED_FILES" = "" ]]; then
  exit 0
fi

echo -e "\033[0;33m☐ Running pre-commmit-hooks:\e[0m"

for FILE in $STAGED_FILES
do
  PRE_LINT_HASH=$(git hash-object "$FILE")
  if [[ $FILE == *vue ]]; 
  then
    npm run --silent format-stylelint "$FILE" || PASS=false
  else
    npm run --silent format-prettier-eslint "$FILE" || PASS=false
    npm run --silent format-eslint "$FILE" || PASS=false
  fi

  POST_LINT_HASH=$(git hash-object "$FILE")
  if [[ "$PRE_LINT_HASH" != "$POST_LINT_HASH" ]]; then
    PASS=false
  fi
done

if ! $PASS; then
  echo -e "\033[0;31m☒ pre-commmit-hooks failed, please check all the errors or stage all changes\e[0m"
  exit 1
fi

exit $?
