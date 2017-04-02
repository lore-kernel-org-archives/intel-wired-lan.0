From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 2 Apr 2017 17:32:59 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 37/45]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2138:36: error: 'size'
 undeclared
Message-ID: <201704021755.hVHEtY9t%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   7c52efdf261ce43ee4c386e442d34c5fea06d9be
commit: 7902157f2a2a120f58d1367eb79ac1b003c74e38 [37/45] ixgbe: add XDP support for pass and drop actions
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7902157f2a2a120f58d1367eb79ac1b003c74e38
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   In file included from include/linux/cache.h:4:0,
                    from include/linux/printk.h:8,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:30:
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_build_skb':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2138:36: error: 'size' undeclared (first use in this function)
        SKB_DATA_ALIGN(IXGBE_SKB_PAD + size);
                                       ^
   include/uapi/linux/kernel.h:10:41: note: in definition of macro '__ALIGN_KERNEL_MASK'
    #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                            ^
   include/linux/kernel.h:49:22: note: in expansion of macro '__ALIGN_KERNEL'
    #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
                         ^~~~~~~~~~~~~~
   include/linux/skbuff.h:226:27: note: in expansion of macro 'ALIGN'
    #define SKB_DATA_ALIGN(X) ALIGN(X, SMP_CACHE_BYTES)
                              ^~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2138:5: note: in expansion of macro 'SKB_DATA_ALIGN'
        SKB_DATA_ALIGN(IXGBE_SKB_PAD + size);
        ^~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2138:36: note: each undeclared identifier is reported only once for each function it appears in
        SKB_DATA_ALIGN(IXGBE_SKB_PAD + size);
                                       ^
   include/uapi/linux/kernel.h:10:41: note: in definition of macro '__ALIGN_KERNEL_MASK'
    #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                            ^
   include/linux/kernel.h:49:22: note: in expansion of macro '__ALIGN_KERNEL'
    #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
                         ^~~~~~~~~~~~~~
   include/linux/skbuff.h:226:27: note: in expansion of macro 'ALIGN'
    #define SKB_DATA_ALIGN(X) ALIGN(X, SMP_CACHE_BYTES)
                              ^~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2138:5: note: in expansion of macro 'SKB_DATA_ALIGN'
        SKB_DATA_ALIGN(IXGBE_SKB_PAD + size);
        ^~~~~~~~~~~~~~
   In file included from arch/ia64/include/uapi/asm/intrinsics.h:21:0,
                    from arch/ia64/include/asm/intrinsics.h:10,
                    from arch/ia64/include/asm/bitops.h:18,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:30:
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_xdp_setup':
   arch/ia64/include/uapi/asm/cmpxchg.h:56:2: warning: value computed is not used [-Wunused-value]
    ((__typeof__(*(ptr))) __xchg((unsigned long) (x), (ptr), sizeof(*(ptr))))
    ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9564:3: note: in expansion of macro 'xchg'
      xchg(&adapter->rx_ring[i]->xdp_prog, adapter->xdp_prog);
      ^~~~

vim +/size +2138 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

7902157f John Fastabend  2017-03-29  2132  				       union ixgbe_adv_rx_desc *rx_desc)
6f429223 Alexander Duyck 2017-01-17  2133  {
6f429223 Alexander Duyck 2017-01-17  2134  #if (PAGE_SIZE < 8192)
6f429223 Alexander Duyck 2017-01-17  2135  	unsigned int truesize = ixgbe_rx_pg_size(rx_ring) / 2;
6f429223 Alexander Duyck 2017-01-17  2136  #else
6f429223 Alexander Duyck 2017-01-17  2137  	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
6f429223 Alexander Duyck 2017-01-17 @2138  				SKB_DATA_ALIGN(IXGBE_SKB_PAD + size);
6f429223 Alexander Duyck 2017-01-17  2139  #endif
6f429223 Alexander Duyck 2017-01-17  2140  	struct sk_buff *skb;
6f429223 Alexander Duyck 2017-01-17  2141  

:::::: The code at line 2138 was first introduced by commit
:::::: 6f429223b31c550b835b4f066ac034d0cf0cc71e ixgbe: Add support for build_skb

:::::: TO: Alexander Duyck <alexander.h.duyck@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46781 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170402/4c542f1d/attachment-0001.bin>
