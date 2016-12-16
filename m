From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 16 Dec 2016 22:31:29 +0000
Subject: [Intel-wired-lan] [next PATCH S57 06/11] i40e: Fix Adaptive
	ITR	enabling
In-Reply-To: <1481586257-28872-7-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
 <1481586257-28872-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA499C8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, December 12, 2016 3:44 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S57 06/11] i40e: Fix Adaptive ITR
> enabling
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes a bug introduced with the addition of the per queue ITR
> feature support in ethtool.  With that addition, there were functions added
> which converted the ITR settings to binary values.
> The IS_ENABLED macros that run on those values check whether a bit is set
> or not and with the value being binary, the bit check always returned ITR
> disabled which prevents any updating of the ITR rate.
> This patch fixes the problem by changing the functions to return the current
> ITR value instead and renaming it to better reflect its function.  These
> functions now provide a value which will be accurately asessed and update
> the ITR as intended.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: I14f1d088d052e27f652aaa3113e186415ddea1fc
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 12 ++++++------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


