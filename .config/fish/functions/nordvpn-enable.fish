function nordvpn-enable
command ipsec restart $argv
command ipsec up NordVPN $argv
end
