# lib/facter/pp_location.rb
# get location from relevant file

Facter.add(:pp_location) do
  locationfile = '/etc/pocketprotector/location'
  setcode do
    File.read(locationfile) if File.exist?(locationfile)
  end
end
