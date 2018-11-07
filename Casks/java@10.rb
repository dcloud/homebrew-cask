cask 'java' do
  version '10.0.2,13:19aef61b38124481863b1413dce1855f'
  sha256 '77ea7675ee29b85aa7df138014790f91047bfdafbc997cb41a1030a0417356d7'

  url "https://download.java.net/java/GA/jdk#{version.major}/#{version.before_comma}/#{version.after_colon}/#{version.after_comma.before_colon}/openjdk-#{version.before_comma}_osx-x64_bin.tar.gz"
  name 'OpenJDK'
  homepage 'https://jdk.java.net/'

  postflight do
    system_command '/bin/mv',
                   args: ['-f', '--', "#{staged_path}/jdk-#{version.before_comma}.jdk",
                          "/Library/Java/JavaVirtualMachines/openjdk-#{version.before_comma}.jdk"],
                   sudo: true

    system_command '/bin/mkdir',
                   args: ['-p', '--', "/Library/Java/JavaVirtualMachines/openjdk-#{version.before_comma}.jdk/Contents/Home/bundle/Libraries"],
                   sudo: true

    system_command '/bin/ln',
                   args: ['-nsf', '--', "/Library/Java/JavaVirtualMachines/openjdk-#{version.before_comma}.jdk/Contents/Home/lib/server/libjvm.dylib",
                          "/Library/Java/JavaVirtualMachines/openjdk-#{version.before_comma}.jdk/Contents/Home/bundle/Libraries/libserver.dylib"],
                   sudo: true
  end

  uninstall delete: "/Library/Java/JavaVirtualMachines/openjdk-#{version.before_comma}.jdk"
end
