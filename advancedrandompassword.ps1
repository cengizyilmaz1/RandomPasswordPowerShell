# Cengiz YILMAZ
# MVP - MCT
# https://cengizyilmaz.com.tr

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Function to generate a complex and secure password
function Generate-ComplexPassword {
    param (
        [int]$Length,
        [bool]$IncludeLowerCase,
        [bool]$IncludeUpperCase,
        [bool]$IncludeNumbers,
        [bool]$IncludeSpecialChars
    )

    # Define character sets
    $lowerCase = 97..122 | ForEach-Object { [char]$_ }
    $upperCase = 65..90 | ForEach-Object { [char]$_ }
    $numbers = 48..57 | ForEach-Object { [char]$_ }
    $specialChars = 33..47 + 58..64 + 91..96 + 123..126 | ForEach-Object { [char]$_ }

    # Combine selected character sets
    $charSets = @()
    if ($IncludeLowerCase) { $charSets += $lowerCase }
    if ($IncludeUpperCase) { $charSets += $upperCase }
    if ($IncludeNumbers) { $charSets += $numbers }
    if ($IncludeSpecialChars) { $charSets += $specialChars }

    # Generate the password
    $securePassword = for ($i = 0; $i -lt $Length; $i++) {
        Get-Random -InputObject $charSets
    }

    return -join $securePassword
}

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Advanced Password Generator - Cengiz YILMAZ'
$form.Size = New-Object System.Drawing.Size(420,260)
$form.StartPosition = 'CenterScreen'
$form.AutoSize = $true
$form.AutoSizeMode = 'GrowAndShrink'

# Password Length Label and Numeric UpDown
$labelLength = New-Object System.Windows.Forms.Label
$labelLength.Location = New-Object System.Drawing.Point(10,10)
$labelLength.Size = New-Object System.Drawing.Size(120,20)
$labelLength.Text = 'Password Length:'
$form.Controls.Add($labelLength)

$numUpDownLength = New-Object System.Windows.Forms.NumericUpDown
$numUpDownLength.Location = New-Object System.Drawing.Point(140,10)
$numUpDownLength.Size = New-Object System.Drawing.Size(50,20)
$numUpDownLength.Minimum = 1
$numUpDownLength.Maximum = 128
$numUpDownLength.Value = 25
$form.Controls.Add($numUpDownLength)

# Checkbox for Lowercase, Uppercase, Numbers, Special Characters
$chkLowerCase = New-Object System.Windows.Forms.CheckBox
$chkLowerCase.Location = New-Object System.Drawing.Point(10,40)
$chkLowerCase.Size = New-Object System.Drawing.Size(200,20)
$chkLowerCase.Text = 'Include Lowercase Letters'
$chkLowerCase.Checked = $true
$form.Controls.Add($chkLowerCase)

$chkUpperCase = New-Object System.Windows.Forms.CheckBox
$chkUpperCase.Location = New-Object System.Drawing.Point(10,70)
$chkUpperCase.Size = New-Object System.Drawing.Size(200,20)
$chkUpperCase.Text = 'Include Uppercase Letters'
$chkUpperCase.Checked = $true
$form.Controls.Add($chkUpperCase)

$chkNumbers = New-Object System.Windows.Forms.CheckBox
$chkNumbers.Location = New-Object System.Drawing.Point(10,100)
$chkNumbers.Size = New-Object System.Drawing.Size(200,20)
$chkNumbers.Text = 'Include Numbers'
$chkNumbers.Checked = $true
$form.Controls.Add($chkNumbers)

$chkSpecialChars = New-Object System.Windows.Forms.CheckBox
$chkSpecialChars.Location = New-Object System.Drawing.Point(10,130)
$chkSpecialChars.Size = New-Object System.Drawing.Size(200,20)
$chkSpecialChars.Text = 'Include Special Characters'
$chkSpecialChars.Checked = $true
$form.Controls.Add($chkSpecialChars)

# Output Box for Displaying the Password
$outputBox = New-Object System.Windows.Forms.TextBox
$outputBox.Location = New-Object System.Drawing.Point(10,160)
$outputBox.Size = New-Object System.Drawing.Size(390,20)
$form.Controls.Add($outputBox)

# Button for Generating the Password
$generateButton = New-Object System.Windows.Forms.Button
$generateButton.Location = New-Object System.Drawing.Point(10,190)
$generateButton.Size = New-Object System.Drawing.Size(390,30)
$generateButton.Text = 'Generate Password'
$generateButton.Add_Click({
    $outputBox.Text = Generate-ComplexPassword -Length $numUpDownLength.Value -IncludeLowerCase $chkLowerCase.Checked -IncludeUpperCase $chkUpperCase.Checked -IncludeNumbers $chkNumbers.Checked -IncludeSpecialChars $chkSpecialChars.Checked
})
$form.Controls.Add($generateButton)

# Show the Form
$form.ShowDialog()
