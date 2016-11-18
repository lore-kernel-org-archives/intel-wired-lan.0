From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 18 Nov 2016 17:21:41 +0000
Subject: [Intel-wired-lan] [next PATCH S54 14/15] i40e: Deprecating
 unused	macro and
In-Reply-To: <1478896779-13697-15-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-15-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38148@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, November 11, 2016 12:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S54 14/15] i40e: Deprecating unused
> macro and
> 
> I40E_MAC_X710 was supposed to be for 10G and I40E_MAC_XL710 was
> supposed to be for 40G. But function i40e_is_mac_710 sets I40E_MAC_XL710
> for all device IDS, I40E_MAC_X710 is not used at all. As there is nothing to
> compare there is no need for this function. Thus deprecating this extra macro
> and removing this function entirely and replacing it with a direct check.
> 
> Signed-off-by: Bimmy Pujari <bimmy.pujari@intel.com>
> Change-ID: I7d1769954dccd574a290ac04adb836ebd156730e
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        | 13 -------------
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 -
>  drivers/net/ethernet/intel/i40evf/i40e_type.h |  1 -
>  4 files changed, 3 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


