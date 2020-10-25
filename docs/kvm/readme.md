# KVM Tips

## install

```
sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
# libvirt-bin provides libvirtd which you need to administer qemu and kvm instances using libvirt

# qemu-kvm (kvm in Karmic and earlier) is the backend

# ubuntu-vm-builder powerful command line tool for building virtual machines

# bridge-utils provides a bridge from your network to the virtual machines

sudo adduser `id -un` libvirt
sudo adduser `id -un` kvm

virsh list --all

sudo apt-get install virt-manager

lsmod | grep 8021q
```

### nested vm's

```
$ cat /sys/module/kvm_intel/parameters/nested
Y
```

```
virt-host-validate
```

#### Intel

```
modprobe -r kvm_intel
modprobe kvm_intel nested=1
```

to add nested vm permemently add `options kvm_intel nested=1`
to `/etc/modprobe.d/kvm.conf`

#### AMD

```
modprobe -r kvm_amd
modprobe kvm_amd nested=1
```

to add nested vm permemently add `options kvm_amd nested=1`
to `/etc/modprobe.d/kvm.conf`

Enable on guest

set cpu to "host-model"

or to:

```
<cpu mode='custom' match='exact' check='full'>
    <model fallback='forbid'>SandyBridge-IBRS</model>
    <vendor>Intel</vendor>
    <feature policy='require' name='vme'/>
    <feature policy='require' name='vmx'/>
    <feature policy='require' name='pcid'/>
    <feature policy='require' name='hypervisor'/>
    <feature policy='require' name='arat'/>
    <feature policy='require' name='tsc_adjust'/>
    <feature policy='require' name='umip'/>
    <feature policy='require' name='md-clear'/>
    <feature policy='require' name='stibp'/>
    <feature policy='require' name='arch-capabilities'/>
    <feature policy='require' name='ssbd'/>
    <feature policy='require' name='xsaveopt'/>
    <feature policy='require' name='ibpb'/>
    <feature policy='require' name='amd-ssbd'/>
    <feature policy='require' name='skip-l1dfl-vmentry'/>
    <feature policy='disable' name='aes'/>
</cpu>
```

## virsh

```
virsh list --all
virsh autostart other
virsh dominfo your_vm_name
virsh # edit centos
virsh # dumpxml centos8
```

