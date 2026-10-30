function vpn --description "Control sing-box via Clash API"
    set -l api http://127.0.0.1:9090
    set -l secret h6TZkyb4lAX7nCDgd2nJ1zSR # leave empty if no secret is set
    set -l group proxy

    set -l hdr
    test -n "$secret"; and set hdr -H "Authorization: Bearer $secret"

    # service control
    switch "$argv[1]"
        case on
            sudo systemctl start sing-box; and echo "VPN enabled"
            return
        case off
            sudo systemctl stop sing-box; and echo "VPN disabled"
            return
    end

    # check API
    set -l data (curl -s -m 3 $hdr $api/proxies/$group | string collect)
    if test -z "$data"
        echo "API is not responding at $api"
        echo "Check: systemctl status sing-box and the clash_api block in the config"
        return 1
    end
    if not echo $data | jq -e '.all' >/dev/null 2>&1
        echo "Unexpected API response: $data"
        echo "If it says 'Unauthorized', the secret in this function is wrong"
        return 1
    end

    set -l now (echo $data | jq -r '.now')

    switch "$argv[1]"
        case ""
            set -l pick (echo $data | jq -r '.all[]' | fzf --height 40% --reverse --prompt="server (current: $now)> " | string collect)
            test -z "$pick"; and return
            __vpn_select $api $group "$pick" $hdr
        case now
            echo "Current: $now"
        case list
            echo $data | jq -r --arg now "$now" '.all[] | if . == $now then "* " + . else "  " + . end'
        case ping
            for n in (echo $data | jq -r '.all[]')
                set -l enc (jq -rn --arg n "$n" '$n|@uri')
                set -l d (curl -s -m 7 $hdr "$api/proxies/$enc/delay?url=https://www.gstatic.com/generate_204&timeout=5000" | jq -r '.delay // "timeout"')
                printf "%-24s %s\n" "$n" "$d"
            end
        case '*'
            # select by part of the name: vpn germany, vpn auto
            set -l name (echo $data | jq -r --arg q "$argv[1]" '.all[] | select(contains($q))' | head -n1)
            if test -z "$name"
                echo "Not found: $argv[1]. List servers with: vpn list"
                return 1
            end
            __vpn_select $api $group "$name" $hdr
    end
end

function __vpn_select
    set -l api $argv[1]
    set -l group $argv[2]
    set -l name $argv[3]
    set -l hdr $argv[4..-1]
    set -l body (jq -nc --arg n "$name" '{name:$n}')
    set -l code (curl -s -o /dev/null -w "%{http_code}" $hdr -X PUT $api/proxies/$group -d "$body")
    if test "$code" = 204
        echo "Selected: $name"
    else
        echo "Selection failed (HTTP $code)"
    end
end
