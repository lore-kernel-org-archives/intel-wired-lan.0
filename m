From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 17 Apr 2017 07:45:21 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 29/50]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2138:36: error: 'size'
 undeclared
Message-ID: <201704170719.afRiPX1o%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   d1a889819a33af9fc4367b1e689d3f18208ba5e5
commit: 7c8cbc64cbf13425c13f55ba648fadeac8132200 [29/50] ixgbe: add XDP support for pass and drop actions
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7c8cbc64cbf13425c13f55ba648fadeac8132200
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

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

vim +/size +2138 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

7c8cbc64 John Fastabend  2017-04-12  2132  				       union ixgbe_adv_rx_desc *rx_desc)
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
Size: 23158 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170417/1590b340/attachment-0001.bin>
