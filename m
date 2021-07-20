From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 20 Jul 2021 08:27:34 +0200
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix ATR queue selection
In-Reply-To: <20210719194931.11173-1-arkadiusz.kubalewski@intel.com>
References: <20210719194931.11173-1-arkadiusz.kubalewski@intel.com>
Message-ID: <8bc5e9a3-36a1-e90e-7e29-dba1a700bd56@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Arkadiusz,


Am 19.07.21 um 21:49 schrieb Arkadiusz Kubalewski:
> If traffic classes are not configured for PF, then use
> netdev_pick_tx function for selecting queue for packet transmission.
> Instead of calling i40e_swdcb_skb_tx_hash, call netdev_pick_tx,
> which ensures that packet is transmitted/received from CPU that is
> running the application.
> Without this patch, ATR does not work. Receive/transmit uses queue
> selection based on SW DCB hashing method.

For the future, the problem statement should go first in my opinion.

Do you have a recipe, how to reproduce the problem?


Kind regards,

Paul

> Fixes: 821bd0c990ba ("i40e: Fix queue-to-TC mapping on Tx")
> Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 3f25bd8..10a83e5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -3663,8 +3663,7 @@ u16 i40e_lan_select_queue(struct net_device *netdev,
>   
>   	/* is DCB enabled at all? */
>   	if (vsi->tc_config.numtc == 1)
> -		return i40e_swdcb_skb_tx_hash(netdev, skb,
> -					      netdev->real_num_tx_queues);
> +		return netdev_pick_tx(netdev, skb, sb_dev);
>   
>   	prio = skb->priority;
>   	hw = &vsi->back->hw;
> 
> base-commit: e84671cd9648eb1f2b346378c100b4ebfbd1b01c
> 
