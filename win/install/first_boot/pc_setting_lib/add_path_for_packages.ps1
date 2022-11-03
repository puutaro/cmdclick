

Function addPathForPackages(){
    $addPathPackage = "C:\Program Files\cmdclick\package"
    $env:Path = `
        [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';'
    $regexAddPathPackage = [regex]::Escape($addPathPackage)
    echo addPathPackage
    echo $regexAddPathPackage
    $arrPath = `
        $env:Path -split ';' `
        | Where-Object {$_ -notMatch "^$regexAddPathPackage$"}
    echo arrPath
    echo $arrPath
    $env:Path = ($arrPath + $addPathPackage) -join ';'
    $env:Path = $env:Path -replace ';+',';'
    echo env:Path
    echo $env:Path

    $addPathSublime = 'C:\Program Files\Sublime Text'
    $regexAddPathSublime = [regex]::Escape($addPathSublime)
    echo addPathSublime
    echo $addPathSublime
    echo regexAddPathSublime
    echo $regexAddPathSublime
    $arrPath = `
        $env:Path -split ';' `
        | Where-Object {$_ -notMatch "$regexAddPathSublime"}
    echo arrPath; echo $arrPath
    $env:Path = ($arrPath + $addPathSublime) -join ';'
    $env:Path = $env:Path -replace ';+',';'
    echo env:Path
    echo $env:Path
    echo $env:Path
    [System.Environment]::SetEnvironmentVariable('Path', "$env:Path", 'Machine');
}
