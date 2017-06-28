From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Jun 2017 23:57:24 +0000
Subject: [Intel-wired-lan] [next PATCH S74-V2 06/10] i40e: remove
 workaround	for Open Firmware MAC address
In-Reply-To: <20170623082451.32671-6-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
 <20170623082451.32671-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC09D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, June 23, 2017 1:25 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: tushar.n.dave at oracle.com
> Subject: [Intel-wired-lan] [next PATCH S74-V2 06/10] i40e: remove
> workaround for Open Firmware MAC address
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Since commit b499ffb0a22c ("i40e: Look up MAC address in Open Firmware
> or IDPROM"), we've had support for obtaining the MAC address form Open
> Firmware or IDPROM.
> 
> This code relied on sending the Open Firmware address directly to the device
> firmware instead of relying on our MAC/VLAN filter list. Thus, a work around
> was introduced in commit b1b15df59232 ("i40e: Explicitly write platform-
> specific mac address after PF reset")
> 
> We refactored the Open Firmware address enablement code in the ill-
> named commit 41c4c2b50d52 ("i40e: allow look-up of MAC address from
> Open Firmware or IDPROM")
> 
> Since this refactor, we no longer even set I40E_FLAG_PF_MAC. Further, we
> don't need this work around, because we actually store the MAC address as
> part of the MAC/VLAN filter hash. Thus, we will restore the address correctly
> upon reset.
> 
> The refactor above failed to revert the workaround, so do that now.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 60 -----------------------------
>  2 files changed, 61 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


