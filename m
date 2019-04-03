From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Apr 2019 21:57:23 +0000
Subject: [Intel-wired-lan] [next PATCH S4 05/11] i40e: fix wrapping
 around netif_set_real_num_tx_queues
In-Reply-To: <20190329220840.51187-5-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
 <20190329220840.51187-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3787D1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 29, 2019 3:09 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S4 05/11] i40e: fix wrapping around
> netif_set_real_num_tx_queues
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> After total number of queues are updated under heavy traffic with ethtool -L
> command, the driver may receive few skbuffs with queue_mapping value
> greater than new total number of queues causing kernel panic.
> 
> This fix flushes all skbs after netif_set_real_num_tx_queues call while
> reconfiguring total tx queues. This helps in avoiding skbs with invalid
> queue_mapping.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


