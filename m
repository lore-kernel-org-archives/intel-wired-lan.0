From: kbuild test robot <lkp@intel.com>
Date: Sat, 4 Apr 2020 11:46:03 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 68/69]
 drivers/net/ethernet/intel/igc/igc_main.c:5164:6: warning: Condition '!err'
 is always true [knownConditionTrueFalse]
Message-ID: <202004041100.9b0fDR0x%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a7dc1908e52f3b08664e61b87542d17646f1781d
commit: 426d53dac2727acb4fa5c51f4b1e6f703e10a940 [68/69] igc: remove IGC_REMOVED function

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/igc/igc_main.c:2192:23: warning: The scope of the variable 'entry' can be reduced. [variableScope]
    struct igc_mac_addr *entry;
                         ^
   drivers/net/ethernet/intel/igc/igc_main.c:2215:23: warning: The scope of the variable 'entry' can be reduced. [variableScope]
    struct igc_mac_addr *entry;
                         ^
   drivers/net/ethernet/intel/igc/igc_main.c:1569:14: warning: 'va' is of type 'void *'. When using void pointers in calculations, the behaviour is undefined. [arithOperationsOnVoidPointer]
    prefetch(va + L1_CACHE_BYTES);
                ^
   drivers/net/ethernet/intel/igc/igc_main.c:1608:14: warning: 'va' is of type 'void *'. When using void pointers in calculations, the behaviour is undefined. [arithOperationsOnVoidPointer]
    prefetch(va + L1_CACHE_BYTES);
                ^
   drivers/net/ethernet/intel/igc/igc_main.c:1618:6: warning: 'va' is of type 'void *'. When using void pointers in calculations, the behaviour is undefined. [arithOperationsOnVoidPointer]
     va += IGC_TS_HDR_LEN;
        ^
   drivers/net/ethernet/intel/igc/igc_main.c:1634:9: warning: 'va' is of type 'void *'. When using void pointers in calculations, the behaviour is undefined. [arithOperationsOnVoidPointer]
       (va + headlen) - page_address(rx_buffer->page),
           ^
>> drivers/net/ethernet/intel/igc/igc_main.c:5164:6: warning: Condition '!err' is always true [knownConditionTrueFalse]
    if (!err && netif_running(netdev))
        ^
>> drivers/net/ethernet/intel/igc/igc_main.c:5136:6: note: Assuming that condition 'err' is not redundant
    if (err) {
        ^
>> drivers/net/ethernet/intel/igc/igc_main.c:5164:6: note: Condition '!err' is always true
    if (!err && netif_running(netdev))
        ^

vim +5164 drivers/net/ethernet/intel/igc/igc_main.c

9513d2a5dc7f3f Sasha Neftin 2019-11-14  5120  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5121  static int __maybe_unused igc_resume(struct device *dev)
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5122  {
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5123  	struct pci_dev *pdev = to_pci_dev(dev);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5124  	struct net_device *netdev = pci_get_drvdata(pdev);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5125  	struct igc_adapter *adapter = netdev_priv(netdev);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5126  	struct igc_hw *hw = &adapter->hw;
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5127  	u32 err, val;
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5128  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5129  	pci_set_power_state(pdev, PCI_D0);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5130  	pci_restore_state(pdev);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5131  	pci_save_state(pdev);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5132  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5133  	if (!pci_device_is_present(pdev))
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5134  		return -ENODEV;
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5135  	err = pci_enable_device_mem(pdev);
9513d2a5dc7f3f Sasha Neftin 2019-11-14 @5136  	if (err) {
82200edc4daccf Andre Guedes 2020-03-30  5137  		netdev_err(netdev, "Cannot enable PCI device from suspend");
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5138  		return err;
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5139  	}
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5140  	pci_set_master(pdev);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5141  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5142  	pci_enable_wake(pdev, PCI_D3hot, 0);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5143  	pci_enable_wake(pdev, PCI_D3cold, 0);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5144  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5145  	if (igc_init_interrupt_scheme(adapter, true)) {
82200edc4daccf Andre Guedes 2020-03-30  5146  		netdev_err(netdev, "Unable to allocate memory for queues");
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5147  		return -ENOMEM;
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5148  	}
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5149  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5150  	igc_reset(adapter);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5151  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5152  	/* let the f/w know that the h/w is now under the control of the
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5153  	 * driver.
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5154  	 */
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5155  	igc_get_hw_control(adapter);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5156  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5157  	val = rd32(IGC_WUS);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5158  	if (val & WAKE_PKT_WUS)
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5159  		igc_deliver_wake_packet(netdev);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5160  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5161  	wr32(IGC_WUS, ~0);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5162  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5163  	rtnl_lock();
9513d2a5dc7f3f Sasha Neftin 2019-11-14 @5164  	if (!err && netif_running(netdev))
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5165  		err = __igc_open(netdev, true);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5166  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5167  	if (!err)
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5168  		netif_device_attach(netdev);
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5169  	rtnl_unlock();
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5170  
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5171  	return err;
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5172  }
9513d2a5dc7f3f Sasha Neftin 2019-11-14  5173  

:::::: The code at line 5164 was first introduced by commit
:::::: 9513d2a5dc7f3f2c037bfd2ea35264cc783b954e igc: Add legacy power management support

:::::: TO: Sasha Neftin <sasha.neftin@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
