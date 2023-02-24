# Write your PowerShell commands here.g 
#$($env:AzureDevOps.PAT)

Write-Host ' - - - - - - - - - - - - - - - - - - - - - - - - -'
Write-Host 'reflect Azure Devops repo changes to GitHub repo'
Write-Host ' - - - - - - - - - - - - - - - - - - - - - - - - - '
$stageDir = '$(Build.SourcesDirectory)' | Split-Path
$githubDir = $stageDir +"\"+"gitHub"
$destination = $githubDir +"\"+"flatriss.git"
#please provide your username
#$alias = 'snowwhite686:'+ "$($env:Github.PAT)"
$alias = 'snowwhite686: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'
$azurepat = "$($env:AzureDevOps.PAT)"
#Please make sure, you remove https from azure-repo-clone-url
$sourceURL = 'https://icloud9@dev.azure.com/icloud9/Features%20Rich%20Epics%20Team/_git/flatriss.git'
#Please make sure, you remove https from github-repo-clone-url
#$destURL ='https://'+ "$($env:Github.PAT)"+'@github.com/snowwhite686/flatrissbck.git'
$destURL = 'https://' + $alias + '@github.com/snowwhite686/flatrissbck.git'
#Check if the parent directory exists and delete
if((Test-Path -path $githubDir))
{
  Remove-Item -Path $githubDir -Recurse -force
}
if(!(Test-Path -path $githubDir))
{
  New-Item -ItemType directory -Path $githubDir
  Set-Location $githubDir
  git clone --mirror $sourceURL
}
else
{
  Write-Host "The given folder path $githubDir already exists";
}
Set-Location $destination
Write-Output '*****Git removing remote secondary****'
git remote rm secondary
Write-Output '*****Git remote add****'
git remote add --mirror=fetch secondary $destURL
Write-Output '*****Git fetch origin****'
git fetch $sourceURL
Write-Output '*****Git push secondary****'
git push secondary --all
Write-Output '**Azure Devops repo synced with Github repo**'
Set-Location $stageDir
