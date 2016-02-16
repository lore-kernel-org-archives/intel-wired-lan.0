From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 16 Feb 2016 11:57:13 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 149/154]
 include/linux/compiler.h:501:38: error: call to '__compiletime_assert_487'
 declared with attribute error: BUILD_BUG_ON failed: idx !=
 FM10K_REGS_LEN_VSI
Message-ID: <201602161109.SwD9qJJG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   c72b5dfa8ce58dc105ed3b31fc7a44664cbbb62f
commit: cd2e5fc0d28f3c00900de884b3abafc68df49ca7 [149/154] fm10k: Avoid crashing the kernel
config: x86_64-allyesconfig (attached as .config)
reproduce:
        git checkout cd2e5fc0d28f3c00900de884b3abafc68df49ca7
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   In file included from include/linux/linkage.h:4:0,
                    from include/linux/preempt.h:9,
                    from include/linux/spinlock.h:50,
                    from include/linux/vmalloc.h:4,
                    from drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:21:
   drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c: In function 'fm10k_get_reg_vsi':
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_487' declared with attribute error: BUILD_BUG_ON failed: idx != FM10K_REGS_LEN_VSI
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^
   drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:487:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(idx != FM10K_REGS_LEN_VSI);
     ^

vim +/__compiletime_assert_487 +501 include/linux/compiler.h

9a8ab1c3 Daniel Santos  2013-02-21  495   *
9a8ab1c3 Daniel Santos  2013-02-21  496   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c3 Daniel Santos  2013-02-21  497   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c3 Daniel Santos  2013-02-21  498   * compiler has support to do so.
9a8ab1c3 Daniel Santos  2013-02-21  499   */
9a8ab1c3 Daniel Santos  2013-02-21  500  #define compiletime_assert(condition, msg) \
9a8ab1c3 Daniel Santos  2013-02-21 @501  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
9a8ab1c3 Daniel Santos  2013-02-21  502  
47933ad4 Peter Zijlstra 2013-11-06  503  #define compiletime_assert_atomic_type(t)				\
47933ad4 Peter Zijlstra 2013-11-06  504  	compiletime_assert(__native_word(t),				\

:::::: The code at line 501 was first introduced by commit
:::::: 9a8ab1c39970a4938a72d94e6fd13be88a797590 bug.h, compiler.h: introduce compiletime_assert & BUILD_BUG_ON_MSG

:::::: TO: Daniel Santos <daniel.santos@pobox.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 52453 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160216/7d224e01/attachment-0001.obj>
