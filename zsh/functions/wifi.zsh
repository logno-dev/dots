wifiqr() {
  local ssid=""
  local password=""
  local output=""
  local enc="WPA"
  local enc_set=0
  local qr_type=""

  while getopts "n:p:o:t:h" opt; do
    case "$opt" in
      n) ssid="$OPTARG" ;;
      p) password="$OPTARG" ;;
      o) output="$OPTARG" ;;
      t)
        enc="$OPTARG"
        enc_set=1
        ;;
      h)
        echo "Usage: wifiqr -n <network-name> [-o <output-file>] [-p <password>] [-t WPA|WEP|nopass]"
        return 0
        ;;
      *)
        echo "Usage: wifiqr -n <network-name> [-o <output-file>] [-p <password>] [-t WPA|WEP|nopass]"
        return 1
        ;;
    esac
  done

  # Be forgiving if users pass quoted values literally, e.g. -n "'Arise Guest'"
  if [[ "$ssid" == "'"*"'" && "$ssid" == *"'" ]]; then
    ssid="${ssid:1:-1}"
  elif [[ "$ssid" == '"'*'"' && "$ssid" == *'"' ]]; then
    ssid="${ssid:1:-1}"
  fi

  if [[ "$password" == "'"*"'" && "$password" == *"'" ]]; then
    password="${password:1:-1}"
  elif [[ "$password" == '"'*'"' && "$password" == *'"' ]]; then
    password="${password:1:-1}"
  fi

  if [[ "$enc_set" -eq 1 ]]; then
    case "${enc:l}" in
      wpa|wpa2|wpa3)
        qr_type="WPA"
        ;;
      wep)
        qr_type="WEP"
        ;;
      nopass|open|none)
        qr_type="nopass"
        ;;
      *)
        echo "wifiqr: invalid encryption type '$enc' (use WPA, WEP, or nopass)"
        return 1
        ;;
    esac
  else
    if [[ -n "$password" ]]; then
      qr_type="WPA"
    else
      qr_type="nopass"
    fi
  fi

  if [[ -z "$ssid" ]]; then
    echo "Usage: wifiqr -n <network-name> [-o <output-file>] [-p <password>] [-t WPA|WEP|nopass]"
    return 1
  fi

  if [[ "$qr_type" != "nopass" && -z "$password" ]]; then
    echo "wifiqr: password is required unless -t nopass"
    return 1
  fi

  if ! command -v qrencode >/dev/null 2>&1; then
    echo "wifiqr: qrencode is not installed"
    return 1
  fi

  if [[ -z "$output" ]]; then
    local slug="${ssid:l}"
    slug="${slug//[^a-z0-9]/-}"
    while [[ "$slug" == *--* ]]; do
      slug="${slug//--/-}"
    done
    while [[ "$slug" == -* ]]; do
      slug="${slug#-}"
    done
    while [[ "$slug" == *- ]]; do
      slug="${slug%-}"
    done
    if [[ -z "$slug" ]]; then
      slug="wifi"
    fi
    output="${slug}-qr.png"
  elif [[ "${output:l}" != *.png ]]; then
    output="${output}.png"
  fi

  local escaped_ssid="$ssid"
  local escaped_password="$password"

  escaped_ssid="${escaped_ssid//\\/\\\\}"
  escaped_ssid="${escaped_ssid//;/\\;}"
  escaped_ssid="${escaped_ssid//,/\\,}"
  escaped_ssid="${escaped_ssid//:/\\:}"

  escaped_password="${escaped_password//\\/\\\\}"
  escaped_password="${escaped_password//;/\\;}"
  escaped_password="${escaped_password//,/\\,}"
  escaped_password="${escaped_password//:/\\:}"

  local payload=""
  if [[ "$qr_type" == "nopass" ]]; then
    payload="WIFI:T:${qr_type};S:${escaped_ssid};H:false;;"
  else
    payload="WIFI:T:${qr_type};S:${escaped_ssid};P:${escaped_password};H:false;;"
  fi

  if ! qrencode -o "$output" -t PNG -s 8 -m 2 "$payload"; then
    echo "wifiqr: failed to generate QR code"
    return 1
  fi

  echo "Saved Wi-Fi QR code to $output"
}
