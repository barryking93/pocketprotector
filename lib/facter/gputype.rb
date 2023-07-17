# lib/facter/gputype.rb
# get GPU vendor

Facter.add(:ppgputype) do
  vendor = Facter::Core::Execution.exec('lspci -nn | grep -i "VGA\|3D\|2D\|DISPLAY"')
  setcode do
    if vendor.include? "10de" # Checks for NVIDIA's PCI vendor id
      'nvidia'
    elsif vendor.include? "1002" # Checks for AMD's PCI vendor id
      'amd'
    else
      ''
    end
  end
end
