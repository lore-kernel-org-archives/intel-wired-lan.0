From: kernel test robot <lkp@intel.com>
Date: Wed, 15 Jul 2020 11:46:10 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 91/92]
 drivers/net/ethernet/intel/iecm/iecm_txrx.c:2462:28: error: 'last_offset'
 undeclared; did you mean
Message-ID: <202007151108.n5Zape6H%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alice,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   0499ed813d995f0a1b97e5e59ff7fd864d8ffb62
commit: ac1fe751555b417952104c2a5f09592c0348c40d [91/92] iecm: Add iecm to the kernel build system
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ac1fe751555b417952104c2a5f09592c0348c40d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/iecm/iecm_txrx.c: In function 'iecm_rx_can_reuse_page':
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:2462:28: error: 'last_offset' undeclared (first use in this function); did you mean 'page_offset'?
    2462 |  if (rx_buf->page_offset > last_offset)
         |                            ^~~~~~~~~~~
         |                            page_offset
   drivers/net/ethernet/intel/iecm/iecm_txrx.c:2462:28: note: each undeclared identifier is reported only once for each function it appears in

vim +2462 drivers/net/ethernet/intel/iecm/iecm_txrx.c

2158dc66f3a92d Alice Michael 2020-07-14  2436  
2158dc66f3a92d Alice Michael 2020-07-14  2437  /**
2158dc66f3a92d Alice Michael 2020-07-14  2438   * iecm_rx_can_reuse_page - Determine if page can be reused for another Rx
2158dc66f3a92d Alice Michael 2020-07-14  2439   * @rx_buf: buffer containing the page
2158dc66f3a92d Alice Michael 2020-07-14  2440   *
2158dc66f3a92d Alice Michael 2020-07-14  2441   * If page is reusable, we have a green light for calling iecm_reuse_rx_page,
2158dc66f3a92d Alice Michael 2020-07-14  2442   * which will assign the current buffer to the buffer that next_to_alloc is
2158dc66f3a92d Alice Michael 2020-07-14  2443   * pointing to; otherwise, the DMA mapping needs to be destroyed and
2158dc66f3a92d Alice Michael 2020-07-14  2444   * page freed
2158dc66f3a92d Alice Michael 2020-07-14  2445   */
2158dc66f3a92d Alice Michael 2020-07-14  2446  static bool iecm_rx_can_reuse_page(struct iecm_rx_buf *rx_buf)
2158dc66f3a92d Alice Michael 2020-07-14  2447  {
8aa91340983bdc Alice Michael 2020-07-14  2448  #if (PAGE_SIZE >= 8192)
8aa91340983bdc Alice Michael 2020-07-14  2449  #endif
8aa91340983bdc Alice Michael 2020-07-14  2450  	unsigned int pagecnt_bias = rx_buf->pagecnt_bias;
8aa91340983bdc Alice Michael 2020-07-14  2451  	struct page *page = rx_buf->page;
8aa91340983bdc Alice Michael 2020-07-14  2452  
8aa91340983bdc Alice Michael 2020-07-14  2453  	/* avoid re-using remote pages */
8aa91340983bdc Alice Michael 2020-07-14  2454  	if (unlikely(iecm_rx_page_is_reserved(page)))
8aa91340983bdc Alice Michael 2020-07-14  2455  		return false;
8aa91340983bdc Alice Michael 2020-07-14  2456  
8aa91340983bdc Alice Michael 2020-07-14  2457  #if (PAGE_SIZE < 8192)
8aa91340983bdc Alice Michael 2020-07-14  2458  	/* if we are only owner of page we can reuse it */
8aa91340983bdc Alice Michael 2020-07-14  2459  	if (unlikely((page_count(page) - pagecnt_bias) > 1))
8aa91340983bdc Alice Michael 2020-07-14  2460  		return false;
8aa91340983bdc Alice Michael 2020-07-14  2461  #else
8aa91340983bdc Alice Michael 2020-07-14 @2462  	if (rx_buf->page_offset > last_offset)
8aa91340983bdc Alice Michael 2020-07-14  2463  		return false;
8aa91340983bdc Alice Michael 2020-07-14  2464  #endif /* PAGE_SIZE < 8192) */
8aa91340983bdc Alice Michael 2020-07-14  2465  
8aa91340983bdc Alice Michael 2020-07-14  2466  	/* If we have drained the page fragment pool we need to update
8aa91340983bdc Alice Michael 2020-07-14  2467  	 * the pagecnt_bias and page count so that we fully restock the
8aa91340983bdc Alice Michael 2020-07-14  2468  	 * number of references the driver holds.
8aa91340983bdc Alice Michael 2020-07-14  2469  	 */
8aa91340983bdc Alice Michael 2020-07-14  2470  	if (unlikely(pagecnt_bias == 1)) {
8aa91340983bdc Alice Michael 2020-07-14  2471  		page_ref_add(page, USHRT_MAX - 1);
8aa91340983bdc Alice Michael 2020-07-14  2472  		rx_buf->pagecnt_bias = USHRT_MAX;
8aa91340983bdc Alice Michael 2020-07-14  2473  	}
8aa91340983bdc Alice Michael 2020-07-14  2474  
8aa91340983bdc Alice Michael 2020-07-14  2475  	return true;
2158dc66f3a92d Alice Michael 2020-07-14  2476  }
2158dc66f3a92d Alice Michael 2020-07-14  2477  

:::::: The code at line 2462 was first introduced by commit
:::::: 8aa91340983bdcd6861be0aad259c5b1d14584fb iecm: Add splitq TX/RX

:::::: TO: Alice Michael <alice.michael@intel.com>
:::::: CC: Tony Nguyen <anthony.l.nguyen@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65067 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200715/734f635c/attachment-0001.bin>
