From: kbuild test robot <lkp@intel.com>
Date: Fri, 30 Nov 2018 07:24:05 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 14/15]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11178: undefined reference to
 `mdiobus_unregister'
Message-ID: <201811300759.Rg3WqV4v%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   355027b7bf46f1180b8ad582b3241745e1b50f22
commit: 6b15b057dc406ba4d7a3fe8a873d46749869d5d3 [14/15] ixgbe: register a mdiobus
config: i386-randconfig-s1-201847 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout 6b15b057dc406ba4d7a3fe8a873d46749869d5d3
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.o: In function `ixgbe_remove':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11178: undefined reference to `mdiobus_unregister'
   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.o: In function `devm_mdiobus_alloc':
>> include/linux/phy.h:264: undefined reference to `devm_mdiobus_alloc_size'
   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.o: In function `ixgbe_mii_bus_init':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:850: undefined reference to `__mdiobus_register'

vim +11178 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

 11150	
 11151	/**
 11152	 * ixgbe_remove - Device Removal Routine
 11153	 * @pdev: PCI device information struct
 11154	 *
 11155	 * ixgbe_remove is called by the PCI subsystem to alert the driver
 11156	 * that it should release a PCI device.  The could be caused by a
 11157	 * Hot-Plug event, or because the driver is going to be removed from
 11158	 * memory.
 11159	 **/
 11160	static void ixgbe_remove(struct pci_dev *pdev)
 11161	{
 11162		struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
 11163		struct net_device *netdev;
 11164		bool disable_dev;
 11165		int i;
 11166	
 11167		/* if !adapter then we already cleaned up in probe */
 11168		if (!adapter)
 11169			return;
 11170	
 11171		netdev  = adapter->netdev;
 11172		ixgbe_dbg_adapter_exit(adapter);
 11173	
 11174		set_bit(__IXGBE_REMOVING, &adapter->state);
 11175		cancel_work_sync(&adapter->service_task);
 11176	
 11177		if (adapter->mii_bus)
 11178			mdiobus_unregister(adapter->mii_bus);
 11179	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28700 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181130/178b4ead/attachment-0001.bin>
