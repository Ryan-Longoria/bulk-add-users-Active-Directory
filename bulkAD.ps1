Import-Module ActiveDirectory
  
$ADUsers = Import-Csv C:\Desktop\users.csv -Delimiter ","

foreach ($User in $ADUsers) {

    $username = $User.username
    $password = $User.password
    $firstname = $User.firstname
    $lastname = $User.lastname
    $OU = $displayName
    $jobtitle = $User.jobtitle
    $department = $User.department

    if (Get-ADUser -F { SamAccountName -eq $username }) {
        
        Write-Warning "A user account with username $username already exists in Active Directory."
    }
    else {

        New-ADUser `
            -SamAccountName $username `
            -UserPrincipalName "$username@test.ing.local" `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -Enabled $True `
            -DisplayName "$lastname, $firstname" `
            -Path $OU `
            -Title $jobtitle `
            -Department $department `
            -AccountPassword (ConvertTo-secureString $password -AsPlainText -Force) -ChangePasswordAtLogon $True
    }
}