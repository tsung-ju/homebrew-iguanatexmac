cask 'iguanatexmac' do
  version '1.56-mac.3'
  sha256 '3cc24cac0a11f0e49d5411b02c461859a5befe9f01e96ae3a3329f2b96b7bb8e'

  url "https://github.com/ray851107/IguanaTexMac/releases/download/#{version}/IguanaTex_v#{version.gsub(/[.-]/, '_')}.zip"
  name 'IguanaTexMac'
  homepage 'https://github.com/ray851107/IguanaTexMac'

  artifact "IguanaTex_v#{version.gsub(/[.-]/, '_')}/IguanaTexMac.ppam",
    target: "#{ENV['HOME']}/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Add-Ins.localized/IguanaTexMac.ppam"
  artifact "IguanaTex_v#{version.gsub(/[.-]/, '_')}/IguanaTex.scpt",
    target: "#{ENV['HOME']}/Library/Application Scripts/com.microsoft.Powerpoint/IguanaTex.scpt"
  artifact "IguanaTex_v#{version.gsub(/[.-]/, '_')}/libIguanaTexHelper.dylib",
    target: '/Library/Application Support/Microsoft/Office365/User Content.localized/Add-Ins.localized/libIguanaTexHelper.dylib'

  postflight do
    # Taken from http://youpresent.co.uk/developing-installers-for-office-mac-2016-application-add-ins/
    out, err, status = Open3.capture3('osascript', :stdin_data=>%Q{
      tell application "Microsoft PowerPoint"
        set addIn to register add in "#{ENV['HOME']}/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Add-Ins.localized/IguanaTexMac.ppam"
        set the auto load of addIn to true
        set the loaded of addIn to true
      end tell
    })
    raise err unless status.success?
  end

  uninstall_preflight do
    out, err, status = Open3.capture3('osascript', :stdin_data=>%Q{
      tell application "Microsoft PowerPoint"
        if add ins is not missing value then
          repeat with addIn in (add ins as list)
            if name of addIn = "IguanaTexMac" then
              set loaded of addIn to false
              set auto load of addIn to false
              set registered of addIn to false
            end if
          end repeat
        end if
      end tell
    })
    $stderr.puts err unless status.success?
  end

  uninstall_postflight do
    puts 'Restart PowerPoint for the changes to take effect'
  end
end
