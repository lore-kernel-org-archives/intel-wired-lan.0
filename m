From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Wed, 14 Oct 2015 00:47:36 +0000
Subject: [Intel-wired-lan] [next-queue 11/17] fm10k: Add support for
	ITR	scaling based on PCIe link speed
In-Reply-To: <1444779554-20464-11-git-send-email-jacob.e.keller@intel.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-11-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC51D20@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, October 13, 2015 4:39 PM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [next-queue 11/17] fm10k: Add support for ITR
> scaling based on PCIe link speed
> 
> Red Rock Canyon's interrupt throttle timers are based on the PCIe link
> speed. Because of this, the value being programmed into the ITR
> registers must be scaled.

"Red Rock Canyon" is a codename.  Use "The fm10k device" or
"Intel Ethernet Switch FM10000 Host Interface" instead.

> 
> For the PF, this is as simple as reading the PCIe link speed and storing
> the result. However, in the case of SR-IOV, the VF's interrupt throttle
> timers are based on the link speed of the PF. However, the VF is unable
> to get the link speed information from its configuration space, so the
> PF must inform it of what scale to use.
> 
> Rather than pass this scale via mailbox message, take advantage of
> unused bits in the TDLEN register to pass the scale. It is the
> responsibility of the PF to program this for the VF while setting up the
> VF queues and the responsibility of the VF to get the information
> accordingly. This is preferable because it allows the VF to set up the
> interrupts properly during initialization and matches how the MAC
> address is passed in the TDBAL/TDBAH registers.
> 
> Reported-by: Matthew Vick <matthew.vick@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c   | 22
> +++++++++++++++++++++-
>  drivers/net/ethernet/intel/fm10k/fm10k_type.h | 15 +++++++++++++++

Care to update the copyright date in fm10k_type.h while you're already updating it?

>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c   | 20
> ++++++++++++++++++--
>  3 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
> index 52f754b35972..9c3a48f04056 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
> @@ -150,19 +150,26 @@ static s32 fm10k_init_hw_pf(struct fm10k_hw
> *hw)
>  				FM10K_TPH_RXCTRL_HDR_WROEN);
>  	}
> 
> -	/* set max hold interval to align with 1.024 usec in all modes */
> +	/* set max hold interval to align with 1.024 usec in all modes and
> +	 * store ITR scale
> +	 */
>  	switch (hw->bus.speed) {
>  	case fm10k_bus_speed_2500:
>  		dma_ctrl = FM10K_DMA_CTRL_MAX_HOLD_1US_GEN1;
> +		hw->mac.itr_scale = FM10K_TDLEN_ITR_SCALE_GEN1;
>  		break;
>  	case fm10k_bus_speed_5000:
>  		dma_ctrl = FM10K_DMA_CTRL_MAX_HOLD_1US_GEN2;
> +		hw->mac.itr_scale = FM10K_TDLEN_ITR_SCALE_GEN2;
>  		break;
>  	case fm10k_bus_speed_8000:
>  		dma_ctrl = FM10K_DMA_CTRL_MAX_HOLD_1US_GEN3;
> +		hw->mac.itr_scale = FM10K_TDLEN_ITR_SCALE_GEN3;
>  		break;
>  	default:
>  		dma_ctrl = 0;
> +		/* just in case, assume Gen3 ITR scale */
> +		hw->mac.itr_scale = FM10K_TDLEN_ITR_SCALE_GEN3;
>  		break;
>  	}
> 
> @@ -903,6 +910,13 @@ static s32
> fm10k_iov_assign_default_mac_vlan_pf(struct fm10k_hw *hw,
>  	fm10k_write_reg(hw, FM10K_TDBAL(vf_q_idx), tdbal);
>  	fm10k_write_reg(hw, FM10K_TDBAH(vf_q_idx), tdbah);
> 
> +	/* Provide the VF the ITR scale, using software-defined fields in
> TDLEN
> +	 * to pass the information during VF initialization. See definition of
> +	 * FM10K_TDLEN_ITR_SCALE_SHIFT for more details.
> +	 */
> +	fm10k_write_reg(hw, FM10K_TDLEN(vf_q_idx), hw->mac.itr_scale
> <<
> +
> FM10K_TDLEN_ITR_SCALE_SHIFT);
> +
>  err_out:
>  	/* configure Queue control register */
>  	txqctl = ((u32)vf_vid << FM10K_TXQCTL_VID_SHIFT) &
> @@ -1035,6 +1049,12 @@ static s32 fm10k_iov_reset_resources_pf(struct
> fm10k_hw *hw,
>  	for (i = queues_per_pool; i--;) {
>  		fm10k_write_reg(hw, FM10K_TDBAL(vf_q_idx + i), tdbal);
>  		fm10k_write_reg(hw, FM10K_TDBAH(vf_q_idx + i), tdbah);
> +		/* See definition of FM10K_TDLEN_ITR_SCALE_SHIFT for an
> +		 * explanation of how TDLEN is used.
> +		 */
> +		fm10k_write_reg(hw, FM10K_TDLEN(vf_q_idx + i),
> +				hw->mac.itr_scale <<
> +				FM10K_TDLEN_ITR_SCALE_SHIFT);
>  		fm10k_write_reg(hw, FM10K_TQMAP(qmap_idx + i),
> vf_q_idx + i);
>  		fm10k_write_reg(hw, FM10K_RQMAP(qmap_idx + i),
> vf_q_idx + i);
>  	}
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_type.h
> b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
> index 35afd711d144..02d370fb8bbb 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_type.h
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
> @@ -272,6 +272,20 @@ struct fm10k_hw;
>  #define FM10K_TDBAL(_n)		((0x40 * (_n)) + 0x8000)
>  #define FM10K_TDBAH(_n)		((0x40 * (_n)) + 0x8001)
>  #define FM10K_TDLEN(_n)		((0x40 * (_n)) + 0x8002)
> +/* When fist initialized, VFs need to know the Interrupt Throttle Rate (ITR)
> + * scale which is based on the PCIe speed but the speed information in the
> PCI
> + * configuration space may not be accurate. The PF already knows the ITR
> scale
> + * but there is no defined method to pass that information from the PF to
> the
> + * VF. This is accomplished during VF initialization by temporarily co-opting
> + * the yet-to-be-used TDLEN register to have the PF store the ITR shift for
> + * the VF to retrieve before the VF needs to use the TDLEN register for its
> + * intended purpose, i.e. before the Tx resources are allocated.
> + */
> +#define FM10K_TDLEN_ITR_SCALE_SHIFT		9
> +#define FM10K_TDLEN_ITR_SCALE_MASK		0x00000E00
> +#define FM10K_TDLEN_ITR_SCALE_GEN1		2
> +#define FM10K_TDLEN_ITR_SCALE_GEN2		1
> +#define FM10K_TDLEN_ITR_SCALE_GEN3		0
>  #define FM10K_TPH_TXCTRL(_n)	((0x40 * (_n)) + 0x8003)
>  #define FM10K_TPH_TXCTRL_DESC_TPHEN		0x00000020
>  #define FM10K_TPH_TXCTRL_DESC_RROEN		0x00000200
> @@ -560,6 +574,7 @@ struct fm10k_mac_info {
>  	bool get_host_state;
>  	bool tx_ready;
>  	u32 dglort_map;
> +	u8 itr_scale;
>  };
> 
>  struct fm10k_swapi_table_info {
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
> index d512575c33f3..2af697df5abc 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
> @@ -28,7 +28,7 @@
>  static s32 fm10k_stop_hw_vf(struct fm10k_hw *hw)
>  {
>  	u8 *perm_addr = hw->mac.perm_addr;
> -	u32 bal = 0, bah = 0;
> +	u32 bal = 0, bah = 0, tdlen;
>  	s32 err;
>  	u16 i;
> 
> @@ -48,6 +48,9 @@ static s32 fm10k_stop_hw_vf(struct fm10k_hw *hw)
>  		       ((u32)perm_addr[2]);
>  	}
> 
> +	/* restore default itr_scale for next VF initialization */
> +	tdlen = hw->mac.itr_scale << FM10K_TDLEN_ITR_SCALE_SHIFT;
> +
>  	/* The queues have already been disabled so we just need to
>  	 * update their base address registers
>  	 */
> @@ -56,6 +59,12 @@ static s32 fm10k_stop_hw_vf(struct fm10k_hw *hw)
>  		fm10k_write_reg(hw, FM10K_TDBAH(i), bah);
>  		fm10k_write_reg(hw, FM10K_RDBAL(i), bal);
>  		fm10k_write_reg(hw, FM10K_RDBAH(i), bah);
> +		/* Restore ITR scale in software-defined mechanism in
> TDLEN
> +		 * for next VF initialization. See definition of
> +		 * FM10K_TDLEN_ITR_SCALE_SHIFT for more details on the
> use of
> +		 * TDLEN here.
> +		 */
> +		fm10k_write_reg(hw, FM10K_TDLEN(i), tdlen);
>  	}
> 
>  	return 0;
> @@ -131,9 +140,16 @@ static s32 fm10k_init_hw_vf(struct fm10k_hw *hw)
>  	/* record maximum queue count */
>  	hw->mac.max_queues = i;
> 
> -	/* fetch default VLAN */
> +	/* fetch default VLAN and ITR scale */
>  	hw->mac.default_vid = (fm10k_read_reg(hw, FM10K_TXQCTL(0)) &
>  			       FM10K_TXQCTL_VID_MASK) >>
> FM10K_TXQCTL_VID_SHIFT;
> +	/* Read the ITR scale from TDLEN. See the definition of
> +	 * FM10K_TDLEN_ITR_SCALE_SHIFT for more information about
> how TDLEN is
> +	 * used here.
> +	 */
> +	hw->mac.itr_scale = (fm10k_read_reg(hw, FM10K_TDLEN(0)) &
> +			     FM10K_TDLEN_ITR_SCALE_MASK) >>
> +			    FM10K_TDLEN_ITR_SCALE_SHIFT;
> 
>  	return 0;
> 
> --
> 2.6.1.264.gbab76a9
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
