# homebrew-IguanaTexMac

Homebrew tap for the Mac version of [IguanaTex](https://github.com/Jonathan-LeRoux/IguanaTex).

To install:
```sh
brew tap tsung-ju/iguanatexmac
brew install --cask --no-quarantine iguanatexmac latexit-metadata
```

To upgrade, close PowerPoint, then run:
```sh
brew update
brew upgrade --cask --no-quarantine iguanatexmac latexit-metadata
```
Put your password in if prompted. If PowerPoint starts and shows an error message, click Ok.   
If PowerPoint did start, restart it for changes to take effect. 

To uninstall:
```sh
brew uninstall --cask iguanatexmac latexit-metadata
# Restart PowerPoint for the changes to take effect

# To remove this repo from Homebrew
brew untap tsung-ju/iguanatexmac
```
