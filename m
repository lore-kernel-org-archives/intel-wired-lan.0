From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 11 Sep 2020 16:03:15 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 06/11]
 drivers/net/ethernet: clean up unused assignments
In-Reply-To: <20200911012337.14015-7-jesse.brandeburg@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-7-jesse.brandeburg@intel.com>
Message-ID: <e1cf9542-4e3b-a666-7861-47b069b3a606@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 9/10/2020 6:23 PM, Jesse Brandeburg wrote:
> As part of the W=1 compliation series, these lines all created
> warnings about unused variables that were assigned a value. Most
> of them are from register reads, but some are just picking up
> a return value from a function and never doing anything with it.
> 
> The register reads should be OK, because the current
> implementation of readl and friends will always execute even
> without an lvalue.
> 
> When it makes sense, just remove the lvalue assignment and the
> local. Other times, just remove the offending code, and
> occasionally, just mark the variable as maybe unused since it
> could be used in an ifdef or debug scenario.
> 
> Only compile tested with W=1 and an allyesconfig with all the
> network drivers turned into modules (to try to test all options).
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/brocade/bna/bnad.c       |  7 ++--
>  .../net/ethernet/cavium/liquidio/lio_main.c   |  4 +--
>  .../ethernet/cavium/liquidio/octeon_device.c  | 13 ++++----
>  drivers/net/ethernet/cortina/gemini.c         |  6 ++--
>  drivers/net/ethernet/dec/tulip/de4x5.c        |  4 +--
>  drivers/net/ethernet/dec/tulip/media.c        |  5 ---
>  drivers/net/ethernet/dnet.c                   |  8 ++---
>  drivers/net/ethernet/freescale/fec_ptp.c      |  3 +-
>  drivers/net/ethernet/marvell/mvneta.c         |  7 ++--
>  drivers/net/ethernet/marvell/pxa168_eth.c     |  3 +-
>  drivers/net/ethernet/mellanox/mlx4/en_tx.c    |  2 +-
>  drivers/net/ethernet/micrel/ksz884x.c         | 13 +++-----
>  drivers/net/ethernet/microchip/lan743x_main.c |  9 ++----
>  drivers/net/ethernet/neterion/vxge/vxge-reg.h |  4 +--
>  .../net/ethernet/neterion/vxge/vxge-traffic.c | 32 +++++++------------
>  .../ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |  3 +-
>  drivers/net/ethernet/sfc/falcon/farch.c       | 29 +++++++----------
>  drivers/net/ethernet/sis/sis900.c             |  5 ++-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  4 +--
>  .../net/ethernet/synopsys/dwc-xlgmac-common.c |  2 +-
>  drivers/net/ethernet/ti/cpsw_new.c            |  2 --
>  drivers/net/ethernet/ti/davinci_emac.c        |  5 ++-
>  drivers/net/ethernet/ti/tlan.c                |  4 +--
>  drivers/net/ethernet/via/via-velocity.c       | 13 --------
>  24 files changed, 65 insertions(+), 122 deletions(-)
> 
> diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
> index cc80bbbefe87..7e4e831d720f 100644
> --- a/drivers/net/ethernet/brocade/bna/bnad.c
> +++ b/drivers/net/ethernet/brocade/bna/bnad.c
> @@ -3277,7 +3277,7 @@ bnad_change_mtu(struct net_device *netdev, int new_mtu)
>  {
>  	int err, mtu;
>  	struct bnad *bnad = netdev_priv(netdev);
> -	u32 rx_count = 0, frame, new_frame;
> +	u32 frame, new_frame;
>  
>  	mutex_lock(&bnad->conf_mutex);
>  
> @@ -3293,12 +3293,9 @@ bnad_change_mtu(struct net_device *netdev, int new_mtu)
>  		/* only when transition is over 4K */
>  		if ((frame <= 4096 && new_frame > 4096) ||
>  		    (frame > 4096 && new_frame <= 4096))
> -			rx_count = bnad_reinit_rx(bnad);
> +			bnad_reinit_rx(bnad);
>  	}
>  
> -	/* rx_count > 0 - new rx created
> -	 *	- Linux set err = 0 and return
> -	 */
>  	err = bnad_mtu_set(bnad, new_frame);
>  	if (err)
>  		err = -EBUSY;
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index 8e0ed01e7f03..737ae69eec6e 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -1,4 +1,4 @@
> -/**********************************************************************
> +/*

I suspect this was meant to go into the kdoc patch instead?

Thanks,
Jake
