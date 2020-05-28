From: kbuild test robot <lkp@intel.com>
Date: Thu, 28 May 2020 15:40:15 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 90/101]
 drivers/net/ethernet/intel/iecm/iecm_txrx.c:2510:28: error: 'last_offset'
 undeclared; did you mean 'page_offset'?
Message-ID: <202005281511.yBhUfDaN%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alice,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   3ef27f2497f6408f432049c5d117d425048ae1e7
commit: eb8cbcf9f9254a97825dcb478a8c73d86040117b [90/101] iecm: Add iecm to the kernel build system
config: sparc-allyesconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout eb8cbcf9f9254a97825dcb478a8c73d86040117b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sparc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

drivers/net/ethernet/intel/iecm/iecm_txrx.c:84:6: warning: no previous prototype for 'iecm_tx_buf_rel_all' [-Wmissing-prototypes]
84 | void iecm_tx_buf_rel_all(struct iecm_queue *txq)
|      ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:115:6: warning: no previous prototype for 'iecm_tx_desc_rel' [-Wmissing-prototypes]
115 | void iecm_tx_desc_rel(struct iecm_queue *txq, bool bufq)
|      ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:136:6: warning: no previous prototype for 'iecm_tx_desc_rel_all' [-Wmissing-prototypes]
136 | void iecm_tx_desc_rel_all(struct iecm_vport *vport)
|      ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:312:6: warning: no previous prototype for 'iecm_rx_buf_rel_all' [-Wmissing-prototypes]
312 | void iecm_rx_buf_rel_all(struct iecm_queue *rxq)
|      ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:341:6: warning: no previous prototype for 'iecm_rx_desc_rel' [-Wmissing-prototypes]
341 | void iecm_rx_desc_rel(struct iecm_queue *rxq, bool bufq,
|      ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:371:6: warning: no previous prototype for 'iecm_rx_desc_rel_all' [-Wmissing-prototypes]
371 | void iecm_rx_desc_rel_all(struct iecm_vport *vport)
|      ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:486:6: warning: no previous prototype for 'iecm_rx_hdr_buf_hw_alloc' [-Wmissing-prototypes]
486 | bool iecm_rx_hdr_buf_hw_alloc(struct iecm_queue *rxq,
|      ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c: In function 'iecm_rx_can_reuse_page':
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:2510:28: error: 'last_offset' undeclared (first use in this function); did you mean 'page_offset'?
2510 |  if (rx_buf->page_offset > last_offset)
|                            ^~~~~~~~~~~
|                            page_offset
drivers/net/ethernet/intel/iecm/iecm_txrx.c:2510:28: note: each undeclared identifier is reported only once for each function it appears in
drivers/net/ethernet/intel/iecm/iecm_txrx.c: At top level:
drivers/net/ethernet/intel/iecm/iecm_txrx.c:3565:5: warning: no previous prototype for 'iecm_vport_splitq_napi_poll' [-Wmissing-prototypes]
3565 | int iecm_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
|     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:3603:6: warning: no previous prototype for 'iecm_vport_intr_map_vector_to_qs' [-Wmissing-prototypes]
3603 | void iecm_vport_intr_map_vector_to_qs(struct iecm_vport *vport)
|      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:3715:5: warning: no previous prototype for 'iecm_vport_intr_alloc' [-Wmissing-prototypes]
3715 | int iecm_vport_intr_alloc(struct iecm_vport *vport)
|     ^~~~~~~~~~~~~~~~~~~~~
In file included from drivers/net/ethernet/intel/include/iecm.h:50,
from drivers/net/ethernet/intel/iecm/iecm_txrx.c:4:
drivers/net/ethernet/intel/include/iecm_txrx.h:293:30: warning: 'iecm_rx_ptype_lkup' defined but not used [-Wunused-const-variable=]
293 | struct iecm_rx_ptype_decoded iecm_rx_ptype_lkup[IECM_RX_SUPP_PTYPE] = {
|                              ^~~~~~~~~~~~~~~~~~

vim +2510 drivers/net/ethernet/intel/iecm/iecm_txrx.c

d9fbe2c8b917f0 Alice Michael 2020-05-18  2484  
d9fbe2c8b917f0 Alice Michael 2020-05-18  2485  /**
d9fbe2c8b917f0 Alice Michael 2020-05-18  2486   * iecm_rx_can_reuse_page - Determine if page can be reused for another rx
d9fbe2c8b917f0 Alice Michael 2020-05-18  2487   * @rx_buf: buffer containing the page
d9fbe2c8b917f0 Alice Michael 2020-05-18  2488   *
d9fbe2c8b917f0 Alice Michael 2020-05-18  2489   * If page is reusable, we have a green light for calling iecm_reuse_rx_page,
d9fbe2c8b917f0 Alice Michael 2020-05-18  2490   * which will assign the current buffer to the buffer that next_to_alloc is
d9fbe2c8b917f0 Alice Michael 2020-05-18  2491   * pointing to; otherwise, the dma mapping needs to be destroyed and
d9fbe2c8b917f0 Alice Michael 2020-05-18  2492   * page freed
d9fbe2c8b917f0 Alice Michael 2020-05-18  2493   */
d9fbe2c8b917f0 Alice Michael 2020-05-18  2494  static bool iecm_rx_can_reuse_page(struct iecm_rx_buf *rx_buf)
d9fbe2c8b917f0 Alice Michael 2020-05-18  2495  {
f51d60213bad7f Alice Michael 2020-05-18  2496  #if (PAGE_SIZE >= 8192)
f51d60213bad7f Alice Michael 2020-05-18  2497  #endif
f51d60213bad7f Alice Michael 2020-05-18  2498  	unsigned int pagecnt_bias = rx_buf->pagecnt_bias;
f51d60213bad7f Alice Michael 2020-05-18  2499  	struct page *page = rx_buf->page;
f51d60213bad7f Alice Michael 2020-05-18  2500  
f51d60213bad7f Alice Michael 2020-05-18  2501  	/* avoid re-using remote pages */
f51d60213bad7f Alice Michael 2020-05-18  2502  	if (unlikely(iecm_rx_page_is_reserved(page)))
f51d60213bad7f Alice Michael 2020-05-18  2503  		return false;
f51d60213bad7f Alice Michael 2020-05-18  2504  
f51d60213bad7f Alice Michael 2020-05-18  2505  #if (PAGE_SIZE < 8192)
f51d60213bad7f Alice Michael 2020-05-18  2506  	/* if we are only owner of page we can reuse it */
f51d60213bad7f Alice Michael 2020-05-18  2507  	if (unlikely((page_count(page) - pagecnt_bias) > 1))
f51d60213bad7f Alice Michael 2020-05-18  2508  		return false;
f51d60213bad7f Alice Michael 2020-05-18  2509  #else
f51d60213bad7f Alice Michael 2020-05-18 @2510  	if (rx_buf->page_offset > last_offset)
f51d60213bad7f Alice Michael 2020-05-18  2511  		return false;
f51d60213bad7f Alice Michael 2020-05-18  2512  #endif /* PAGE_SIZE < 8192) */
f51d60213bad7f Alice Michael 2020-05-18  2513  
f51d60213bad7f Alice Michael 2020-05-18  2514  	/* If we have drained the page fragment pool we need to update
f51d60213bad7f Alice Michael 2020-05-18  2515  	 * the pagecnt_bias and page count so that we fully restock the
f51d60213bad7f Alice Michael 2020-05-18  2516  	 * number of references the driver holds.
f51d60213bad7f Alice Michael 2020-05-18  2517  	 */
f51d60213bad7f Alice Michael 2020-05-18  2518  	if (unlikely(pagecnt_bias == 1)) {
f51d60213bad7f Alice Michael 2020-05-18  2519  		page_ref_add(page, USHRT_MAX - 1);
f51d60213bad7f Alice Michael 2020-05-18  2520  		rx_buf->pagecnt_bias = USHRT_MAX;
f51d60213bad7f Alice Michael 2020-05-18  2521  	}
f51d60213bad7f Alice Michael 2020-05-18  2522  
f51d60213bad7f Alice Michael 2020-05-18  2523  	return true;
d9fbe2c8b917f0 Alice Michael 2020-05-18  2524  }
d9fbe2c8b917f0 Alice Michael 2020-05-18  2525  

:::::: The code at line 2510 was first introduced by commit
:::::: f51d60213bad7f31d66dcda23af2155aeb4e5f7a iecm: Add splitq TX/RX

:::::: TO: Alice Michael <alice.michael@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62522 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200528/d4b49679/attachment-0001.bin>
