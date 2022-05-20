From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 20 May 2022 11:06:00 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 10/11] igc: Check
 incompatible configs for Frame Preemption
In-Reply-To: <20220520011538.1098888-11-vinicius.gomes@intel.com>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
 <20220520011538.1098888-11-vinicius.gomes@intel.com>
Message-ID: <20220520110559.p65s3wf2dr4qhjxi@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 19, 2022 at 06:15:37PM -0700, Vinicius Costa Gomes wrote:
> Frame Preemption and LaunchTime cannot be enabled on the same queue.
> If that situation happens, emit an error to the user, and log the
> error.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 69e96e9a3ec8..96ad00e33f4b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -5916,6 +5916,11 @@ static int igc_save_launchtime_params(struct igc_adapter *adapter, int queue,
>  	if (queue < 0 || queue >= adapter->num_tx_queues)
>  		return -EINVAL;
>  
> +	if (ring->preemptible) {
> +		netdev_err(adapter->netdev, "Cannot enable LaunchTime on a preemptible queue\n");
> +		return -EINVAL;
> +	}
> +
>  	ring = adapter->tx_ring[queue];
>  	ring->launchtime_enable = enable;
>  
> -- 
> 2.35.3
>

I'm kind of concerned about this. I was thinking of adapting some
scripts I had into some functional kselftests for frame preemption.
I am sending 2 streams, one preemptable and one express. With SO_TXTIME
I am controlling their scheduled TX times, and I am forcing collisions
in the MAC merge layer by making the express packet have a scheduled TX
time equal to the preemptable packet's scheduled TX time, then I gradually
increase the express packet's scheduled time by small amounts (8 ns or so).
I take hardware TX timestamps of both packets and I plot when the express
packet is actually sent by the MAC. That is, I measure how long it takes
for the MAC to preempt and to reschedule the express packet.

My point is, if the LaunchTime feature cannot be enabled on preemptable
queues, how can I know that the igc does something functionally valid with
preemptable packets on TX, other than to reassemble the mPackets on RX?

Otherwise, if there isn't any other disagreement on the UAPI, would you
mind posting the iproute2 patch as well, so we could work in parallel
(me on enetc + the selftest) until net-next reopens? I'd like to write a
selftest that covers your hardware as well, but then again, not sure how
to cover it.

Do you have any sort of counters from the list in clause 30.14
Management for MAC Merge Sublayer? I see that structured ethtool counters
are becoming more popular, see struct ethtool_eth_mac_stats for example.
