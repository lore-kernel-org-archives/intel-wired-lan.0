From: kbuild test robot <lkp@intel.com>
Date: Sat, 30 May 2020 17:20:53 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 62/73]
 drivers/net/ethernet/intel/iecm/iecm_lib.c:77:5: warning: no previous
 prototype for 'iecm_mb_intr_req_irq'
Message-ID: <202005301749.MOhTtTtb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alice,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   4b1ba063a5a5cf9c533aa0b2ca8a423df159773e
commit: 57168068502344f572f6d8e3c916922780241a76 [62/73] iecm: Add iecm to the kernel build system
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 57168068502344f572f6d8e3c916922780241a76
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=xtensa 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

In file included from include/linux/build_bug.h:5,
from include/linux/bits.h:23,
from include/linux/bitops.h:5,
from include/linux/bitmap.h:8,
from drivers/net/ethernet/intel/include/iecm.h:8,
from drivers/net/ethernet/intel/iecm/iecm_lib.c:6:
include/linux/scatterlist.h: In function 'sg_set_buf':
arch/xtensa/include/asm/page.h:193:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
193 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
|         ^~
include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
78 | # define unlikely(x) __builtin_expect(!!(x), 0)
|                                          ^
include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
143 |  BUG_ON(!virt_addr_valid(buf));
|  ^~~~~~
arch/xtensa/include/asm/page.h:201:32: note: in expansion of macro 'pfn_valid'
201 | #define virt_addr_valid(kaddr) pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
|                                ^~~~~~~~~
include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
143 |  BUG_ON(!virt_addr_valid(buf));
|          ^~~~~~~~~~~~~~~
In file included from ./arch/xtensa/include/generated/asm/bug.h:1,
from include/linux/bug.h:5,
from include/linux/cpumask.h:14,
from drivers/net/ethernet/intel/include/iecm.h:10,
from drivers/net/ethernet/intel/iecm/iecm_lib.c:6:
include/linux/dma-mapping.h: In function 'dma_map_resource':
arch/xtensa/include/asm/page.h:193:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
193 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
|         ^~
include/asm-generic/bug.h:139:27: note: in definition of macro 'WARN_ON_ONCE'
139 |  int __ret_warn_once = !!(condition);            |                           ^~~~~~~~~
include/linux/dma-mapping.h:352:19: note: in expansion of macro 'pfn_valid'
352 |  if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
|                   ^~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_lib.c: At top level:
drivers/net/ethernet/intel/iecm/iecm_lib.c:49:13: warning: no previous prototype for 'iecm_mb_intr_clean' [-Wmissing-prototypes]
49 | irqreturn_t iecm_mb_intr_clean(int __always_unused irq, void *data)
|             ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_lib.c:63:6: warning: no previous prototype for 'iecm_mb_irq_enable' [-Wmissing-prototypes]
63 | void iecm_mb_irq_enable(struct iecm_adapter *adapter)
|      ^~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:77:5: warning: no previous prototype for 'iecm_mb_intr_req_irq' [-Wmissing-prototypes]
77 | int iecm_mb_intr_req_irq(struct iecm_adapter *adapter)
|     ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:104:6: warning: no previous prototype for 'iecm_get_mb_vec_id' [-Wmissing-prototypes]
104 | void iecm_get_mb_vec_id(struct iecm_adapter *adapter)
|      ^~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:122:5: warning: no previous prototype for 'iecm_mb_intr_init' [-Wmissing-prototypes]
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
In file included from include/linux/build_bug.h:5,
from include/linux/bits.h:23,
from include/linux/bitops.h:5,
from include/linux/bitmap.h:8,
from drivers/net/ethernet/intel/include/iecm.h:8,
from drivers/net/ethernet/intel/iecm/iecm_txrx.c:4:
include/linux/scatterlist.h: In function 'sg_set_buf':
arch/xtensa/include/asm/page.h:193:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
193 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
|         ^~
include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
78 | # define unlikely(x) __builtin_expect(!!(x), 0)
|                                          ^
include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
143 |  BUG_ON(!virt_addr_valid(buf));
|  ^~~~~~
arch/xtensa/include/asm/page.h:201:32: note: in expansion of macro 'pfn_valid'
201 | #define virt_addr_valid(kaddr) pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
|                                ^~~~~~~~~
include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
143 |  BUG_ON(!virt_addr_valid(buf));
|          ^~~~~~~~~~~~~~~
In file included from ./arch/xtensa/include/generated/asm/bug.h:1,
from include/linux/bug.h:5,
from include/linux/cpumask.h:14,
from drivers/net/ethernet/intel/include/iecm.h:10,
from drivers/net/ethernet/intel/iecm/iecm_txrx.c:4:
include/linux/dma-mapping.h: In function 'dma_map_resource':
arch/xtensa/include/asm/page.h:193:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
193 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
|         ^~
include/asm-generic/bug.h:139:27: note: in definition of macro 'WARN_ON_ONCE'
139 |  int __ret_warn_once = !!(condition);            |                           ^~~~~~~~~
include/linux/dma-mapping.h:352:19: note: in expansion of macro 'pfn_valid'
352 |  if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
|                   ^~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c: At top level:
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:84:6: warning: no previous prototype for 'iecm_tx_buf_rel_all' [-Wmissing-prototypes]
84 | void iecm_tx_buf_rel_all(struct iecm_queue *txq)
|      ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:115:6: warning: no previous prototype for 'iecm_tx_desc_rel' [-Wmissing-prototypes]
115 | void iecm_tx_desc_rel(struct iecm_queue *txq, bool bufq)
|      ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:136:6: warning: no previous prototype for 'iecm_tx_desc_rel_all' [-Wmissing-prototypes]
136 | void iecm_tx_desc_rel_all(struct iecm_vport *vport)
|      ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:312:6: warning: no previous prototype for 'iecm_rx_buf_rel_all' [-Wmissing-prototypes]
312 | void iecm_rx_buf_rel_all(struct iecm_queue *rxq)
|      ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:341:6: warning: no previous prototype for 'iecm_rx_desc_rel' [-Wmissing-prototypes]
341 | void iecm_rx_desc_rel(struct iecm_queue *rxq, bool bufq,
|      ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:371:6: warning: no previous prototype for 'iecm_rx_desc_rel_all' [-Wmissing-prototypes]
371 | void iecm_rx_desc_rel_all(struct iecm_vport *vport)
|      ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:486:6: warning: no previous prototype for 'iecm_rx_hdr_buf_hw_alloc' [-Wmissing-prototypes]
486 | bool iecm_rx_hdr_buf_hw_alloc(struct iecm_queue *rxq,
|      ^~~~~~~~~~~~~~~~~~~~~~~~
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

87d2d1a0512b70 Alice Michael 2020-05-18   72  
87d2d1a0512b70 Alice Michael 2020-05-18   73  /**
87d2d1a0512b70 Alice Michael 2020-05-18   74   * iecm_mb_intr_req_irq - Request irq for the mailbox interrupt
87d2d1a0512b70 Alice Michael 2020-05-18   75   * @adapter: adapter structure to pass to the mailbox irq handler
87d2d1a0512b70 Alice Michael 2020-05-18   76   */
87d2d1a0512b70 Alice Michael 2020-05-18  @77  int iecm_mb_intr_req_irq(struct iecm_adapter *adapter)
87d2d1a0512b70 Alice Michael 2020-05-18   78  {
5c9a1cf7085795 Alice Michael 2020-05-18   79  	struct iecm_q_vector *mb_vector = &adapter->mb_vector;
5c9a1cf7085795 Alice Michael 2020-05-18   80  	int irq_num, mb_vidx = 0, err;
5c9a1cf7085795 Alice Michael 2020-05-18   81  
5c9a1cf7085795 Alice Michael 2020-05-18   82  	irq_num = adapter->msix_entries[mb_vidx].vector;
5c9a1cf7085795 Alice Michael 2020-05-18   83  	snprintf(mb_vector->name, sizeof(mb_vector->name) - 1,
5c9a1cf7085795 Alice Michael 2020-05-18   84  		 "%s-%s-%d", dev_driver_string(&adapter->pdev->dev),
5c9a1cf7085795 Alice Michael 2020-05-18   85  		 "Mailbox", mb_vidx);
5c9a1cf7085795 Alice Michael 2020-05-18   86  	err = request_irq(irq_num, adapter->irq_mb_handler, 0,
5c9a1cf7085795 Alice Michael 2020-05-18   87  			  mb_vector->name, adapter);
5c9a1cf7085795 Alice Michael 2020-05-18   88  	if (err) {
5c9a1cf7085795 Alice Michael 2020-05-18   89  		dev_err(&adapter->pdev->dev,
5c9a1cf7085795 Alice Michael 2020-05-18   90  			"Request_irq for mailbox failed, error: %d\n", err);
5c9a1cf7085795 Alice Michael 2020-05-18   91  		return err;
5c9a1cf7085795 Alice Michael 2020-05-18   92  	}
5c9a1cf7085795 Alice Michael 2020-05-18   93  	set_bit(__IECM_MB_INTR_MODE, adapter->flags);
5c9a1cf7085795 Alice Michael 2020-05-18   94  	return 0;
87d2d1a0512b70 Alice Michael 2020-05-18   95  }
87d2d1a0512b70 Alice Michael 2020-05-18   96  
87d2d1a0512b70 Alice Michael 2020-05-18   97  /**
87d2d1a0512b70 Alice Michael 2020-05-18   98   * iecm_get_mb_vec_id - Get vector index for mailbox
87d2d1a0512b70 Alice Michael 2020-05-18   99   * @adapter: adapter structure to access the vector chunks
87d2d1a0512b70 Alice Michael 2020-05-18  100   *
87d2d1a0512b70 Alice Michael 2020-05-18  101   * The first vector id in the requested vector chunks from the CP is for
87d2d1a0512b70 Alice Michael 2020-05-18  102   * the mailbox
87d2d1a0512b70 Alice Michael 2020-05-18  103   */
87d2d1a0512b70 Alice Michael 2020-05-18 @104  void iecm_get_mb_vec_id(struct iecm_adapter *adapter)
87d2d1a0512b70 Alice Michael 2020-05-18  105  {
5c9a1cf7085795 Alice Michael 2020-05-18  106  	struct virtchnl_vector_chunks *vchunks;
5c9a1cf7085795 Alice Michael 2020-05-18  107  	struct virtchnl_vector_chunk *chunk;
5c9a1cf7085795 Alice Michael 2020-05-18  108  
5c9a1cf7085795 Alice Michael 2020-05-18  109  	if (adapter->req_vec_chunks) {
5c9a1cf7085795 Alice Michael 2020-05-18  110  		vchunks = &adapter->req_vec_chunks->vchunks;
5c9a1cf7085795 Alice Michael 2020-05-18  111  		chunk = &vchunks->num_vchunk[0];
5c9a1cf7085795 Alice Michael 2020-05-18  112  		adapter->mb_vector.v_idx = chunk->start_vector_id;
5c9a1cf7085795 Alice Michael 2020-05-18  113  	} else {
5c9a1cf7085795 Alice Michael 2020-05-18  114  		adapter->mb_vector.v_idx = 0;
5c9a1cf7085795 Alice Michael 2020-05-18  115  	}
87d2d1a0512b70 Alice Michael 2020-05-18  116  }
87d2d1a0512b70 Alice Michael 2020-05-18  117  
87d2d1a0512b70 Alice Michael 2020-05-18  118  /**
87d2d1a0512b70 Alice Michael 2020-05-18  119   * iecm_mb_intr_init - Initialize the mailbox interrupt
87d2d1a0512b70 Alice Michael 2020-05-18  120   * @adapter: adapter structure to store the mailbox vector
87d2d1a0512b70 Alice Michael 2020-05-18  121   */
87d2d1a0512b70 Alice Michael 2020-05-18 @122  int iecm_mb_intr_init(struct iecm_adapter *adapter)
87d2d1a0512b70 Alice Michael 2020-05-18  123  {
5c9a1cf7085795 Alice Michael 2020-05-18  124  	int err = 0;
5c9a1cf7085795 Alice Michael 2020-05-18  125  
5c9a1cf7085795 Alice Michael 2020-05-18  126  	iecm_get_mb_vec_id(adapter);
5c9a1cf7085795 Alice Michael 2020-05-18  127  	adapter->dev_ops.reg_ops.mb_intr_reg_init(adapter);
5c9a1cf7085795 Alice Michael 2020-05-18  128  	adapter->irq_mb_handler = iecm_mb_intr_clean;
5c9a1cf7085795 Alice Michael 2020-05-18  129  	err = iecm_mb_intr_req_irq(adapter);
5c9a1cf7085795 Alice Michael 2020-05-18  130  	return err;
87d2d1a0512b70 Alice Michael 2020-05-18  131  }
87d2d1a0512b70 Alice Michael 2020-05-18  132  

:::::: The code at line 77 was first introduced by commit
:::::: 87d2d1a0512b70033f623da2e17b7cd91d4f6c25 iecm: Common module introduction and function stubs

:::::: TO: Alice Michael <alice.michael@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62921 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200530/fa6caaa0/attachment-0001.bin>
