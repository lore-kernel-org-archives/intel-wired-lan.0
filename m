From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 08 May 2015 18:05:28 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] net: igb: register mii_bus for
 SerDes w/ external phy
In-Reply-To: <1430417955-28252-4-git-send-email-tharvey@gateworks.com>
References: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>
 <1430417955-28252-4-git-send-email-tharvey@gateworks.com>
Message-ID: <554D5D58.4080300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/30/2015 11:19 AM, Tim Harvey wrote:
> If an i210 is configured for 1000BASE-BX link_mode and has an external
> phy specified, then register an mii bus using the external phy address as
> a mask.
>
> An i210 hooked to an external standard phy will be configured with a
> link_mode of SGMII in which case phy ops will be configured and used
> internal in the igb driver for link status. However, in certain cases
> one might be using a backplane SerDes connection to something that talks
> on the mdio bus but is not a standard phy, such as a switch. In this case
> by registering an mdio bus a phy driver can manage the device.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>


So I think I am staring to see a pattern here between the i210 and the 
i354 it looks like the EEPROMs for these interfaces are not getting set 
up correctly.  Unfortunately for the i210 you cannot change the EEPROM 
from ethtool so you would need to work out with your manufacturer how to 
get that fixed for your device.

As far as the code below I think there may be an easy way to work around 
a bunch of this code.  The quick trick for most of this would be to 
update igb_init_phy_params_82575 to return a new value, maybe make up 
something like E1000_ERR_PHY_UNKNOWN when the PHY ID is unrecognized. 
Then you could add the phylib code as a handler for if you encounter 
that error code.

Also in terms of naming I would recommend sticking with one convention. 
  Either igb_mdio_ or igb_mii_ for all of these functions.  It is kind 
of confusing to be switching back and forth and I don't really see the 
point of adding the "enet" to the prefixes.

> ---
>   drivers/net/ethernet/intel/igb/e1000_82575.c |  16 +++
>   drivers/net/ethernet/intel/igb/e1000_hw.h    |   7 ++
>   drivers/net/ethernet/intel/igb/igb_main.c    | 163 ++++++++++++++++++++++++++-
>   3 files changed, 181 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
> index d2afd7b..e80617b 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_82575.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
> @@ -598,13 +598,26 @@ static s32 igb_get_invariants_82575(struct e1000_hw *hw)
>   	switch (link_mode) {
>   	case E1000_CTRL_EXT_LINK_MODE_1000BASE_KX:
>   		hw->phy.media_type = e1000_media_type_internal_serdes;
> +		if (igb_sgmii_uses_mdio_82575(hw)) {
> +			u32 mdicnfg = rd32(E1000_MDICNFG);
> +
> +			mdicnfg &= E1000_MDICNFG_PHY_MASK;
> +			hw->phy.addr = mdicnfg >> E1000_MDICNFG_PHY_SHIFT;
> +			hw_dbg("1000BASE_KX w/ external MDIO device at 0x%x\n",
> +			       hw->phy.addr);
> +		} else {
> +			hw_dbg("1000BASE_KX");
> +		}
>   		break;

You should not be running SGMII under KX mode.  If you are then you have 
an EEPROM bug.  The correct link mode is SGMII below.  Unfortunately you 
would need to check with your vendor on that one as I believe the 
EEPROMs for i210/i211 parts are not writable via ethtool.

As for a hack workaround for now what you could do is use a 
!igb_sgmii_uses_mdio_82575() check to determine if you want to break, or 
to clear the LINK_MODE field and rewrite it as SGMII and then just fall 
though to SGMII which will help to clear up many issues you are probably 
seeing.  You might keep that as a separate local patch until you can get 
the EEPROM issue resolved.

As far as pulling the phy.addr value that should be taken care of by 
igb_get_phy_id_82575 if the link mode is correctly updated in the EEPROM 
to LINK_MODE_SGMII.

>   	case E1000_CTRL_EXT_LINK_MODE_SGMII:
>   		/* Get phy control interface type set (MDIO vs. I2C)*/
>   		if (igb_sgmii_uses_mdio_82575(hw)) {
>   			hw->phy.media_type = e1000_media_type_copper;
>   			dev_spec->sgmii_active = true;
> +			hw_dbg("SGMII with external MDIO PHY");
>   			break;
> +		} else {
> +			hw_dbg("SGMII with external I2C PHY");
>   		}
>   		/* fall through for I2C based SGMII */
>   	case E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES:

These hw_dbg messages can probably be dropped since they aren't adding 
much value.

> @@ -621,8 +634,11 @@ static s32 igb_get_invariants_82575(struct e1000_hw *hw)
>   				hw->phy.media_type = e1000_media_type_copper;
>   				dev_spec->sgmii_active = true;
>   			}
> +			hw_dbg("SERDES with external SFP");
>
>   			break;
> +		} else {
> +			hw_dbg("SERDES");
>   		}
>
>   		/* do not change link mode for 100BaseFX */

Same for these.

> diff --git a/drivers/net/ethernet/intel/igb/e1000_hw.h b/drivers/net/ethernet/intel/igb/e1000_hw.h
> index 2003b37..2864779 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_hw.h
> +++ b/drivers/net/ethernet/intel/igb/e1000_hw.h
> @@ -27,6 +27,7 @@
>   #include <linux/delay.h>
>   #include <linux/io.h>
>   #include <linux/netdevice.h>
> +#include <linux/phy.h>
>
>   #include "e1000_regs.h"
>   #include "e1000_defines.h"
> @@ -543,6 +544,12 @@ struct e1000_hw {
>   	struct e1000_mbx_info mbx;
>   	struct e1000_host_mng_dhcp_cookie mng_cookie;
>
> +#ifdef CONFIG_PHYLIB
> +	/* Phylib and MDIO interface */
> +	struct mii_bus *mii_bus;
> +	struct phy_device *phy_dev;
> +	phy_interface_t phy_interface;
> +#endif
>   	union {
>   		struct e1000_dev_spec_82575	_82575;
>   	} dev_spec;

Just to save the Intel guys a ton of grief you may want to consider 
moving these into the igb_adapter struct instead of the e1000_hw struct. 
  The fact is these are all Linux specific interfaces and the e1000_hw 
is meant to be more-or-less OS agnostic.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index f366b3b..9b5f538 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -41,6 +41,7 @@
>   #include <linux/if_vlan.h>
>   #include <linux/pci.h>
>   #include <linux/pci-aspm.h>
> +#include <linux/phy.h>
>   #include <linux/delay.h>
>   #include <linux/interrupt.h>
>   #include <linux/ip.h>
> @@ -2223,6 +2224,121 @@ static s32 igb_init_i2c(struct igb_adapter *adapter)
>   	return status;
>   }
>
> +#ifdef CONFIG_PHYLIB
> +static int igb_enet_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
> +{
> +	struct e1000_hw *hw = bus->priv;
> +	u16 out;
> +	int err;
> +
> +	err = igb_read_reg_gs40g(hw, mii_id, regnum, &out);
> +	if (err)
> +		return err;
> +	return out;
> +}
> +

I'm not really a fan of the igb_enet_ stuff, why not just igb_mdio_read, 
igb_mdio_write, etc..?

> +static int igb_enet_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
> +			       u16 val)
> +{
> +	struct e1000_hw *hw = bus->priv;
> +
> +	return igb_write_reg_gs40g(hw, mii_id, regnum, val);
> +}
> +

There shouldn't be any need to actually pass the PHY address assuming 
you let the driver code take care of pulling the address of the PHY from 
the EEPROM before hand.  As such you can probably just not use the 
mii_id value.

> +static int igb_enet_mdio_reset(struct mii_bus *bus)
> +{
> +	usleep_range(1000, 2000);
> +	return 0;
> +}
> +

Is there a reason for having a sleep here if you aren't doing anything? 
  You could probably just not define this since it doesn't do anything.

> +static void igb_enet_mii_link(struct net_device *netdev)
> +{
> +}
> +

Seems like there should probably be something here, but I don't know 
enough about phylib yet to say what.

> +/* Probe the mdio bus for phys and connect them */
> +static int igb_enet_mii_probe(struct net_device *netdev)
> +{
> +	struct igb_adapter *adapter = netdev_priv(netdev);
> +	struct e1000_hw *hw = &adapter->hw;
> +	struct phy_device *phy_dev = NULL;
> +	int phy_id;
> +
> +	/* check for attached phy */
> +	for (phy_id = 0; (phy_id < PHY_MAX_ADDR); phy_id++) {
> +		if (hw->mii_bus->phy_map[phy_id]) {
> +			phy_dev = hw->mii_bus->phy_map[phy_id];
> +			break;
> +		}
> +	}

There is code that should have already figured this out in the driver. 
We just need to check the PHY addr after get_invarians has been called, 
assuming the EEPROM is correct.  So you should be able to just get the 
phy.addr from the e1000_hw struct.

> +	if (!phy_dev) {
> +		netdev_err(netdev, "no PHY found\n");
> +		return -ENODEV;
> +	}
> +
> +	hw->phy_interface = PHY_INTERFACE_MODE_RGMII;
> +	phy_dev = phy_connect(netdev, dev_name(&phy_dev->dev),
> +			      igb_enet_mii_link, hw->phy_interface);
> +	if (IS_ERR(phy_dev)) {
> +		netdev_err(netdev, "could not attach to PHY\n");
> +		return PTR_ERR(phy_dev);
> +	}
> +
> +	hw->phy_dev = phy_dev;
> +	netdev_info(netdev, "igb PHY driver [%s] (mii_bus:phy_addr=%s)\n",
> +		    hw->phy_dev->drv->name, dev_name(&hw->phy_dev->dev));
> +
> +	return 0;
> +}
> +
> +/* Create and register mdio bus */
> +static int igb_enet_mii_init(struct pci_dev *pdev)
> +{
> +	struct mii_bus *mii_bus;
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct igb_adapter *adapter = netdev_priv(netdev);
> +	struct e1000_hw *hw = &adapter->hw;
> +	int err;
> +
> +	mii_bus = mdiobus_alloc();
> +	if (!mii_bus) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	mii_bus->name = "igb_enet_mii_bus";
> +	mii_bus->read = igb_enet_mdio_read;
> +	mii_bus->write = igb_enet_mdio_write;
> +	mii_bus->reset = igb_enet_mdio_reset;
> +	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
> +		 pci_name(pdev), hw->device_id + 1);
> +	mii_bus->priv = hw;
> +	mii_bus->parent = &pdev->dev;
> +	mii_bus->phy_mask = ~(1 << hw->phy.addr);
> +
> +	err = mdiobus_register(mii_bus);
> +	if (err) {
> +		netdev_err(netdev, "failed to register mii_bus: %d\n", err);
> +		goto err_out_free_mdiobus;
> +	}
> +	hw->mii_bus = mii_bus;
> +
> +	return 0;
> +
> +err_out_free_mdiobus:
> +	mdiobus_free(mii_bus);
> +err_out:
> +	return err;
> +}
> +
> +static void igb_enet_mii_remove(struct e1000_hw *hw)
> +{
> +	if (hw->mii_bus) {
> +		mdiobus_unregister(hw->mii_bus);
> +		mdiobus_free(hw->mii_bus);
> +	}
> +}
> +#endif /* CONFIG_PHYLIB */
> +
>   /**
>    *  igb_probe - Device Initialization Routine
>    *  @pdev: PCI device information struct
> @@ -2645,6 +2761,13 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		}
>   	}
>   	pm_runtime_put_noidle(&pdev->dev);
> +
> +#ifdef CONFIG_PHYLIB
> +	/* create and register the mdio bus if using ext phy */
> +	if (rd32(E1000_MDICNFG) & E1000_MDICNFG_EXT_MDIO)
> +		igb_enet_mii_init(pdev);
> +#endif
> +
>   	return 0;
>
>   err_register:

The MDICNFG register doesn't exist for all devices as I recall.  What 
you may want to do is make enabling the mii_bus optional dependent on 
get_invariants returning an error that the PHY is not recognized.

> @@ -2788,6 +2911,10 @@ static void igb_remove(struct pci_dev *pdev)
>   	struct e1000_hw *hw = &adapter->hw;
>
>   	pm_runtime_get_noresume(&pdev->dev);
> +#ifdef CONFIG_PHYLIB
> +	if (rd32(E1000_MDICNFG) & E1000_MDICNFG_EXT_MDIO)
> +		igb_enet_mii_remove(hw);
> +#endif
>   #ifdef CONFIG_IGB_HWMON
>   	igb_sysfs_exit(adapter);
>   #endif

Same thing here.  I would say what you could do is just check to see if 
a mii_bus is allocated and if so remove it.  You could probably push the 
check inside of igb_mii_remove.

> @@ -3093,6 +3220,12 @@ static int __igb_open(struct net_device *netdev, bool resuming)
>   	if (!resuming)
>   		pm_runtime_put(&pdev->dev);
>
> +#ifdef CONFIG_PHYLIB
> +	/* Probe and connect to PHY if using ext phy */
> +	if (rd32(E1000_MDICNFG) & E1000_MDICNFG_EXT_MDIO)
> +		igb_enet_mii_probe(netdev);
> +#endif
> +
>   	/* start the watchdog. */
>   	hw->mac.get_link_status = 1;
>   	schedule_work(&adapter->watchdog_task);

Same here, use the existance of a mii_bus, not the register check.

> @@ -7127,21 +7260,41 @@ void igb_alloc_rx_buffers(struct igb_ring *rx_ring, u16 cleaned_count)
>   static int igb_mii_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
>   {
>   	struct igb_adapter *adapter = netdev_priv(netdev);
> +	struct e1000_hw *hw = &adapter->hw;
>   	struct mii_ioctl_data *data = if_mii(ifr);
>
> -	if (adapter->hw.phy.media_type != e1000_media_type_copper)
> +	if (adapter->hw.phy.media_type != e1000_media_type_copper &&
> +	    !(rd32(E1000_MDICNFG) & E1000_MDICNFG_EXT_MDIO))
>   		return -EOPNOTSUPP;
>
>   	switch (cmd) {
>   	case SIOCGMIIPHY:
> -		data->phy_id = adapter->hw.phy.addr;
> +		data->phy_id = hw->phy.addr;
>   		break;
>   	case SIOCGMIIREG:
> -		if (igb_read_phy_reg(&adapter->hw, data->reg_num & 0x1F,
> -				     &data->val_out))
> -			return -EIO;
> +		if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211) {
> +			if (igb_read_reg_gs40g(&adapter->hw, data->phy_id,
> +					       data->reg_num & 0x1F,
> +					       &data->val_out))
> +				return -EIO;
> +		} else {
> +			if (igb_read_phy_reg(&adapter->hw, data->reg_num & 0x1F,
> +					     &data->val_out))
> +				return -EIO;
> +		}
>   		break;
>   	case SIOCSMIIREG:
> +		if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211) {
> +			if (igb_write_reg_gs40g(hw, data->phy_id,
> +						data->reg_num & 0x1F,
> +						data->val_in))
> +				return -EIO;
> +		} else {
> +			if (igb_write_phy_reg(hw, data->reg_num & 0x1F,
> +					      data->val_in))
> +				return -EIO;
> +		}
> +		break;
>   	default:
>   		return -EOPNOTSUPP;
>   	}
>

These changes just shouldn't be needed.  I'd say they could be dropped. 
  The phy_id should be static and configured by the hardware before the 
driver is even loaded.
