From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 1 Mar 2016 02:52:17 +0000
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
 using a device tree blob V5
In-Reply-To: <56C5A6BC.6030708@gmail.com>
References: <56C5A6BC.6030708@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EA731A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of John Holland
> Sent: Thursday, February 18, 2016 3:11 AM
> To: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211 using
> a device tree blob V5
> 
> Hello,
> 
> The Intel i211 LOM PCIe Ethernet controllers' iNVM operates as an OTP and
> has no external EEPROM interface [1]. The following allows the driver to
> pickup the MAC address from a device tree blob when CONFIG_OF has been
> enabled.
> 
> [1]
> http://www.intel.com/content/www/us/en/embedded/products/networkin
> g/i211-ethernet-controller-datasheet.html
> 
> Changes V2
> - Restrict searching for compatible devices to current pci device.
> 
> Changes V3
> - Add device tree binding documentation.
> 
> Changes V4
> - Rebase patch.
> 
> Changes V5
> - Use eth_platform_get_mac_address() to resolve MAC specified in a dtb.
> - Remove now invalid device tree binding documentation specified in V3
>    und V4.
> 
> Signed-off-by: John Holland<jotihojr@gmail.com>
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

This throws a few checkpatch warnings, but I won't withhold my tested by for these:
-----------------------------------------------------
u1463:[0]/usr/src/kernels/next-queue> git format-patch $item -1 --stdout|./scripts/checkpatch.pl -
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#14:
http://www.intel.com/content/www/us/en/embedded/products/networking/i211-ethernet-controller-datasheet.html

WARNING: email address 'John Holland<jotihojr@gmail.com>' might be better as 'John Holland <jotihojr@gmail.com>'
#30:
Signed-off-by: John Holland<jotihojr@gmail.com>

total: 0 errors, 2 warnings, 0 checks, 21 lines checked

Your patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
u1463:[0]/usr/src/kernels/next-queue>
-----------------------------------------------------

I do not seem to have hardware that uses device tree, so my testing is relegated to regression tests with my existing set of chipsets.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
