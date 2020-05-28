From: kbuild test robot <lkp@intel.com>
Date: Thu, 28 May 2020 16:13:00 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 90/101]
 drivers/net/ethernet/intel/iecm/iecm_lib.c:77:5: warning: no previous
 prototype for 'iecm_mb_intr_req_irq'
Message-ID: <202005281656.uPOtqWot%lkp@intel.com>
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
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout eb8cbcf9f9254a97825dcb478a8c73d86040117b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

drivers/net/ethernet/intel/iecm/iecm_lib.c:49:13: warning: no previous prototype for 'iecm_mb_intr_clean' [-Wmissing-prototypes]
49 | irqreturn_t iecm_mb_intr_clean(int __always_unused irq, void *data)
|             ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_lib.c:63:6: warning: no previous prototype for 'iecm_mb_irq_enable' [-Wmissing-prototypes]
63 | void iecm_mb_irq_enable(struct iecm_adapter *adapter)
|      ^~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:77:5: warning: no previous prototype for 'iecm_mb_intr_req_irq' [-Wmissing-prototypes]
77 | int iecm_mb_intr_req_irq(struct iecm_adapter *adapter)
|     ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_lib.c:104:6: warning: no previous prototype for 'iecm_get_mb_vec_id' [-Wmissing-prototypes]
104 | void iecm_get_mb_vec_id(struct iecm_adapter *adapter)
|      ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_lib.c:122:5: warning: no previous prototype for 'iecm_mb_intr_init' [-Wmissing-prototypes]
122 | int iecm_mb_intr_init(struct iecm_adapter *adapter)
|     ^~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_lib.c:140:6: warning: no previous prototype for 'iecm_intr_distribute' [-Wmissing-prototypes]
140 | void iecm_intr_distribute(struct iecm_adapter *adapter)
|      ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_lib.c:417:5: warning: no previous prototype for 'iecm_vport_rel' [-Wmissing-prototypes]
417 | int iecm_vport_rel(struct iecm_vport *vport)
|     ^~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_lib.c:748:6: warning: no previous prototype for 'iecm_deinit_task' [-Wmissing-prototypes]
748 | void iecm_deinit_task(struct iecm_adapter *adapter)
|      ^~~~~~~~~~~~~~~~
In file included from drivers/net/ethernet/intel/include/iecm.h:50,
from drivers/net/ethernet/intel/iecm/iecm_lib.c:6:
drivers/net/ethernet/intel/include/iecm_txrx.h:293:30: warning: 'iecm_rx_ptype_lkup' defined but not used [-Wunused-const-variable=]
293 | struct iecm_rx_ptype_decoded iecm_rx_ptype_lkup[IECM_RX_SUPP_PTYPE] = {
|                              ^~~~~~~~~~~~~~~~~~
--
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:84:6: warning: no previous prototype for 'iecm_tx_buf_rel_all' [-Wmissing-prototypes]
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
drivers/net/ethernet/intel/iecm/iecm_txrx.c:2510:28: error: 'last_offset' undeclared (first use in this function); did you mean 'page_offset'?
2510 |  if (rx_buf->page_offset > last_offset)
|                            ^~~~~~~~~~~
|                            page_offset
drivers/net/ethernet/intel/iecm/iecm_txrx.c:2510:28: note: each undeclared identifier is reported only once for each function it appears in
drivers/net/ethernet/intel/iecm/iecm_txrx.c: At top level:
drivers/net/ethernet/intel/iecm/iecm_txrx.c:3565:5: warning: no previous prototype for 'iecm_vport_splitq_napi_poll' [-Wmissing-prototypes]
3565 | int iecm_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
|     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:3603:6: warning: no previous prototype for 'iecm_vport_intr_map_vector_to_qs' [-Wmissing-prototypes]
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

vim +/iecm_mb_intr_req_irq +77 drivers/net/ethernet/intel/iecm/iecm_lib.c

d9fbe2c8b917f0 Alice Michael 2020-05-18  72  
d9fbe2c8b917f0 Alice Michael 2020-05-18  73  /**
d9fbe2c8b917f0 Alice Michael 2020-05-18  74   * iecm_mb_intr_req_irq - Request irq for the mailbox interrupt
d9fbe2c8b917f0 Alice Michael 2020-05-18  75   * @adapter: adapter structure to pass to the mailbox irq handler
d9fbe2c8b917f0 Alice Michael 2020-05-18  76   */
d9fbe2c8b917f0 Alice Michael 2020-05-18 @77  int iecm_mb_intr_req_irq(struct iecm_adapter *adapter)
d9fbe2c8b917f0 Alice Michael 2020-05-18  78  {
39faec629b99d7 Alice Michael 2020-05-18  79  	struct iecm_q_vector *mb_vector = &adapter->mb_vector;
39faec629b99d7 Alice Michael 2020-05-18  80  	int irq_num, mb_vidx = 0, err;
39faec629b99d7 Alice Michael 2020-05-18  81  
39faec629b99d7 Alice Michael 2020-05-18  82  	irq_num = adapter->msix_entries[mb_vidx].vector;
39faec629b99d7 Alice Michael 2020-05-18  83  	snprintf(mb_vector->name, sizeof(mb_vector->name) - 1,
39faec629b99d7 Alice Michael 2020-05-18  84  		 "%s-%s-%d", dev_driver_string(&adapter->pdev->dev),
39faec629b99d7 Alice Michael 2020-05-18  85  		 "Mailbox", mb_vidx);
39faec629b99d7 Alice Michael 2020-05-18  86  	err = request_irq(irq_num, adapter->irq_mb_handler, 0,
39faec629b99d7 Alice Michael 2020-05-18  87  			  mb_vector->name, adapter);
39faec629b99d7 Alice Michael 2020-05-18  88  	if (err) {
39faec629b99d7 Alice Michael 2020-05-18  89  		dev_err(&adapter->pdev->dev,
39faec629b99d7 Alice Michael 2020-05-18  90  			"Request_irq for mailbox failed, error: %d\n", err);
39faec629b99d7 Alice Michael 2020-05-18  91  		return err;
39faec629b99d7 Alice Michael 2020-05-18  92  	}
39faec629b99d7 Alice Michael 2020-05-18  93  	set_bit(__IECM_MB_INTR_MODE, adapter->flags);
39faec629b99d7 Alice Michael 2020-05-18  94  	return 0;
d9fbe2c8b917f0 Alice Michael 2020-05-18  95  }
d9fbe2c8b917f0 Alice Michael 2020-05-18  96  

:::::: The code at line 77 was first introduced by commit
:::::: d9fbe2c8b917f0a521c0b5c337ffbfc4742b6ae5 iecm: Common module introduction and function stubs

:::::: TO: Alice Michael <alice.michael@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62523 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200528/ab602cee/attachment-0001.bin>
