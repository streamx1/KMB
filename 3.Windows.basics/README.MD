### Automatic soft installation.
#### Install Chocolatey, install 7zip and docker using it.

```bash
--Install choco:
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

--Install 7zip:
choco install 7zip

 The install of 7zip.install was successful.
  Software installed to 'C:\Program Files\7-Zip\'

7zip v22.1 [Approved]
7zip package files install completed. Performing other installation steps.
 The install of 7zip was successful.
  Software installed to 'C:\ProgramData\chocolatey\lib\7zip'

Chocolatey installed 4/4 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

--Install Docker:
choco install docker

Chocolatey v1.4.0
Installing the following packages:
docker
By installing, you accept licenses for the packages.
Progress: Downloading docker-cli 24.0.2... 100%
Progress: Downloading docker 99.0.0... 100%

docker-cli v24.0.2 [Approved]
docker-cli package files install completed. Performing other installation steps.
 ShimGen has successfully created a shim for docker.exe
 The install of docker-cli was successful.
  Software installed to 'C:\ProgramData\chocolatey\lib\docker-cli'

docker v99.0.0 [Approved]
docker package files install completed. Performing other installation steps.
The package docker wants to run 'chocolateyInstall.ps1'.
Note: If you don't run this script, the installation will fail.
Note: To confirm automatically next time, use '-y' or consider:
choco feature enable -n allowGlobalConfirmation
Do you want to run the script?([Y]es/[A]ll - yes to all/[N]o/[P]rint): y

WARNING: This package is superseeded by docker-cli, you should install that package from now on.
 The install of docker was successful.
  Software install location not explicitly set, it could be in package or
  default install location of installer.

Chocolatey installed 2/2 packages.
See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

```

### System variables.
#### Add a path to the PATH environment variable.

```bash

$existingPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")  
$newPath = "C:\New\Path\To\Add"  
$newPath = $existingPath + ";" + $newPath  
[Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")  
# it may be needs restart PowerShell

```

### Scheduling.
#### Make an application to be run on each system start.

```bash
$action = New-ScheduledTaskAction -Execute "C:\Path\To\App\App.exe"  


$trigger = New-ScheduledTaskTrigger -AtStartup
$settings = New-ScheduledTaskSettingsSet

Register-ScheduledTask -TaskName "App to be run on each system start" -Action $action -Trigger $trigger -Settings $settings

```




