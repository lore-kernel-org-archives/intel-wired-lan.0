From: kbuild test robot <lkp@intel.com>
Date: Thu, 7 May 2020 00:35:48 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 20/81]
 drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:258:10: note: in expansion
 of macro 'FIELD_PREP'
Message-ID: <202005070044.1LSWSMnh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   72b88096a8c29448b29df809e4d800d5652408eb
commit: 35f9f065dbb6b4a0ce5d55c3d91fede6b12af8cc [20/81] gwdpa: gswip: Introduce Gigabit Ethernet Switch (GSWIP) device driver
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 35f9f065dbb6b4a0ce5d55c3d91fede6b12af8cc
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/bitfield.h:10,
                    from drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:4:
   In function 'get_2G5_intf',
       inlined from 'mac_get_mii_interface' at drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:335:10:
   include/linux/compiler.h:350:38: error: call to '__compiletime_assert_89' declared with attribute error: FIELD_PREP: value too large for the field
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                      ^
   include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
     331 |    prefix ## suffix();    \
         |    ^~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
         |   ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:3: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
         |   ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:258:10: note: in expansion of macro 'FIELD_PREP'
     258 |  macif = FIELD_PREP(MAC_IF_CFG_CFG2G5, mac_if_cfg);
         |          ^~~~~~~~~~
   drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c: In function 'get_2G5_intf':
   include/linux/compiler.h:350:38: error: call to '__compiletime_assert_89' declared with attribute error: FIELD_PREP: value too large for the field
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                      ^
   include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
     331 |    prefix ## suffix();    \
         |    ^~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
         |   ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:3: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
         |   ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:258:10: note: in expansion of macro 'FIELD_PREP'
     258 |  macif = FIELD_PREP(MAC_IF_CFG_CFG2G5, mac_if_cfg);
         |          ^~~~~~~~~~
--
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bitfield.h:10,
                    from drivers/net/ethernet/intel/gwdpa/gswip/gswip_mac.c:4:
   drivers/net/ethernet/intel/gwdpa/gswip/gswip_mac.c: In function 'sw_mac_get_mtu':
   include/linux/compiler.h:350:38: error: call to '__compiletime_assert_160' declared with attribute error: FIELD_PREP: value too large for the field
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                      ^
   include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
     331 |    prefix ## suffix();    \
         |    ^~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
         |   ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:3: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
         |   ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/gwdpa/gswip/gswip_mac.c:211:8: note: in expansion of macro 'FIELD_PREP'
     211 |  val = FIELD_PREP(MAC_MTU_CFG_MTU, reg);
         |        ^~~~~~~~~~

vim +/FIELD_PREP +258 drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c

   251	
   252	inline int get_2G5_intf(struct gswip_mac *priv)
   253	{
   254		u32 mac_if_cfg, macif;
   255		int ret;
   256	
   257		mac_if_cfg = sw_read(priv, MAC_IF_CFG_REG(priv->mac_idx));
 > 258		macif = FIELD_PREP(MAC_IF_CFG_CFG2G5, mac_if_cfg);
   259	
   260		if (macif == 0)
   261			ret = XGMAC_GMII;
   262		else if (macif == 1)
   263			ret = XGMAC_XGMII;
   264		else
   265			ret = -EINVAL;
   266	
   267		return ret;
   268	}
   269	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66065 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200507/c64dacbb/attachment-0001.bin>
