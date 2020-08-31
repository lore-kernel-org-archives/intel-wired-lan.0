From: kernel test robot <lkp@intel.com>
Date: Tue, 1 Sep 2020 07:24:26 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 6/54]
 drivers/net/ethernet/intel/igb/igb_main.c:2881:6: warning: no previous
 prototype for 'igb_xdp_ring_update_tail'
Message-ID: <202009010722.IpJUqCHm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   6d046ecc1304263afa6f58b7617da6927a08fa72
commit: 614e8e50553041d02fbc50dbe192ea8df9399321 [6/54] igb: add XDP support
config: ia64-randconfig-r005-20200831 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 614e8e50553041d02fbc50dbe192ea8df9399321
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:154,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from include/linux/pagemap.h:8,
                    from drivers/net/ethernet/intel/igb/igb_main.c:11:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:137:41: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     137 |  unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c: At top level:
>> drivers/net/ethernet/intel/igb/igb_main.c:2881:6: warning: no previous prototype for 'igb_xdp_ring_update_tail' [-Wmissing-prototypes]
    2881 | void igb_xdp_ring_update_tail(struct igb_ring *ring)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~

# https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=614e8e50553041d02fbc50dbe192ea8df9399321
git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git fetch --no-tags jkirsher-next-queue dev-queue
git checkout 614e8e50553041d02fbc50dbe192ea8df9399321
vim +/igb_xdp_ring_update_tail +2881 drivers/net/ethernet/intel/igb/igb_main.c

  2880	
> 2881	void igb_xdp_ring_update_tail(struct igb_ring *ring)
  2882	{
  2883		/* Force memory writes to complete before letting h/w know there
  2884		 * are new descriptors to fetch.
  2885		 */
  2886		wmb();
  2887		writel(ring->next_to_use, ring->tail);
  2888	}
  2889	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30002 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200901/715e2660/attachment-0001.bin>
