# HISTORY: Dell Vostro 15 3530 Troubleshooting Log

## 1. Audio (Microphone) Issue


### Problem

- Built-in microphone on Dell Vostro 15 3530 running NixOS was not detected or
available as an input device.

### Investigation & Attempts

- Initial driver: `snd_hda_intel` loaded; provided sound output but did not enable
internal mic.
- Tried enabling SOF/AVS (modern) driver using:
  - `boot.kernelModules` for `snd_sof_pci`.
  - Kernel params: `snd_intel_dsp_driver` and `snd_intel_dspcfg.dsp_driver` across
different kernel versions.
  - Blacklisting `snd_hda_intel` caused no audio devices at all.
- Applied model tuning to `snd_hda_intel` (`model=dell-headset-multi`) – no mic.
- Key breakthrough: `snd_intel_dspcfg.dsp_driver=2` and `3` switched to SOF/AVS
drivers, but failed due to missing firmware (`dsp_basefw.bin`).
- Firmware now detected; mic works after correct kernel and firmware configuration.

### Current Status

- Microphone works, but "monitor of output" sources appear under Input Devices in
pavucontrol/pipewire. Want these hidden for clarity.
- Proposed fix: Use `services.pipewire.wireplumber.extraConfig` to hide "monitor"
nodes. Next session: confirm that only real inputs are shown.


## 2. USB Port Issue (Left Side)

### Problem

- Left USB port does not recognize thumb drives or other devices, while right port
works.

### Next Steps done

- Need to gather hardware and kernel logs while hot-plugging into left USB port:
  - `dmesg | tail -40`
  - `lsusb`
  - `lsusb -t`
  - `sudo journalctl -k -b | tail -80`
- Analyze output to determine if issue is hardware, BIOS/firmware, or OS-level.
- No userland config is suspected; focus is on hardware and kernel reaction.


## AND THEN I DID THE STEPS, SHARED THE OUTPUT. YOU WROTE:


    ## 1. PipeWire (monitor sources not hidden)

    Your config in <pkgs/disable-monitors.nix> looks almost right. However, there are
    subtle issues that can prevent it from working:

    ### Issues / Checks

        * **Config placement**: Make sure this config **actually gets imported** into
    your NixOS config. Are you importing `disable-monitors.nix` in your Nix config and
     rebuilding?
        * **Extra nesting**: Sometimes WirePlumber expects the top-level config to
    name the table you want to override (`monitor`), not nest it.
        * **Rule matching**: Your regex looks good, but sometimes node names are e.g.,
     `"alsa_output.pci-0000_00_1f.3.analog-stereo.monitor"`. You can loosen the match
    by using `*monitor` or a full regex: `".*monitor$"`.
        * **Config location**: It's possible you want this under `[rules]` rather than
     inside `"monitor" = { ... }`. Most wireplumber configs look like:
    services.pipewire.wireplumber.extraConfig = {
                "policy.rules" = [
                  {
                    matches = [{ "node.name" = "~.*monitor$"; }];
                    actions = { "update-props" = { "node.hidden" = true; }; };
                  }
                ];
              };

          Or, for legacy:    services.pipewire.wireplumber.extraConfig = {
                "filter.chain.rules" = [ ... ];
              };
        * **Rebuilding NixOS and restart**: Did you run `sudo nixos-rebuild switch`
    after editing and also restart WirePlumber (`systemctl --user restart wireplumber`
     or reboot)?

    #### Try: Minimal working WirePlumber hide-monitor example

    Here's a modification you should try (in your <pkgs/disable-monitors.nix>):

        {...}: {
          services.pipewire.wireplumber.extraConfig = {
            "policy.rules" = [
              {
                matches = [{ "node.name" = "~.*monitor$"; }];
                actions = { "update-props" = { "node.hidden" = true; }; };
              }
            ];
          };
        }

        * Place this config, `nixos-rebuild switch`, restart your session, and check
    again in pavucontrol.

    ----------------------------------------------------------------------------------
    ---

    ## 2. Left USB Port Analysis

    ### What your logs show

        * **Kernel & lsusb output** shows:
            * When you insert your USB drive (Kingston DataTraveler), it’s detected
    and properly enumerated:
                `usb 1-1: New USB device found, idVendor=0951, idProduct=1666`
                Storage drivers and partitions appear.

            * After removing the device and running `lsusb`, the device disappears as
    expected.
        * In **all logs you provided**, the system seems to *correctly detect and
    mount* the USB stick when plugged into the "bad" port.

    #### Conclusion:

    Your "bad" USB port appears to work correctly. Since the hub detects and mounts
    the device, there's no outright hardware or OS problem as per this session.

    ### If you still see failures

        * Next time you get a "bad" port result, immediately collect logs as you did
    above:
            * Look for the **absence of device connect events** (`usb 1-1: new device
    found ...`) or any USB errors.

            * Try with other USB devices/cables to confirm if it's a port or
    device-specific issue.

            * Try `lsusb -v` immediately after plugging—look for transfer errors.
        * **If you only see high-speed hub, but never device found**, it can be a
    physical port issue (cracked solder, etc).

    ----------------------------------------------------------------------------------
    ---

    ## Next Actions

        * **Audio:** Update your WirePlumber config as suggested, rebuild, and restart
     your user session or wireplumber; confirm in pavucontrol.
        * **USB:** If you see another "bad" port moment where *nothing* gets detected,
     save the full log again and compare.

    Want help automating the config test, better matching for WirePlumber, or a
    systemd unit to auto-hide monitors? Or do you have a USB failure log where the
    device is NOT detected at all? Let me know your next focus!