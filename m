From: kernel test robot <lkp@intel.com>
Date: Fri, 11 Sep 2020 19:52:29 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 4/72]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2264:15: error: redefinition
 of 'truesize'
Message-ID: <202009111925.OzYDwJvg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   68e2960f0dff2cf6dbc4db26539990b286631bde
commit: d181ca300c59d80ca58397a9e23f21f71ce121ff [4/72] ixgbe: fix XDP redirect on archs with PAGE_SIZE above 4K
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d181ca300c59d80ca58397a9e23f21f71ce121ff
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_rx_buffer_flip':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2264:15: error: redefinition of 'truesize'
    2264 |  unsigned int truesize = ring_uses_build_skb(rx_ring) ?
         |               ^~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2260:15: note: previous definition of 'truesize' was here
    2260 |  unsigned int truesize = ixgbe_rx_frame_truesize(rx_ring, size);
         |               ^~~~~~~~

# https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=d181ca300c59d80ca58397a9e23f21f71ce121ff
git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git fetch --no-tags jkirsher-next-queue dev-queue
git checkout d181ca300c59d80ca58397a9e23f21f71ce121ff
vim +/truesize +2264 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  2255	
  2256	static void ixgbe_rx_buffer_flip(struct ixgbe_ring *rx_ring,
  2257					 struct ixgbe_rx_buffer *rx_buffer,
  2258					 unsigned int size)
  2259	{
  2260		unsigned int truesize = ixgbe_rx_frame_truesize(rx_ring, size);
  2261	#if (PAGE_SIZE < 8192)
  2262		rx_buffer->page_offset ^= truesize;
  2263	#else
> 2264		unsigned int truesize = ring_uses_build_skb(rx_ring) ?
  2265					SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) +
  2266					SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
  2267					SKB_DATA_ALIGN(size);
  2268	
  2269		rx_buffer->page_offset += truesize;
  2270	#endif
  2271	}
  2272	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61674 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200911/eb1e1a27/attachment-0001.bin>
