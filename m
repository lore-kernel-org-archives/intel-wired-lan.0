From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Thu, 14 May 2015 17:34:27 -0700
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: add array of MAC type
 dependent values
In-Reply-To: <20150514221630.16569.73269.stgit@dcs-desk.jf.intel.com>
References: <20150514221630.16569.73269.stgit@dcs-desk.jf.intel.com>
Message-ID: <55553F13.2010605@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/14/2015 03:16 PM, Don Skidmore wrote:
> Some of the register addresses and format where unfortunately changed
> between MAC types. To get around this we add a const u32 *mvals pointer
> to the ixgbe_hw struct to point to an array of mac-type-dependent
> values.  These can include register offsets, masks, whatever can be in
> a u32. When the ixgbe_hw struct is initialized, a pointer to the
> appropriate array must be set.
>
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c  |    1
>   drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c  |    1
>   drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    5 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |    2
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |   20 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |  210 +++++++++++++++++++++--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c   |    5 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |   10 +
>   8 files changed, 227 insertions(+), 27 deletions(-)
>

I added a few comments inline below.  Other than the fact that you 
should make the tables all const the only other thing I see is the 
naming is a big ugly.  I explained more in the comments below.

- Alex

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
> index 824a7ab..a0c2e3d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
> @@ -1234,4 +1234,5 @@ struct ixgbe_info ixgbe_82598_info = {
>   	.mac_ops		= &mac_ops_82598,
>   	.eeprom_ops		= &eeprom_ops_82598,
>   	.phy_ops		= &phy_ops_82598,
> +	.mvals			= ixgbe_mvals_base,
>   };
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
> index de83b6f..d773dca 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
> @@ -2376,4 +2376,5 @@ struct ixgbe_info ixgbe_82599_info = {
>   	.eeprom_ops             = &eeprom_ops_82599,
>   	.phy_ops                = &phy_ops_82599,
>   	.mbx_ops                = &mbx_ops_generic,
> +	.mvals			= ixgbe_mvals_base,
>   };
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> index 06d8f3c..f61ab24 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> @@ -57,6 +57,11 @@ static s32 ixgbe_detect_eeprom_page_size_generic(struct ixgbe_hw *hw,
>   						 u16 offset);
>   static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw);
>
> +/* Base table for registers values that change by MAC */
> +u32 ixgbe_mvals_base[IXGBE_MVALS_IDX_LIMIT] = {
> +	IXGBE_MVALS_INIT()
> +};
> +

This should be const u32, also I would say you might as well add a 
prefix for it.  Since you are lumping them together you might just label 
it something like 82598, 82599, or maybe even 8259X.

>   /**
>    *  ixgbe_device_supports_autoneg_fc - Check if phy supports autoneg flow
>    *  control
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
> index f21f8a1..b8240a3 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
> @@ -118,6 +118,8 @@ bool ixgbe_mng_enabled(struct ixgbe_hw *hw);
>   void ixgbe_set_rxpba_generic(struct ixgbe_hw *hw, int num_pb,
>   			     u32 headroom, int strategy);
>
> +extern u32 ixgbe_mvals_base[];
> +

extern const u32

>   #define IXGBE_I2C_THERMAL_SENSOR_ADDR	0xF8
>   #define IXGBE_EMC_INTERNAL_DATA		0x00
>   #define IXGBE_EMC_INTERNAL_THERM_LIMIT	0x20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index ee600b2..c58bae6 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2403,7 +2403,7 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
>
>   		break;
>   	default:
> -		if (!(eicr & IXGBE_EICR_GPI_SDP0))
> +		if (!(eicr & IXGBE_EICR_GPI_SDP0_BY_MAC(hw)))
>   			return;
>   		break;
>   	}
> @@ -2420,10 +2420,10 @@ static void ixgbe_check_fan_failure(struct ixgbe_adapter *adapter, u32 eicr)
>   	struct ixgbe_hw *hw = &adapter->hw;
>
>   	if ((adapter->flags & IXGBE_FLAG_FAN_FAIL_CAPABLE) &&
> -	    (eicr & IXGBE_EICR_GPI_SDP1)) {
> +	    (eicr & IXGBE_EICR_GPI_SDP1_BY_MAC(hw))) {
>   		e_crit(probe, "Fan has stopped, replace the adapter\n");
>   		/* write to clear the interrupt */
> -		IXGBE_WRITE_REG(hw, IXGBE_EICR, IXGBE_EICR_GPI_SDP1);
> +		IXGBE_WRITE_REG(hw, IXGBE_EICR, IXGBE_EICR_GPI_SDP1_BY_MAC(hw));
>   	}
>   }
>
> @@ -2464,18 +2464,18 @@ static void ixgbe_check_sfp_event(struct ixgbe_adapter *adapter, u32 eicr)
>   {
>   	struct ixgbe_hw *hw = &adapter->hw;
>
> -	if (eicr & IXGBE_EICR_GPI_SDP2) {
> +	if (eicr & IXGBE_EICR_GPI_SDP2_BY_MAC(hw)) {
>   		/* Clear the interrupt */
> -		IXGBE_WRITE_REG(hw, IXGBE_EICR, IXGBE_EICR_GPI_SDP2);
> +		IXGBE_WRITE_REG(hw, IXGBE_EICR, IXGBE_EICR_GPI_SDP2_BY_MAC(hw));
>   		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
>   			adapter->flags2 |= IXGBE_FLAG2_SFP_NEEDS_RESET;
>   			ixgbe_service_event_schedule(adapter);
>   		}
>   	}
>
> -	if (eicr & IXGBE_EICR_GPI_SDP1) {
> +	if (eicr & IXGBE_EICR_GPI_SDP1_BY_MAC(hw)) {
>   		/* Clear the interrupt */
> -		IXGBE_WRITE_REG(hw, IXGBE_EICR, IXGBE_EICR_GPI_SDP1);
> +		IXGBE_WRITE_REG(hw, IXGBE_EICR, IXGBE_EICR_GPI_SDP1_BY_MAC(hw));
>   		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
>   			adapter->flags |= IXGBE_FLAG_NEED_LINK_CONFIG;
>   			ixgbe_service_event_schedule(adapter);
> @@ -2560,6 +2560,7 @@ static inline void ixgbe_irq_disable_queues(struct ixgbe_adapter *adapter,
>   static inline void ixgbe_irq_enable(struct ixgbe_adapter *adapter, bool queues,
>   				    bool flush)
>   {
> +	struct ixgbe_hw *hw = &adapter->hw;
>   	u32 mask = (IXGBE_EIMS_ENABLE_MASK & ~IXGBE_EIMS_RTX_QUEUE);
>
>   	/* don't reenable LSC while waiting for link */
> @@ -2580,7 +2581,7 @@ static inline void ixgbe_irq_enable(struct ixgbe_adapter *adapter, bool queues,
>   			break;
>   		}
>   	if (adapter->flags & IXGBE_FLAG_FAN_FAIL_CAPABLE)
> -		mask |= IXGBE_EIMS_GPI_SDP1;
> +		mask |= IXGBE_EIMS_GPI_SDP1_BY_MAC(hw);
>   	switch (adapter->hw.mac.type) {
>   	case ixgbe_mac_82599EB:
>   		mask |= IXGBE_EIMS_GPI_SDP1;
> @@ -4866,7 +4867,7 @@ static void ixgbe_setup_gpie(struct ixgbe_adapter *adapter)
>
>   	/* Enable fan failure interrupt */
>   	if (adapter->flags & IXGBE_FLAG_FAN_FAIL_CAPABLE)
> -		gpie |= IXGBE_SDP1_GPIEN;
> +		gpie |= IXGBE_SDP1_GPIEN_BY_MAC(hw);
>
>   	if (hw->mac.type == ixgbe_mac_82599EB) {
>   		gpie |= IXGBE_SDP1_GPIEN;

I'm not really a fan of the _BY_MAC being added on.  I would say to just 
make the default register require an argument.  So instead it comes out 
IXGBE_SPD1_GPIEN(hw).  By doing that you guarantee that you have caught 
any places where the old define was being used.

> @@ -8453,6 +8454,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	/* Setup hw api */
>   	memcpy(&hw->mac.ops, ii->mac_ops, sizeof(hw->mac.ops));
>   	hw->mac.type  = ii->mac;
> +	hw->mvals     = ii->mvals;
>
>   	/* EEPROM */
>   	memcpy(&hw->eeprom.ops, ii->eeprom_ops, sizeof(hw->eeprom.ops));

You will ned to make sure that mvals is const u32 everwhere where it is 
defined.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> index dd6ba59..4eb90af 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> @@ -91,14 +91,24 @@
>   #define IXGBE_DEV_ID_X550_VF		0x1565
>   #define IXGBE_DEV_ID_X550EM_X_VF	0x15A8
>
> +#define IXGBE_CAT(r, m)	IXGBE_##r##m
> +
> +#define IXGBE_BY_MAC(_hw, r)	((_hw)->mvals[IXGBE_CAT(r, _IDX)])
> +

It seems like if you defined IXGBE_CAT(r, m) as IXGBE_##r_##m you could 
save yourself a bit of trouble by dropping all of the underscores you 
are having to pass when you call IXGBE_CAT or IXGBE_MVALS_INIT.

>   /* General Registers */
>   #define IXGBE_CTRL      0x00000
>   #define IXGBE_STATUS    0x00008
>   #define IXGBE_CTRL_EXT  0x00018
>   #define IXGBE_ESDP      0x00020
>   #define IXGBE_EODSDP    0x00028
> -#define IXGBE_I2CCTL_BY_MAC(_hw)((((_hw)->mac.type >= ixgbe_mac_X550) ? \
> -					0x15F5C : 0x00028))
> +
> +#define IXGBE_I2CCTL	0x00028
> +#define IXGBE_I2CCTL_X540	IXGBE_I2CCTL
> +#define IXGBE_I2CCTL_X550	0x15F5C
> +#define IXGBE_I2CCTL_X550EM_x	IXGBE_I2CCTL_X550
> +#define IXGBE_I2CCTL_X550EM_a	IXGBE_I2CCTL_X550
> +#define IXGBE_I2CCTL_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), I2CCTL)
> +

For the sake of readability I would say to lose the _BY_MAC name and 
just use the register name.  Then you can replace the register name 
based version with something like 82599 since that is probably where the 
original register started at.

>   #define IXGBE_LEDCTL    0x00200
>   #define IXGBE_FRTIMER   0x00048
>   #define IXGBE_TCPTIMER  0x0004C
> @@ -107,9 +117,19 @@
>
>   /* NVM Registers */
>   #define IXGBE_EEC       0x10010
> +#define IXGBE_EEC_X540		IXGBE_EEC
> +#define IXGBE_EEC_X550		IXGBE_EEC
> +#define IXGBE_EEC_X550EM_x	IXGBE_EEC
> +#define IXGBE_EEC_X550EM_a	0x15FF8
> +#define IXGBE_EEC_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), EEC)
>   #define IXGBE_EERD      0x10014
>   #define IXGBE_EEWR      0x10018
>   #define IXGBE_FLA       0x1001C
> +#define IXGBE_FLA_X540		IXGBE_FLA
> +#define IXGBE_FLA_X550		IXGBE_FLA
> +#define IXGBE_FLA_X550EM_x	IXGBE_FLA
> +#define IXGBE_FLA_X550EM_a	0x15F6C
> +#define IXGBE_FLA_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), FLA)
>   #define IXGBE_EEMNGCTL  0x10110
>   #define IXGBE_EEMNGDATA 0x10114
>   #define IXGBE_FLMNGCTL  0x10118
> @@ -117,6 +137,18 @@
>   #define IXGBE_FLMNGCNT  0x10120
>   #define IXGBE_FLOP      0x1013C
>   #define IXGBE_GRC       0x10200
> +#define IXGBE_GRC_X540		IXGBE_GRC
> +#define IXGBE_GRC_X550		IXGBE_GRC
> +#define IXGBE_GRC_X550EM_x	IXGBE_GRC
> +#define IXGBE_GRC_X550EM_a	0x15F64
> +#define IXGBE_GRC_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), GRC)
> +
> +#define IXGBE_SRAMREL	0x10210
> +#define IXGBE_SRAMREL_X540	IXGBE_SRAMREL
> +#define IXGBE_SRAMREL_X550	IXGBE_SRAMREL
> +#define IXGBE_SRAMREL_X550EM_x	IXGBE_SRAMREL
> +#define IXGBE_SRAMREL_X550EM_a	0x15F6C
> +#define IXGBE_SRAMREL_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), SRAMREL)
>
>   /* General Receive Control */
>   #define IXGBE_GRC_MNG  0x00000001 /* Manageability Enable */
> @@ -126,14 +158,55 @@
>   #define IXGBE_VPDDIAG1  0x10208
>
>   /* I2CCTL Bit Masks */
> -#define IXGBE_I2C_CLK_IN_BY_MAC(_hw)(((_hw)->mac.type) >= ixgbe_mac_X550 ? \
> -					0x00004000 : 0x00000001)
> -#define IXGBE_I2C_CLK_OUT_BY_MAC(_hw)(((_hw)->mac.type) >= ixgbe_mac_X550 ? \
> -					0x00000200 : 0x00000002)
> -#define IXGBE_I2C_DATA_IN_BY_MAC(_hw)(((_hw)->mac.type) >= ixgbe_mac_X550 ? \
> -					0x00001000 : 0x00000004)
> -#define IXGBE_I2C_DATA_OUT_BY_MAC(_hw)(((_hw)->mac.type) >= ixgbe_mac_X550 ? \
> -					0x00000400 : 0x00000008)
> +#define IXGBE_I2C_CLK_IN	0x00000001
> +#define IXGBE_I2C_CLK_IN_X540		IXGBE_I2C_CLK_IN
> +#define IXGBE_I2C_CLK_IN_X550		0x00004000
> +#define IXGBE_I2C_CLK_IN_X550EM_x	IXGBE_I2C_CLK_IN_X550
> +#define IXGBE_I2C_CLK_IN_X550EM_a	IXGBE_I2C_CLK_IN_X550
> +#define IXGBE_I2C_CLK_IN_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), I2C_CLK_IN)
> +
> +#define IXGBE_I2C_CLK_OUT	0x00000002
> +#define IXGBE_I2C_CLK_OUT_X540		IXGBE_I2C_CLK_OUT
> +#define IXGBE_I2C_CLK_OUT_X550		0x00000200
> +#define IXGBE_I2C_CLK_OUT_X550EM_x	IXGBE_I2C_CLK_OUT_X550
> +#define IXGBE_I2C_CLK_OUT_X550EM_a	IXGBE_I2C_CLK_OUT_X550
> +#define IXGBE_I2C_CLK_OUT_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), I2C_CLK_OUT)
> +
> +#define IXGBE_I2C_DATA_IN	0x00000004
> +#define IXGBE_I2C_DATA_IN_X540		IXGBE_I2C_DATA_IN
> +#define IXGBE_I2C_DATA_IN_X550		0x00001000
> +#define IXGBE_I2C_DATA_IN_X550EM_x	IXGBE_I2C_DATA_IN_X550
> +#define IXGBE_I2C_DATA_IN_X550EM_a	IXGBE_I2C_DATA_IN_X550
> +#define IXGBE_I2C_DATA_IN_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), I2C_DATA_IN)
> +
> +#define IXGBE_I2C_DATA_OUT	0x00000008
> +#define IXGBE_I2C_DATA_OUT_X540		IXGBE_I2C_DATA_OUT
> +#define IXGBE_I2C_DATA_OUT_X550		0x00000400
> +#define IXGBE_I2C_DATA_OUT_X550EM_x	IXGBE_I2C_DATA_OUT_X550
> +#define IXGBE_I2C_DATA_OUT_X550EM_a	IXGBE_I2C_DATA_OUT_X550
> +#define IXGBE_I2C_DATA_OUT_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), I2C_DATA_OUT)
> +
> +#define IXGBE_I2C_DATA_OE_N_EN	0
> +#define IXGBE_I2C_DATA_OE_N_EN_X540	IXGBE_I2C_DATA_OE_N_EN
> +#define IXGBE_I2C_DATA_OE_N_EN_X550	0x00000800
> +#define IXGBE_I2C_DATA_OE_N_EN_X550EM_x	IXGBE_I2C_DATA_OE_N_EN_X550
> +#define IXGBE_I2C_DATA_OE_N_EN_X550EM_a	IXGBE_I2C_DATA_OE_N_EN_X550
> +#define IXGBE_I2C_DATA_OE_N_EN_BY_MAC(_hw) IXGBE_BY_MAC((_hw), I2C_DATA_OE_N_EN)
> +
> +#define IXGBE_I2C_BB_EN		0
> +#define IXGBE_I2C_BB_EN_X540		IXGBE_I2C_BB_EN
> +#define IXGBE_I2C_BB_EN_X550		0x00000100
> +#define IXGBE_I2C_BB_EN_X550EM_x	IXGBE_I2C_BB_EN_X550
> +#define IXGBE_I2C_BB_EN_X550EM_a	IXGBE_I2C_BB_EN_X550
> +#define IXGBE_I2C_BB_EN_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), I2C_BB_EN)
> +
> +#define IXGBE_I2C_CLK_OE_N_EN	0
> +#define IXGBE_I2C_CLK_OE_N_EN_X540	IXGBE_I2C_CLK_OE_N_EN
> +#define IXGBE_I2C_CLK_OE_N_EN_X550	0x00002000
> +#define IXGBE_I2C_CLK_OE_N_EN_X550EM_x	IXGBE_I2C_CLK_OE_N_EN_X550
> +#define IXGBE_I2C_CLK_OE_N_EN_X550EM_a	IXGBE_I2C_CLK_OE_N_EN_X550
> +#define IXGBE_I2C_CLK_OE_N_EN_BY_MAC(_hw) IXGBE_BY_MAC((_hw), I2C_CLK_OE_N_EN)
> +
>   #define IXGBE_I2C_CLOCK_STRETCHING_TIMEOUT	500
>
>   #define IXGBE_I2C_THERMAL_SENSOR_ADDR	0xF8
> @@ -836,14 +909,34 @@ struct ixgbe_thermal_sensor_data {
>   #define IXGBE_GSCN_2    0x11028
>   #define IXGBE_GSCN_3    0x1102C
>   #define IXGBE_FACTPS    0x10150
> +#define IXGBE_FACTPS_X540	IXGBE_FACTPS
> +#define IXGBE_FACTPS_X550	IXGBE_FACTPS
> +#define IXGBE_FACTPS_X550EM_x	IXGBE_FACTPS
> +#define IXGBE_FACTPS_X550EM_a	0x15FEC
> +#define IXGBE_FACTPS_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), FACTPS)
> +
>   #define IXGBE_PCIEANACTL  0x11040
>   #define IXGBE_SWSM      0x10140
> +#define IXGBE_SWSM_X540		IXGBE_SWSM
> +#define IXGBE_SWSM_X550		IXGBE_SWSM
> +#define IXGBE_SWSM_X550EM_x	IXGBE_SWSM
> +#define IXGBE_SWSM_X550EM_a	0x15F70
> +#define IXGBE_SWSM_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), SWSM)
>   #define IXGBE_FWSM      0x10148
> +#define IXGBE_FWSM_X540		IXGBE_FWSM
> +#define IXGBE_FWSM_X550		IXGBE_FWSM
> +#define IXGBE_FWSM_X550EM_x	IXGBE_FWSM
> +#define IXGBE_FWSM_X550EM_a	0x15F74
> +#define IXGBE_FWSM_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), FWSM)
>   #define IXGBE_GSSR      0x10160
>   #define IXGBE_MREVID    0x11064
>   #define IXGBE_DCA_ID    0x11070
>   #define IXGBE_DCA_CTRL  0x11074
>   #define IXGBE_SWFW_SYNC IXGBE_GSSR
> +#define IXGBE_SWFW_SYNC_X540		IXGBE_SWFW_SYNC
> +#define IXGBE_SWFW_SYNC_X550		IXGBE_SWFW_SYNC
> +#define IXGBE_SWFW_SYNC_X550EM_x	IXGBE_SWFW_SYNC
> +#define IXGBE_SWFW_SYNC_X550EM_a	0x15F78
>
>   /* PCIe registers 82599-specific */
>   #define IXGBE_GCR_EXT           0x11050
> @@ -855,14 +948,21 @@ struct ixgbe_thermal_sensor_data {
>   #define IXGBE_PHYDAT_82599      0x11044
>   #define IXGBE_PHYCTL_82599      0x11048
>   #define IXGBE_PBACLR_82599      0x11068
> -#define IXGBE_CIAA_82599        0x11088
> -#define IXGBE_CIAD_82599        0x1108C
> -#define IXGBE_CIAA_X550         0x11508
> -#define IXGBE_CIAD_X550         0x11510
> -#define IXGBE_CIAA_BY_MAC(_hw)  ((((_hw)->mac.type >= ixgbe_mac_X550) ? \
> -				IXGBE_CIAA_X550 : IXGBE_CIAA_82599))
> -#define IXGBE_CIAD_BY_MAC(_hw)  ((((_hw)->mac.type >= ixgbe_mac_X550) ? \
> -				IXGBE_CIAD_X550 : IXGBE_CIAD_82599))
> +
> +#define IXGBE_CIAA	0x11088
> +#define IXGBE_CIAA_X540		IXGBE_CIAA
> +#define IXGBE_CIAA_X550		0x11508
> +#define IXGBE_CIAA_X550EM_x	IXGBE_CIAA_X550
> +#define IXGBE_CIAA_X550EM_a	IXGBE_CIAA_X550
> +#define IXGBE_CIAA_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), CIAA)
> +
> +#define IXGBE_CIAD	0x1108C
> +#define IXGBE_CIAD_X540		IXGBE_CIAD
> +#define IXGBE_CIAD_X550		0x11510
> +#define IXGBE_CIAD_X550EM_x	IXGBE_CIAD_X550
> +#define IXGBE_CIAD_X550EM_a	IXGBE_CIAD_X550
> +#define IXGBE_CIAD_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), CIAD)
> +
>   #define IXGBE_PICAUSE           0x110B0
>   #define IXGBE_PIENA             0x110B8
>   #define IXGBE_CDQ_MBR_82599     0x110B4
> @@ -1256,6 +1356,22 @@ struct ixgbe_thermal_sensor_data {
>   #define IXGBE_SDP0_GPIEN         0x00000001 /* SDP0 */
>   #define IXGBE_SDP1_GPIEN         0x00000002 /* SDP1 */
>   #define IXGBE_SDP2_GPIEN         0x00000004 /* SDP2 */
> +#define IXGBE_SDP0_GPIEN_X540		0x00000002 /* SDP0 on X540 and X550 */
> +#define IXGBE_SDP1_GPIEN_X540		0x00000004 /* SDP1 on X540 and X550 */
> +#define IXGBE_SDP2_GPIEN_X540		0x00000008 /* SDP2 on X540 and X550 */
> +#define IXGBE_SDP0_GPIEN_X550		IXGBE_SDP0_GPIEN_X540
> +#define IXGBE_SDP1_GPIEN_X550		IXGBE_SDP1_GPIEN_X540
> +#define IXGBE_SDP2_GPIEN_X550		IXGBE_SDP2_GPIEN_X540
> +#define IXGBE_SDP0_GPIEN_X550EM_x	IXGBE_SDP0_GPIEN_X540
> +#define IXGBE_SDP1_GPIEN_X550EM_x	IXGBE_SDP1_GPIEN_X540
> +#define IXGBE_SDP2_GPIEN_X550EM_x	IXGBE_SDP2_GPIEN_X540
> +#define IXGBE_SDP0_GPIEN_X550EM_a	IXGBE_SDP0_GPIEN_X540
> +#define IXGBE_SDP1_GPIEN_X550EM_a	IXGBE_SDP1_GPIEN_X540
> +#define IXGBE_SDP2_GPIEN_X550EM_a	IXGBE_SDP2_GPIEN_X540
> +#define IXGBE_SDP0_GPIEN_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), SDP0_GPIEN)
> +#define IXGBE_SDP1_GPIEN_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), SDP1_GPIEN)
> +#define IXGBE_SDP2_GPIEN_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), SDP2_GPIEN)
> +
>   #define IXGBE_GPIE_MSIX_MODE     0x00000010 /* MSI-X mode */
>   #define IXGBE_GPIE_OCD           0x00000020 /* Other Clear Disable */
>   #define IXGBE_GPIE_EIMEN         0x00000040 /* Immediate Interrupt Enable */
> @@ -1420,6 +1536,22 @@ enum {
>   #define IXGBE_EICR_GPI_SDP0     0x01000000 /* Gen Purpose Interrupt on SDP0 */
>   #define IXGBE_EICR_GPI_SDP1     0x02000000 /* Gen Purpose Interrupt on SDP1 */
>   #define IXGBE_EICR_GPI_SDP2     0x04000000 /* Gen Purpose Interrupt on SDP2 */
> +#define IXGBE_EICR_GPI_SDP0_X540	0x02000000
> +#define IXGBE_EICR_GPI_SDP1_X540	0x04000000
> +#define IXGBE_EICR_GPI_SDP2_X540	0x08000000
> +#define IXGBE_EICR_GPI_SDP0_X550	IXGBE_EICR_GPI_SDP0_X540
> +#define IXGBE_EICR_GPI_SDP1_X550	IXGBE_EICR_GPI_SDP1_X540
> +#define IXGBE_EICR_GPI_SDP2_X550	IXGBE_EICR_GPI_SDP2_X540
> +#define IXGBE_EICR_GPI_SDP0_X550EM_x	IXGBE_EICR_GPI_SDP0_X540
> +#define IXGBE_EICR_GPI_SDP1_X550EM_x	IXGBE_EICR_GPI_SDP1_X540
> +#define IXGBE_EICR_GPI_SDP2_X550EM_x	IXGBE_EICR_GPI_SDP2_X540
> +#define IXGBE_EICR_GPI_SDP0_X550EM_a	IXGBE_EICR_GPI_SDP0_X540
> +#define IXGBE_EICR_GPI_SDP1_X550EM_a	IXGBE_EICR_GPI_SDP1_X540
> +#define IXGBE_EICR_GPI_SDP2_X550EM_a	IXGBE_EICR_GPI_SDP2_X540
> +#define IXGBE_EICR_GPI_SDP0_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), EICR_GPI_SDP0)
> +#define IXGBE_EICR_GPI_SDP1_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), EICR_GPI_SDP1)
> +#define IXGBE_EICR_GPI_SDP2_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), EICR_GPI_SDP2)
> +
>   #define IXGBE_EICR_ECC          0x10000000 /* ECC Error */
>   #define IXGBE_EICR_PBUR         0x10000000 /* Packet Buffer Handler Error */
>   #define IXGBE_EICR_DHER         0x20000000 /* Descriptor Handler Error */
> @@ -1438,6 +1570,9 @@ enum {
>   #define IXGBE_EICS_GPI_SDP0     IXGBE_EICR_GPI_SDP0  /* SDP0 Gen Purpose Int */
>   #define IXGBE_EICS_GPI_SDP1     IXGBE_EICR_GPI_SDP1  /* SDP1 Gen Purpose Int */
>   #define IXGBE_EICS_GPI_SDP2     IXGBE_EICR_GPI_SDP2  /* SDP2 Gen Purpose Int */
> +#define IXGBE_EICS_GPI_SDP0_BY_MAC(_hw)	IXGBE_EICR_GPI_SDP0_BY_MAC(_hw)
> +#define IXGBE_EICS_GPI_SDP1_BY_MAC(_hw)	IXGBE_EICR_GPI_SDP1_BY_MAC(_hw)
> +#define IXGBE_EICS_GPI_SDP2_BY_MAC(_hw)	IXGBE_EICR_GPI_SDP2_BY_MAC(_hw)
>   #define IXGBE_EICS_ECC          IXGBE_EICR_ECC       /* ECC Error */
>   #define IXGBE_EICS_PBUR         IXGBE_EICR_PBUR      /* Pkt Buf Handler Err */
>   #define IXGBE_EICS_DHER         IXGBE_EICR_DHER      /* Desc Handler Error */
> @@ -1457,6 +1592,9 @@ enum {
>   #define IXGBE_EIMS_GPI_SDP0     IXGBE_EICR_GPI_SDP0  /* SDP0 Gen Purpose Int */
>   #define IXGBE_EIMS_GPI_SDP1     IXGBE_EICR_GPI_SDP1  /* SDP1 Gen Purpose Int */
>   #define IXGBE_EIMS_GPI_SDP2     IXGBE_EICR_GPI_SDP2  /* SDP2 Gen Purpose Int */
> +#define IXGBE_EIMS_GPI_SDP0_BY_MAC(_hw)	IXGBE_EICR_GPI_SDP0_BY_MAC(_hw)
> +#define IXGBE_EIMS_GPI_SDP1_BY_MAC(_hw)	IXGBE_EICR_GPI_SDP1_BY_MAC(_hw)
> +#define IXGBE_EIMS_GPI_SDP2_BY_MAC(_hw)	IXGBE_EICR_GPI_SDP2_BY_MAC(_hw)
>   #define IXGBE_EIMS_ECC          IXGBE_EICR_ECC       /* ECC Error */
>   #define IXGBE_EIMS_PBUR         IXGBE_EICR_PBUR      /* Pkt Buf Handler Err */
>   #define IXGBE_EIMS_DHER         IXGBE_EICR_DHER      /* Descr Handler Error */
> @@ -1475,6 +1613,9 @@ enum {
>   #define IXGBE_EIMC_GPI_SDP0     IXGBE_EICR_GPI_SDP0  /* SDP0 Gen Purpose Int */
>   #define IXGBE_EIMC_GPI_SDP1     IXGBE_EICR_GPI_SDP1  /* SDP1 Gen Purpose Int */
>   #define IXGBE_EIMC_GPI_SDP2     IXGBE_EICR_GPI_SDP2  /* SDP2 Gen Purpose Int */
> +#define IXGBE_EIMC_GPI_SDP0_BY_MAC(_hw)	IXGBE_EICR_GPI_SDP0_BY_MAC(_hw)
> +#define IXGBE_EIMC_GPI_SDP1_BY_MAC(_hw)	IXGBE_EICR_GPI_SDP1_BY_MAC(_hw)
> +#define IXGBE_EIMC_GPI_SDP2_BY_MAC(_hw)	IXGBE_EICR_GPI_SDP2_BY_MAC(_hw)
>   #define IXGBE_EIMC_ECC          IXGBE_EICR_ECC       /* ECC Error */
>   #define IXGBE_EIMC_PBUR         IXGBE_EICR_PBUR      /* Pkt Buf Handler Err */
>   #define IXGBE_EIMC_DHER         IXGBE_EICR_DHER      /* Desc Handler Err */
> @@ -2741,6 +2882,37 @@ union ixgbe_atr_hash_dword {
>   	__be32 dword;
>   };
>
> +#define IXGBE_MVALS_INIT(m)		\
> +	IXGBE_CAT(EEC, m),		\
> +	IXGBE_CAT(FLA, m),		\
> +	IXGBE_CAT(GRC, m),		\
> +	IXGBE_CAT(SRAMREL, m),		\
> +	IXGBE_CAT(FACTPS, m),		\
> +	IXGBE_CAT(SWSM, m),		\
> +	IXGBE_CAT(SWFW_SYNC, m),	\
> +	IXGBE_CAT(FWSM, m),		\
> +	IXGBE_CAT(SDP0_GPIEN, m),	\
> +	IXGBE_CAT(SDP1_GPIEN, m),	\
> +	IXGBE_CAT(SDP2_GPIEN, m),	\
> +	IXGBE_CAT(EICR_GPI_SDP0, m),	\
> +	IXGBE_CAT(EICR_GPI_SDP1, m),	\
> +	IXGBE_CAT(EICR_GPI_SDP2, m),	\
> +	IXGBE_CAT(CIAA, m),		\
> +	IXGBE_CAT(CIAD, m),		\
> +	IXGBE_CAT(I2C_CLK_IN, m),	\
> +	IXGBE_CAT(I2C_CLK_OUT, m),	\
> +	IXGBE_CAT(I2C_DATA_IN, m),	\
> +	IXGBE_CAT(I2C_DATA_OUT, m),	\
> +	IXGBE_CAT(I2C_DATA_OE_N_EN, m),	\
> +	IXGBE_CAT(I2C_BB_EN, m),	\
> +	IXGBE_CAT(I2C_CLK_OE_N_EN, m),	\
> +	IXGBE_CAT(I2CCTL, m)
> +
> +enum ixgbe_mvals {
> +	IXGBE_MVALS_INIT(_IDX),
> +	IXGBE_MVALS_IDX_LIMIT
> +};
> +
>   enum ixgbe_eeprom_type {
>   	ixgbe_eeprom_uninitialized = 0,
>   	ixgbe_eeprom_spi,
> @@ -3216,6 +3388,7 @@ struct ixgbe_hw {
>   	struct ixgbe_eeprom_info	eeprom;
>   	struct ixgbe_bus_info		bus;
>   	struct ixgbe_mbx_info		mbx;
> +	u32				*mvals;
>   	u16				device_id;
>   	u16				vendor_id;
>   	u16				subsystem_device_id;
> @@ -3234,6 +3407,7 @@ struct ixgbe_info {
>   	struct ixgbe_eeprom_operations	*eeprom_ops;
>   	struct ixgbe_phy_operations	*phy_ops;
>   	struct ixgbe_mbx_operations	*mbx_ops;
> +	u32				*mvals;
>   };
>
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> index 0a8b5e4..aedd632 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> @@ -853,6 +853,10 @@ static struct ixgbe_phy_operations phy_ops_X540 = {
>   	.get_firmware_version   = &ixgbe_get_phy_firmware_version_generic,
>   };
>
> +static u32 ixgbe_mvals_X540[IXGBE_MVALS_IDX_LIMIT] = {
> +	IXGBE_MVALS_INIT(_X540)
> +};
> +
>   struct ixgbe_info ixgbe_X540_info = {
>   	.mac                    = ixgbe_mac_X540,
>   	.get_invariants         = &ixgbe_get_invariants_X540,
> @@ -860,4 +864,5 @@ struct ixgbe_info ixgbe_X540_info = {
>   	.eeprom_ops             = &eeprom_ops_X540,
>   	.phy_ops                = &phy_ops_X540,
>   	.mbx_ops                = &mbx_ops_generic,
> +	.mvals			= ixgbe_mvals_X540,
>   };
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> index b023698..6375a54 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> @@ -1541,6 +1541,14 @@ static struct ixgbe_phy_operations phy_ops_X550EM_x = {
>   	.setup_link		= NULL, /* defined later */
>   };
>
> +static u32 ixgbe_mvals_X550[IXGBE_MVALS_IDX_LIMIT] = {
> +	IXGBE_MVALS_INIT(_X550)
> +};
> +
> +static u32 ixgbe_mvals_X550EM_x[IXGBE_MVALS_IDX_LIMIT] = {
> +	IXGBE_MVALS_INIT(_X550EM_x)
> +};
> +
>   struct ixgbe_info ixgbe_X550_info = {
>   	.mac			= ixgbe_mac_X550,
>   	.get_invariants		= &ixgbe_get_invariants_X540,
> @@ -1548,6 +1556,7 @@ struct ixgbe_info ixgbe_X550_info = {
>   	.eeprom_ops		= &eeprom_ops_X550,
>   	.phy_ops		= &phy_ops_X550,
>   	.mbx_ops		= &mbx_ops_generic,
> +	.mvals			= ixgbe_mvals_X550,
>   };
>
>   struct ixgbe_info ixgbe_X550EM_x_info = {
> @@ -1557,4 +1566,5 @@ struct ixgbe_info ixgbe_X550EM_x_info = {
>   	.eeprom_ops		= &eeprom_ops_X550EM_x,
>   	.phy_ops		= &phy_ops_X550EM_x,
>   	.mbx_ops		= &mbx_ops_generic,
> +	.mvals			= ixgbe_mvals_X550EM_x,
>   };
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>
