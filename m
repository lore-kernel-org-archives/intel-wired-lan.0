From: kbuild test robot <lkp@intel.com>
Date: Mon, 1 Jun 2020 00:52:53 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 5/57]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2271:15: error: redefinition
 of 'truesize'
Message-ID: <202006010051.8EAhGnR3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   cf731225b28c18d6e612900febee69b61a395ed8
commit: a44c5f291928687775352aafa86ffb30304f8e66 [5/57] ixgbe: fix XDP redirect on archs with PAGE_SIZE above 4K
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a44c5f291928687775352aafa86ffb30304f8e66
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_rx_buffer_flip':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2271:15: error: redefinition of 'truesize'
2271 |  unsigned int truesize = ring_uses_build_skb(rx_ring) ?
|               ^~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2267:15: note: previous definition of 'truesize' was here
2267 |  unsigned int truesize = ixgbe_rx_frame_truesize(rx_ring, size);
|               ^~~~~~~~

vim +/truesize +2271 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  2262	
  2263	static void ixgbe_rx_buffer_flip(struct ixgbe_ring *rx_ring,
  2264					 struct ixgbe_rx_buffer *rx_buffer,
  2265					 unsigned int size)
  2266	{
  2267		unsigned int truesize = ixgbe_rx_frame_truesize(rx_ring, size);
  2268	#if (PAGE_SIZE < 8192)
  2269		rx_buffer->page_offset ^= truesize;
  2270	#else
> 2271		unsigned int truesize = ring_uses_build_skb(rx_ring) ?
  2272					SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) +
  2273					SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
  2274					SKB_DATA_ALIGN(size);
  2275	
  2276		rx_buffer->page_offset += truesize;
  2277	#endif
  2278	}
  2279	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57844 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200601/3b6482d0/attachment-0001.bin>
