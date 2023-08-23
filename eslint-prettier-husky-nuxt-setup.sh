#!/bin/sh

pnpm add -D eslint

pnpm add -D prettier eslint-config-prettier eslint-plugin-prettier prettier-plugin-tailwindcss

pnpm add -D typescript @typescript-eslint/parser @nuxtjs/eslint-config-typescript

touch .eslintrc.cjs

cat << EOT >> .eslintrc.cjs
module.exports = {
	root: true,
	env: {
		browser: true,
		node: true
	},
	parser: 'vue-eslint-parser',
	parserOptions: {
		parser: '@typescript-eslint/parser'
	},
	extends: ['@nuxtjs/eslint-config-typescript', 'plugin:prettier/recommended'],
	plugins: [],
	rules: {
		'vue/multi-word-component-names': 0
	}
}
EOT

touch .prettierrc.json
cat << EOT >> .prettierrc.json
{
	"useTabs": true,
	"singleQuote": true,
	"trailingComma": "none",
	"semi": false,
	"plugins": ["prettier-plugin-tailwindcss"]
}
EOT

cp .gitignore .prettierignore

mkdir .vscode
touch .vscode/settings.json

cat << EOT >> .vscode/settings.json
{
	"editor.codeActionsOnSave": {
		"source.fixAll.eslint": true
	},
	"editor.formatOnSave": true,
	"editor.defaultFormatter": "esbenp.prettier-vscode"
}
EOT

pnpm pkg set scripts.format="prettier . --write ."
pnpm pkg set scripts.lint="prettier . --check . && eslint ."

# Husky
pnpm dlx husky-init && pnpm install

> .husky/pre-commit
touch .husky/post-commit
cat << EOT >> .husky/pre-commit
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

pnpm lint

FILES=$(git diff --cached --name-only --diff-filter=ACMR | sed 's| |\\ |g')
[ -z "$FILES" ] && exit 0

# Prettify all selected files
echo "$FILES" | xargs ./node_modules/.bin/prettier --ignore-unknown --write

# Add back the modified/prettified files to staging
echo "$FILES" | xargs git add

exit 0
EOT

cat << EOT >> .husky/post-commit
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

git update-index -g
EOT

pnpm format
pnpm lint