From: kernel test robot <lkp@intel.com>
Date: Thu, 20 Aug 2020 15:08:06 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 48/55]
 drivers/net/ethernet/intel/iecm/iecm_txrx.c:1370:12: error: 'struct
 iecm_tx_buf' has no member named 'dma'
Message-ID: <202008201502.rgrMIE38%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alice,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ecb4203e85ea61fef623f9df41b0a68285c48361
commit: f2f18999e1b409dfc9d24e539dff43a81501c81f [48/55] iecm: Add iecm to the kernel build system
config: i386-randconfig-a004-20200820 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        git checkout f2f18999e1b409dfc9d24e539dff43a81501c81f
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/net/intel/iecm.h:12,
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
   drivers/net/ethernet/intel/iecm/iecm_txrx.c: In function 'iecm_stash_flow_sch_buffers':
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:1370:12: error: 'struct iecm_tx_buf' has no member named 'dma'
    1370 |  shadow_buf->dma = tx_buf->dma;
         |            ^~
   drivers/net/ethernet/intel/iecm/iecm_txrx.c:1370:26: error: 'struct iecm_tx_buf' has no member named 'dma'
    1370 |  shadow_buf->dma = tx_buf->dma;
         |                          ^~
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:1371:12: error: 'struct iecm_tx_buf' has no member named 'len'
    1371 |  shadow_buf->len = tx_buf->len;
         |            ^~
   drivers/net/ethernet/intel/iecm/iecm_txrx.c:1371:26: error: 'struct iecm_tx_buf' has no member named 'len'
    1371 |  shadow_buf->len = tx_buf->len;
         |                          ^~

# https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=f2f18999e1b409dfc9d24e539dff43a81501c81f
git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git fetch --no-tags jkirsher-next-queue dev-queue
git checkout f2f18999e1b409dfc9d24e539dff43a81501c81f
vim +1370 drivers/net/ethernet/intel/iecm/iecm_txrx.c

98accafb2669bd Alice Michael 2020-08-14  1346  
98accafb2669bd Alice Michael 2020-08-14  1347  /**
98accafb2669bd Alice Michael 2020-08-14  1348   * iecm_stash_flow_sch_buffers - store buffere parameter info to be freed at a
98accafb2669bd Alice Michael 2020-08-14  1349   * later time (only relevant for flow scheduling mode)
98accafb2669bd Alice Michael 2020-08-14  1350   * @txq: Tx queue to clean
98accafb2669bd Alice Michael 2020-08-14  1351   * @tx_buf: buffer to store
98accafb2669bd Alice Michael 2020-08-14  1352   */
98accafb2669bd Alice Michael 2020-08-14  1353  static int
98accafb2669bd Alice Michael 2020-08-14  1354  iecm_stash_flow_sch_buffers(struct iecm_queue *txq, struct iecm_tx_buf *tx_buf)
98accafb2669bd Alice Michael 2020-08-14  1355  {
097c7f5e5f5e79 Alice Michael 2020-08-14  1356  	struct iecm_adapter *adapter = txq->vport->adapter;
097c7f5e5f5e79 Alice Michael 2020-08-14  1357  	struct iecm_tx_buf *shadow_buf;
097c7f5e5f5e79 Alice Michael 2020-08-14  1358  
097c7f5e5f5e79 Alice Michael 2020-08-14  1359  	shadow_buf = iecm_buf_lifo_pop(&txq->buf_stack);
097c7f5e5f5e79 Alice Michael 2020-08-14  1360  	if (!shadow_buf) {
097c7f5e5f5e79 Alice Michael 2020-08-14  1361  		dev_err(&adapter->pdev->dev,
097c7f5e5f5e79 Alice Michael 2020-08-14  1362  			"No out-of-order TX buffers left!\n");
097c7f5e5f5e79 Alice Michael 2020-08-14  1363  		return -ENOMEM;
097c7f5e5f5e79 Alice Michael 2020-08-14  1364  	}
097c7f5e5f5e79 Alice Michael 2020-08-14  1365  
097c7f5e5f5e79 Alice Michael 2020-08-14  1366  	/* Store buffer params in shadow buffer */
097c7f5e5f5e79 Alice Michael 2020-08-14  1367  	shadow_buf->skb = tx_buf->skb;
097c7f5e5f5e79 Alice Michael 2020-08-14  1368  	shadow_buf->bytecount = tx_buf->bytecount;
097c7f5e5f5e79 Alice Michael 2020-08-14  1369  	shadow_buf->gso_segs = tx_buf->gso_segs;
097c7f5e5f5e79 Alice Michael 2020-08-14 @1370  	shadow_buf->dma = tx_buf->dma;
097c7f5e5f5e79 Alice Michael 2020-08-14 @1371  	shadow_buf->len = tx_buf->len;
097c7f5e5f5e79 Alice Michael 2020-08-14  1372  	shadow_buf->compl_tag = tx_buf->compl_tag;
097c7f5e5f5e79 Alice Michael 2020-08-14  1373  
097c7f5e5f5e79 Alice Michael 2020-08-14  1374  	/* Add buffer to buf_hash table to be freed
097c7f5e5f5e79 Alice Michael 2020-08-14  1375  	 * later
097c7f5e5f5e79 Alice Michael 2020-08-14  1376  	 */
097c7f5e5f5e79 Alice Michael 2020-08-14  1377  	hash_add(txq->sched_buf_hash, &shadow_buf->hlist,
097c7f5e5f5e79 Alice Michael 2020-08-14  1378  		 shadow_buf->compl_tag);
097c7f5e5f5e79 Alice Michael 2020-08-14  1379  
097c7f5e5f5e79 Alice Michael 2020-08-14  1380  	memset(tx_buf, 0, sizeof(struct iecm_tx_buf));
097c7f5e5f5e79 Alice Michael 2020-08-14  1381  
097c7f5e5f5e79 Alice Michael 2020-08-14  1382  	return 0;
98accafb2669bd Alice Michael 2020-08-14  1383  }
98accafb2669bd Alice Michael 2020-08-14  1384  

:::::: The code at line 1370 was first introduced by commit
:::::: 097c7f5e5f5e7941b1ebd5ded4fd736aacd22b3d iecm: Add splitq TX/RX

:::::: TO: Alice Michael <alice.michael@intel.com>
:::::: CC: Tony Nguyen <anthony.l.nguyen@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34318 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200820/1f31d3a7/attachment-0001.bin>
