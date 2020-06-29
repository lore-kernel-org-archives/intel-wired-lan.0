From: kernel test robot <lkp@intel.com>
Date: Tue, 30 Jun 2020 03:30:13 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 48/53]
 drivers/net/ethernet/intel/iecm/iecm_txrx.c:2508:28: error: 'last_offset'
 undeclared; did you mean
Message-ID: <202006300308.bNpC5DFy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alice,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   b072950db9f903b6ce6b5cf02a173ca59f6b7035
commit: 6b1a2c323715552596acb22c5c0273ea039ffe73 [48/53] iecm: Add iecm to the kernel build system
config: sparc-allyesconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6b1a2c323715552596acb22c5c0273ea039ffe73
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sparc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/iecm/iecm_txrx.c: In function 'iecm_rx_can_reuse_page':
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:2508:28: error: 'last_offset' undeclared (first use in this function); did you mean 'page_offset'?
    2508 |  if (rx_buf->page_offset > last_offset)
         |                            ^~~~~~~~~~~
         |                            page_offset
   drivers/net/ethernet/intel/iecm/iecm_txrx.c:2508:28: note: each undeclared identifier is reported only once for each function it appears in

vim +2508 drivers/net/ethernet/intel/iecm/iecm_txrx.c

07a2bfb6d36ed7 Alice Michael 2020-06-23  2482  
07a2bfb6d36ed7 Alice Michael 2020-06-23  2483  /**
07a2bfb6d36ed7 Alice Michael 2020-06-23  2484   * iecm_rx_can_reuse_page - Determine if page can be reused for another Rx
07a2bfb6d36ed7 Alice Michael 2020-06-23  2485   * @rx_buf: buffer containing the page
07a2bfb6d36ed7 Alice Michael 2020-06-23  2486   *
07a2bfb6d36ed7 Alice Michael 2020-06-23  2487   * If page is reusable, we have a green light for calling iecm_reuse_rx_page,
07a2bfb6d36ed7 Alice Michael 2020-06-23  2488   * which will assign the current buffer to the buffer that next_to_alloc is
07a2bfb6d36ed7 Alice Michael 2020-06-23  2489   * pointing to; otherwise, the DMA mapping needs to be destroyed and
07a2bfb6d36ed7 Alice Michael 2020-06-23  2490   * page freed
07a2bfb6d36ed7 Alice Michael 2020-06-23  2491   */
07a2bfb6d36ed7 Alice Michael 2020-06-23  2492  static bool iecm_rx_can_reuse_page(struct iecm_rx_buf *rx_buf)
07a2bfb6d36ed7 Alice Michael 2020-06-23  2493  {
f6511742f0b8dc Alice Michael 2020-06-23  2494  #if (PAGE_SIZE >= 8192)
f6511742f0b8dc Alice Michael 2020-06-23  2495  #endif
f6511742f0b8dc Alice Michael 2020-06-23  2496  	unsigned int pagecnt_bias = rx_buf->pagecnt_bias;
f6511742f0b8dc Alice Michael 2020-06-23  2497  	struct page *page = rx_buf->page;
f6511742f0b8dc Alice Michael 2020-06-23  2498  
f6511742f0b8dc Alice Michael 2020-06-23  2499  	/* avoid re-using remote pages */
f6511742f0b8dc Alice Michael 2020-06-23  2500  	if (unlikely(iecm_rx_page_is_reserved(page)))
f6511742f0b8dc Alice Michael 2020-06-23  2501  		return false;
f6511742f0b8dc Alice Michael 2020-06-23  2502  
f6511742f0b8dc Alice Michael 2020-06-23  2503  #if (PAGE_SIZE < 8192)
f6511742f0b8dc Alice Michael 2020-06-23  2504  	/* if we are only owner of page we can reuse it */
f6511742f0b8dc Alice Michael 2020-06-23  2505  	if (unlikely((page_count(page) - pagecnt_bias) > 1))
f6511742f0b8dc Alice Michael 2020-06-23  2506  		return false;
f6511742f0b8dc Alice Michael 2020-06-23  2507  #else
f6511742f0b8dc Alice Michael 2020-06-23 @2508  	if (rx_buf->page_offset > last_offset)
f6511742f0b8dc Alice Michael 2020-06-23  2509  		return false;
f6511742f0b8dc Alice Michael 2020-06-23  2510  #endif /* PAGE_SIZE < 8192) */
f6511742f0b8dc Alice Michael 2020-06-23  2511  
f6511742f0b8dc Alice Michael 2020-06-23  2512  	/* If we have drained the page fragment pool we need to update
f6511742f0b8dc Alice Michael 2020-06-23  2513  	 * the pagecnt_bias and page count so that we fully restock the
f6511742f0b8dc Alice Michael 2020-06-23  2514  	 * number of references the driver holds.
f6511742f0b8dc Alice Michael 2020-06-23  2515  	 */
f6511742f0b8dc Alice Michael 2020-06-23  2516  	if (unlikely(pagecnt_bias == 1)) {
f6511742f0b8dc Alice Michael 2020-06-23  2517  		page_ref_add(page, USHRT_MAX - 1);
f6511742f0b8dc Alice Michael 2020-06-23  2518  		rx_buf->pagecnt_bias = USHRT_MAX;
f6511742f0b8dc Alice Michael 2020-06-23  2519  	}
f6511742f0b8dc Alice Michael 2020-06-23  2520  
f6511742f0b8dc Alice Michael 2020-06-23  2521  	return true;
07a2bfb6d36ed7 Alice Michael 2020-06-23  2522  }
07a2bfb6d36ed7 Alice Michael 2020-06-23  2523  

:::::: The code at line 2508 was first introduced by commit
:::::: f6511742f0b8dc9229b1014791e5727e8b74d5d4 iecm: Add splitq TX/RX

:::::: TO: Alice Michael <alice.michael@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66232 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200630/8fa7687f/attachment-0001.bin>
