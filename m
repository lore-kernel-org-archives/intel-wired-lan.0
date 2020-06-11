From: kernel test robot <lkp@intel.com>
Date: Thu, 11 Jun 2020 16:59:42 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 24/55]
 drivers/net/ethernet/intel/iecm/iecm_txrx.c:2510:28: error: 'last_offset'
 undeclared; did you mean
Message-ID: <202006111637.20CqMGvm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alice,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   94e8b9f389d896ead02e9633104231fc864da9b0
commit: c819711bc82d7e96631d43f7c7c7a0e11fc8aad0 [24/55] iecm: Add iecm to the kernel build system
config: arc-allyesconfig (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c819711bc82d7e96631d43f7c7c7a0e11fc8aad0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

In file included from drivers/net/ethernet/intel/include/iecm.h:44,
from drivers/net/ethernet/intel/iecm/iecm_txrx.c:4:
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:809:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
809 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
809 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_get_capabilities);
|                               ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:891:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
891 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
891 | VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_txq_info_v2);
|                               ^~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:907:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
907 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
907 | VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_config_tx_queues);
|                               ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:937:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
937 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
937 | VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_rxq_info_v2);
|                               ^~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:952:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
952 | VIRTCHNL_CHECK_STRUCT_LEN(80, virtchnl_config_rx_queues);
|                               ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                    ^
include/linux/avf/virtchnl.h:1090:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
1090 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
| ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
1090 | VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rss_hash);
|                               ^~~~~~~~~~~~~~~~~
include/linux/avf/virtchnl.h:175:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
175 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
|                                                     ^
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

fdd2252e115282 Alice Michael 2020-05-18  2484  
fdd2252e115282 Alice Michael 2020-05-18  2485  /**
fdd2252e115282 Alice Michael 2020-05-18  2486   * iecm_rx_can_reuse_page - Determine if page can be reused for another rx
fdd2252e115282 Alice Michael 2020-05-18  2487   * @rx_buf: buffer containing the page
fdd2252e115282 Alice Michael 2020-05-18  2488   *
fdd2252e115282 Alice Michael 2020-05-18  2489   * If page is reusable, we have a green light for calling iecm_reuse_rx_page,
fdd2252e115282 Alice Michael 2020-05-18  2490   * which will assign the current buffer to the buffer that next_to_alloc is
fdd2252e115282 Alice Michael 2020-05-18  2491   * pointing to; otherwise, the dma mapping needs to be destroyed and
fdd2252e115282 Alice Michael 2020-05-18  2492   * page freed
fdd2252e115282 Alice Michael 2020-05-18  2493   */
fdd2252e115282 Alice Michael 2020-05-18  2494  static bool iecm_rx_can_reuse_page(struct iecm_rx_buf *rx_buf)
fdd2252e115282 Alice Michael 2020-05-18  2495  {
a97bc8562eabd9 Alice Michael 2020-05-18  2496  #if (PAGE_SIZE >= 8192)
a97bc8562eabd9 Alice Michael 2020-05-18  2497  #endif
a97bc8562eabd9 Alice Michael 2020-05-18  2498  	unsigned int pagecnt_bias = rx_buf->pagecnt_bias;
a97bc8562eabd9 Alice Michael 2020-05-18  2499  	struct page *page = rx_buf->page;
a97bc8562eabd9 Alice Michael 2020-05-18  2500  
a97bc8562eabd9 Alice Michael 2020-05-18  2501  	/* avoid re-using remote pages */
a97bc8562eabd9 Alice Michael 2020-05-18  2502  	if (unlikely(iecm_rx_page_is_reserved(page)))
a97bc8562eabd9 Alice Michael 2020-05-18  2503  		return false;
a97bc8562eabd9 Alice Michael 2020-05-18  2504  
a97bc8562eabd9 Alice Michael 2020-05-18  2505  #if (PAGE_SIZE < 8192)
a97bc8562eabd9 Alice Michael 2020-05-18  2506  	/* if we are only owner of page we can reuse it */
a97bc8562eabd9 Alice Michael 2020-05-18  2507  	if (unlikely((page_count(page) - pagecnt_bias) > 1))
a97bc8562eabd9 Alice Michael 2020-05-18  2508  		return false;
a97bc8562eabd9 Alice Michael 2020-05-18  2509  #else
a97bc8562eabd9 Alice Michael 2020-05-18 @2510  	if (rx_buf->page_offset > last_offset)
a97bc8562eabd9 Alice Michael 2020-05-18  2511  		return false;
a97bc8562eabd9 Alice Michael 2020-05-18  2512  #endif /* PAGE_SIZE < 8192) */
a97bc8562eabd9 Alice Michael 2020-05-18  2513  
a97bc8562eabd9 Alice Michael 2020-05-18  2514  	/* If we have drained the page fragment pool we need to update
a97bc8562eabd9 Alice Michael 2020-05-18  2515  	 * the pagecnt_bias and page count so that we fully restock the
a97bc8562eabd9 Alice Michael 2020-05-18  2516  	 * number of references the driver holds.
a97bc8562eabd9 Alice Michael 2020-05-18  2517  	 */
a97bc8562eabd9 Alice Michael 2020-05-18  2518  	if (unlikely(pagecnt_bias == 1)) {
a97bc8562eabd9 Alice Michael 2020-05-18  2519  		page_ref_add(page, USHRT_MAX - 1);
a97bc8562eabd9 Alice Michael 2020-05-18  2520  		rx_buf->pagecnt_bias = USHRT_MAX;
a97bc8562eabd9 Alice Michael 2020-05-18  2521  	}
a97bc8562eabd9 Alice Michael 2020-05-18  2522  
a97bc8562eabd9 Alice Michael 2020-05-18  2523  	return true;
fdd2252e115282 Alice Michael 2020-05-18  2524  }
fdd2252e115282 Alice Michael 2020-05-18  2525  

:::::: The code at line 2510 was first introduced by commit
:::::: a97bc8562eabd967fbf65cf4c21c2118599d8908 iecm: Add splitq TX/RX

:::::: TO: Alice Michael <alice.michael@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63920 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200611/a50797ae/attachment-0001.bin>
