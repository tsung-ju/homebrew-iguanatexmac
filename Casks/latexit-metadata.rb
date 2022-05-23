cask 'latexit-metadata' do
  version '1.60'
  sha256 '42e23e9ef173de1c716e22a4c842e0a903d543db8b0624d963105e952339d31d'

  url "https://github.com/Jonathan-LeRoux/IguanaTex/releases/download/v#{version}/LaTeXiT-metadata-macos"
  name 'LaTeXiT-metadata'
  homepage 'https://github.com/Jonathan-LeRoux/IguanaTex'

  artifact "LaTeXiT-metadata-macos",
    target: '/Library/Application Support/Microsoft/Office365/User Content.localized/Add-Ins.localized/LaTeXiT-metadata-macos'

  preflight do
    set_permissions "#{staged_path}/LaTeXiT-metadata-macos", "0755"
  end
end
