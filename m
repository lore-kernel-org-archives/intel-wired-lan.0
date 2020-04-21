From: kbuild test robot <lkp@intel.com>
Date: Tue, 21 Apr 2020 13:45:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 37/81]
 include/linux/compiler.h:350:38: error: call to '__compiletime_assert_51'
 declared with attribute error: FIELD_GET: mask is not constant
Message-ID: <202004211337.Uftg2Z6k%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   d97e98934d756963b37943d99867b3becd51450e
commit: dd4810026b54dc648f2661c574facb77f1f2ea8d [37/81] gwdpa: gswip: Introduce Gigabit Ethernet Switch (GSWIP) device driver
config: ia64-randconfig-a001-20200421 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout dd4810026b54dc648f2661c574facb77f1f2ea8d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/linux/unaligned/packed_struct.h:4,
                    from include/linux/unaligned/le_struct.h:5,
                    from arch/ia64/include/asm/unaligned.h:5,
                    from drivers/net/ethernet/intel/gwdpa/gswip/gswip_core.c:4:
   drivers/net/ethernet/intel/gwdpa/gswip/gswip_core.h: In function 'reg_rbits':
>> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_51' declared with attribute error: FIELD_GET: mask is not constant
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
   include/linux/bitfield.h:46:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      46 |   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),  \
         |   ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:108:3: note: in expansion of macro '__BF_FIELD_CHECK'
     108 |   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
         |   ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/gwdpa/gswip/gswip_core.h:76:9: note: in expansion of macro 'FIELD_GET'
      76 |  return FIELD_GET(mask, reg_val);
         |         ^~~~~~~~~
>> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_55' declared with attribute error: BUILD_BUG_ON failed: (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) & (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) - 1)) != 0
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
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:2: note: in expansion of macro 'BUILD_BUG_ON'
      21 |  BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |  ^~~~~~~~~~~~
   include/linux/bitfield.h:54:3: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      54 |   __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +   \
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:108:3: note: in expansion of macro '__BF_FIELD_CHECK'
     108 |   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
         |   ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/gwdpa/gswip/gswip_core.h:76:9: note: in expansion of macro 'FIELD_GET'
      76 |  return FIELD_GET(mask, reg_val);
         |         ^~~~~~~~~
   In file included from drivers/net/ethernet/intel/gwdpa/gswip/gswip_core.h:8,
                    from drivers/net/ethernet/intel/gwdpa/gswip/gswip_core.c:9:
   drivers/net/ethernet/intel/gwdpa/gswip/gswip_core.h: In function 'reg_wbits':
>> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_46' declared with attribute error: FIELD_PREP: mask is not constant
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                      ^
   include/linux/regmap.h:75:42: note: in definition of macro 'regmap_update_bits'
      75 |  regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
         |                                          ^~~
   include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     338 |  __compiletime_assert(condition, msg, prefix, suffix)
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:46:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      46 |   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),  \
         |   ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:3: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
         |   ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/gwdpa/gswip/gswip_core.h:68:46: note: in expansion of macro 'FIELD_PREP'
      68 |  regmap_update_bits(priv->regmap, reg, mask, FIELD_PREP(mask, val));
         |                                              ^~~~~~~~~~
   include/linux/compiler.h:350:38: error: call to '__compiletime_assert_50' declared with attribute error: BUILD_BUG_ON failed: (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) & (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) - 1)) != 0
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                      ^
   include/linux/regmap.h:75:42: note: in definition of macro 'regmap_update_bits'
      75 |  regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
         |                                          ^~~
   include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     338 |  __compiletime_assert(condition, msg, prefix, suffix)
         |  ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:2: note: in expansion of macro 'BUILD_BUG_ON'
      21 |  BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |  ^~~~~~~~~~~~
   include/linux/bitfield.h:54:3: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      54 |   __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +   \
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:3: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
         |   ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/gwdpa/gswip/gswip_core.h:68:46: note: in expansion of macro 'FIELD_PREP'
      68 |  regmap_update_bits(priv->regmap, reg, mask, FIELD_PREP(mask, val));
         |                                              ^~~~~~~~~~

vim +/__compiletime_assert_51 +350 include/linux/compiler.h

9a8ab1c39970a4 Daniel Santos 2013-02-21  336  
9a8ab1c39970a4 Daniel Santos 2013-02-21  337  #define _compiletime_assert(condition, msg, prefix, suffix) \
9a8ab1c39970a4 Daniel Santos 2013-02-21  338  	__compiletime_assert(condition, msg, prefix, suffix)
9a8ab1c39970a4 Daniel Santos 2013-02-21  339  
9a8ab1c39970a4 Daniel Santos 2013-02-21  340  /**
9a8ab1c39970a4 Daniel Santos 2013-02-21  341   * compiletime_assert - break build and emit msg if condition is false
9a8ab1c39970a4 Daniel Santos 2013-02-21  342   * @condition: a compile-time constant condition to check
9a8ab1c39970a4 Daniel Santos 2013-02-21  343   * @msg:       a message to emit if condition is false
9a8ab1c39970a4 Daniel Santos 2013-02-21  344   *
9a8ab1c39970a4 Daniel Santos 2013-02-21  345   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c39970a4 Daniel Santos 2013-02-21  346   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c39970a4 Daniel Santos 2013-02-21  347   * compiler has support to do so.
9a8ab1c39970a4 Daniel Santos 2013-02-21  348   */
9a8ab1c39970a4 Daniel Santos 2013-02-21  349  #define compiletime_assert(condition, msg) \
af9c5d2e3b3558 Vegard Nossum 2020-04-06 @350  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
9a8ab1c39970a4 Daniel Santos 2013-02-21  351  

:::::: The code at line 350 was first introduced by commit
:::::: af9c5d2e3b355854ff0e4acfbfbfadcd5198a349 compiler.h: fix error in BUILD_BUG_ON() reporting

:::::: TO: Vegard Nossum <vegard.nossum@oracle.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29343 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200421/0ff604c7/attachment-0001.bin>
