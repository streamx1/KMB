### CI training 1.
#### AWS. Create a EC2 instance for a gitlab runner using the portal.

```bash
See picture AWS_1.png and AWS_2.png


ubuntu@ip-172-31-35-7:~$ mkdir actions-runner && cd actions-runner
ubuntu@ip-172-31-35-7:~/actions-runner$
ubuntu@ip-172-31-35-7:~/actions-runner$ curl -o actions-runner-linux-x64-2.305.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.305.0/actions-runner-linux-x64-2.305.0.tar.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100  137M  100  137M    0     0  90.5M      0  0:00:01  0:00:01 --:--:--  119M
ubuntu@ip-172-31-35-7:~/actions-runner$
ubuntu@ip-172-31-35-7:~/actions-runner$ echo "737bdcef6287a11672d6a5a752d70a7c96b4934de512b7eb283be6f51a563f2f  actions-runner-linux-x64-2.305.0.tar.gz" | shasum -a 256 -c
actions-runner-linux-x64-2.305.0.tar.gz: OK
ubuntu@ip-172-31-35-7:~/actions-runner$
ubuntu@ip-172-31-35-7:~/actions-runner$ tar xzf ./actions-runner-linux-x64-2.305.0.tar.gz
ubuntu@ip-172-31-35-7:~/actions-runner$
ubuntu@ip-172-31-35-7:~/actions-runner$ ./config.sh --url https://github.com/streamx1/AWS --token A576GLFRAG2BJKJZJEDAD73ETLMJA

--------------------------------------------------------------------------------
|        ____ _ _   _   _       _          _        _   _                      |
|       / ___(_) |_| | | |_   _| |__      / \   ___| |_(_) ___  _ __  ___      |
|      | |  _| | __| |_| | | | | '_ \    / _ \ / __| __| |/ _ \| '_ \/ __|     |
|      | |_| | | |_|  _  | |_| | |_) |  / ___ \ (__| |_| | (_) | | | \__ \     |
|       \____|_|\__|_| |_|\__,_|_.__/  /_/   \_\___|\__|_|\___/|_| |_|___/     |
|                                                                              |
|                       Self-hosted runner registration                        |
|                                                                              |
--------------------------------------------------------------------------------

# Authentication


√ Connected to GitHub

# Runner Registration

Enter the name of the runner group to add this runner to: [press Enter for Default]

Enter the name of runner: [press Enter for ip-172-31-35-7]

This runner will have the following labels: 'self-hosted', 'Linux', 'X64'
Enter any additional labels (ex. label-1,label-2): [press Enter to skip]

This runner will have the following labels: 'self-hosted', 'Linux', 'X64'
Enter any additional labels (ex. label-1,label-2): [press Enter to skip]

√ Runner connection is good

# Runner settings

Enter name of work folder: [press Enter for _work]

√ Settings Saved.

ubuntu@ip-172-31-35-7:~/actions-runner$ ./run.sh

√ Connected to GitHub

Current runner version: '2.305.0'
2023-06-27 12:26:58Z: Listening for Jobs

```


#### GitLab-CI. Create a project, runner installation on the previously created EC2, run a helloworld job


```bash
--github action

on:
  push:
    branches:
    - master

  pull_request:
    branches:
    - master

jobs:
  prepare:
    runs-on: self-hosted
    steps:

    - name: action1
      uses: actions/checkout@v3

    - name: action2
      id: changed-files
      uses: tj-actions/changed-files@v35

    - name: count tabs
      run: |
        for file in ${{ steps.changed-files.outputs.all_changed_files }}; do
          echo "File $file has `grep -o $'\t' $file | wc -l` TAB." >> nc_report.log
        done
          echo "Hello World"
    - name: Upload report
      uses: actions/upload-artifact@v2
      with:
        path: nc_report.log

See picture AWS_3.png


--result from AWS EC2
√ Connected to GitHub

Current runner version: '2.305.0'
2023-06-27 11:40:07Z: Listening for Jobs
2023-06-27 11:42:34Z: Running job: prepare
2023-06-27 11:42:47Z: Job prepare completed with result: Succeeded

```
