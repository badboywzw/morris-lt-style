[CmdletBinding()]
param(
    [string]$SkillRoot = 'F:\codex\skills',
    [string]$DiscoveryRoot
)

$ErrorActionPreference = 'Stop'
$sourceRoot = [IO.Path]::GetFullPath($PSScriptRoot)
$nameMatch = [regex]::Match([IO.File]::ReadAllText((Join-Path $sourceRoot 'SKILL.md')), '(?m)^name:\s*([a-z0-9-]+)\s*$')
if (-not $nameMatch.Success) { throw 'SKILL.md must contain a valid name.' }
$skillName = $nameMatch.Groups[1].Value
if (-not $DiscoveryRoot) {
    $discoveryBase = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path ([Environment]::GetFolderPath('UserProfile')) '.codex' }
    $DiscoveryRoot = Join-Path $discoveryBase 'skills'
}
$targetPath = [IO.Path]::GetFullPath((Join-Path $SkillRoot $skillName)).TrimEnd('\')
$discoveryPath = [IO.Path]::GetFullPath((Join-Path $DiscoveryRoot $skillName)).TrimEnd('\')
$sourceRoot = $sourceRoot.TrimEnd('\')
$bundleNames = @('SKILL.md', 'agents', 'references', 'assets', 'README.md', 'install.ps1', '.gitignore', '.gitattributes')

# Check collisions before copying anything; never replace an existing skill or link.
$existingLink = Get-Item -LiteralPath $discoveryPath -Force -ErrorAction SilentlyContinue
if ($existingLink -and $discoveryPath -ine $targetPath) {
    if ($existingLink.LinkType -ne 'Junction' -or [IO.Path]::GetFullPath([string]$existingLink.Target).TrimEnd('\') -ine $targetPath) {
        throw "Discovery path already exists and points elsewhere: $discoveryPath"
    }
}

if ($sourceRoot -ine $targetPath) {
    if (Test-Path -LiteralPath $targetPath) {
        foreach ($bundleName in $bundleNames) {
            $sourceEntry = Join-Path $sourceRoot $bundleName
            if (-not (Test-Path -LiteralPath $sourceEntry)) { continue }
            $sourceFiles = if (Test-Path -LiteralPath $sourceEntry -PathType Container) {
                @(Get-ChildItem -LiteralPath $sourceEntry -Recurse -File -Force)
            } else { @(Get-Item -LiteralPath $sourceEntry -Force) }
            foreach ($sourceFile in $sourceFiles) {
                $relativePath = $sourceFile.FullName.Substring($sourceRoot.Length + 1)
                $targetFile = Join-Path $targetPath $relativePath
                if (-not (Test-Path -LiteralPath $targetFile -PathType Leaf) -or
                    (Get-FileHash -LiteralPath $sourceFile.FullName).Hash -ne (Get-FileHash -LiteralPath $targetFile).Hash) {
                    throw "Target differs from this package. Review it before updating: $targetPath"
                }
            }
        }
    } else {
        New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
        foreach ($bundleName in $bundleNames) {
            $sourceEntry = Join-Path $sourceRoot $bundleName
            if (Test-Path -LiteralPath $sourceEntry) {
                Copy-Item -LiteralPath $sourceEntry -Destination $targetPath -Recurse
            }
        }
    }
}

if ($discoveryPath -ine $targetPath -and -not $existingLink) {
    New-Item -ItemType Directory -Path $DiscoveryRoot -Force | Out-Null
    New-Item -ItemType Junction -Path $discoveryPath -Target $targetPath | Out-Null
}
Write-Output "Installed: $targetPath"
Write-Output "Discoverable: $discoveryPath"
