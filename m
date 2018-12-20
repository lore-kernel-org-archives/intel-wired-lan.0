From: kbuild test robot <lkp@intel.com>
Date: Thu, 20 Dec 2018 14:09:00 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 14/18]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11177: undefined reference to
 `mdiobus_unregister'
Message-ID: <201812201435.il1h6FzJ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a73457fe8784cca7512719229887550c067cfad2
commit: c6ca04dcf53e95e150c4cdd9b766c5954a9f6ede [14/18] ixgbe: register a mdiobus
config: i386-randconfig-s0-12160735 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout c6ca04dcf53e95e150c4cdd9b766c5954a9f6ede
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.o: In function `ixgbe_remove':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11177: undefined reference to `mdiobus_unregister'
   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.o: In function `devm_mdiobus_alloc':
>> include/linux/phy.h:264: undefined reference to `devm_mdiobus_alloc_size'
   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.o: In function `ixgbe_mii_bus_init':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:952: undefined reference to `__mdiobus_register'
>> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:955: undefined reference to `devm_mdiobus_free'

vim +11177 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

 11149	
 11150	/**
 11151	 * ixgbe_remove - Device Removal Routine
 11152	 * @pdev: PCI device information struct
 11153	 *
 11154	 * ixgbe_remove is called by the PCI subsystem to alert the driver
 11155	 * that it should release a PCI device.  The could be caused by a
 11156	 * Hot-Plug event, or because the driver is going to be removed from
 11157	 * memory.
 11158	 **/
 11159	static void ixgbe_remove(struct pci_dev *pdev)
 11160	{
 11161		struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
 11162		struct net_device *netdev;
 11163		bool disable_dev;
 11164		int i;
 11165	
 11166		/* if !adapter then we already cleaned up in probe */
 11167		if (!adapter)
 11168			return;
 11169	
 11170		netdev  = adapter->netdev;
 11171		ixgbe_dbg_adapter_exit(adapter);
 11172	
 11173		set_bit(__IXGBE_REMOVING, &adapter->state);
 11174		cancel_work_sync(&adapter->service_task);
 11175	
 11176		if (adapter->mii_bus)
 11177			mdiobus_unregister(adapter->mii_bus);
 11178	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29231 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181220/61b536e7/attachment-0001.bin>
