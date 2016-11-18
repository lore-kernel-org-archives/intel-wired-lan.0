From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 18 Nov 2016 18:03:42 +0000
Subject: [Intel-wired-lan] [next PATCH S54 13/15] i40e: when adding
	or	removing MAC filters, correctly handle VLANs
In-Reply-To: <1478896779-13697-14-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-14-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA381A3@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S54 13/15] i40e: when adding or
> removing MAC filters, correctly handle VLANs
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Instead of using i40e_add_filter or i40e_del_filter directly, when adding a
> MAC address, we should normally be using i40e_add_mac_filter or
> i40e_del_mac_filter. These functions correctly handle the various cases of
> VLAN mode or PVID settings. This ensures consistency and avoids the issues
> that can occur with the recent addition of a WARN_ON() in
> i40e_sync_vsi_filters.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I7fe62db063391fdd1180b2d6a6a3c5ab4307eeee
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++-------
>  2 files changed, 7 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


