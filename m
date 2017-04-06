From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 21:42:34 +0000
Subject: [Intel-wired-lan] [next S66 v2 05/11] i40e: allow look-up of
 MAC	address from Open Firmware or IDPROM
In-Reply-To: <20170405115103.67374-5-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
 <20170405115103.67374-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B14E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 5, 2017 4:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S66 v2 05/11] i40e: allow look-up of MAC
> address from Open Firmware or IDPROM
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Look up the MAC address from the eth_get_platform_mac_address()
> function first before checking what the firmware provides. We already
> handle the case of re-writing the MAC-VLAN filter, so there is no need to add
> extra code for this. However, update the comment where we do this to
> indicate that it does impact the Open Firmware MAC address case.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I73e59fbe0b0e7e6f3ee9f5170d0bd3a4d5faf4db
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 29 ++++++++++++++++-------
> ------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


