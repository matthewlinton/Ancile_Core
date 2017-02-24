# Ancile Core(https://bitbucket.org/ancile_development/ancile_core)
Ancile Core is a set of scripts that configure your Windows shell to run plugins that can be placed in the plugins directory.

For more information go to https://voat.co/v/ancile

## Features
*  Sync Windows time with ntp.org
*  Generate a Windows restore point before making changes.
*  Support for 3rd party plugins

## Instructions
Ancile Core does not require installation and can be run directly from within it's parent folder.

1. Clone the latest repository (git clone https://matthewlinton@bitbucket.org/ancile_development/ancile_core.git)
1. Navigate to the Ancile Core directory.
1. Optionally, install any third party plugins.
1. Right click on "ancile.cmd"
1. Select "Run as Administrator" from the menu
1. Follow the on screen instructions

## Configuration
### Configuration File
Some aspects of Ancile Core can be configured using the "config.ini" file in the root directory. This allows you to customize some of Ancile's behavior. All Ancile configuration options are outlined within the config file itself.

### Data Folder
The data folder contains various configuration information for Ancile Core. You can modify the behavior of some of these by adding or removing the correct configuration options within the data folders.

**WARNING:** Incorrect modifications to any of these files may break Ancile and could potentially damage your system. Do not make any modifications to these files or folders unless you know what you're doing.

### Plugins
Users can create their own plugins for Ancile Core. For more information check out the Example plugin (https://bitbucket.org/ancile_development/ancileplugin_example).

## License
This code is not covered under any license. You are welcome to modify and share this code as you please.

## Liability
Use Ancile at your own risk!

Ancile, to the best of my knowledge, does not contain any harmful or malicious code. I assume no liability for any issues that may occur from the use of this software. Please take the time to understand how this code will interact with your system before using it.

## Resources
Ancile Core uses the following third party resources to perform specific tasks.

### Synchronous-ZipAndUnzip.psm1
Synchronous-ZipAndUnzip.psm1 is a powershell module created by Daniel Schroeder to add Zip and un-Zip functionality to powershell 2.0 environments.

### Other
* setacl-**.exe (https://helgeklein.com/setacl/) : Modify ACL permissions on files.

## Feedback
Please direct all feedback to the Voat subverse (https://voat.co/v/ancile/).

If you find a bug, please take the time to report it (https://bitbucket.org/ancile_development/ancile_core/issues).
