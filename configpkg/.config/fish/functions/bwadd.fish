function bwadd --description "Add a login to Bitwarden"
    argparse p/prompt -- $argv
    or return 1

    if test (count $argv) -lt 2
        echo "usage: bwadd [-p] NAME USERNAME [https://site]"
        echo "  -p  type the password manually (otherwise one is generated)"
        return 1
    end

    set -l name $argv[1]
    set -l user $argv[2]
    set -l uri ""
    test (count $argv) -ge 3; and set uri $argv[3]

    if not set -q BW_SESSION
        set -gx BW_SESSION (bw unlock --raw)
        or return 1
    end

    set -l pw
    if set -q _flag_prompt
        read -s -P "Password: " pw
    else
        set pw (bw generate -uln --length 24)
    end

    bw get template item | jq \
        --arg n "$name" --arg u "$user" --arg p "$pw" --arg uri "$uri" \
        '.type=1 | .name=$n
         | .login={username:$u, password:$p,
                   uris:(if $uri=="" then [] else [{match:null,uri:$uri}] end)}' \
        | bw encode | bw create item >/dev/null
    and bw sync >/dev/null
    and echo "Created: $name"
end
