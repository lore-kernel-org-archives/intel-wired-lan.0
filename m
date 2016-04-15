From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 Apr 2016 06:08:23 +0800
Subject: [Intel-wired-lan] [PATCH v2] e1000e: don't modify SYSTIM
 registers during SIOCSHWTSTAMP ioctl
In-Reply-To: <20160415213655.28072-1-jacob.e.keller@intel.com>
Message-ID: <201604160620.tzwVNm0h%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jacob,

[auto build test WARNING on v4.6-rc3]
[also build test WARNING on next-20160415]
[cannot apply to jkirsher-next-queue/dev-queue]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Keller/e1000e-don-t-modify-SYSTIM-registers-during-SIOCSHWTSTAMP-ioctl/20160416-054018
config: x86_64-allyesconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/e1000e/netdev.c:7499:13: error: initializer element is not constant
     .resume  = e1000e_pm_resume,
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7499:13: note: (near initialization for 'e1000_pm_ops.resume')
   drivers/net/ethernet/intel/e1000e/netdev.c:7500:13: error: initializer element is not constant
     .freeze  = e1000e_pm_freeze,
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7500:13: note: (near initialization for 'e1000_pm_ops.freeze')
   drivers/net/ethernet/intel/e1000e/netdev.c:7501:11: error: initializer element is not constant
     .thaw  = e1000e_pm_thaw,
              ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7501:11: note: (near initialization for 'e1000_pm_ops.thaw')
   drivers/net/ethernet/intel/e1000e/netdev.c:7502:14: error: initializer element is not constant
     .poweroff = e1000e_pm_suspend,
                 ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7502:14: note: (near initialization for 'e1000_pm_ops.poweroff')
   drivers/net/ethernet/intel/e1000e/netdev.c:7503:13: error: initializer element is not constant
     .restore = e1000e_pm_resume,
                ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7503:13: note: (near initialization for 'e1000_pm_ops.restore')
   In file included from arch/x86/include/asm/apic.h:5:0,
                    from arch/x86/include/asm/smp.h:12,
                    from arch/x86/include/asm/mmzone_64.h:10,
                    from arch/x86/include/asm/mmzone.h:4,
                    from include/linux/mmzone.h:869,
                    from include/linux/gfp.h:5,
                    from include/linux/kmod.h:22,
                    from include/linux/module.h:13,
                    from drivers/net/ethernet/intel/e1000e/netdev.c:24:
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
   drivers/net/ethernet/intel/e1000e/netdev.c:7496:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static const struct dev_pm_ops e1000_pm_ops = {
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
   In file included from include/linux/printk.h:5:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/net/ethernet/intel/e1000e/netdev.c:24:
   drivers/net/ethernet/intel/e1000e/netdev.c:7536:13: error: initializer element is not constant
    module_init(e1000_init_module);
                ^
   include/linux/init.h:188:58: note: in definition of macro '__define_initcall'
     __attribute__((__section__(".initcall" #id ".init"))) = fn; \
                                                             ^
   include/linux/init.h:223:24: note: in expansion of macro 'device_initcall'
    #define __initcall(fn) device_initcall(fn)
                           ^
   include/linux/module.h:84:24: note: in expansion of macro '__initcall'
    #define module_init(x) __initcall(x);
                           ^
>> drivers/net/ethernet/intel/e1000e/netdev.c:7536:1: note: in expansion of macro 'module_init'
    module_init(e1000_init_module);
    ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7544:20: error: invalid storage class for function 'e1000_exit_module'
    static void __exit e1000_exit_module(void)
                       ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7544:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void __exit e1000_exit_module(void)
    ^
   In file included from include/linux/printk.h:5:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/net/ethernet/intel/e1000e/netdev.c:24:
   drivers/net/ethernet/intel/e1000e/netdev.c:7548:13: error: initializer element is not constant
    module_exit(e1000_exit_module);
                ^
   include/linux/init.h:226:50: note: in definition of macro '__exitcall'
     static exitcall_t __exitcall_##fn __exit_call = fn
                                                     ^
>> drivers/net/ethernet/intel/e1000e/netdev.c:7548:1: note: in expansion of macro 'module_exit'
    module_exit(e1000_exit_module);
    ^
   In file included from include/linux/module.h:18:0,
                    from drivers/net/ethernet/intel/e1000e/netdev.c:24:
   include/linux/moduleparam.h:27:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      struct __UNIQUE_ID(name) {}
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
   In file included from drivers/net/ethernet/intel/e1000e/netdev.c:24:0:
   include/linux/module.h:261:22: error: expected declaration or statement at end of input
     static const struct module_version_attribute   \
                         ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7553:1: note: in expansion of macro 'MODULE_VERSION'
    MODULE_VERSION(DRV_VERSION);
    ^
   cc1: some warnings being treated as errors

vim +/module_init +7536 drivers/net/ethernet/intel/e1000e/netdev.c

8544b9f7 drivers/net/e1000e/netdev.c                Bruce Allan    2010-03-24  7530  	pr_info("Intel(R) PRO/1000 Network Driver - %s\n",
8544b9f7 drivers/net/e1000e/netdev.c                Bruce Allan    2010-03-24  7531  		e1000e_driver_version);
529498cd drivers/net/ethernet/intel/e1000e/netdev.c Yanir Lubetkin 2015-06-02  7532  	pr_info("Copyright(c) 1999 - 2015 Intel Corporation.\n");
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7533  
5a5e889c drivers/net/ethernet/intel/e1000e/netdev.c Jean Sacren    2015-09-19  7534  	return pci_register_driver(&e1000_driver);
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7535  }
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17 @7536  module_init(e1000_init_module);
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7537  
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7538  /**
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7539   * e1000_exit_module - Driver Exit Cleanup Routine
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7540   *
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7541   * e1000_exit_module is called just before the driver is removed
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7542   * from memory.
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7543   **/
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7544  static void __exit e1000_exit_module(void)
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7545  {
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7546  	pci_unregister_driver(&e1000_driver);
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7547  }
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17 @7548  module_exit(e1000_exit_module);
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7549  
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7550  MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  7551  MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");

:::::: The code at line 7536 was first introduced by commit
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
Size: 53380 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160416/356b0efd/attachment-0001.obj>
