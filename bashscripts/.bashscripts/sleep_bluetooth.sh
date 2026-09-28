#!/bin/bash
# =============================================================
# setup_bt_on_sleep.sh
# Turns off Bluetooth when Mac lid is closed (sleep).
# Uses: sleepwatcher + blueutil
# =============================================================

set -e

echo "Setting up Bluetooth-off-on-sleep..."

# -- 1. Check for Homebrew -----------------------------------
if ! command -v brew &>/dev/null; then
  echo "ERROR: Homebrew is not installed. Install it first:"
  echo '   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  exit 1
fi

# -- 2. Install dependencies ---------------------------------
echo "Installing sleepwatcher and blueutil..."
brew install sleepwatcher blueutil

# -- 3. Create sleep hook (~/.sleep) -------------------------
SLEEP_SCRIPT="$HOME/.sleep"
cat > "$SLEEP_SCRIPT" << 'EOF'
#!/bin/bash
# Runs when Mac goes to sleep (lid closed)
/usr/local/bin/blueutil --power 0
EOF
chmod +x "$SLEEP_SCRIPT"
echo "Created $SLEEP_SCRIPT"

# -- 4. Enable and start sleepwatcher as a launchd service ---
brew services start sleepwatcher
echo "sleepwatcher service started"

echo ""
echo "Done. Bluetooth will turn OFF when you close your Mac lid."
echo ""
echo "To stop this behaviour at any time, run:"
echo "   brew services stop sleepwatcher"
