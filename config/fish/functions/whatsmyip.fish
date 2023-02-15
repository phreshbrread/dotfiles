function whatsmyip
command dig +short txt ch whoami.cloudflare @1.0.0.1 $argv
end
