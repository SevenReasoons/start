$localSkills = Get-ChildItem -Directory "$PSScriptRoot/../.agents/skills"
$globalDir = "$HOME/.gemini/config/skills"
$globalSkills = Get-ChildItem -Directory $globalDir

Write-Host "=== VERIFICANDO SKILLS LOCALES (.agents/skills) ===" -ForegroundColor Cyan
$mismatches = 0
foreach ($d in $localSkills) {
    $f = Join-Path $d.FullName "SKILL.md"
    if (-not (Test-Path $f)) {
        Write-Host "FALTA SKILL.md: $($d.Name)" -ForegroundColor Red
        $mismatches++
        continue
    }
    $raw = Get-Content $f -Raw
    if ($raw -match "name:\s*([^\r\n]+)") {
        $yamlName = $matches[1].Trim()
        if ($d.Name -ne $yamlName) {
            Write-Host "MISMATCH: Dir '$($d.Name)' vs YAML '$yamlName'" -ForegroundColor Red
            $mismatches++
        }
    } else {
        Write-Host "SIN CAMPO NAME: $($d.Name)" -ForegroundColor Red
        $mismatches++
    }
}

$statusColor = if ($mismatches -eq 0) { "Green" } else { "Red" }
Write-Host "Total skills locales: $($localSkills.Count)" -ForegroundColor Green
Write-Host "Mismatches locales: $mismatches" -ForegroundColor $statusColor

Write-Host "`n=== VERIFICANDO SINCRONIZACION GLOBAL (~/.gemini/config/skills) ===" -ForegroundColor Cyan
$globalMissing = 0
foreach ($d in $localSkills) {
    $target = Join-Path $globalDir $d.Name
    if (-not (Test-Path $target)) {
        Write-Host "FALTA EN GLOBAL: $($d.Name)" -ForegroundColor Yellow
        $globalMissing++
    }
}
$globalColor = if ($globalMissing -eq 0) { "Green" } else { "Yellow" }
Write-Host "Total skills globales: $($globalSkills.Count)" -ForegroundColor Green
Write-Host "Faltantes en global: $globalMissing" -ForegroundColor $globalColor
