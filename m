From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 26 Jan 2021 00:32:44 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 6/8] igc: Add support for
 tuning frame preemption via ethtool
In-Reply-To: <20210122224453.4161729-7-vinicius.gomes@intel.com>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-7-vinicius.gomes@intel.com>
Message-ID: <20210126003243.x3c44pmxmieqsa6e@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 22, 2021 at 02:44:51PM -0800, Vinicius Costa Gomes wrote:
> The tc subsystem sets which queues are marked as preemptible, it's the
> role of ethtool to control more hardware specific parameters. These
> parameters include:
> 
>  - enabling the frame preemption hardware: As enabling frame
>  preemption may have other requirements before it can be enabled, it's
>  exposed via the ethtool API;
> 
>  - mininum fragment size multiplier: expressed in usually in the form
>  of (1 + N)*64, this number indicates what's the size of the minimum
>  fragment that can be preempted.

And not one word has been said about the patch...

> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         | 12 +++++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  4 ++
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 53 ++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_tsn.c     | 25 +++++++--
>  4 files changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 35baae900c1f..1067c46e0bc2 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -87,6 +87,7 @@ struct igc_ring {
>  	u8 queue_index;                 /* logical index of the ring*/
>  	u8 reg_idx;                     /* physical index of the ring */
>  	bool launchtime_enable;         /* true if LaunchTime is enabled */
> +	bool preemptible;		/* true if not express */

Mixing tabs and spaces?

> +static int igc_ethtool_set_preempt(struct net_device *netdev,
> +				   struct ethtool_fp *fpcmd,
> +				   struct netlink_ext_ack *extack)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	int i;
> +
> +	if (fpcmd->add_frag_size < 68 || fpcmd->add_frag_size > 260) {
> +		NL_SET_ERR_MSG_MOD(extack, "Invalid value for add-frag-size");
> +		return -EINVAL;
> +	}

This check should belong in ethtool, since there's nothing unusual about
this supported range.

Also, I believe that Jakub requested the min-frag-size to be passed as
0, 1, 2, 3 as the standard specifies it, and not its multiplied version?

> +
> +	adapter->frame_preemption_active = fpcmd->enabled;
> +	adapter->add_frag_size = fpcmd->add_frag_size;
> +
> +	if (!adapter->frame_preemption_active)
> +		goto done;
> +
> +	/* Enabling frame preemption requires TSN mode to be enabled,
> +	 * which requires a schedule to be active. So, if there isn't
> +	 * a schedule already configured, configure a simple one, with
> +	 * all queues open, with 1ms cycle time.
> +	 */
> +	if (adapter->base_time)
> +		goto done;

Unless I'm missing something, you are interpreting an adapter->base_time
value of zero as "no Qbv schedule on port", as if it was invalid to have
a base-time of zero, which it isn't.

> @@ -115,6 +130,9 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>  		if (ring->launchtime_enable)
>  			txqctl |= IGC_TXQCTL_QUEUE_MODE_LAUNCHT;
>  
> +		if (ring->preemptible)
> +			txqctl |= IGC_TXQCTL_PREEMPTABLE;

I think this is the only place in the series where you use PREEMPTABLE
instead of PREEMPTIBLE.

> +
>  		wr32(IGC_TXQCTL(i), txqctl);
>  	}

Out of curiosity, where is the ring to traffic class mapping configured
in the igc driver? I suppose that you have more rings than traffic classes.
