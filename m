From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 May 2018 18:14:43 +0000
Subject: [Intel-wired-lan] [next PATCH S91 07/11] i40e: add tx_busy to
 ethtool stats
In-Reply-To: <20180510125949.79823-7-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
 <20180510125949.79823-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B76510A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, May 10, 2018 6:00 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S91 07/11] i40e: add tx_busy to
> ethtool stats
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> This patch adds the tx_busy stat to the ethtool stats. The tx_busy stat tracks
> the number of times we return NETDEV_TX_BUSY to the stack during
> transmit.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


