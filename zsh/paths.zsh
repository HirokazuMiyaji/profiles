for i in /opt/local /usr/local; do
  local bin_path="$i/bin"
  if [ -d "$bin_path" ]; then
    PATH=$bin_path:$PATH
  fi
  local sbin_path="$i/sbin"
  if [ -d "$sbin_path" ]; then
    PATH=$sbin_path:$PATH
  fi
  local man_path="$i/share/man"
  if [ -d "$man_path" ]; then
    MANPATH=$man_path:$MANPATH
  fi
  done
PATH=$PATH:$HOME/bin
