From: kernel test robot <lkp@intel.com>
Date: Sat, 1 Aug 2020 22:09:46 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 1901/1959]
 include/linux/kernel.h:47:38: warning: division by zero
Message-ID: <202008012237.F1NJb2jD%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   9217a41c8ac7e1ca23399f9af7455f1085df9594
commit: 9466a1ccebbe54ac57fb8a89c2b4b854826546a8 [1901/1959] mptcp: enable JOIN requests even if cookies are in use
config: parisc-randconfig-c004-20200731 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9466a1ccebbe54ac57fb8a89c2b4b854826546a8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/skbuff.h:13,
                    from net/mptcp/syncookies.c:2:
   net/mptcp/syncookies.c: In function 'mptcp_join_cookie_init':
>> include/linux/kernel.h:47:38: warning: division by zero [-Wdiv-by-zero]
      47 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                      ^
   net/mptcp/syncookies.c:128:18: note: in expansion of macro 'ARRAY_SIZE'
     128 |  for (i = 0; i < ARRAY_SIZE(join_entry_locks); i++)
         |                  ^~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/skbuff.h:13,
                    from net/mptcp/syncookies.c:2:
>> include/linux/kernel.h:47:38: warning: division by zero [-Wdiv-by-zero]
      47 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                      ^
   include/linux/compiler.h:372:9: note: in definition of macro '__compiletime_assert'
     372 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler.h:392:2: note: in expansion of macro '_compiletime_assert'
     392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   net/mptcp/syncookies.c:131:2: note: in expansion of macro 'BUILD_BUG_ON'
     131 |  BUILD_BUG_ON(ARRAY_SIZE(join_entry_locks) != ARRAY_SIZE(join_entries));
         |  ^~~~~~~~~~~~
   net/mptcp/syncookies.c:131:15: note: in expansion of macro 'ARRAY_SIZE'
     131 |  BUILD_BUG_ON(ARRAY_SIZE(join_entry_locks) != ARRAY_SIZE(join_entries));
         |               ^~~~~~~~~~

vim +47 include/linux/kernel.h

d38499530e5f170 Christoph Hellwig 2016-11-01  42  
e8c97af0c1f23d6 Randy Dunlap      2017-10-13  43  /**
e8c97af0c1f23d6 Randy Dunlap      2017-10-13  44   * ARRAY_SIZE - get the number of elements in array @arr
e8c97af0c1f23d6 Randy Dunlap      2017-10-13  45   * @arr: array to be sized
e8c97af0c1f23d6 Randy Dunlap      2017-10-13  46   */
c5e631cf65f4d68 Rusty Russell     2007-05-06 @47  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
c5e631cf65f4d68 Rusty Russell     2007-05-06  48  

:::::: The code at line 47 was first introduced by commit
:::::: c5e631cf65f4d6875efcd571275436f2964a8b48 ARRAY_SIZE: check for type

:::::: TO: Rusty Russell <rusty@rustcorp.com.au>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27980 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200801/7b084499/attachment-0001.bin>
