# sayo-device-nix

## Udev rules to use the website

### Manually

If you just want to use the website, you just need to add this udev rule.

```nix
services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="8089", GROUP="input", MODE="0660"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="8089", GROUP="input", MODE="0660"
'';

users.users.${your-username}.extraGroups = [ "input" ];
```

You can also specify your idProduct if you want.

```console
$ lsusb -d 8089: -v | grep idProduct
idProduct          0x0009 SayoDevice O3C v1
```

In my case it's `0009`, so:

```nix
services.udev.extraRules = ''
    SUBSYSTEM=="hidraw" \
    , ATTRS{idVendor}=="8089" \
    , ATTRS{idProduct}="0009" \
    , GROUP="input", MODE="0660"
'';
```

### Udev rules from this flake

```nix
inputs.sayo-device.url = "github:h-banii/sayo-device-nix.git";

...

services.udev.packages = [
    inputs.sayo-device.packages.sayo-udev-rules
];
```

## Sayo CLI

```nix
environment.systemPackages = with inputs.sayo-device.packages; [
    sayo-cli-v1
    sayo-cli-v2
]
```
