From: kbuild test robot <lkp@intel.com>
Date: Sat, 28 Dec 2019 10:48:21 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue 5/5]
 drivers/net//ethernet/intel/e1000e/netdev.c:7604:2: note: in expansion of
 macro 'if'
Message-ID: <201912281017.OfQFlOVY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git dev-queue
head:   7e5a53fc0c524519c2941cfd719ee598800a5572
commit: 7e5a53fc0c524519c2941cfd719ee598800a5572 [5/5] e1000e: Revert "e1000e: Make watchdog use delayed work"
config: i386-randconfig-f001-20191228 (attached as .config)
compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
reproduce:
        git checkout 7e5a53fc0c524519c2941cfd719ee598800a5572
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/export.h:43:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/net//ethernet/intel/e1000e/netdev.c:6:
   drivers/net//ethernet/intel/e1000e/netdev.c: In function 'e1000_remove':
   drivers/net//ethernet/intel/e1000e/netdev.c:7604:6: warning: the address of 'down' will always evaluate as 'true' [-Waddress]
     if (!down)
         ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> drivers/net//ethernet/intel/e1000e/netdev.c:7604:2: note: in expansion of macro 'if'
     if (!down)
     ^~
   drivers/net//ethernet/intel/e1000e/netdev.c:7604:6: warning: the address of 'down' will always evaluate as 'true' [-Waddress]
     if (!down)
         ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> drivers/net//ethernet/intel/e1000e/netdev.c:7604:2: note: in expansion of macro 'if'
     if (!down)
     ^~
   drivers/net//ethernet/intel/e1000e/netdev.c:7604:6: warning: the address of 'down' will always evaluate as 'true' [-Waddress]
     if (!down)
         ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> drivers/net//ethernet/intel/e1000e/netdev.c:7604:2: note: in expansion of macro 'if'
     if (!down)
     ^~

vim +/if +7604 drivers/net//ethernet/intel/e1000e/netdev.c

  7584	
  7585	/**
  7586	 * e1000_remove - Device Removal Routine
  7587	 * @pdev: PCI device information struct
  7588	 *
  7589	 * e1000_remove is called by the PCI subsystem to alert the driver
  7590	 * that it should release a PCI device.  The could be caused by a
  7591	 * Hot-Plug event, or because the driver is going to be removed from
  7592	 * memory.
  7593	 **/
  7594	static void e1000_remove(struct pci_dev *pdev)
  7595	{
  7596		struct net_device *netdev = pci_get_drvdata(pdev);
  7597		struct e1000_adapter *adapter = netdev_priv(netdev);
  7598	
  7599		e1000e_ptp_remove(adapter);
  7600	
  7601		/* The timers may be rescheduled, so explicitly disable them
  7602		 * from being rescheduled.
  7603		 */
> 7604		if (!down)
  7605			set_bit(__E1000_DOWN, &adapter->state);
  7606		del_timer_sync(&adapter->watchdog_timer);
  7607		del_timer_sync(&adapter->phy_info_timer);
  7608	
  7609		cancel_work_sync(&adapter->reset_task);
  7610		cancel_work_sync(&adapter->watchdog_task);
  7611		cancel_work_sync(&adapter->downshift_task);
  7612		cancel_work_sync(&adapter->update_phy_task);
  7613		cancel_work_sync(&adapter->print_hang_task);
  7614	
  7615		if (adapter->flags & FLAG_HAS_HW_TIMESTAMP) {
  7616			cancel_work_sync(&adapter->tx_hwtstamp_work);
  7617			if (adapter->tx_hwtstamp_skb) {
  7618				dev_consume_skb_any(adapter->tx_hwtstamp_skb);
  7619				adapter->tx_hwtstamp_skb = NULL;
  7620			}
  7621		}
  7622	
  7623		unregister_netdev(netdev);
  7624	
  7625		if (pci_dev_run_wake(pdev))
  7626			pm_runtime_get_noresume(&pdev->dev);
  7627	
  7628		/* Release control of h/w to f/w.  If f/w is AMT enabled, this
  7629		 * would have already happened in close and is redundant.
  7630		 */
  7631		e1000e_release_hw_control(adapter);
  7632	
  7633		e1000e_reset_interrupt_capability(adapter);
  7634		kfree(adapter->tx_ring);
  7635		kfree(adapter->rx_ring);
  7636	
  7637		iounmap(adapter->hw.hw_addr);
  7638		if ((adapter->hw.flash_address) &&
  7639		    (adapter->hw.mac.type < e1000_pch_spt))
  7640			iounmap(adapter->hw.flash_address);
  7641		pci_release_mem_regions(pdev);
  7642	
  7643		free_netdev(netdev);
  7644	
  7645		/* AER disable */
  7646		pci_disable_pcie_error_reporting(pdev);
  7647	
  7648		pci_disable_device(pdev);
  7649	}
  7650	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39504 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191228/f590a44c/attachment-0001.bin>
