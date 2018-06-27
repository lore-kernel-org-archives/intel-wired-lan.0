From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 26 Jun 2018 17:32:31 -0700
Subject: [Intel-wired-lan] [PATCH v3 03/11] igc: Add netdev
In-Reply-To: <20180624084503.10065-1-sasha.neftin@intel.com>
References: <20180624084503.10065-1-sasha.neftin@intel.com>
Message-ID: <800bbf05-477f-870c-730a-bf129e1eea9a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/24/2018 1:45 AM, Sasha Neftin wrote:
> Now that we have the ability to configure the basic settings on the device
> we can start allocating and configuring a netdev for the interface.
> 
> Sasha Neftin (v2):
> added description
> 
> Sasha Neftin (v3):
> minor cosmetic changes
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/e1000_defines.h |  15 +
>   drivers/net/ethernet/intel/igc/e1000_hw.h      |   1 +
>   drivers/net/ethernet/intel/igc/igc.h           |  48 +++
>   drivers/net/ethernet/intel/igc/igc_main.c      | 490 ++++++++++++++++++++++++-
>   4 files changed, 551 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/e1000_defines.h b/drivers/net/ethernet/intel/igc/e1000_defines.h
> index 6831a0864bb4..66b05898eb00 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_defines.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_defines.h
> @@ -4,6 +4,8 @@
>   #ifndef _E1000_DEFINES_H_
>   #define _E1000_DEFINES_H_
>   
> +#define E1000_CTRL_EXT_DRV_LOAD         0x10000000 /* Drv loaded bit for FW */
> +
>   #define E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES	0x00C00000
>   /* Priority on PCI. 0=rx,1=fair */
>   #define E1000_CTRL_PRIOR			0x00000004
> @@ -28,6 +30,16 @@
>   #define E1000_PCI_PMCSR			0x44
>   #define E1000_PCI_PMCSR_D3		0x03
>   
> +/* Receive Address
> + * Number of high/low register pairs in the RAR. The RAR (Receive Address
> + * Registers) holds the directed and multicast addresses that we monitor.
> + * Technically, we have 16 spots.  However, we reserve one of these spots
> + * (RAR[15]) for our directed address used by controllers with
> + * manageability enabled, allowing us room for 15 multicast addresses.
> + */
> +#define E1000_RAH_AV		0x80000000 /* Receive descriptor valid */
> +#define E1000_RAH_POOL_1	0x00040000
> +
>   /* Error Codes */
>   #define E1000_SUCCESS				0
>   #define E1000_ERR_NVM				1
> @@ -37,6 +49,9 @@
>   #define E1000_ERR_MAC_INIT			5
>   #define E1000_ERR_RESET				9
>   
> +/* PBA constants */
> +#define E1000_PBA_34K			0x0022
> +
>   /* Device Status */
>   #define E1000_STATUS_FD		0x00000001      /* Full duplex.0=half,1=full */
>   #define E1000_STATUS_LU		0x00000002      /* Link up.0=no,1=link */
> diff --git a/drivers/net/ethernet/intel/igc/e1000_hw.h b/drivers/net/ethernet/intel/igc/e1000_hw.h
> index b8f82f4ba998..6abe722f0bc4 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_hw.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_hw.h
> @@ -87,6 +87,7 @@ struct e1000_mac_info {
>   
>   	bool autoneg;
>   	bool autoneg_failed;
> +	bool get_link_status;
>   };
>   
>   struct e1000_bus_info {
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index bd732390bd4b..29df87285b9b 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -28,15 +28,63 @@
>   extern char igc_driver_name[];
>   extern char igc_driver_version[];
>   
> +/* Transmit and receive queues */
> +#define IGC_MAX_RX_QUEUES                 4
> +#define IGC_MAX_TX_QUEUES                 4
> +
> +#define MAX_Q_VECTORS                     10
> +#define MAX_STD_JUMBO_FRAME_SIZE        9216
> +
> +enum e1000_state_t {
> +	 __IGC_TESTING,

This mixing of e1000 and IGC is just wrong...
Can you tell I don't like it?

> +	__IGC_RESETTING,

funky indent

> +	 __IGC_DOWN,
> +	 __IGC_PTP_TX_IN_PROGRESS,
> +};
> +
> +struct igc_q_vector {
> +	struct igc_adapter *adapter;    /* backlink */
> +
> +	struct napi_struct napi;
> +};
> +
> +struct igc_mac_addr {
> +	u8 addr[ETH_ALEN];
> +	u8 queue;
> +	u8 state; /* bitmask */
> +};
> +
> +#define IGC_MAC_STATE_DEFAULT   0x1
> +#define IGC_MAC_STATE_MODIFIED  0x2
> +#define IGC_MAC_STATE_IN_USE    0x4
> +
>   /* Board specific private data structure */
>   struct igc_adapter {
> +	struct net_device *netdev;
> +
> +	unsigned long state;
> +	unsigned int flags;

These state and flags fields should probably be specifically defined as 
u32 or u64.

Is there a reason that state is a long and flags an int?  Is there an 
expectation of different sizes?

> +	unsigned int num_q_vectors;
> +	u16 link_speed;
> +	u16 link_duplex;
> +
> +	u8 port_num;
> +
>   	u8 __iomem *io_addr;
> +	struct work_struct watchdog_task;
> +
> +	int msg_enable;
> +	u32 max_frame_size;
>   
>   	/* OS defined structs */
>   	struct pci_dev *pdev;
>   
>   	/* structs defined in e1000_hw.h */
>   	struct e1000_hw hw;
> +
> +	struct igc_q_vector *q_vector[MAX_Q_VECTORS];
> +
> +	struct igc_mac_addr *mac_table;
>   };
>   
>   #endif /* _IGC_H_ */
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index ec3451dad91e..520f49be8e19 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -3,6 +3,8 @@
>   
>   #include <linux/module.h>
>   #include <linux/types.h>
> +#include <linux/if_vlan.h>
> +#include <linux/aer.h>
>   
>   #include "igc.h"
>   #include "e1000_hw.h"
> @@ -10,6 +12,7 @@
>   #define DRV_VERSION	"0.0.1-k"
>   #define DRV_SUMMARY	"Intel(R) 2.5G Ethernet Linux Driver"
>   
> +static int debug = -1;
>   char igc_driver_name[] = "igc";
>   char igc_driver_version[] = DRV_VERSION;
>   static const char igc_driver_string[] = DRV_SUMMARY;
> @@ -25,8 +28,371 @@ static const struct pci_device_id igc_pci_tbl[] = {
>   
>   MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
>   
> -/* Forward declaration */
> +/* forward declaration */
>   static int igc_sw_init(struct igc_adapter *);
> +static void igc_configure(struct igc_adapter *adapter);
> +static void igc_power_down_link(struct igc_adapter *adapter);
> +static void igc_set_default_mac_filter(struct igc_adapter *adapter);

If you change the order of the functions in the file you shouldn't need 
the forward decl crutch.

> +
> +void igc_reset(struct igc_adapter *adapter)
> +{
> +	if (!netif_running(adapter->netdev))
> +		igc_power_down_link(adapter);
> +}
> +
> +/**
> + *  igc_power_up_link - Power up the phy/serdes link
> + *  @adapter: address of board private structure
> + **/
> +void igc_power_up_link(struct igc_adapter *adapter)
> +{
> +}
> +
> +/**
> + *  igc_power_down_link - Power down the phy/serdes link
> + *  @adapter: address of board private structure
> + **/
> +static void igc_power_down_link(struct igc_adapter *adapter)
> +{
> +}
> +
> +/**
> + *  igc_release_hw_control - release control of the h/w to f/w
> + *  @adapter: address of board private structure
> + *
> + *  igc_release_hw_control resets CTRL_EXT:DRV_LOAD bit.
> + *  For ASF and Pass Through versions of f/w this means that the
> + *  driver is no longer loaded.
> + **/
> +static void igc_release_hw_control(struct igc_adapter *adapter)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +	u32 ctrl_ext;
> +
> +	/* Let firmware take over control of h/w */
> +	ctrl_ext = rd32(E1000_CTRL_EXT);
> +	wr32(E1000_CTRL_EXT,
> +	     ctrl_ext & ~E1000_CTRL_EXT_DRV_LOAD);
> +}
> +
> +/**
> + *  igc_get_hw_control - get control of the h/w from f/w
> + *  @adapter: address of board private structure
> + *
> + *  igc_get_hw_control sets CTRL_EXT:DRV_LOAD bit.
> + *  For ASF and Pass Through versions of f/w this means that
> + *  the driver is loaded.
> + **/
> +static void igc_get_hw_control(struct igc_adapter *adapter)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +	u32 ctrl_ext;
> +
> +	/* Let firmware know the driver has taken over */
> +	ctrl_ext = rd32(E1000_CTRL_EXT);
> +	wr32(E1000_CTRL_EXT,
> +	     ctrl_ext | E1000_CTRL_EXT_DRV_LOAD);
> +}
> +
> +/**
> + *  igc_set_mac - Change the Ethernet Address of the NIC
> + *  @netdev: network interface device structure
> + *  @p: pointer to an address structure
> + *
> + *  Returns 0 on success, negative on failure
> + **/
> +static int igc_set_mac(struct net_device *netdev, void *p)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	struct e1000_hw *hw = &adapter->hw;
> +	struct sockaddr *addr = p;
> +
> +	if (!is_valid_ether_addr(addr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
> +	memcpy(netdev->dev_addr, addr->sa_data, netdev->addr_len);
> +	memcpy(hw->mac.addr, addr->sa_data, netdev->addr_len);
> +
> +	/* set the correct pool for the new PF MAC address in entry 0 */
> +	igc_set_default_mac_filter(adapter);
> +
> +	return 0;
> +}
> +
> +static netdev_tx_t igc_xmit_frame(struct sk_buff *skb,
> +				  struct net_device *netdev)
> +{
> +	dev_kfree_skb_any(skb);
> +	return NETDEV_TX_OK;
> +}
> +
> +/**
> + *  igc_ioctl - I/O control method
> + *  @netdev: network interface device structure
> + *  @ifreq: frequency
> + *  @cmd: command
> + **/
> +static int igc_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
> +{
> +	switch (cmd) {
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +/**
> + *  igc_up - Open the interface and prepare it to handle traffic
> + *  @adapter: board private structure
> + **/
> +int igc_up(struct igc_adapter *adapter)
> +{
> +	int i = 0;
> +
> +	/* hardware has been reset, we need to reload some things */
> +	igc_configure(adapter);
> +
> +	clear_bit(__IGC_DOWN, &adapter->state);
> +
> +	for (i = 0; i < adapter->num_q_vectors; i++)
> +		napi_enable(&adapter->q_vector[i]->napi);
> +
> +	return 0;
> +}
> +
> +/**
> + *  igc_down - Close the interface
> + *  @adapter: board private structure
> + **/
> +void igc_down(struct igc_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i = 0;
> +
> +	set_bit(__IGC_DOWN, &adapter->state);
> +
> +	/* set trans_start so we don't get spurious watchdogs during reset */
> +	netif_trans_update(netdev);
> +
> +	netif_carrier_off(netdev);
> +	netif_tx_stop_all_queues(netdev);
> +
> +	for (i = 0; i < adapter->num_q_vectors; i++)
> +		napi_disable(&adapter->q_vector[i]->napi);
> +
> +	adapter->link_speed = 0;
> +	adapter->link_duplex = 0;
> +}
> +
> +/**
> + *  igc_change_mtu - Change the Maximum Transfer Unit
> + *  @netdev: network interface device structure
> + *  @new_mtu: new value for maximum frame size
> + *
> + *  Returns 0 on success, negative on failure
> + **/
> +static int igc_change_mtu(struct net_device *netdev, int new_mtu)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	struct pci_dev *pdev = adapter->pdev;
> +	int max_frame = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
> +
> +	/* adjust max frame to be at least the size of a standard frame */
> +	if (max_frame < (ETH_FRAME_LEN + ETH_FCS_LEN))
> +		max_frame = ETH_FRAME_LEN + ETH_FCS_LEN;
> +
> +	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
> +		usleep_range(1000, 2000);
> +
> +	/* igc_down has a dependency on max_frame_size */
> +	adapter->max_frame_size = max_frame;
> +
> +	if (netif_running(netdev))
> +		igc_down(adapter);
> +
> +	dev_info(&pdev->dev, "changing MTU from %d to %d\n",
> +		 netdev->mtu, new_mtu);
> +	netdev->mtu = new_mtu;
> +
> +	if (netif_running(netdev))
> +		igc_up(adapter);
> +	else
> +		igc_reset(adapter);
> +
> +	clear_bit(__IGC_RESETTING, &adapter->state);
> +
> +	return 0;
> +}
> +
> +/**
> + *  igc_update_stats - Update the board statistics counters
> + *  @adapter: board private structure
> + **/
> +void igc_update_stats(struct igc_adapter *adapter)
> +{
> +}
> +
> +/**
> + *  igc_get_stats - Get System Network Statistics
> + *  @netdev: network interface device structure
> + *
> + *  Returns the address of the device statistics structure.
> + *  The statistics are updated here and also from the timer callback.
> + **/
> +static struct net_device_stats *igc_get_stats(struct net_device *netdev)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +
> +	if (!test_bit(__IGC_RESETTING, &adapter->state))
> +		igc_update_stats(adapter);
> +
> +	/* only return the current stats */
> +	return &netdev->stats;
> +}
> +
> +/**
> + *  igc_configure - configure the hardware for RX and TX
> + *  @adapter: private board structure
> + **/
> +static void igc_configure(struct igc_adapter *adapter)
> +{
> +	igc_get_hw_control(adapter);
> +}
> +
> +/**
> + *  igc_rar_set_index - Sync RAL[index] and RAH[index] registers with MAC table
> + *  @adapter: Pointer to adapter structure
> + *  @index: Index of the RAR entry which need to be synced with MAC table
> + **/
> +static void igc_rar_set_index(struct igc_adapter *adapter, u32 index)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +	u32 rar_low, rar_high;
> +	u8 *addr = adapter->mac_table[index].addr;
> +
> +	/* HW expects these to be in network order when they are plugged
> +	 * into the registers which are little endian.  In order to guarantee
> +	 * that ordering we need to do an leXX_to_cpup here in order to be
> +	 * ready for the byteswap that occurs with writel
> +	 */
> +	rar_low = le32_to_cpup((__le32 *)(addr));
> +	rar_high = le16_to_cpup((__le16 *)(addr + 4));
> +
> +	/* Indicate to hardware the Address is Valid. */
> +	if (adapter->mac_table[index].state & IGC_MAC_STATE_IN_USE) {
> +		if (is_valid_ether_addr(addr))
> +			rar_high |= E1000_RAH_AV;
> +
> +		rar_high |= E1000_RAH_POOL_1 <<
> +			adapter->mac_table[index].queue;
> +	}
> +
> +	wr32(E1000_RAL(index), rar_low);
> +	wrfl();
> +	wr32(E1000_RAH(index), rar_high);
> +	wrfl();
> +}
> +
> +/* Set default MAC address for the PF in the first RAR entry */
> +static void igc_set_default_mac_filter(struct igc_adapter *adapter)
> +{
> +	struct igc_mac_addr *mac_table = &adapter->mac_table[0];
> +
> +	ether_addr_copy(mac_table->addr, adapter->hw.mac.addr);
> +	mac_table->state = IGC_MAC_STATE_DEFAULT | IGC_MAC_STATE_IN_USE;
> +
> +	igc_rar_set_index(adapter, 0);
> +}
> +
> +/**
> + * igc_open - Called when a network interface is made active
> + * @netdev: network interface device structure
> + *
> + * Returns 0 on success, negative value on failure
> + *
> + * The open entry point is called when a network interface is made
> + * active by the system (IFF_UP).  At this point all resources needed
> + * for transmit and receive operations are allocated, the interrupt
> + * handler is registered with the OS, the watchdog timer is started,
> + * and the stack is notified that the interface is ready.
> + **/
> +static int __igc_open(struct net_device *netdev, bool resuming)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	struct e1000_hw *hw = &adapter->hw;
> +	int i = 0;
> +
> +	/* disallow open during test */
> +
> +	if (test_bit(__IGC_TESTING, &adapter->state)) {
> +		WARN_ON(resuming);
> +		return -EBUSY;
> +	}
> +
> +	netif_carrier_off(netdev);
> +
> +	igc_power_up_link(adapter);
> +
> +	igc_configure(adapter);
> +
> +	/* From here on the code is the same as igc_up() */

Then why not use igc_up()?

> +	clear_bit(__IGC_DOWN, &adapter->state);
> +
> +	for (i = 0; i < adapter->num_q_vectors; i++)
> +		napi_enable(&adapter->q_vector[i]->napi);
> +
> +	/* start the watchdog. */
> +	hw->mac.get_link_status = 1;
> +	schedule_work(&adapter->watchdog_task);
> +
> +	return E1000_SUCCESS;
> +}
> +
> +int igc_open(struct net_device *netdev)
> +{
> +	return __igc_open(netdev, false);
> +}
> +
> +/**
> + * igc_close - Disables a network interface
> + * @netdev: network interface device structure
> + *
> + * Returns 0, this is not allowed to fail
> + *
> + * The close entry point is called when an interface is de-activated
> + * by the OS.  The hardware is still under the driver's control, but
> + * needs to be disabled.  A global MAC reset is issued to stop the
> + * hardware, and all transmit and receive resources are freed.
> + **/
> +static int __igc_close(struct net_device *netdev, bool suspending)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +
> +	WARN_ON(test_bit(__IGC_RESETTING, &adapter->state));
> +
> +	igc_down(adapter);
> +
> +	igc_release_hw_control(adapter);
> +
> +	return 0;
> +}
> +
> +int igc_close(struct net_device *netdev)
> +{
> +	if (netif_device_present(netdev) || netdev->dismantle)
> +		return __igc_close(netdev, false);
> +	return 0;
> +}
> +
> +static const struct net_device_ops igc_netdev_ops = {
> +	.ndo_open               = igc_open,
> +	.ndo_stop               = igc_close,
> +	.ndo_start_xmit         = igc_xmit_frame,
> +	.ndo_set_mac_address    = igc_set_mac,
> +	.ndo_change_mtu         = igc_change_mtu,
> +	.ndo_get_stats          = igc_get_stats,
> +	.ndo_do_ioctl           = igc_ioctl,
> +
> +};
>   
>   /* PCIe configuration access */
>   void igc_read_pci_cfg(struct e1000_hw *hw, u32 reg, u16 *value)
> @@ -73,6 +439,7 @@ s32 igc_write_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value)
>   
>   u32 igc_rd32(struct e1000_hw *hw, u32 reg)
>   {
> +	struct igc_adapter *igc = container_of(hw, struct igc_adapter, hw);
>   	u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
>   	u32 value = 0;
>   
> @@ -82,8 +449,13 @@ u32 igc_rd32(struct e1000_hw *hw, u32 reg)
>   	value = readl(&hw_addr[reg]);
>   
>   	/* reads should not return all F's */
> -	if (!(~value) && (!reg || !(~readl(hw_addr))))
> +	if (!(~value) && (!reg || !(~readl(hw_addr)))) {
> +		struct net_device *netdev = igc->netdev;
> +
>   		hw->hw_addr = NULL;
> +		netif_device_detach(netdev);
> +		netdev_err(netdev, "PCIe link lost, device now detached\n");
> +	}
>   
>   	return value;
>   }
> @@ -102,6 +474,7 @@ u32 igc_rd32(struct e1000_hw *hw, u32 reg)
>   static int igc_probe(struct pci_dev *pdev,
>   		     const struct pci_device_id *ent)
>   {
> +	struct net_device *netdev;

Reverse xmas tree

>   	struct igc_adapter *adapter;
>   	struct e1000_hw *hw;
>   	int err, pci_using_dac;
> @@ -136,8 +509,56 @@ static int igc_probe(struct pci_dev *pdev,
>   	if (err)
>   		goto err_pci_reg;
>   
> +	pci_enable_pcie_error_reporting(pdev);
> +
>   	pci_set_master(pdev);
> -	pci_save_state(pdev);
> +
> +	err = -ENOMEM;
> +	netdev = alloc_etherdev_mq(sizeof(struct igc_adapter),
> +				   IGC_MAX_TX_QUEUES);
> +
> +	if (!netdev)
> +		goto err_alloc_etherdev;
> +
> +	SET_NETDEV_DEV(netdev, &pdev->dev);
> +
> +	pci_set_drvdata(pdev, netdev);
> +	adapter = netdev_priv(netdev);
> +	adapter->netdev = netdev;
> +	adapter->pdev = pdev;
> +	hw = &adapter->hw;
> +	hw->back = adapter;
> +	adapter->port_num = hw->bus.func;
> +	adapter->msg_enable = GENMASK(debug - 1, 0);
> +
> +	err = pci_save_state(pdev);
> +	if (err)
> +		goto err_ioremap;
> +
> +	err = -EIO;
> +	adapter->io_addr = ioremap(pci_resource_start(pdev, 0),
> +				   pci_resource_len(pdev, 0));
> +	if (!adapter->io_addr)
> +		goto err_ioremap;
> +
> +	/* hw->hw_addr can be zeroed, so use adapter->io_addr for unmap */
> +	hw->hw_addr = adapter->io_addr;
> +
> +	netdev->netdev_ops = &igc_netdev_ops;
> +
> +	netdev->watchdog_timeo = 5 * HZ;
> +
> +	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
> +
> +	netdev->mem_start = pci_resource_start(pdev, 0);
> +	netdev->mem_end = pci_resource_end(pdev, 0);
> +
> +	/* PCI config space info */
> +	hw->vendor_id = pdev->vendor;
> +	hw->device_id = pdev->device;
> +	hw->revision_id = pdev->revision;
> +	hw->subsystem_vendor_id = pdev->subsystem_vendor;
> +	hw->subsystem_device_id = pdev->subsystem_device;
>   
>   	/* setup the private structure */
>   	err = igc_sw_init(adapter);
> @@ -146,9 +567,49 @@ static int igc_probe(struct pci_dev *pdev,
>   
>   	igc_get_bus_info_pcie(hw);
>   
> +	/* MTU range: 68 - 9216 */
> +	netdev->min_mtu = ETH_MIN_MTU;
> +	netdev->max_mtu = MAX_STD_JUMBO_FRAME_SIZE;
> +
> +	/* reset the hardware with the new settings */
> +	igc_reset(adapter);
> +
> +	/* let the f/w know that the h/w is now under the control of the
> +	 * driver.
> +	 */
> +	igc_get_hw_control(adapter);
> +
> +	strncpy(netdev->name, "eth%d", IFNAMSIZ);

You're stomping on what you just set a few lines earlier.  Of course, 
some might argue that you shouldn't put anything here at all and let the 
system name the device.

> +	err = register_netdev(netdev);
> +	if (err)
> +		goto err_register;
> +
> +	 /* carrier off reporting is important to ethtool even BEFORE open */
> +	netif_carrier_off(netdev);
> +
> +	dev_info(&pdev->dev, "@SUMMARY@");
> +	/* print bus type/speed/width info */
> +	dev_info(&pdev->dev, "%s: (PCIe:%s:%s) ",
> +		 netdev->name,
> +		 ((hw->bus.speed == e1000_bus_speed_2500) ? "2.5GT/s" :
> +		 (hw->bus.speed == e1000_bus_speed_5000) ? "5.0GT/s" :
> +		 "unknown"),
> +		 ((hw->bus.width == e1000_bus_width_pcie_x4) ? "Width x4" :
> +		 (hw->bus.width == e1000_bus_width_pcie_x2) ? "Width x2" :
> +		 (hw->bus.width == e1000_bus_width_pcie_x1) ? "Width x1" :
> +		 "unknown"));

How about using the new pcie_print_link_status()?

> +	netdev_info(netdev, "MAC: %pM\n", netdev->dev_addr);
> +
>   	return 0;
>   
> +err_register:
> +	igc_release_hw_control(adapter);
>   err_sw_init:
> +err_ioremap:
> +	free_netdev(netdev);
> +err_alloc_etherdev:
> +	pci_release_selected_regions(pdev,
> +				     pci_select_bars(pdev, IORESOURCE_MEM));
>   err_pci_reg:
>   err_dma:
>   	pci_disable_device(pdev);
> @@ -166,9 +627,22 @@ static int igc_probe(struct pci_dev *pdev,
>    **/
>   static void igc_remove(struct pci_dev *pdev)
>   {
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +
> +	set_bit(__IGC_DOWN, &adapter->state);
> +	flush_scheduled_work();
> +
> +	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
> +	 * would have already happened in close and is redundant.
> +	 */
> +	igc_release_hw_control(adapter);
> +	unregister_netdev(netdev);
> +
>   	pci_release_selected_regions(pdev,
>   				     pci_select_bars(pdev, IORESOURCE_MEM));
>   
> +	free_netdev(netdev);
>   	pci_disable_device(pdev);
>   }
>   
> @@ -190,6 +664,7 @@ static struct pci_driver igc_driver = {
>   static int igc_sw_init(struct igc_adapter *adapter)
>   {
>   	struct e1000_hw *hw = &adapter->hw;
> +	struct net_device *netdev = adapter->netdev;
>   	struct pci_dev *pdev = adapter->pdev;
>   
>   	/* PCI config space info */
> @@ -203,6 +678,12 @@ static int igc_sw_init(struct igc_adapter *adapter)
>   
>   	pci_read_config_word(pdev, PCI_COMMAND, &hw->bus.pci_cmd_word);
>   
> +	/* set default work limits */
> +	adapter->max_frame_size = netdev->mtu + ETH_HLEN + ETH_FCS_LEN +
> +					VLAN_HLEN;
> +
> +	set_bit(__IGC_DOWN, &adapter->state);
> +
>   	return 0;
>   }
>   
> @@ -244,4 +725,7 @@ MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
>   MODULE_DESCRIPTION(DRV_SUMMARY);
>   MODULE_LICENSE("GPL");
>   MODULE_VERSION(DRV_VERSION);
> +
> +module_param(debug, int, 0);
> +MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
>   /* igc_main.c */
> 
