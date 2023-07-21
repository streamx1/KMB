### CI training. 
#### AWS. Create 2 additional EC2 instances to have a total of 3 for 3 environments: dev, staging, prod.

```bash
see AWS.dev.staging.prod_1.png
```

#### GitLab-CI. Install gitlab agents on the new 2 EC2s, implement gitflow to separately deploy to dev, staging and prod (by tags).

```bash

-- do for each AWS instance (dev, prod, staging): 

mkdir AWS.DEV && cd AWS.DEV
ssh keygen
cat ~/.ssh/id_rsa.pub
git clone git@github.com:streamx1/KMB.AWS.git
sudo apt-get update && sudo apt-get install git-flow
git flow version
-- OUTPUT: 1.12.3 (AVH Edition)
git flow init

-- OUTPUT:
hint: Using 'master' as the name for the initial branch. This default branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint:   git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint:   git branch -m <name>
Initialized empty Git repository in /home/ubuntu/AWS.DEV/.git/
No branches exist yet. Base branches must be created now.
Branch name for production releases: [master] prod
Branch name for "next release" development: [develop] dev

How to name your supporting branch prefixes?
Feature branches? [feature/]
Bugfix branches? [bugfix/]
Release branches? [release/]
Hotfix branches? [hotfix/]
Support branches? [support/]
Version tag prefix? []
Hooks and filters directory? [/home/ubuntu/AWS.DEV/.git/hooks]


mkdir -p .github/workflows && cd .github/workflows
nano ci.yml

--- ci.yaml
name: CI/CD

on:
  push:
    tags:
      - 'v*'   # teg for prod
      - 's*'   # teg for staging
      - 'd*'   # teg for dev'

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Setup Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '14'

    - name: Install dependencies
      run: npm install

    - name: Run tests
      run: npm test

  deploy_to_dev:
    needs: build
    runs-on: ubuntu-latest
    if: startsWith(github.ref, 'refs/tags/d')

    steps:
    - name: Deploy to Dev
      # Insert code for deploiment dev

  deploy_to_staging:
    needs: build
    runs-on: ubuntu-latest
    if: startsWith(github.ref, 'refs/tags/s')

    steps:
    - name: Deploy to Staging
      # Insert code for deploiment staging

  deploy_to_prod:
    needs: build
    runs-on: ubuntu-latest
    if: startsWith(github.ref, 'refs/tags/v')

    steps:
    - name: Deploy to Production
      # Insert code for deploiment prod

-- end ci.yml

```
