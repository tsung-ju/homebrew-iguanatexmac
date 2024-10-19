# homebrew-IguanaTexMac

Homebrew tap for the Mac version of [IguanaTex](https://github.com/Jonathan-LeRoux/IguanaTex).

To install:
```sh
brew tap tsung-ju/iguanatexmac
brew install --cask --no-quarantine iguanatexmac latexit-metadata
```
Note for 10.13 (High Sierra) users:
IguanaTex requires the [Swift 5 Runtime Support](https://support.apple.com/en-us/106446) to function properly on macOS 10.13 (it's included by default on macOS 10.14 and above). Please follow the link to download and install it manually

To upgrade, close PowerPoint, then run:
```sh
brew update
brew upgrade --cask --no-quarantine iguanatexmac latexit-metadata
```
Put your password in if prompted.
If PowerPoint starts and shows an error message complaining that the previous version's `.ppam` file cannot be found,
click Ok and go to `PowerPoint > Tools > PowerPoint Add-ins`, remove the previous version using the "-" button.

To uninstall:
```sh
brew uninstall --cask iguanatexmac latexit-metadata
# Restart PowerPoint for the changes to take effect

# To remove this repo from Homebrew
brew untap tsung-ju/iguanatexmac
```
