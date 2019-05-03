From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 3 May 2019 23:39:57 +0000
Subject: [Intel-wired-lan] [next PATCH S5 09/10] i40e: remove duplicate
 stat calculation for tx_errors
In-Reply-To: <20190424122055.27896-9-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
 <20190424122055.27896-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C6FE@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 24, 2019 5:21 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S5 09/10] i40e: remove duplicate stat
> calculation for tx_errors
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The tx_errors statistic was being calculated twice in i40e_update_eth_stats.
> 
> This appears to be as of commit 201db2898f2c ("i40e: add missing VSI
> statistics", 2014-03-25).
> 
> Remove the extra i40e_stat_update32 call for GLV_TEPC.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ---
>  1 file changed, 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


