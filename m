From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 Apr 2016 06:05:56 +0800
Subject: [Intel-wired-lan] [PATCH v2] e1000e: don't modify SYSTIM
 registers during SIOCSHWTSTAMP ioctl
In-Reply-To: <20160415213655.28072-1-jacob.e.keller@intel.com>
Message-ID: <201604160628.1n03fCEf%fengguang.wu@intel.com>
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
config: x86_64-randconfig-x011-201615 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

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
   drivers/net/ethernet/intel/e1000e/netdev.c:6955:15: error: initializer element is not constant
     .ndo_open  = e1000_open,
                  ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6955:15: note: (near initialization for 'e1000e_netdev_ops.ndo_open')
   drivers/net/ethernet/intel/e1000e/netdev.c:6956:15: error: initializer element is not constant
     .ndo_stop  = e1000_close,
                  ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6956:15: note: (near initialization for 'e1000e_netdev_ops.ndo_stop')
   drivers/net/ethernet/intel/e1000e/netdev.c:6957:21: error: initializer element is not constant
     .ndo_start_xmit  = e1000_xmit_frame,
                        ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6957:21: note: (near initialization for 'e1000e_netdev_ops.ndo_start_xmit')
   drivers/net/ethernet/intel/e1000e/netdev.c:6958:21: error: initializer element is not constant
     .ndo_get_stats64 = e1000e_get_stats64,
                        ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6958:21: note: (near initialization for 'e1000e_netdev_ops.ndo_get_stats64')
   drivers/net/ethernet/intel/e1000e/netdev.c:6960:25: error: initializer element is not constant
     .ndo_set_mac_address = e1000_set_mac,
                            ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6960:25: note: (near initialization for 'e1000e_netdev_ops.ndo_set_mac_address')
   drivers/net/ethernet/intel/e1000e/netdev.c:6961:21: error: initializer element is not constant
     .ndo_change_mtu  = e1000_change_mtu,
                        ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6961:21: note: (near initialization for 'e1000e_netdev_ops.ndo_change_mtu')
   drivers/net/ethernet/intel/e1000e/netdev.c:6962:19: error: initializer element is not constant
     .ndo_do_ioctl  = e1000_ioctl,
                      ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6962:19: note: (near initialization for 'e1000e_netdev_ops.ndo_do_ioctl')
   drivers/net/ethernet/intel/e1000e/netdev.c:6963:21: error: initializer element is not constant
     .ndo_tx_timeout  = e1000_tx_timeout,
                        ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6963:21: note: (near initialization for 'e1000e_netdev_ops.ndo_tx_timeout')
   drivers/net/ethernet/intel/e1000e/netdev.c:6969:25: error: initializer element is not constant
     .ndo_poll_controller = e1000_netpoll,
                            ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6969:25: note: (near initialization for 'e1000e_netdev_ops.ndo_poll_controller')
   drivers/net/ethernet/intel/e1000e/netdev.c:6971:22: error: initializer element is not constant
     .ndo_set_features = e1000_set_features,
                         ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6971:22: note: (near initialization for 'e1000e_netdev_ops.ndo_set_features')
   drivers/net/ethernet/intel/e1000e/netdev.c:6972:22: error: initializer element is not constant
     .ndo_fix_features = e1000_fix_features,
                         ^
   drivers/net/ethernet/intel/e1000e/netdev.c:6972:22: note: (near initialization for 'e1000e_netdev_ops.ndo_fix_features')
   drivers/net/ethernet/intel/e1000e/netdev.c:6987:12: error: invalid storage class for function 'e1000_probe'
    static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7336:13: error: invalid storage class for function 'e1000_remove'
    static void e1000_remove(struct pci_dev *pdev)
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7400:20: error: initializer element is not constant
     .error_detected = e1000_io_error_detected,
                       ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7400:20: note: (near initialization for 'e1000_err_handler.error_detected')
   drivers/net/ethernet/intel/e1000e/netdev.c:7401:16: error: initializer element is not constant
     .slot_reset = e1000_io_slot_reset,
                   ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7401:16: note: (near initialization for 'e1000_err_handler.slot_reset')
   drivers/net/ethernet/intel/e1000e/netdev.c:7402:12: error: initializer element is not constant
     .resume = e1000_io_resume,
               ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7402:12: note: (near initialization for 'e1000_err_handler.resume')
>> drivers/net/ethernet/intel/e1000e/netdev.c:7494:1: warning: 'alias' attribute ignored [-Wattributes]
    MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
    ^
   In file included from include/linux/device.h:25:0,
                    from include/linux/pci.h:30,
                    from drivers/net/ethernet/intel/e1000e/netdev.c:27:
   drivers/net/ethernet/intel/e1000e/netdev.c:7505:21: error: initializer element is not constant
     SET_RUNTIME_PM_OPS(e1000e_pm_runtime_suspend, e1000e_pm_runtime_resume,
                        ^
   include/linux/pm.h:359:21: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_suspend = suspend_fn, \
                        ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7505:21: note: (near initialization for 'e1000_pm_ops.runtime_suspend')
     SET_RUNTIME_PM_OPS(e1000e_pm_runtime_suspend, e1000e_pm_runtime_resume,
                        ^
   include/linux/pm.h:359:21: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_suspend = suspend_fn, \
                        ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7505:48: error: initializer element is not constant
     SET_RUNTIME_PM_OPS(e1000e_pm_runtime_suspend, e1000e_pm_runtime_resume,
                                                   ^
   include/linux/pm.h:360:20: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_resume = resume_fn, \
                       ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7505:48: note: (near initialization for 'e1000_pm_ops.runtime_resume')
     SET_RUNTIME_PM_OPS(e1000e_pm_runtime_suspend, e1000e_pm_runtime_resume,
                                                   ^
   include/linux/pm.h:360:20: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_resume = resume_fn, \
                       ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7506:7: error: initializer element is not constant
          e1000e_pm_runtime_idle)
          ^
   include/linux/pm.h:361:18: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_idle = idle_fn,
                     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7506:7: note: (near initialization for 'e1000_pm_ops.runtime_idle')
          e1000e_pm_runtime_idle)
          ^
   include/linux/pm.h:361:18: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_idle = idle_fn,
                     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7513:14: error: initializer element is not constant
     .probe    = e1000_probe,
                 ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7513:14: note: (near initialization for 'e1000_driver.probe')
   drivers/net/ethernet/intel/e1000e/netdev.c:7514:14: error: initializer element is not constant
     .remove   = e1000_remove,
                 ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7514:14: note: (near initialization for 'e1000_driver.remove')
   drivers/net/ethernet/intel/e1000e/netdev.c:7518:14: error: initializer element is not constant
     .shutdown = e1000_shutdown,
                 ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7518:14: note: (near initialization for 'e1000_driver.shutdown')
   drivers/net/ethernet/intel/e1000e/netdev.c:7528:19: error: invalid storage class for function 'e1000_init_module'
    static int __init e1000_init_module(void)
                      ^
   In file included from drivers/net/ethernet/intel/e1000e/netdev.c:24:0:
>> include/linux/module.h:128:27: error: invalid storage class for function '__inittest'
     static inline initcall_t __inittest(void)  \
                              ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7536:1: note: in expansion of macro 'module_init'
    module_init(e1000_init_module);
    ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7536:1: warning: 'alias' attribute ignored [-Wattributes]
   drivers/net/ethernet/intel/e1000e/netdev.c:7544:20: error: invalid storage class for function 'e1000_exit_module'
    static void __exit e1000_exit_module(void)
                       ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7544:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void __exit e1000_exit_module(void)
    ^
   In file included from drivers/net/ethernet/intel/e1000e/netdev.c:24:0:
>> include/linux/module.h:134:27: error: invalid storage class for function '__exittest'
     static inline exitcall_t __exittest(void)  \
                              ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7548:1: note: in expansion of macro 'module_exit'
    module_exit(e1000_exit_module);
    ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7548:1: warning: 'alias' attribute ignored [-Wattributes]
   In file included from include/linux/module.h:18:0,
                    from drivers/net/ethernet/intel/e1000e/netdev.c:24:
   include/linux/moduleparam.h:21:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static const char __UNIQUE_ID(name)[]       \
    ^
   include/linux/module.h:171:32: note: in expansion of macro '__MODULE_INFO'
    #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
                                   ^
   include/linux/module.h:215:32: note: in expansion of macro 'MODULE_INFO'
    #define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)
                                   ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7550:1: note: in expansion of macro 'MODULE_AUTHOR'
    MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
    ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7553:1: error: expected declaration or statement at end of input
    MODULE_VERSION(DRV_VERSION);
    ^
   cc1: some warnings being treated as errors

vim +/alias +7494 drivers/net/ethernet/intel/e1000e/netdev.c

111b9dc5 drivers/net/e1000e/netdev.c                Jesse Brandeburg  2009-02-10  7394  
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7395  	pci_disable_device(pdev);
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7396  }
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7397  
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7398  /* PCI Error Recovery (ERS) */
3646f0e5 drivers/net/ethernet/intel/e1000e/netdev.c Stephen Hemminger 2012-09-07  7399  static const struct pci_error_handlers e1000_err_handler = {
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17 @7400  	.error_detected = e1000_io_error_detected,
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7401  	.slot_reset = e1000_io_slot_reset,
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7402  	.resume = e1000_io_resume,
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7403  };
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7404  
0e8e842b drivers/net/ethernet/intel/e1000e/netdev.c David Ertman      2014-04-08  7405  static const struct pci_device_id e1000_pci_tbl[] = {
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7406  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_COPPER), board_82571 },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7407  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_FIBER), board_82571 },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7408  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_QUAD_COPPER), board_82571 },
c29c3ba5 drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2013-02-20  7409  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_QUAD_COPPER_LP),
c29c3ba5 drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2013-02-20  7410  	  board_82571 },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7411  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_QUAD_FIBER), board_82571 },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7412  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_SERDES), board_82571 },
040babf9 drivers/net/e1000e/netdev.c                Auke Kok          2007-10-31  7413  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_SERDES_DUAL), board_82571 },
040babf9 drivers/net/e1000e/netdev.c                Auke Kok          2007-10-31  7414  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571EB_SERDES_QUAD), board_82571 },
040babf9 drivers/net/e1000e/netdev.c                Auke Kok          2007-10-31  7415  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82571PT_QUAD_COPPER), board_82571 },
ad68076e drivers/net/e1000e/netdev.c                Bruce Allan       2008-03-28  7416  
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7417  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI), board_82572 },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7418  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI_COPPER), board_82572 },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7419  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI_FIBER), board_82572 },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7420  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82572EI_SERDES), board_82572 },
ad68076e drivers/net/e1000e/netdev.c                Bruce Allan       2008-03-28  7421  
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7422  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82573E), board_82573 },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7423  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82573E_IAMT), board_82573 },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7424  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82573L), board_82573 },
ad68076e drivers/net/e1000e/netdev.c                Bruce Allan       2008-03-28  7425  
4662e82b drivers/net/e1000e/netdev.c                Bruce Allan       2008-08-26  7426  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82574L), board_82574 },
bef28b11 drivers/net/e1000e/netdev.c                Bruce Allan       2009-03-24  7427  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82574LA), board_82574 },
8c81c9c3 drivers/net/e1000e/netdev.c                Alexander Duyck   2009-03-19  7428  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_82583V), board_82583 },
4662e82b drivers/net/e1000e/netdev.c                Bruce Allan       2008-08-26  7429  
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7430  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_COPPER_DPT),
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7431  	  board_80003es2lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7432  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_COPPER_SPT),
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7433  	  board_80003es2lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7434  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_SERDES_DPT),
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7435  	  board_80003es2lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7436  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_80003ES2LAN_SERDES_SPT),
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7437  	  board_80003es2lan },
ad68076e drivers/net/e1000e/netdev.c                Bruce Allan       2008-03-28  7438  
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7439  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IFE), board_ich8lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7440  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IFE_G), board_ich8lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7441  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IFE_GT), board_ich8lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7442  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_AMT), board_ich8lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7443  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_C), board_ich8lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7444  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_M), board_ich8lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7445  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_IGP_M_AMT), board_ich8lan },
9e135a2e drivers/net/e1000e/netdev.c                Bruce Allan       2009-12-01  7446  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH8_82567V_3), board_ich8lan },
ad68076e drivers/net/e1000e/netdev.c                Bruce Allan       2008-03-28  7447  
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7448  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IFE), board_ich9lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7449  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IFE_G), board_ich9lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7450  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IFE_GT), board_ich9lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7451  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_AMT), board_ich9lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7452  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_C), board_ich9lan },
2f15f9d6 drivers/net/e1000e/netdev.c                Bruce Allan       2008-08-26  7453  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_BM), board_ich9lan },
97ac8cae drivers/net/e1000e/netdev.c                Bruce Allan       2008-04-29  7454  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_M), board_ich9lan },
97ac8cae drivers/net/e1000e/netdev.c                Bruce Allan       2008-04-29  7455  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_M_AMT), board_ich9lan },
97ac8cae drivers/net/e1000e/netdev.c                Bruce Allan       2008-04-29  7456  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH9_IGP_M_V), board_ich9lan },
97ac8cae drivers/net/e1000e/netdev.c                Bruce Allan       2008-04-29  7457  
97ac8cae drivers/net/e1000e/netdev.c                Bruce Allan       2008-04-29  7458  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_R_BM_LM), board_ich9lan },
97ac8cae drivers/net/e1000e/netdev.c                Bruce Allan       2008-04-29  7459  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_R_BM_LF), board_ich9lan },
97ac8cae drivers/net/e1000e/netdev.c                Bruce Allan       2008-04-29  7460  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_R_BM_V), board_ich9lan },
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7461  
f4187b56 drivers/net/e1000e/netdev.c                Bruce Allan       2008-08-26  7462  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_D_BM_LM), board_ich10lan },
f4187b56 drivers/net/e1000e/netdev.c                Bruce Allan       2008-08-26  7463  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_D_BM_LF), board_ich10lan },
10df0b91 drivers/net/e1000e/netdev.c                Bruce Allan       2010-05-10  7464  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_ICH10_D_BM_V), board_ich10lan },
f4187b56 drivers/net/e1000e/netdev.c                Bruce Allan       2008-08-26  7465  
a4f58f54 drivers/net/e1000e/netdev.c                Bruce Allan       2009-06-02  7466  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_M_HV_LM), board_pchlan },
a4f58f54 drivers/net/e1000e/netdev.c                Bruce Allan       2009-06-02  7467  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_M_HV_LC), board_pchlan },
a4f58f54 drivers/net/e1000e/netdev.c                Bruce Allan       2009-06-02  7468  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_D_HV_DM), board_pchlan },
a4f58f54 drivers/net/e1000e/netdev.c                Bruce Allan       2009-06-02  7469  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_D_HV_DC), board_pchlan },
a4f58f54 drivers/net/e1000e/netdev.c                Bruce Allan       2009-06-02  7470  
d3738bb8 drivers/net/e1000e/netdev.c                Bruce Allan       2010-06-16  7471  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH2_LV_LM), board_pch2lan },
d3738bb8 drivers/net/e1000e/netdev.c                Bruce Allan       2010-06-16  7472  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH2_LV_V), board_pch2lan },
d3738bb8 drivers/net/e1000e/netdev.c                Bruce Allan       2010-06-16  7473  
2fbe4526 drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2012-04-19  7474  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPT_I217_LM), board_pch_lpt },
2fbe4526 drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2012-04-19  7475  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPT_I217_V), board_pch_lpt },
16e310ae drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2012-10-09  7476  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPTLP_I218_LM), board_pch_lpt },
16e310ae drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2012-10-09  7477  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LPTLP_I218_V), board_pch_lpt },
91a3d82f drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2013-06-29  7478  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_LM2), board_pch_lpt },
91a3d82f drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2013-06-29  7479  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_V2), board_pch_lpt },
91a3d82f drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2013-06-29  7480  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_LM3), board_pch_lpt },
91a3d82f drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2013-06-29  7481  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_I218_V3), board_pch_lpt },
79849ebc drivers/net/ethernet/intel/e1000e/netdev.c David Ertman      2015-02-10  7482  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM), board_pch_spt },
79849ebc drivers/net/ethernet/intel/e1000e/netdev.c David Ertman      2015-02-10  7483  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V), board_pch_spt },
79849ebc drivers/net/ethernet/intel/e1000e/netdev.c David Ertman      2015-02-10  7484  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM2), board_pch_spt },
79849ebc drivers/net/ethernet/intel/e1000e/netdev.c David Ertman      2015-02-10  7485  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V2), board_pch_spt },
f3ed935d drivers/net/ethernet/intel/e1000e/netdev.c Raanan Avargil    2015-10-20  7486  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LBG_I219_LM3), board_pch_spt },
9cd34b3a drivers/net/ethernet/intel/e1000e/netdev.c Raanan Avargil    2015-12-22  7487  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM4), board_pch_spt },
9cd34b3a drivers/net/ethernet/intel/e1000e/netdev.c Raanan Avargil    2015-12-22  7488  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V4), board_pch_spt },
9cd34b3a drivers/net/ethernet/intel/e1000e/netdev.c Raanan Avargil    2015-12-22  7489  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM5), board_pch_spt },
9cd34b3a drivers/net/ethernet/intel/e1000e/netdev.c Raanan Avargil    2015-12-22  7490  	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V5), board_pch_spt },
2fbe4526 drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2012-04-19  7491  
f36bb6ca drivers/net/ethernet/intel/e1000e/netdev.c Bruce Allan       2012-01-31  7492  	{ 0, 0, 0, 0, 0, 0, 0 }	/* terminate list */
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7493  };
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17 @7494  MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok          2007-09-17  7495  
23606cf5 drivers/net/e1000e/netdev.c                Rafael J. Wysocki 2010-03-14  7496  static const struct dev_pm_ops e1000_pm_ops = {
72f72dcc drivers/net/ethernet/intel/e1000e/netdev.c Kevin Hao         2014-03-18  7497  #ifdef CONFIG_PM_SLEEP

:::::: The code at line 7494 was first introduced by commit
:::::: bc7f75fa97884d41efbfde1397b621fefb2550b4 [E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)

:::::: TO: Auke Kok <auke-jan.h.kok@intel.com>
:::::: CC: David S. Miller <davem@sunset.davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 32453 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160416/92d9af20/attachment-0001.obj>
