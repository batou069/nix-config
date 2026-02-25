# TODO / OPEN ISSUES

IMPORTANT: When trying to solve those problems, always think step-by step and explain your reasoning

## anime-downloader

file: at @home/anime-downloader.nix

app not working, when launching `anime` in shell i get the error below

```error
Traceback (most recent call last):
  File "/nix/store/ch361nn4y8xhvxvba0xi1zkkn4sz8513-anime-downloader-5.0.14/bin/..anime-wrapped-wrapped", line 6, in <module>
    from anime_downloader.cli import main
  File "/nix/store/ch361nn4y8xhvxvba0xi1zkkn4sz8513-anime-downloader-5.0.14/lib/python3.13/site-packages/anime_downloader/__init__.py", line 1, in <module>
    from anime_downloader.sites import get_anime_class
  File "/nix/store/ch361nn4y8xhvxvba0xi1zkkn4sz8513-anime-downloader-5.0.14/lib/python3.13/site-packages/anime_downloader/sites/__init__.py", line 2, in <module>
    from .anime import Anime
  File "/nix/store/ch361nn4y8xhvxvba0xi1zkkn4sz8513-anime-downloader-5.0.14/lib/python3.13/site-packages/anime_downloader/sites/anime.py", line 10, in <module>
    from anime_downloader import util
  File "/nix/store/ch361nn4y8xhvxvba0xi1zkkn4sz8513-anime-downloader-5.0.14/lib/python3.13/site-packages/anime_downloader/util.py", line 24, in <module>
    from anime_downloader.sites import get_anime_class, helpers
  File "/nix/store/ch361nn4y8xhvxvba0xi1zkkn4sz8513-anime-downloader-5.0.14/lib/python3.13/site-packages/anime_downloader/sites/helpers/__init__.py", line 1, in <module>
    from anime_downloader.sites.helpers.request import *
  File "/nix/store/ch361nn4y8xhvxvba0xi1zkkn4sz8513-anime-downloader-5.0.14/lib/python3.13/site-packages/anime_downloader/sites/helpers/request.py", line 3, in <module>
    import cfscrape
  File "/nix/store/0xxks5kylza1g0czzlmxcldfm0s2cv05-python3.13-cfscrape-2.1.1/lib/python3.13/site-packages/cfscrape/__init__.py", line 19, in <module>
    from urllib3.util.ssl_ import create_urllib3_context, DEFAULT_CIPHERS
ImportError: cannot import name 'DEFAULT_CIPHERS' from 'urllib3.util.ssl_' (/nix/store/smz6ypxwsszlmraxqd65g0gq3xs924r4-python3.13-urllib3-2.6.0/lib/python3.13/site-packages/urllib3/util/ssl_.py)
```

## apple trackpad not working

**Status: FIX APPLIED — needs rebuild & verification**

file: hosts/default/core.nix

the (lightning cable) apple trackpad used to work only with cable, bluetooth would connect but the trackpad wouldnt work over bt.
lately the trackpad stopped to work.

we alreay tried adding:
1) `kernelModules = ["kvm-intel" "hid-magicmouse" "hid-apple" "btusb"]`, the new additions being  hid-magicmouse, hid-apple, and btusb
2) `extraModprobeConfig = ''options hid_magicmouse scroll_acceleration=1 scroll_speed=25''
3) changed nix-mineral preset from maximum to performance

### Fix applied

Root cause: nix-mineral's strict IOMMU (`iommu=force`, `iommu.strict=1`) breaks USB controller init on Intel chipsets. The trackpad is a USB HID device.

Fix: `modules/nix-mineral-bt-usb.nix` disables `settings.kernel.strict-iommu`, removing the problematic kernel params.

#### Verify after rebuild
- [ ] `lsusb` lists Apple device
- [ ] `dmesg | grep -i "hid\|apple\|magic"` shows HID device registration
- [ ] `cat /proc/cmdline` no longer contains `iommu=force`
- [ ] If still broken, uncomment `settings.kernel.intel-iommu = false` in the module and rebuild again

## bluetooth not working

**Status: FIX APPLIED — needs rebuild & verification**

in file: hosts/default/core.nix
we have: `services.blueman.enable = true`

in file: hosts/default/config.nix
we have:

```hosts/default/config.nix
hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
```


maybe related to the apple trackpad issue

the dms-shell bluetooth icon in the desktop bar is gone, launching bluetooth manager (blueman) fails. bluetooth is turned off, turning it on does nothing, and the adapter-menu is empty. having bluetooth manager open for some secongs will show a popup saying `Connection to BlueZ failed - Bluez daemon is not running, blueman-manager cannot continue. This probably means that there were no Bluetooth adapters detected or Bluetooth daemon was not started.`

### Fix applied

Root cause: two nix-mineral settings combined to break bluetooth:
1. Kicksecure's `/etc/bluetooth/main.conf` override sets `AutoEnable=false`, preventing BlueZ from starting
2. Strict IOMMU prevents USB controllers from initializing (internal BT adapters are USB-attached)

Fix: `modules/nix-mineral-bt-usb.nix` (imported in `hosts/lf-nix/config.nix`) disables both:
- `settings.etc.kicksecure-bluetooth = false` — removes the restrictive BlueZ config
- `settings.kernel.strict-iommu = false` — removes `iommu=force iommu.strict=1`

#### Verify after rebuild
- [ ] `bluetoothctl show` shows adapter info
- [ ] `systemctl status bluetooth` is active (running)
- [ ] `blueman-manager` launches without "BlueZ daemon not running" error
- [ ] If still broken, uncomment `settings.kernel.intel-iommu = false` in the module and rebuild again

## Musnix

I added musnix to my config via flake and then:

```/home/lf/nix/hosts/default/config.nix
  musnix = {
    enable = true;

    # KEEPING FALSE for simple playback
    # Prevents long compile times and potential instability
    kernel.realtime = false;

    # OPTIONAL: Useful tool to check if your system is bottlenecking audio
    rtcqs.enable = true;
  };
```

### rtcqs_gui

when i run `rtcqs_gui` i get an error:

```shell
Traceback (most recent call last):
  File "/nix/store/hn7wrrlxbvg2c6vfhskqmcwa194srbf5-rtcqs-0.6.2/bin/.rtcqs_gui-wrapped", line 6, in <module>
    from rtcqs.rtcqs_gui import main
  File "/nix/store/hn7wrrlxbvg2c6vfhskqmcwa194srbf5-rtcqs-0.6.2/lib/python3.13/site-packages/rtcqs/rtcqs_gui.py", line 3, in <module>
    import PySimpleGUI as sg
ModuleNotFoundError: No module named 'PySimpleGUI'
```

### rtcqs

when running the cli tool this is the output, what is wrong?

```shell
Root User
=========
[ OK ] Not running as root.

Group Limits
============
[ OK ] User lf is member of a group that has sufficient rtprio (99) and memlock (unlimited) limits set.

CPU Frequency Scaling
=====================
[ WARNING ] The scaling governor of one or more CPUs is not set to'performance'. You can set the scaling governor to 'performance' with 'cpupower frequency-set -g performance' or 'cpufreq-set -r -g performance' (Debian/Ubuntu). See also https://wiki.linuxaudio.org/wiki/system_configuration#cpu_frequency_scaling

Kernel Configuration
====================
[ OK ] Valid kernel configuration found.

High Resolution Timers
======================
[ OK ] High resolution timers are enabled.

Tickless Kernel
===============
[ OK ] System is using a tickless kernel.

Preempt RT
==========
[ OK ] Kernel 6.19.2 is using threaded IRQs.

Spectre/Meltdown Mitigations
============================
[ WARNING ] Kernel with Spectre/Meltdown mitigations found. This could have a negative impact on the performance of your system. See also https://wiki.linuxaudio.org/wiki/system_configuration#disabling_spectre_and_meltdown_mitigations

RT Priorities
=============
[ OK ] Realtime priorities can be set.

Swappiness
==========
[ OK ] Swappiness is set at 1.

Filesystems
===========
[ OK ] The following mounts can be used for audio purposes: /, /etc, /var, /var/log, /nix/store, /home, /root, /srv, /tmp, /var/tmp
[ WARNING ] The following mounts should be avoided for audio purposes: /boot. See also https://wiki.linuxaudio.org/wiki/system_configuration#filesystems

IRQs
====
[ OK ] USB port xhci_hcd with IRQ 125 does not share its IRQ.

Power Management
================
[ OK ] Power management can be controlled from user space. This enables DAWs like Ardour and Reaper to set CPU DMA latency which could help prevent xruns.
```

## treefmt, precommit, autoformat
im confused if we currently auto-format files prior to comitting
i see the treefmt.toml file disabled (file: `treefmt.toml.disabled` in project root) but i see the `.pre-commit-config.yaml` file in the projects root

## variables.nix

im confused about the `variables.nix` files:
- hosts/default/variables.nix
- hosts/viech/variables.nix

1. hosts/lf/variables.nix is not existing
2. default is shared by both users/machines
3. do i even import the variables files anywhere? I only know about `hosts/default/core.nix` for keyboardLayouts
4. how can we make use of it to be more efficient?