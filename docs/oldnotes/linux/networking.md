# Networking

## DNS

opendns
Primary, secondary DNS servers: 208.67.222.222 and 208.67.220.220

Cloudflare
Primary, secondary DNS servers: 1.1.1.1 and 1.0.0.1

Google Public DNS
Primary, secondary DNS servers: 8.8.8.8 and 8.8.4.4

Comodo Secure DNS
Primary, secondary DNS servers: 8.26.56.26 and 8.20.247.20

Quad9
Primary, secondary DNS servers: 9.9.9.9 and 149.112.112.112

Verisign DNS
Primary, secondary DNS servers: 64.6.64.6 and 64.6.65.6



## network manager

Source https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_ip_networking_with_nmcli#sec-Connecting_to_a_Network_Using_nmcli

```
# terminal editor
nmcli
nmcli connection add type ethernet con-name connection-name ifname interface-name
nmcli con mod test-lab +ipv4.dns "8.8.8.8 8.8.4.4"
nmcli -p connection show Wired\ connection\ 1
nmcli con edit type ethernet con-name ens3

# terminal network editor
nmtui

# gui connection editor
nm-connection-editor
```


