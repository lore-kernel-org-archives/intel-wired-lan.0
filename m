From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 18 Nov 2016 18:06:07 +0000
Subject: [Intel-wired-lan] [next PATCH S54 11/15] i40e:
	rename	i40e_put_mac_in_vlan and i40e_del_mac_all_vlan
In-Reply-To: <1478896779-13697-12-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-12-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA381B6@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S54 11/15] i40e: rename
> i40e_put_mac_in_vlan and i40e_del_mac_all_vlan
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> These functions purpose is to add a new MAC filter correctly, whether we're
> using VLANs or not. Their goal is to ensure that all active VLANs get the new
> MAC filter. Rename them so that their intent is clear. They function correctly
> regardless of whether we have any active VLANs or only have
> I40E_VLAN_ANY filters. The new names convey how they function in a more
> clear manner.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Iec1961f968c0223a7132724a74e26a665750b107
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 24 ++++++++++++---------
> -
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
>  3 files changed, 18 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


