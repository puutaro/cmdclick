

Function addPathForPackages(){
    $addPathPackage = "C:\Program Files\cmdclick\package"
    $env:Path = `
        [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';'
    $regexAddPathPackage = [regex]::Escape($addPathPackage)
    $arrPath = `
        $env:Path -split ';' `
        | Where-Object {$_ -notMatch "^$regexAddPathPackage$"}
    $env:Path = ($arrPath + $addPathPackage) -join ';'
    $env:Path = $env:Path -replace ';+',';'
    
    $addPathSublime = 'C:\Program Files\Sublime Text'
    $regexAddPathSublime = [regex]::Escape($addPathSublime)
    $arrPath = `
        $env:Path -split ';' `
        | Where-Object {$_ -notMatch "$regexAddPathSublime"}
    $env:Path = ($arrPath + $addPathSublime) -join ';'
    $env:Path = $env:Path -replace ';+',';'
    [System.Environment]::SetEnvironmentVariable('Path', "$env:Path", 'Machine');
}
