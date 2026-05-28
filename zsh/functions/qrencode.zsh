qrencodef() {
  local scale=8
  local target_px=""
  local output=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help)
        echo "Usage: qr [--scale <pixels>] [--px <size>] <output-file> <text-or-url>"
        echo ""
        echo "Options:"
        echo "  --scale <pixels>  QR module size passed to qrencode (default: 8)"
        echo "  --px <size>       Resize final PNG to an exact square size (e.g. 1024)"
        echo ""
        echo "Examples:"
        echo "  qr my-code \"https://example.com\""
        echo "  qr --scale 20 my-code \"https://example.com\""
        echo "  qr --px 1024 my-code \"https://example.com\""
        echo ""
        echo "Notes:"
        echo "  - .png is added automatically if missing"
        echo "  - Everything after <output-file> is encoded as one payload"
        return 0
        ;;
      --scale)
        shift
        if [[ -z "$1" || ! "$1" =~ '^[0-9]+$' || "$1" -le 0 ]]; then
          echo "qrencodef: --scale requires a positive integer"
          return 1
        fi
        scale="$1"
        shift
        ;;
      --px)
        shift
        if [[ -z "$1" || ! "$1" =~ '^[0-9]+$' || "$1" -le 0 ]]; then
          echo "qrencodef: --px requires a positive integer"
          return 1
        fi
        target_px="$1"
        shift
        ;;
      --)
        shift
        break
        ;;
      -*)
        echo "qrencodef: unknown option: $1"
        echo "Try: qr --help"
        return 1
        ;;
      *)
        output="$1"
        shift
        break
        ;;
    esac
  done

  if [[ -z "$output" ]]; then
    echo "Usage: qr [--scale <pixels>] [--px <size>] <output-file> <text-or-url>"
    echo "Try: qr --help"
    return 1
  fi

  if [[ $# -eq 0 ]]; then
    echo "Usage: qr [--scale <pixels>] [--px <size>] <output-file> <text-or-url>"
    echo "Try: qr --help"
    return 1
  fi

  if ! command -v qrencode >/dev/null 2>&1; then
    echo "qrencodef: qrencode is not installed"
    return 1
  fi

  local payload="$*"

  if [[ "${output:l}" != *.png ]]; then
    output="${output}.png"
  fi

  if ! qrencode -o "$output" -t PNG -s "$scale" -m 2 -l M "$payload"; then
    echo "qrencodef: failed to generate QR code"
    return 1
  fi

  if [[ -n "$target_px" ]]; then
    if ! sips -z "$target_px" "$target_px" "$output" >/dev/null; then
      echo "qrencodef: generated QR but failed to resize to ${target_px}px"
      return 1
    fi
  fi

  echo "Saved QR code to $output"
}

qr() {
  qrencodef "$@"
}
