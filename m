From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 19 Apr 2022 15:33:02 +0200
Subject: [Intel-wired-lan] [PATCH 2/2] Trigger proper interrupts in
 igc_xsk_wakeup
In-Reply-To: <20220415210546.11294-1-jeff.evanson@qsc.com>
References: <20220415210546.11294-1-jeff.evanson@qsc.com>
Message-ID: <c7d700d8ae15a709424dd337ce459c50406c0a6c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2022-04-15 at 15:05 -0600, Jeff Evanson wrote:
> in igc_xsk_wakeup, trigger the proper interrupt based on whether flags
> contains XDP_WAKEUP_RX and/or XDP_WAKEUP_TX
> 
> Signed-off-by: Jeff Evanson <jeff.evanson@qsc.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 36 +++++++++++++++++------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index a36a18c84aeb..d706de95dc06 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6073,7 +6073,7 @@ static void igc_trigger_rxtxq_interrupt(struct igc_adapter *adapter,
>  int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
>  {
>  	struct igc_adapter *adapter = netdev_priv(dev);
> -	struct igc_q_vector *q_vector;
> +	struct igc_q_vector *txq_vector = 0, *rxq_vector = 0;

Since a v2 is likely required - see even Vinicius's comments on patch
1/2 - please reorder the above to respect the reverse x-mas tree order
and fix the sparse warning introduced above (s/ = 0/ = NULL/)

Thanks!

Paolo

