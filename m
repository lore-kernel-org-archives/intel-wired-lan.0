From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Sun, 18 Oct 2020 15:28:42 +0200
Subject: [Intel-wired-lan] [PATCH v2 6/6] igb: avoid transmit queue
 timeout in xdp path
In-Reply-To: <20201017071238.95190-7-sven.auhagen@voleatech.de>
References: <20201017071238.95190-1-sven.auhagen@voleatech.de>
 <20201017071238.95190-7-sven.auhagen@voleatech.de>
Message-ID: <20201018132842.GA34104@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Oct 17, 2020 at 09:12:38AM +0200, sven.auhagen at voleatech.de wrote:
> From: Sven Auhagen <sven.auhagen@voleatech.de>
> 
> Since we share the transmit queue with the slow path,
> it is possible that we run into a transmit queue timeout.
> This will reset the queue.
> This happens under high load when the fast path is using the
> transmit queue pretty much exclusively.

I'm kinda not leaning towards slow/fast path distinction here, IMHO it
would be better to state that transmit queues are shared between network
stack and XDP, but that's just a rant.

> 
> By setting the transmit queues trans_start variable to jiffies
> in the two xdp xmit functions we avoid the timeout.

Probably a few more words of explanation would help here, specifically I
would say that netdev_start_xmit() sets trans_start to jiffies which is
later utilized by dev_watchdog(), so to avoid timeout, let stack know that
XDP xmit happened by bumping the trans_start within XDP Tx routines.

> 
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 55e708f75187..4a082c06f48d 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2916,6 +2916,8 @@ static int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
>  
>  	nq = txring_txq(tx_ring);
>  	__netif_tx_lock(nq, cpu);
> +	/* Avoid transmit queue timeout since we share it with the slow path */
> +	nq->trans_start = jiffies;
>  	ret = igb_xmit_xdp_ring(adapter, tx_ring, xdpf);
>  	__netif_tx_unlock(nq);
>  
> @@ -2948,6 +2950,9 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
>  	nq = txring_txq(tx_ring);
>  	__netif_tx_lock(nq, cpu);
>  
> +	/* Avoid transmit queue timeout since we share it with the slow path */
> +	nq->trans_start = jiffies;
> +
>  	for (i = 0; i < n; i++) {
>  		struct xdp_frame *xdpf = frames[i];
>  		int err;
> -- 
> 2.20.1
> 
