From: kbuild test robot <lkp@intel.com>
Date: Wed, 5 Dec 2018 13:04:35 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 15/17]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8822: undefined reference to
 `mdiobus_write'
Message-ID: <201812051333.rPGDGxgs%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   7e1ab79ec66131e03715c31928e09efd1c749cef
commit: 9027120a933849accc9100ec5f38a4e1961711a6 [15/17] ixgbe: use mii_bus to handle MII related ioctls
config: i386-randconfig-s1-12051035 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout 9027120a933849accc9100ec5f38a4e1961711a6
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.o: In function `ixgbe_mdio_write':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8822: undefined reference to `mdiobus_write'
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.o: In function `ixgbe_mdio_read':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8799: undefined reference to `mdiobus_read'
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.o: In function `ixgbe_remove':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11195: undefined reference to `mdiobus_unregister'
   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.o: In function `devm_mdiobus_alloc':
>> include/linux/phy.h:264: undefined reference to `devm_mdiobus_alloc_size'
   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.o: In function `ixgbe_mii_bus_init':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:952: undefined reference to `__mdiobus_register'
>> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:955: undefined reference to `devm_mdiobus_free'

vim +8822 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  8784	
  8785	static int
  8786	ixgbe_mdio_read(struct net_device *netdev, int prtad, int devad, u16 addr)
  8787	{
  8788		struct ixgbe_adapter *adapter = netdev_priv(netdev);
  8789		struct ixgbe_hw *hw = &adapter->hw;
  8790		u16 value;
  8791		int rc;
  8792	
  8793		if (adapter->mii_bus) {
  8794			int regnum = addr;
  8795	
  8796			if (devad != MDIO_DEVAD_NONE)
  8797				regnum |= (devad << 16) | MII_ADDR_C45;
  8798	
> 8799			return mdiobus_read(adapter->mii_bus, prtad, regnum);
  8800		}
  8801	
  8802		if (prtad != hw->phy.mdio.prtad)
  8803			return -EINVAL;
  8804		rc = hw->phy.ops.read_reg(hw, addr, devad, &value);
  8805		if (!rc)
  8806			rc = value;
  8807		return rc;
  8808	}
  8809	
  8810	static int ixgbe_mdio_write(struct net_device *netdev, int prtad, int devad,
  8811				    u16 addr, u16 value)
  8812	{
  8813		struct ixgbe_adapter *adapter = netdev_priv(netdev);
  8814		struct ixgbe_hw *hw = &adapter->hw;
  8815	
  8816		if (adapter->mii_bus) {
  8817			int regnum = addr;
  8818	
  8819			if (devad != MDIO_DEVAD_NONE)
  8820				regnum |= (devad << 16) | MII_ADDR_C45;
  8821	
> 8822			return mdiobus_write(adapter->mii_bus, prtad, regnum, value);
  8823		}
  8824	
  8825		if (prtad != hw->phy.mdio.prtad)
  8826			return -EINVAL;
  8827		return hw->phy.ops.write_reg(hw, addr, devad, value);
  8828	}
  8829	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26412 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181205/47fc3bbb/attachment-0001.bin>
