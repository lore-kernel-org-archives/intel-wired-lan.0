From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed, 3 Mar 2021 03:07:26 +0200
Subject: [Intel-wired-lan] [PATCH net-next v3 6/8] igc: Add support for
 tuning frame preemption via ethtool
In-Reply-To: <20210122224453.4161729-7-vinicius.gomes@intel.com>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-7-vinicius.gomes@intel.com>
Message-ID: <20210303010726.7rt6j53zg5xwwtex@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 22, 2021 at 02:44:51PM -0800, Vinicius Costa Gomes wrote:
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 0e78abfd99ee..c2155d109bd6 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -410,10 +410,14 @@
>  /* Transmit Scheduling */
>  #define IGC_TQAVCTRL_TRANSMIT_MODE_TSN	0x00000001
>  #define IGC_TQAVCTRL_ENHANCED_QAV	0x00000008
> +#define IGC_TQAVCTRL_PREEMPT_ENA	0x00000002
> +#define IGC_TQAVCTRL_MIN_FRAG_MASK	0x0000C000
> +#define IGC_TQAVCTRL_MIN_FRAG_SHIFT	14
> @@ -83,13 +89,22 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>  	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
>  	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
>  
> -	tqavctrl = rd32(IGC_TQAVCTRL);
>  	rxpbs = rd32(IGC_RXPBS) & ~IGC_RXPBSIZE_SIZE_MASK;
>  	rxpbs |= IGC_RXPBSIZE_TSN;
>  
>  	wr32(IGC_RXPBS, rxpbs);
>  
> +	tqavctrl = rd32(IGC_TQAVCTRL) &
> +		~(IGC_TQAVCTRL_MIN_FRAG_MASK | IGC_TQAVCTRL_PREEMPT_ENA);
>  	tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN | IGC_TQAVCTRL_ENHANCED_QAV;
> +
> +	if (adapter->frame_preemption_active)
> +		tqavctrl |= IGC_TQAVCTRL_PREEMPT_ENA;

Question: when adapter->frame_preemption_active is false, does the port
have the pMAC enabled, and can it receive preemptable frames? Maybe we
should be very explicit that the ethtool frame preemption only configures
the egress side, and that a driver capable of FP should always turn on
the pMAC on RX. Are you aware of any performance downsides?

> +
> +	frag_size_mult = ethtool_frag_size_to_mult(adapter->add_frag_size);
> +
> +	tqavctrl |= frag_size_mult << IGC_TQAVCTRL_MIN_FRAG_SHIFT;
> +
>  	wr32(IGC_TQAVCTRL, tqavctrl);
>  
>  	wr32(IGC_QBVCYCLET_S, cycle);
