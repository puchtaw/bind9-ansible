#!/bin/bash

set -o errexit

# TEST CASES
cat >> /tmp/dns_test_forwarders << EOF
wp.pl
google.com
EOF

cat >> /tmp/dns_test_real_names << EOF
ap.example.internal
px.example.internal
hv.example.internal
db.example.internal
EOF

# smoke tests:
echo -e "\n"/etc/bind/db.0.10
cat -A /etc/bind/db.0.10

echo -e "\n"/etc/bind/example.internal.zone
cat -A /etc/bind/example.internal.zone

echo -e "\n"/tmp/dns_test
cat -A /tmp/dns_test


echo "########## TESTS:"
! nslookup nonexistant.domain.for.test
nslookup < /tmp/dns_test_forwarders
nslookup < /tmp/dns_test
nslookup < /tmp/dns_test_real_names
