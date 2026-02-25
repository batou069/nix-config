# modules/nix-mineral-bt-usb.nix
# nix-mineral overlay: restore bluetooth adapter detection and USB HID support
#
# Problem: nix-mineral's strict IOMMU settings (iommu=force, iommu.strict=1)
# can prevent USB controllers from properly initializing on some Intel chipsets.
# Since internal bluetooth adapters are USB-attached, this breaks both BT and
# USB HID devices like the Apple Magic Trackpad.
{ config, lib, ... }:

lib.mkIf config.nix-mineral.enable {
  nix-mineral = {
    # --- Bluetooth ---

    # Disable Kicksecure's /etc/bluetooth/main.conf override.
    # It sets AutoEnable=false, PairableTimeout=30, MaxControllers=1,
    # which prevents BlueZ from auto-starting and detecting adapters.
    settings.etc.kicksecure-bluetooth = false;

    # --- IOMMU / DMA (affects both BT and USB) ---

    # Disable strict IOMMU enforcement.
    # Default adds: iommu=force iommu.strict=1
    # These can break USB controllers on Intel platforms, preventing
    # device detection for both bluetooth adapters and USB HID devices.
    settings.kernel.strict-iommu = false;

    # Keep intel-iommu enabled (intel_iommu=on) — this is generally safe
    # and provides DMA protection. Only strict mode causes issues.
    # Uncomment the line below if bluetooth/USB still fails after rebuild:
    # settings.kernel.intel-iommu = false;
  };
}
