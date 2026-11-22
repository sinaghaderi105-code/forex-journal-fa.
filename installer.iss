#define MyAppName "ژورنال معاملاتی فارکس"
#define MyAppExe "ForexJournal.exe"

[Setup]
AppId={{B7A1D1C2-6F6B-4E1B-9C45-1A2B3C4D5E6F}
AppName={#MyAppName}
AppVersion=1.0
AppPublisher=Forex Journal
DefaultDirName={autopf}\ForexJournal
DefaultGroupName={#MyAppName}
OutputDir=installer_output
OutputBaseFilename=ForexJournal_Setup
SetupIconFile=assets\icon.ico
UninstallDisplayIcon={app}\{#MyAppExe}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=lowest
DisableProgramGroupPage=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Shortcuts:"

[Files]
Source: "dist\ForexJournal\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExe}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExe}"; Description: "Launch the app"; Flags: nowait postinstall skipifsilent
