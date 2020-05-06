From: kbuild test robot <lkp@intel.com>
Date: Thu, 7 May 2020 06:55:52 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 20/75]
 include/linux/compiler.h:350:38: error: call to '__compiletime_assert_89'
 declared with attribute error: FIELD_PREP: value too large for the field
Message-ID: <202005070630.rsYcANGj%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a35c1231e94520ae1e5227055bc90cc814f893bd
commit: f6c86c7a09ffa5d7cc31fb62be307016c1802031 [20/75] gwdpa: gswip: Introduce Gigabit Ethernet Switch (GSWIP) device driver
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f6c86c7a09ffa5d7cc31fb62be307016c1802031
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/bitfield.h:10,
                    from drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:4:
   In function 'get_2G5_intf',
       inlined from 'mac_get_mii_interface' at drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:335:10:
>> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_89' declared with attribute error: FIELD_PREP: value too large for the field
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
   drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:258:10: note: in expansion of macro 'FIELD_PREP'
     258 |  macif = FIELD_PREP(MAC_IF_CFG_CFG2G5, mac_if_cfg);
         |          ^~~~~~~~~~
   drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c: In function 'get_2G5_intf':
>> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_89' declared with attribute error: FIELD_PREP: value too large for the field
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
   drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:258:10: note: in expansion of macro 'FIELD_PREP'
     258 |  macif = FIELD_PREP(MAC_IF_CFG_CFG2G5, mac_if_cfg);
         |          ^~~~~~~~~~

vim +/__compiletime_assert_89 +350 include/linux/compiler.h

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
Size: 66063 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200507/ca021fb3/attachment-0001.bin>
