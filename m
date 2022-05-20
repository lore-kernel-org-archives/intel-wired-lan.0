From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 20 May 2022 12:13:25 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 11/11] igc: Add support
 for exposing frame preemption stats registers
In-Reply-To: <20220520011538.1098888-12-vinicius.gomes@intel.com>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
 <20220520011538.1098888-12-vinicius.gomes@intel.com>
Message-ID: <20220520121324.d54p2vjypwyuqhhz@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 19, 2022 at 06:15:38PM -0700, Vinicius Costa Gomes wrote:
> Expose the Frame Preemption counters, so the number of
> express/preemptible packets can be monitored by userspace.
> 
> These registers are cleared when read, so the value shown is the
> number of events that happened since the last read.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c |  8 ++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    | 10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 9a80e2569dc3..0a84fbdd494b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -344,6 +344,14 @@ static void igc_ethtool_get_regs(struct net_device *netdev,
>  
>  	regs_buff[213] = adapter->stats.tlpic;
>  	regs_buff[214] = adapter->stats.rlpic;
> +	regs_buff[215] = rd32(IGC_PRMPTDTCNT);
> +	regs_buff[216] = rd32(IGC_PRMEVNTTCNT);
> +	regs_buff[217] = rd32(IGC_PRMPTDRCNT);
> +	regs_buff[218] = rd32(IGC_PRMEVNTRCNT);
> +	regs_buff[219] = rd32(IGC_PRMPBLTCNT);
> +	regs_buff[220] = rd32(IGC_PRMPBLRCNT);
> +	regs_buff[221] = rd32(IGC_PRMEXPTCNT);
> +	regs_buff[222] = rd32(IGC_PRMEXPRCNT);
>  }
>  
>  static void igc_ethtool_get_wol(struct net_device *netdev,
> diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
> index e197a33d93a0..2b5ef1e80f5f 100644
> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
> @@ -224,6 +224,16 @@
>  
>  #define IGC_FTQF(_n)	(0x059E0 + (4 * (_n)))  /* 5-tuple Queue Fltr */
>  
> +/* Time sync registers - preemption statistics */
> +#define IGC_PRMPTDTCNT	0x04280  /* Good TX Preempted Packets */
> +#define IGC_PRMEVNTTCNT	0x04298  /* TX Preemption event counter */
> +#define IGC_PRMPTDRCNT	0x04284  /* Good RX Preempted Packets */
> +#define IGC_PRMEVNTRCNT	0x0429C  /* RX Preemption event counter */
> +#define IGC_PRMPBLTCNT	0x04288  /* Good TX Preemptable Packets */
> +#define IGC_PRMPBLRCNT	0x0428C  /* Good RX Preemptable Packets */
> +#define IGC_PRMEXPTCNT	0x04290  /* Good TX Express Packets */
> +#define IGC_PRMEXPRCNT	0x042A0  /* Preemption Exception Counter */
> +

Ah, I didn't notice this. FWIW, the standard talks about the following,
at the MAC merge layer:

aMACMergeFrameAssErrorCount
  A count of MAC frames with reassembly errors. The counter is
  incremented by one every time the ASSEMBLY_ERROR state in the Receive
  Processing State Diagram is entered (see Figure 99?6)

aMACMergeFrameSmdErrorCount
  A count of received MAC frames / MAC frame fragments rejected due to
  unknown SMD value or arriving with an SMD-C when no frame is in
  progress. The counter is incremented by one every time the BAD_FRAG
  state in the Receive Processing State Diagram is entered and every
  time the WAIT_FOR_DV_FALSE state is entered due to the invocation of
  the SMD_DECODE function returning the value ?ERR? (see Figure 99?6)

aMACMergeFrameAssOkCount
  A count of MAC frames that were successfully reassembled and delivered
  to MAC. The counter is incremented by one every time the
  FRAME_COMPLETE state in the Receive Processing state diagram (see
  Figure 99?6) is entered if the state CHECK_FOR_RESUME was previously
  entered while processing the packet.

aMACMergeFragCountRx
  A count of the number of additional mPackets received due to preemption.
  The counter is incremented by one every time the state CHECK_FRAG_CNT
  in the Receive Processing State Diagram (see Figure 99?6) is entered.

aMACMergeFragCountTx
  A count of the number of additional mPackets transmitted due to preemption.
  This counter is incremented by one every time the SEND_SMD_C state in
  the Transmit Processing State Diagram (see Figure 99?5) is entered.

aMACMergeHoldCount
  A count of the number of times the variable hold (see 99.4.7.3)
  transitions from FALSE to TRUE.

I think we have the following correspondence:
"TX Preemption event counter" -> aMACMergeFragCountTx
"RX Preemption event counter" -> aMACMergeFragCountRx
"Preemption Exception Counter" -> aMACMergeFrameAssErrorCount + aMACMergeFrameSmdErrorCount?

Then we have the following uncovered counters:

Good TX Preempted Packets
Good RX Preempted Packets
Good TX Preemptable Packets
Good RX Preemptable Packets
Good TX Express Packets

These are at the level of individual MACs (pMAC, eMAC) rather than the MAC merge layer.


FWIW, ENETC has the following counters for FP:

Port MAC Merge Frame Assembly Error Count
Port MAC Merge Frame SMD Error Count
Port MAC Merge Frame Assembly OK
Port MAC Merge Fragment Count RX
Port MAC Merge Fragment Count TX
Port MAC Merge Hold Count

Then it has a series of RMON counters replicated twice, once for the
Port MAC 0 (eMAC) and once for Port MAC 1 (pMAC).

Similarly, the Felix switch has:

c_rx_assembly_err
c_rx_smd_err
c_rx_assembly_ok
c_rx_merge_frag

plus RMON counters replicated for the regular MAC and for the pMAC
(c_rx_pmac_oct vs c_rx_oct, c_rx_pmac_uc vs c_rx_uc, c_rx_pmac_sz_65_127
vs c_rx_sz_65_127, etc etc).

I think there's a tendency here. Maybe we count have structured data for
MAC merge layer counters, pMAC counters and eMAC counters? We already
have eMAC counters in the form of ethtool_eth_mac_stats, ethtool_eth_ctrl_stats,
ethtool_pause_stats, etc etc. We just need to figure out a way of
retrieving the same thing for the preemptable MAC.

Jakub, any ideas?

>  /* Transmit Scheduling Registers */
>  #define IGC_TQAVCTRL		0x3570
>  #define IGC_TXQCTL(_n)		(0x3344 + 0x4 * (_n))
> -- 
> 2.35.3
>
