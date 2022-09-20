// "postinstall": "node build/post-install.js",

// copyfile.js
const fs = require('fs')

// destination will be created or overwritten by default.
fs.copyFile('./git-hooks/prepare-commit-msg', './.git/hooks/prepare-commit-msg', err => {
  if (err) throw err
  console.log('File was copied to destination')
})

// destination will be created or overwritten by default.
fs.copyFile('./git-hooks/pre-commit', './.git/hooks/pre-commit', err => {
  if (err) throw err
  console.log('File was copied to destination')
