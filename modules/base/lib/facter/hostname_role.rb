Facter.add('hostname_role') do
    setcode do
        name = Facter.value(:hostname)
        name.scan(/^[a-zA-Z-]*/)[0]
    end
end
