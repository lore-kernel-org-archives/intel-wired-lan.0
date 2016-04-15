From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 Apr 2016 06:08:49 +0800
Subject: [Intel-wired-lan] [PATCH v2] e1000e: don't modify SYSTIM
 registers during SIOCSHWTSTAMP ioctl
In-Reply-To: <20160415213655.28072-1-jacob.e.keller@intel.com>
Message-ID: <201604160637.Ton6cor4%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jacob,

[auto build test ERROR on v4.6-rc3]
[also build test ERROR on next-20160415]
[cannot apply to jkirsher-next-queue/dev-queue]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Keller/e1000e-don-t-modify-SYSTIM-registers-during-SIOCSHWTSTAMP-ioctl/20160416-054018
config: sparc64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:4767:13: error: invalid storage class for function 'e1000_update_phy_info'
    static void e1000_update_phy_info(unsigned long data)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:4783:13: error: invalid storage class for function 'e1000e_update_phy_stats'
    static void e1000e_update_phy_stats(struct e1000_adapter *adapter)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:4858:13: error: invalid storage class for function 'e1000e_update_stats'
    static void e1000e_update_stats(struct e1000_adapter *adapter)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:4974:13: error: invalid storage class for function 'e1000_phy_read_status'
    static void e1000_phy_read_status(struct e1000_adapter *adapter)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5012:13: error: invalid storage class for function 'e1000_print_link_info'
    static void e1000_print_link_info(struct e1000_adapter *adapter)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5026:13: error: invalid storage class for function 'e1000e_has_link'
    static bool e1000e_has_link(struct e1000_adapter *adapter)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5068:13: error: invalid storage class for function 'e1000e_enable_receives'
    static void e1000e_enable_receives(struct e1000_adapter *adapter)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5081:13: error: invalid storage class for function 'e1000e_check_82574_phy_workaround'
    static void e1000e_check_82574_phy_workaround(struct e1000_adapter *adapter)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5104:13: error: invalid storage class for function 'e1000_watchdog'
    static void e1000_watchdog(unsigned long data)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5114:13: error: invalid storage class for function 'e1000_watchdog_task'
    static void e1000_watchdog_task(struct work_struct *work)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5361:12: error: invalid storage class for function 'e1000_tso'
    static int e1000_tso(struct e1000_ring *tx_ring, struct sk_buff *skb,
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5429:13: error: invalid storage class for function 'e1000_tx_csum'
    static bool e1000_tx_csum(struct e1000_ring *tx_ring, struct sk_buff *skb,
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5483:12: error: invalid storage class for function 'e1000_tx_map'
    static int e1000_tx_map(struct e1000_ring *tx_ring, struct sk_buff *skb,
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5580:13: error: invalid storage class for function 'e1000_tx_queue'
    static void e1000_tx_queue(struct e1000_ring *tx_ring, int tx_flags, int count)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5647:12: error: invalid storage class for function 'e1000_transfer_dhcp_info'
    static int e1000_transfer_dhcp_info(struct e1000_adapter *adapter,
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5684:12: error: invalid storage class for function '__e1000_maybe_stop_tx'
    static int __e1000_maybe_stop_tx(struct e1000_ring *tx_ring, int size)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5707:12: error: invalid storage class for function 'e1000_maybe_stop_tx'
    static int e1000_maybe_stop_tx(struct e1000_ring *tx_ring, int size)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5716:20: error: invalid storage class for function 'e1000_xmit_frame'
    static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
                       ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5873:13: error: invalid storage class for function 'e1000_tx_timeout'
    static void e1000_tx_timeout(struct net_device *netdev)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5882:13: error: invalid storage class for function 'e1000_reset_task'
    static void e1000_reset_task(struct work_struct *work)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:5953:12: error: invalid storage class for function 'e1000_change_mtu'
    static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6021:12: error: invalid storage class for function 'e1000_mii_ioctl'
    static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6095:12: error: invalid storage class for function 'e1000e_hwtstamp_set'
    static int e1000e_hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6130:12: error: invalid storage class for function 'e1000e_hwtstamp_get'
    static int e1000e_hwtstamp_get(struct net_device *netdev, struct ifreq *ifr)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6138:12: error: invalid storage class for function 'e1000_ioctl'
    static int e1000_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6154:12: error: invalid storage class for function 'e1000_init_phy_wakeup'
    static int e1000_init_phy_wakeup(struct e1000_adapter *adapter, u32 wufc)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6228:13: error: invalid storage class for function 'e1000e_flush_lpic'
    static void e1000e_flush_lpic(struct pci_dev *pdev)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6250:12: error: invalid storage class for function 'e1000e_pm_freeze'
    static int e1000e_pm_freeze(struct device *dev)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6277:12: error: invalid storage class for function '__e1000_shutdown'
    static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6426:13: error: invalid storage class for function '__e1000e_disable_aspm'
    static void __e1000e_disable_aspm(struct pci_dev *pdev, u16 state, int locked)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6499:13: error: invalid storage class for function 'e1000e_disable_aspm'
    static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6512:13: error: invalid storage class for function 'e1000e_disable_aspm_locked'
    static void e1000e_disable_aspm_locked(struct pci_dev *pdev, u16 state)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6518:12: error: invalid storage class for function '__e1000_resume'
    static int __e1000_resume(struct pci_dev *pdev)
               ^
>> drivers/net/ethernet/intel/e1000e/netdev.c:6584:12: error: invalid storage class for function 'e1000e_pm_thaw'
    static int e1000e_pm_thaw(struct device *dev)
               ^
>> drivers/net/ethernet/intel/e1000e/netdev.c:6604:12: error: invalid storage class for function 'e1000e_pm_suspend'
    static int e1000e_pm_suspend(struct device *dev)
               ^
>> drivers/net/ethernet/intel/e1000e/netdev.c:6615:12: error: invalid storage class for function 'e1000e_pm_resume'
    static int e1000e_pm_resume(struct device *dev)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6628:12: error: invalid storage class for function 'e1000e_pm_runtime_idle'
    static int e1000e_pm_runtime_idle(struct device *dev)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6645:12: error: invalid storage class for function 'e1000e_pm_runtime_resume'
    static int e1000e_pm_runtime_resume(struct device *dev)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6662:12: error: invalid storage class for function 'e1000e_pm_runtime_suspend'
    static int e1000e_pm_runtime_suspend(struct device *dev)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6689:13: error: invalid storage class for function 'e1000_shutdown'
    static void e1000_shutdown(struct pci_dev *pdev)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6700:20: error: invalid storage class for function 'e1000_intr_msix'
    static irqreturn_t e1000_intr_msix(int __always_unused irq, void *data)
                       ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6738:13: error: invalid storage class for function 'e1000_netpoll'
    static void e1000_netpoll(struct net_device *netdev)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6768:25: error: invalid storage class for function 'e1000_io_error_detected'
    static pci_ers_result_t e1000_io_error_detected(struct pci_dev *pdev,
                            ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6794:25: error: invalid storage class for function 'e1000_io_slot_reset'
    static pci_ers_result_t e1000_io_slot_reset(struct pci_dev *pdev)
                            ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6841:13: error: invalid storage class for function 'e1000_io_resume'
    static void e1000_io_resume(struct pci_dev *pdev)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6861:13: error: invalid storage class for function 'e1000_print_device_info'
    static void e1000_print_device_info(struct e1000_adapter *adapter)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6885:13: error: invalid storage class for function 'e1000_eeprom_checks'
    static void e1000_eeprom_checks(struct e1000_adapter *adapter)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6903:26: error: invalid storage class for function 'e1000_fix_features'
    static netdev_features_t e1000_fix_features(struct net_device *netdev,
                             ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6916:12: error: invalid storage class for function 'e1000_set_features'
    static int e1000_set_features(struct net_device *netdev,
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6955:2: error: initializer element is not constant
     .ndo_open  = e1000_open,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6955:2: error: (near initialization for 'e1000e_netdev_ops.ndo_open')
   drivers/net/ethernet/intel/e1000e/netdev.c:6956:2: error: initializer element is not constant
     .ndo_stop  = e1000_close,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6956:2: error: (near initialization for 'e1000e_netdev_ops.ndo_stop')
   drivers/net/ethernet/intel/e1000e/netdev.c:6957:2: error: initializer element is not constant
     .ndo_start_xmit  = e1000_xmit_frame,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6957:2: error: (near initialization for 'e1000e_netdev_ops.ndo_start_xmit')
   drivers/net/ethernet/intel/e1000e/netdev.c:6958:2: error: initializer element is not constant
     .ndo_get_stats64 = e1000e_get_stats64,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6958:2: error: (near initialization for 'e1000e_netdev_ops.ndo_get_stats64')
   drivers/net/ethernet/intel/e1000e/netdev.c:6960:2: error: initializer element is not constant
     .ndo_set_mac_address = e1000_set_mac,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6960:2: error: (near initialization for 'e1000e_netdev_ops.ndo_set_mac_address')
   drivers/net/ethernet/intel/e1000e/netdev.c:6961:2: error: initializer element is not constant
     .ndo_change_mtu  = e1000_change_mtu,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6961:2: error: (near initialization for 'e1000e_netdev_ops.ndo_change_mtu')
   drivers/net/ethernet/intel/e1000e/netdev.c:6962:2: error: initializer element is not constant
     .ndo_do_ioctl  = e1000_ioctl,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6962:2: error: (near initialization for 'e1000e_netdev_ops.ndo_do_ioctl')
   drivers/net/ethernet/intel/e1000e/netdev.c:6963:2: error: initializer element is not constant
     .ndo_tx_timeout  = e1000_tx_timeout,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6963:2: error: (near initialization for 'e1000e_netdev_ops.ndo_tx_timeout')
   drivers/net/ethernet/intel/e1000e/netdev.c:6969:2: error: initializer element is not constant
     .ndo_poll_controller = e1000_netpoll,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6969:2: error: (near initialization for 'e1000e_netdev_ops.ndo_poll_controller')
   drivers/net/ethernet/intel/e1000e/netdev.c:6971:2: error: initializer element is not constant
     .ndo_set_features = e1000_set_features,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6971:2: error: (near initialization for 'e1000e_netdev_ops.ndo_set_features')
   drivers/net/ethernet/intel/e1000e/netdev.c:6972:2: error: initializer element is not constant
     .ndo_fix_features = e1000_fix_features,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6972:2: error: (near initialization for 'e1000e_netdev_ops.ndo_fix_features')
   drivers/net/ethernet/intel/e1000e/netdev.c:6987:12: error: invalid storage class for function 'e1000_probe'
    static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7336:13: error: invalid storage class for function 'e1000_remove'
    static void e1000_remove(struct pci_dev *pdev)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7400:2: error: initializer element is not constant
     .error_detected = e1000_io_error_detected,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7400:2: error: (near initialization for 'e1000_err_handler.error_detected')
   drivers/net/ethernet/intel/e1000e/netdev.c:7401:2: error: initializer element is not constant
     .slot_reset = e1000_io_slot_reset,
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7401:2: error: (near initialization for 'e1000_err_handler.slot_reset')
   drivers/net/ethernet/intel/e1000e/netdev.c:7402:2: error: initializer element is not constant

vim +/e1000e_pm_thaw +6584 drivers/net/ethernet/intel/e1000e/netdev.c

beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6493   * @pdev: pointer to PCI device struct
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6494   * @state: bit-mask of ASPM states to disable
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6495   *
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6496   * This function acquires the pci_bus_sem!
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6497   * Some devices *must* have certain ASPM states disabled per hardware errata.
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6498   **/
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10 @6499  static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6500  {
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6501  	__e1000e_disable_aspm(pdev, state, 0);
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6502  }
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6503  
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6504  /**
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6505   * e1000e_disable_aspm_locked   Disable ASPM states.
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6506   * @pdev: pointer to PCI device struct
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6507   * @state: bit-mask of ASPM states to disable
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6508   *
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6509   * This function must be called with pci_bus_sem acquired!
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6510   * Some devices *must* have certain ASPM states disabled per hardware errata.
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6511   **/
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10 @6512  static void e1000e_disable_aspm_locked(struct pci_dev *pdev, u16 state)
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6513  {
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6514  	__e1000e_disable_aspm(pdev, state, 1);
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6515  }
beb0a1520 drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin        2015-06-10  6516  
aa3386015 drivers/net/e1000e/netdev.c                Rafael J. Wysocki     2011-02-11  6517  #ifdef CONFIG_PM
23606cf5d drivers/net/e1000e/netdev.c                Rafael J. Wysocki     2010-03-14 @6518  static int __e1000_resume(struct pci_dev *pdev)
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6519  {
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6520  	struct net_device *netdev = pci_get_drvdata(pdev);
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6521  	struct e1000_adapter *adapter = netdev_priv(netdev);
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6522  	struct e1000_hw *hw = &adapter->hw;
78cd29d5a drivers/net/e1000e/netdev.c                Bruce Allan           2011-03-24  6523  	u16 aspm_disable_flag = 0;
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6524  
78cd29d5a drivers/net/e1000e/netdev.c                Bruce Allan           2011-03-24  6525  	if (adapter->flags2 & FLAG2_DISABLE_ASPM_L0S)
78cd29d5a drivers/net/e1000e/netdev.c                Bruce Allan           2011-03-24  6526  		aspm_disable_flag = PCIE_LINK_STATE_L0S;
78cd29d5a drivers/net/e1000e/netdev.c                Bruce Allan           2011-03-24  6527  	if (adapter->flags2 & FLAG2_DISABLE_ASPM_L1)
78cd29d5a drivers/net/e1000e/netdev.c                Bruce Allan           2011-03-24  6528  		aspm_disable_flag |= PCIE_LINK_STATE_L1;
78cd29d5a drivers/net/e1000e/netdev.c                Bruce Allan           2011-03-24  6529  	if (aspm_disable_flag)
2758f9edb drivers/net/ethernet/intel/e1000e/netdev.c Raanan Avargil        2015-07-06  6530  		e1000e_disable_aspm(pdev, aspm_disable_flag);
78cd29d5a drivers/net/e1000e/netdev.c                Bruce Allan           2011-03-24  6531  
66148babe drivers/net/ethernet/intel/e1000e/netdev.c Konstantin Khlebnikov 2013-03-05  6532  	pci_set_master(pdev);
6e4f6f6b4 drivers/net/e1000e/netdev.c                Taku Izumi            2008-06-20  6533  
2fbe4526e drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan           2012-04-19  6534  	if (hw->mac.type >= e1000_pch2lan)
99730e4c1 drivers/net/e1000e/netdev.c                Bruce Allan           2011-05-13  6535  		e1000_resume_workarounds_pchlan(&adapter->hw);
99730e4c1 drivers/net/e1000e/netdev.c                Bruce Allan           2011-05-13  6536  
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6537  	e1000e_power_up_phy(adapter);
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6538  
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6539  	/* report the system wakeup cause from S3/S4 */
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6540  	if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6541  		u16 phy_data;
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6542  
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6543  		e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6544  		if (phy_data) {
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6545  			e_info("PHY Wakeup cause - %s\n",
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6546  			       phy_data & E1000_WUS_EX ? "Unicast Packet" :
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6547  			       phy_data & E1000_WUS_MC ? "Multicast Packet" :
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6548  			       phy_data & E1000_WUS_BC ? "Broadcast Packet" :
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6549  			       phy_data & E1000_WUS_MAG ? "Magic Packet" :
ef456f858 drivers/net/ethernet/intel/e1000e/netdev.c Jeff Kirsher          2011-11-03  6550  			       phy_data & E1000_WUS_LNKC ?
ef456f858 drivers/net/ethernet/intel/e1000e/netdev.c Jeff Kirsher          2011-11-03  6551  			       "Link Status Change" : "other");
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6552  		}
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6553  		e1e_wphy(&adapter->hw, BM_WUS, ~0);
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6554  	} else {
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6555  		u32 wus = er32(WUS);
6cf08d1c5 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-04-05  6556  
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6557  		if (wus) {
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6558  			e_info("MAC Wakeup cause - %s\n",
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6559  			       wus & E1000_WUS_EX ? "Unicast Packet" :
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6560  			       wus & E1000_WUS_MC ? "Multicast Packet" :
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6561  			       wus & E1000_WUS_BC ? "Broadcast Packet" :
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6562  			       wus & E1000_WUS_MAG ? "Magic Packet" :
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6563  			       wus & E1000_WUS_LNKC ? "Link Status Change" :
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6564  			       "other");
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6565  		}
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6566  		ew32(WUS, ~0);
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6567  	}
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6568  
a4f58f545 drivers/net/e1000e/netdev.c                Bruce Allan           2009-06-02  6569  	e1000e_reset(adapter);
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6570  
cd791618c drivers/net/e1000e/netdev.c                Bruce Allan           2010-05-10  6571  	e1000_init_manageability_pt(adapter);
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6572  
e921eb1ac drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan           2012-11-28  6573  	/* If the controller has AMT, do not set DRV_LOAD until the interface
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6574  	 * is up.  For all other cases, let the f/w know that the h/w is now
ad68076e0 drivers/net/e1000e/netdev.c                Bruce Allan           2008-03-28  6575  	 * under the control of the driver.
ad68076e0 drivers/net/e1000e/netdev.c                Bruce Allan           2008-03-28  6576  	 */
c43bc57e5 drivers/net/e1000e/netdev.c                Jesse Brandeburg      2008-08-04  6577  	if (!(adapter->flags & FLAG_HAS_AMT))
31dbe5b4a drivers/net/e1000e/netdev.c                Bruce Allan           2011-01-06  6578  		e1000e_get_hw_control(adapter);
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6579  
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6580  	return 0;
bc7f75fa9 drivers/net/e1000e/netdev.c                Auke Kok              2007-09-17  6581  }
23606cf5d drivers/net/e1000e/netdev.c                Rafael J. Wysocki     2010-03-14  6582  
3e7986f67 drivers/net/ethernet/intel/e1000e/netdev.c Hiroaki SHIMODA       2014-04-15  6583  #ifdef CONFIG_PM_SLEEP
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14 @6584  static int e1000e_pm_thaw(struct device *dev)
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6585  {
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6586  	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6587  	struct e1000_adapter *adapter = netdev_priv(netdev);
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6588  
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6589  	e1000e_set_interrupt_capability(adapter);
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6590  	if (netif_running(netdev)) {
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6591  		u32 err = e1000_request_irq(adapter);
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6592  
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6593  		if (err)
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6594  			return err;
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6595  
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6596  		e1000e_up(adapter);
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6597  	}
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6598  
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6599  	netif_device_attach(netdev);
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6600  
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6601  	return 0;
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6602  }
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6603  
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14 @6604  static int e1000e_pm_suspend(struct device *dev)
a03401628 drivers/net/e1000e/netdev.c                Rafael J. Wysocki     2010-03-17  6605  {
a03401628 drivers/net/e1000e/netdev.c                Rafael J. Wysocki     2010-03-17  6606  	struct pci_dev *pdev = to_pci_dev(dev);
a03401628 drivers/net/e1000e/netdev.c                Rafael J. Wysocki     2010-03-17  6607  
2a7e19af9 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-07-11  6608  	e1000e_flush_lpic(pdev);
2a7e19af9 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-07-11  6609  
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6610  	e1000e_pm_freeze(dev);
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6611  
66148babe drivers/net/ethernet/intel/e1000e/netdev.c Konstantin Khlebnikov 2013-03-05  6612  	return __e1000_shutdown(pdev, false);
a03401628 drivers/net/e1000e/netdev.c                Rafael J. Wysocki     2010-03-17  6613  }
a03401628 drivers/net/e1000e/netdev.c                Rafael J. Wysocki     2010-03-17  6614  
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14 @6615  static int e1000e_pm_resume(struct device *dev)
23606cf5d drivers/net/e1000e/netdev.c                Rafael J. Wysocki     2010-03-14  6616  {
23606cf5d drivers/net/e1000e/netdev.c                Rafael J. Wysocki     2010-03-14  6617  	struct pci_dev *pdev = to_pci_dev(dev);
280020999 drivers/net/ethernet/intel/e1000e/netdev.c David Ertman          2014-02-14  6618  	int rc;

:::::: The code at line 6584 was first introduced by commit
:::::: 2800209994f878b00724ceabb65d744855c8f99a e1000e: Refactor PM flows

:::::: TO: David Ertman <davidx.m.ertman@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45940 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160416/a8ee4abe/attachment-0001.obj>
