From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 22 Mar 2016 19:47:05 +0000
Subject: [Intel-wired-lan] [next PATCH S31 v4 09/12] i40e: Fix for
 supported	link modes in 10GBaseT PHY's
In-Reply-To: <1458328696-135941-10-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
 <1458328696-135941-10-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99EE72@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S31 v4 09/12] i40e: Fix for supported
> link modes in 10GBaseT PHY's
> 
> 100baseT/Full is now listed and supported link mode for 10GBaseT PHY.
> This is a fix to list all the supported link modes of 10GBaseT PHY.
> 
> Testing Hints: Use 'ethtool -s ethx advertise 0x008' to change supported link
> mode. Check if 100baseT is displayed.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Change-ID: If2be3212ef0fef85fd5d6e4550c7783de2f915e9
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
ethtool shows correct link mode

