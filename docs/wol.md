# Wake on Lan

send a magic packet to turn on a machine.

python

```
import socket
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
# s.sendto(bytes('\xff'*6 + '\x01\x02\x03\x04\x05\x06'*16, 'utf-8'), ('192.168.0.1', 80))
s.sendto(r'\xff'*6 + r'\x01\x02\x03\x04\x05\x06'*16, ('192.168.0.1', 80))
print("Done")
```

Rust

https://lib.rs/crates/wakey


```
let wol = wakey::WolPacket::from_string("01:02:03:04:05:06", ':');
match wol.send_magic() {
    Ok(_) => println!("Sent the magic packet!"),
    Err(_) => println!("Failed to send the magic packet!")
}
```

or

```
use std::net::SocketAddr;

let wol = wakey::WolPacket::from_bytes(&vec![0x00, 0x01, 0x02, 0x03, 0x04, 0x05]);
let src = SocketAddr::from(([0,0,0,0], 0));
let dst = SocketAddr::from(([255,255,255,255], 9));

wol.send_magic_to(src, dst);
```
