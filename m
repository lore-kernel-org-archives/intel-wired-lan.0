From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 20 Jun 2019 06:47:25 -0400
Subject: [Intel-wired-lan] [PATCH net-next v4 1/7] igb: clear out tstamp
 after sending the packet
In-Reply-To: <1560966016-28254-2-git-send-email-vedang.patel@intel.com>
References: <1560966016-28254-1-git-send-email-vedang.patel@intel.com>
 <1560966016-28254-2-git-send-email-vedang.patel@intel.com>
Message-ID: <d6655497-5246-c24e-de35-fc6acdad0bf1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 6/19/19 10:40 AM, Vedang Patel wrote:
> skb->tstamp is being used at multiple places. On the transmit side, it
> is used to determine the launchtime of the packet. It is also used to
> determine the software timestamp after the packet has been transmitted.
> 
> So, clear out the tstamp value after it has been read so that we do not
> report false software timestamp on the receive side.
> 
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index fc925adbd9fa..f66dae72fe37 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -5688,6 +5688,7 @@ static void igb_tx_ctxtdesc(struct igb_ring *tx_ring,
>  	 */
>  	if (tx_ring->launchtime_enable) {
>  		ts = ns_to_timespec64(first->skb->tstamp);
> +		first->skb->tstamp = 0;

Please provide more explanations.

Why only this driver would need this ?


>  		context_desc->seqnum_seed = cpu_to_le32(ts.tv_nsec / 32);
>  	} else {
>  		context_desc->seqnum_seed = 0;
> 
