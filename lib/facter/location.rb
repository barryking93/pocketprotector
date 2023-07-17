# lib/facter/location.rb
# get location from relevant file

Facter.add(:pplocation) do
  locationfile = '/etc/pocketprotector/location'
  setcode do
    File.read(locationfile) if File.exist?(locationfile)
  end
end