From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Mar 2016 22:35:34 +0000
Subject: [Intel-wired-lan] [next PATCH S31 v4 03/12] i40evf: Fix
	VLAN	features
In-Reply-To: <1458328696-135941-4-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
 <1458328696-135941-4-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99EC87@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Friday, March 18, 2016 12:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S31 v4 03/12] i40evf: Fix VLAN
> features
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Users of ethtool were being given the mistaken impression that this driver
> was able to change its VLAN tagging features, and were disappointed that
> this was not actually the case. Implement ndo_fix_features method so that
> we can adjust these flags as needed to avoid false impressions.
> 
> Testing Hints: Use 'ethtool -K rxvlan off' to attempt to change the VLAN
> tagging.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I08584f103a4fa73d6a4128d472e4ef44dcfda57f
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 23
> +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes correctly applied, ethtool features work correctly
