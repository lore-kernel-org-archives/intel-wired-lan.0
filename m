From: kernel test robot <lkp@intel.com>
Date: Thu, 11 Nov 2021 22:56:38 +0800
Subject: [Intel-wired-lan] [PATCH linux] e1000e: Delete redundant
 variable definitions
In-Reply-To: <20211111090555.158828-1-luo.penghao@zte.com.cn>
References: <20211111090555.158828-1-luo.penghao@zte.com.cn>
Message-ID: <202111112246.M0trEfiC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]

url:    https://github.com/0day-ci/linux/commits/cgel-zte-gmail-com/e1000e-Delete-redundant-variable-definitions/20211111-170640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git debe436e77c72fcee804fb867f275e6d31aa999c
config: arc-allyesconfig (attached as .config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/81faea6b288a1c17c390413bcb3021fef7e89bad
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/e1000e-Delete-redundant-variable-definitions/20211111-170640
        git checkout 81faea6b288a1c17c390413bcb3021fef7e89bad
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/ktime.h:26,
                    from include/linux/timer.h:6,
                    from drivers/net/ethernet/intel/e1000e/e1000.h:11,
                    from drivers/net/ethernet/intel/e1000e/ptp.c:9:
   drivers/net/ethernet/intel/e1000e/ptp.c: In function 'e1000e_systim_overflow_work':
>> drivers/net/ethernet/intel/e1000e/e1000.h:31:20: error: 'hw' undeclared (first use in this function)
      31 |         netdev_dbg(hw->adapter->netdev, format, ## arg)
         |                    ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:170:9: note: in expansion of macro '_dynamic_func_call'
     170 |         _dynamic_func_call(fmt, __dynamic_netdev_dbg,           \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/netdevice.h:5324:9: note: in expansion of macro 'dynamic_netdev_dbg'
    5324 |         dynamic_netdev_dbg(__dev, format, ##args);              \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/e1000e/e1000.h:31:9: note: in expansion of macro 'netdev_dbg'
      31 |         netdev_dbg(hw->adapter->netdev, format, ## arg)
         |         ^~~~~~~~~~
   drivers/net/ethernet/intel/e1000e/ptp.c:248:9: note: in expansion of macro 'e_dbg'
     248 |         e_dbg("SYSTIM overflow check at %lld.%09lu\n",
         |         ^~~~~
   drivers/net/ethernet/intel/e1000e/e1000.h:31:20: note: each undeclared identifier is reported only once for each function it appears in
      31 |         netdev_dbg(hw->adapter->netdev, format, ## arg)
         |                    ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:170:9: note: in expansion of macro '_dynamic_func_call'
     170 |         _dynamic_func_call(fmt, __dynamic_netdev_dbg,           \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/netdevice.h:5324:9: note: in expansion of macro 'dynamic_netdev_dbg'
    5324 |         dynamic_netdev_dbg(__dev, format, ##args);              \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/e1000e/e1000.h:31:9: note: in expansion of macro 'netdev_dbg'
      31 |         netdev_dbg(hw->adapter->netdev, format, ## arg)
         |         ^~~~~~~~~~
   drivers/net/ethernet/intel/e1000e/ptp.c:248:9: note: in expansion of macro 'e_dbg'
     248 |         e_dbg("SYSTIM overflow check at %lld.%09lu\n",
         |         ^~~~~


vim +/hw +31 drivers/net/ethernet/intel/e1000e/e1000.h

bc7f75fa97884d drivers/net/e1000e/e1000.h Auke Kok     2007-09-17  29  
44defeb3f6f98e drivers/net/e1000e/e1000.h Jeff Kirsher 2008-08-04  30  #define e_dbg(format, arg...) \
8544b9f7371ec6 drivers/net/e1000e/e1000.h Bruce Allan  2010-03-24 @31  	netdev_dbg(hw->adapter->netdev, format, ## arg)
44defeb3f6f98e drivers/net/e1000e/e1000.h Jeff Kirsher 2008-08-04  32  #define e_err(format, arg...) \
8544b9f7371ec6 drivers/net/e1000e/e1000.h Bruce Allan  2010-03-24  33  	netdev_err(adapter->netdev, format, ## arg)
44defeb3f6f98e drivers/net/e1000e/e1000.h Jeff Kirsher 2008-08-04  34  #define e_info(format, arg...) \
8544b9f7371ec6 drivers/net/e1000e/e1000.h Bruce Allan  2010-03-24  35  	netdev_info(adapter->netdev, format, ## arg)
44defeb3f6f98e drivers/net/e1000e/e1000.h Jeff Kirsher 2008-08-04  36  #define e_warn(format, arg...) \
8544b9f7371ec6 drivers/net/e1000e/e1000.h Bruce Allan  2010-03-24  37  	netdev_warn(adapter->netdev, format, ## arg)
44defeb3f6f98e drivers/net/e1000e/e1000.h Jeff Kirsher 2008-08-04  38  #define e_notice(format, arg...) \
8544b9f7371ec6 drivers/net/e1000e/e1000.h Bruce Allan  2010-03-24  39  	netdev_notice(adapter->netdev, format, ## arg)
bc7f75fa97884d drivers/net/e1000e/e1000.h Auke Kok     2007-09-17  40  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 70030 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211111/20d54e3b/attachment-0001.bin>
