# test_repo_windows.ps1
$Repo = Split-Path -Leaf (Get-Location)
$Out = Join-Path .. "$Repo-test-report.txt"
"Report for $Repo" | Out-File $Out
(Get-Date) | Out-File $Out -Append
python --version | Out-File $Out -Append
"--- creating venv ---" | Out-File $Out -Append
python -m venv .venv
. .\.venv\Scripts\Activate.ps1
pip install --upgrade pip setuptools wheel | Out-File $Out -Append

if (Test-Path requirements.txt) { 
  "Installing requirements.txt ..." | Out-File $Out -Append
  pip install -r requirements.txt | Out-File $Out -Append
} else {
  "No requirements.txt" | Out-File $Out -Append
}

"Installing scan tools..." | Out-File $Out -Append
pip install pip-audit safety bandit flake8 mypy pytest detect-secrets requests | Out-File $Out -Append

"=== pip-audit ===" | Out-File $Out -Append
pip-audit --progress-spinner off 2>&1 | Out-File $Out -Append

"=== bandit ===" | Out-File $Out -Append
bandit -r . -ll 2>&1 | Out-File $Out -Append

"=== flake8 ===" | Out-File $Out -Append
flake8 . 2>&1 | Out-File $Out -Append

"=== mypy ===" | Out-File $Out -Append
mypy . 2>&1 | Out-File $Out -Append

"=== pytest ===" | Out-File $Out -Append
if (Test-Path tests -PathType Container -or (Get-ChildItem -Filter "test_*.py" -File -ErrorAction SilentlyContinue)) {
  pytest -q 2>&1 | Out-File $Out -Append
} else {
  "No tests found" | Out-File $Out -Append
}

"=== smoke_imports.py output ===" | Out-File $Out -Append
python smoke_imports.py 2>&1 | Out-File $Out -Append

"Report saved to $Out" | Out-File $Out -Append
deactivate
