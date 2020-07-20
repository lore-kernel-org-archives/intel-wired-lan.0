From: kernel test robot <lkp@intel.com>
Date: Mon, 20 Jul 2020 13:00:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 4/98]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2269:15: error: redefinition
 of 'truesize'
Message-ID: <202007201338.M8Cx1gOu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ad6bec45756329c9f9bfe97f015a89fc68479391
commit: eba152543daeea51dfc43363fd8b2e2ba9b8b7c6 [4/98] ixgbe: fix XDP redirect on archs with PAGE_SIZE above 4K
config: sparc-allyesconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout eba152543daeea51dfc43363fd8b2e2ba9b8b7c6
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sparc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_rx_buffer_flip':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2269:15: error: redefinition of 'truesize'
    2269 |  unsigned int truesize = ring_uses_build_skb(rx_ring) ?
         |               ^~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2265:15: note: previous definition of 'truesize' was here
    2265 |  unsigned int truesize = ixgbe_rx_frame_truesize(rx_ring, size);
         |               ^~~~~~~~

vim +/truesize +2269 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  2260	
  2261	static void ixgbe_rx_buffer_flip(struct ixgbe_ring *rx_ring,
  2262					 struct ixgbe_rx_buffer *rx_buffer,
  2263					 unsigned int size)
  2264	{
  2265		unsigned int truesize = ixgbe_rx_frame_truesize(rx_ring, size);
  2266	#if (PAGE_SIZE < 8192)
  2267		rx_buffer->page_offset ^= truesize;
  2268	#else
> 2269		unsigned int truesize = ring_uses_build_skb(rx_ring) ?
  2270					SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) +
  2271					SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
  2272					SKB_DATA_ALIGN(size);
  2273	
  2274		rx_buffer->page_offset += truesize;
  2275	#endif
  2276	}
  2277	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66267 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200720/6a4a7059/attachment-0001.bin>
