#! /bin/bash
git clone git://git.ipxe.org/ipxe.git

echo "SETTINGS"
echo BackUp files
cp ipxe/src/config/branding.h /config-backup/
cp ipxe/src/config/general.h /config-backup/
cp ipxe/src/config/console.h /config-backup/
echo "Editing branding.h"
sed -i 's/#define\ PRODUCT_NAME\ ""/#define\ PRODUCT_NAME\ "iPXE\ project\ by\ cool"/' ipxe/src/config/branding.h
sed -i 's/#define\ PRODUCT_SHORT_NAME\ "iPXE"/#define\ PRODUCT_SHORT_NAME\ "ipxe-latest"/' ipxe/src/config/branding.h
sed -i 's/#define\ PRODUCT_TAG_LINE\ "Open\ Source\ Network\ Boot\ Firmware"/#define\ PRODUCT_TAG_LINE\ "by\ cool"/' ipxe/src/config/branding.h
echo "Editing general.h"
sed -i 's/#undef\tDOWNLOAD_PROTO_HTTPS/#define\ DOWNLOAD_PROTO_HTTPS/' ipxe/src/config/general.h
sed -i 's/#undef\tDOWNLOAD_PROTO_FTP/#define\ DOWNLOAD_PROTO_FTP/' ipxe/src/config/general.h
sed -i 's/#undef\tDOWNLOAD_PROTO_NFS/#define\ DOWNLOAD_PROTO_NFS/' ipxe/src/config/general.h
sed -i 's/\/\/#undef\tSANBOOT_PROTO_ISCSI/#define\ SANBOOT_PROTO_ISCSI/' ipxe/src/config/general.h
sed -i 's/\/\/#undef\tSANBOOT_PROTO_HTTP/#define\ SANBOOT_PROTO_HTTP/' ipxe/src/config/general.h
sed -i 's/\/\/#define\tIMAGE_PXE/#define\ IMAGE_PXE/' ipxe/src/config/general.h
sed -i 's/\/\/#define\tIMAGE_SCRIPT/#define\ IMAGE_SCRIPT/' ipxe/src/config/general.h
sed -i 's/\/\/#define\tIMAGE_BZIMAGE/#define\ IMAGE_BZIMAGE/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ DIGEST_CMD/#define\ DIGEST_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ REBOOT_CMD/#define\ REBOOT_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ POWEROFF_CMD/#define\ POWEROFF_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ IMAGE_TRUST_CMD/#define\ IMAGE_TRUST_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ PING_CMD/#define\ PING_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ CONSOLE_CMD/#define\ CONSOLE_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ IPSTAT_CMD/#define\ IPSTAT_CMD/' ipxe/src/config/general.h
sed -i 's/\/\/#define\ CERT_CMD/#define\ CERT_CMD/' ipxe/src/config/general.h
echo "Editing console.h"
sed -i 's/\/\/#undef\tCONSOLE_PCBIOS/#define\ CONSOLE_PCBIOS/' ipxe/src/config/console.h
sed -i 's/\/\/#define\tCONSOLE_FRAMEBUFFER/#define\ CONSOLE_FRAMEBUFFER/' ipxe/src/config/console.h
sed -i 's/\/\/#define\tCONSOLE_DIRECT_VGA/#define\ CONSOLE_DIRECT_VGA/' ipxe/src/config/console.h
echo "Runing make..."
sleep 3
make -C ipxe/src
echo "Adding scripts"
cp /config-backup/Legacy.ipxe /ipxe/src/
cp /config-backup/EFI.ipxe /ipxe/src/
echo "Creating Legacy BIOS Images"
sleep 3
make bin/ipxe.iso EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.iso /firmware/
make bin/ipxe.dsk EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.dsk /firmware/
make bin/ipxe.lkrn EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.lkrn /firmware/
make bin/ipxe.usb EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.usb /firmware/
make bin/ipxe.pxe EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.pxe /firmware/
make bin/ipxe.kpxe EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.kpxe /firmware/
make bin/ipxe.kkpxe EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.kkpxe /firmware/
make bin/ipxe.kkkpxe EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/ipxe.kkkpxe /firmware/
make bin/undionly.kpxe EMBED=Legacy.ipxe -C ipxe/src && mv ipxe/src/bin/undionly.kpxe /firmware/
echo "SETTINGS EFI"
echo "Editing general.h"
sed -i 's/#define\ IMAGE_PXE/\/\/#define\ IMAGE_PXE/' ipxe/src/config/general.h
sed -i 's/#define\ IMAGE_BZIMAGE/\/\/#define\ IMAGE_BZIMAGE/' ipxe/src/config/general.h
sed -i 's/\/\/#define\tIMAGE_EFI/#define\ IMAGE_EFI/' ipxe/src/config/general.h
echo "Editing console.h"
sed -i 's/#define\ CONSOLE_PCBIOS/\/\/#define\ CONSOLE_PCBIOS/' ipxe/src/config/console.h
sed -i 's/\/\/#undef\tCONSOLE_EFI/#define\tCONSOLE_EFI/' ipxe/src/config/console.h
echo "Creating EFI Images"
make bin-x86_64-efi/ipxe.efi EMBED=EFI.ipxe -C ipxe/src && cp ipxe/src/bin-x86_64-efi/ipxe.efi /firmware/bootx64.efi
make bin-x86_64-efi/ipxe.usb EMBED=EFI.ipxe -C ipxe/src && mv ipxe/src/bin-x86_64-efi/ipxe.usb /firmware/ipxe-efi-x64.usb
make bin-x86_64-efi/ipxe.iso EMBED=EFI.ipxe -C ipxe/src && mv ipxe/src/bin-x86_64-efi/ipxe.iso /firmware/ipxe-efi-x64.iso
make bin-x86_64-efi/snponly.efi EMBED=EFI.ipxe -C ipxe/src && cp ipxe/src/bin-x86_64-efi/snponly.efi /firmware/snponly-x64.efi
make bin-i386-efi/ipxe.efi EMBED=EFI.ipxe -C ipxe/src && cp ipxe/src/bin-i386-efi/ipxe.efi /firmware/bootia32.efi
make bin-i386-efi/ipxe.usb EMBED=EFI.ipxe -C ipxe/src && mv ipxe/src/bin-i386-efi/ipxe.usb /firmware/ipxe-efi-x86.usb
make bin-i386-efi/ipxe.iso EMBED=EFI.ipxe -C ipxe/src && mv ipxe/src/bin-i386-efi/ipxe.iso /firmware/ipxe-efi-x86.iso
make bin-i386-efi/snponly.efi EMBED=EFI.ipxe -C ipxe/src && cp ipxe/src/bin-i386-efi/snponly.efi /firmware/snponly-x86.efi
echo "Cleaning project"
make clean -C ipxe/src
cp /config-backup/branding.h ipxe/src/config/branding.h
cp /config-backup/general.h ipxe/src/config/general.h
cp /config-backup/console.h ipxe/src/config/console.h
echo "Script completed"
