From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 29 Jul 2016 15:18:04 +0000
Subject: [Intel-wired-lan] [next PATCH S40-V2 02/12] i40e/i40evf: Reset
 vlan	filter count when resetting
In-Reply-To: <1469646161-30024-3-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
 <1469646161-30024-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EB89F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, July 27, 2016 12:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S40-V2 02/12] i40e/i40evf: Reset vlan
> filter count when resetting
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> When we do a reset, all the vlan filters get added again. Therefore we also
> want to reset the vlan count to 0 or we quickly run out of filters.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I459f26851e22204dc8b8999928ad87cde8170119
> ---
> Testing Hints: Make sure that you don't run out of filters when doing multiple
> resets.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Able to perform multiple resets with VLAN filters, without running out of filters
