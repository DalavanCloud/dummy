#!/usr/bin/env node

const path = require('path')
const fs = require('fs')
const {execSync} = require('child_process')
const beautify = require('js-beautify')['js_beautify']

// Extract version from TRAVIS_TAG
const [, version] = process.env.TRAVIS_TAG.match(/v(.+)/)

// Write package.json with the version equal to the version encoded in the tag name
const packagePath = path.join(process.cwd(), 'package.json')
const packageContent = JSON.parse(fs.readFileSync(packagePath).toString())
Object.assign(packageContent, {version})
const newPackageContentStr = beautify(JSON.stringify(packageContent), {'indent_size': 2})
fs.writeFileSync(packagePath, `${newPackageContentStr}\n`)

// Setup git and push updated package.json
const githubToken = process.env.GITHUB_TOKEN
execSync('git config --global user.email "koss+jake-the-bot@nocorp.me"')
execSync('git config --global user.name "Jake the Bot"')
execSync('git add package.json')
execSync(`git commit --message "Prepare for v${verson}"`)
execSync(`git remote add origin-pages https://${githubToken}@github.com/date-fns/dummy.git > /dev/null 2>&1`)
execSync('git push --quiet --set-upstream master master')