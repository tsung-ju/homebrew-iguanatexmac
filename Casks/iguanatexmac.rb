cask 'iguanatexmac' do
  version '1.61'
  sha256 'fe46d46778258dc008f1cd011a7c3e117d6b2eeb1dfa18606622e13b285c3efe'


  url "https://github.com/Jonathan-LeRoux/IguanaTex/releases/download/v#{version}/IguanaTex_v#{version.gsub('.', '_')}.zip"
  name 'IguanaTexMac'
  homepage 'https://github.com/Jonathan-LeRoux/IguanaTex'

  addin_name = "IguanaTex_v#{version.gsub('.', '_')}"
  ppam_name = "#{addin_name}.ppam"
  ppam_dir = "#{ENV['HOME']}/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Add-Ins.localized"

  artifact ppam_name,
    target: "#{ppam_dir}/#{ppam_name}"
  artifact "IguanaTex.scpt",
    target: "#{ENV['HOME']}/Library/Application Scripts/com.microsoft.Powerpoint/IguanaTex.scpt"
  artifact "libIguanaTexHelper.dylib",
    target: '/Library/Application Support/Microsoft/Office365/User Content.localized/Add-Ins.localized/libIguanaTexHelper.dylib'

  postflight do
    # Taken from http://youpresent.co.uk/developing-installers-for-office-mac-2016-application-add-ins/
    out, err, status = Open3.capture3('osascript', :stdin_data=>%Q{
      tell application "Microsoft PowerPoint"
        set addIn to register add in "#{ppam_dir}/#{ppam_name}"
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
            if name of addIn = "#{addin_name}" or name of addIn = "#{ppam_name}" then
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
