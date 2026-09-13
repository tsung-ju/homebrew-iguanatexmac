cask "iguanatexmac" do
  version "1.62.1"
  sha256 "e38838f6e6f86ce8768f7928075040f5b11a1d26e8cfe7ebcb077adcf032c588"

  url "https://github.com/Jonathan-LeRoux/IguanaTex/releases/download/v#{version}/IguanaTex_v#{version.tr(".", "_")}.zip"
  name "IguanaTexMac"
  homepage "https://github.com/Jonathan-LeRoux/IguanaTex"

  addin_name = "IguanaTex_v#{version.tr(".", "_")}"
  ppam_name = "#{addin_name}.ppam"
  ppam_dir = "#{Dir.home}/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Add-Ins.localized"

  # Taken from http://youpresent.co.uk/developing-installers-for-office-mac-2016-application-add-ins/
  installer script: {
    executable: "osascript",
    input:      <<~SCRIPT,
      tell application "Microsoft PowerPoint"
        set addIn to register add in "#{ppam_dir}/#{ppam_name}"
        set the auto load of addIn to true
        set the loaded of addIn to true
      end tell
    SCRIPT
  }
  artifact "IguanaTex.scpt",
           target: "#{Dir.home}/Library/Application Scripts/com.microsoft.Powerpoint/IguanaTex.scpt"
  artifact "libIguanaTexHelper.dylib",
           target: "/Library/Application Support/Microsoft/Office365/User Content.localized/Add-Ins.localized/libIguanaTexHelper.dylib"

  preflight_steps do
    run "xattr", args: ["-d", "com.apple.quarantine", "{{staged_path}}/libIguanaTexHelper.dylib"], must_succeed: false
    copy ppam_name.to_s, "#{ppam_dir}/#{ppam_name}"
  end

  uninstall_postflight_steps do
    remove "#{ppam_dir}/#{ppam_name}"
    run "echo", args: ["Restart PowerPoint for the changes to take effect"]
  end

  uninstall script: {
    executable:   "osascript",
    input:        <<~SCRIPT,
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
    SCRIPT
    must_succeed: false,
  }
end
