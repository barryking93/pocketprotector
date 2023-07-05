# lib/facter/gputype.rb
# get GPU vendor

Facter.add(:gputype) do
  vendor = Facter::Core::Execution.exec('lspci -nn | grep -i "VGA\|3D\|2D\|DISPLAY"')
  setcode do
    if vendor.include? "10de"    # Checks if at least one of the GPUs have NVIDIA's PCI vendor id
      'nvidia'
    elsif vendor.include? "1002" # Checks if at least one of the GPUs have AMD's PCI vendor id
      'amd'
    else
      ''
    end
