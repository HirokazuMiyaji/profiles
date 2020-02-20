brew tap dart-lang/dart
installed=$(brew list)
echo ${installed} | grep make > /dev/null || brew install make
echo ${installed} | grep autoconf > /dev/null || brew install autoconf
echo ${installed} | grep openssl > /dev/null || brew install openssl
echo ${installed} | grep readline > /dev/null || brew install readline
echo ${installed} | grep zlib > /dev/null || brew install zlib
echo ${installed} | grep dart > /dev/null || brew install dart
echo ${installed} | grep direnv > /dev/null || brew install direnv
