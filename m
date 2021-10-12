From: kernel test robot <lkp@intel.com>
Date: Wed, 13 Oct 2021 07:57:40 +0800
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix handling of vlan
 strip virtual channel messages
In-Reply-To: <20211012130447.6177-1-michal.maloszewski@intel.com>
References: <20211012130447.6177-1-michal.maloszewski@intel.com>
Message-ID: <202110130713.1x1zbqX7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Michal,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tnguy-next-queue/dev-queue]
[also build test ERROR on v5.15-rc5 next-20211012]
[cannot apply to net/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michal-Maloszewski/iavf-Fix-handling-of-vlan-strip-virtual-channel-messages/20211012-215003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
config: riscv-randconfig-c006-20211012 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c3dcf39554dbea780d6cb7e12239451ba47a2668)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/da86d18f37a7ff9c6223f103e20908b9ee6a8b0c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michal-Maloszewski/iavf-Fix-handling-of-vlan-strip-virtual-channel-messages/20211012-215003
        git checkout da86d18f37a7ff9c6223f103e20908b9ee6a8b0c
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/ethernet/intel/iavf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

                                                                    ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:42:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1141:5: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                            ntohs(f->data.tcp_spec.src_port));
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:42:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1147:5: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                            ntohs(f->data.tcp_spec.vlan_id),
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:42:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1150:5: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                            ntohs(f->data.tcp_spec.dst_port),
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:42:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1151:5: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                            ntohs(f->data.tcp_spec.src_port));
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:42:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1470:53: error: use of undeclared identifier 'NETIF_F_HW_VLAN_RX'
                netdev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_RX;
                                                              ^
   drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1472:55: error: use of undeclared identifier 'NETIF_F_HW_VLAN_RX'
                netdev->features &= ~NETIF_F_HW_VLAN_CTAG_RX & ~NETIF_F_HW_VLAN_RX;
                                                                ^
   6 warnings and 2 errors generated.


vim +/NETIF_F_HW_VLAN_RX +1470 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

  1458	
  1459	/**
  1460	 * iavf_netdev_features_vlan_strip_set
  1461	 * @netdev: ptr to netdev being adjusted
  1462	 * @enable: enable or disable vlan strip
  1463	 *
  1464	 * Helper function to change vlan strip status in netdev->features.
  1465	 **/
  1466	static void iavf_netdev_features_vlan_strip_set(struct net_device *netdev,
  1467						       const bool enable)
  1468	{
  1469		if (enable)
> 1470		     netdev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_RX;
  1471		else
  1472		     netdev->features &= ~NETIF_F_HW_VLAN_CTAG_RX & ~NETIF_F_HW_VLAN_RX;
  1473	}
  1474	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39049 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211013/c4253d0a/attachment-0001.bin>
