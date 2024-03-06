# homebrew-IguanaTexMac

Homebrew tap for the Mac version of [IguanaTex](https://github.com/Jonathan-LeRoux/IguanaTex).

To install:
```sh
brew tap tsung-ju/iguanatexmac
brew install --cask --no-quarantine iguanatexmac latexit-metadata
```

To upgrade, close PowerPoint, then run:
```sh
brew upgrade --cask --no-quarantine iguanatexmac latexit-metadata
```
Check in PowerPoint > Tools > PowerPoint Add-ins that the previous version has been fully removed. If it is still there but disabled, remove it using "-".

To uninstall:
```sh
brew uninstall --cask iguanatexmac latexit-metadata
# Restart PowerPoint for the changes to take effect

# To remove this repo from Homebrew
brew untap tsung-ju/iguanatexmac
```
