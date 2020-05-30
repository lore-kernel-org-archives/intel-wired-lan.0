From: kbuild test robot <lkp@intel.com>
Date: Sat, 30 May 2020 19:26:34 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 62/73]
 drivers/net/ethernet/intel/iecm/iecm_lib.c:417:5: warning: no previous
 prototype for 'iecm_vport_rel'
Message-ID: <202005301931.7VWw0gnH%lkp@intel.com>
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
config: riscv-allyesconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 57168068502344f572f6d8e3c916922780241a76
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

drivers/net/ethernet/intel/iecm/iecm_lib.c:49:13: warning: no previous prototype for 'iecm_mb_intr_clean' [-Wmissing-prototypes]
49 | irqreturn_t iecm_mb_intr_clean(int __always_unused irq, void *data)
|             ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_lib.c:63:6: warning: no previous prototype for 'iecm_mb_irq_enable' [-Wmissing-prototypes]
63 | void iecm_mb_irq_enable(struct iecm_adapter *adapter)
|      ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_lib.c:77:5: warning: no previous prototype for 'iecm_mb_intr_req_irq' [-Wmissing-prototypes]
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
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:417:5: warning: no previous prototype for 'iecm_vport_rel' [-Wmissing-prototypes]
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
drivers/net/ethernet/intel/iecm/iecm_txrx.c:84:6: warning: no previous prototype for 'iecm_tx_buf_rel_all' [-Wmissing-prototypes]
84 | void iecm_tx_buf_rel_all(struct iecm_queue *txq)
|      ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:115:6: warning: no previous prototype for 'iecm_tx_desc_rel' [-Wmissing-prototypes]
115 | void iecm_tx_desc_rel(struct iecm_queue *txq, bool bufq)
|      ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/iecm/iecm_txrx.c:136:6: warning: no previous prototype for 'iecm_tx_desc_rel_all' [-Wmissing-prototypes]
136 | void iecm_tx_desc_rel_all(struct iecm_vport *vport)
|      ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:312:6: warning: no previous prototype for 'iecm_rx_buf_rel_all' [-Wmissing-prototypes]
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

vim +/iecm_vport_rel +417 drivers/net/ethernet/intel/iecm/iecm_lib.c

87d2d1a0512b70 Alice Michael 2020-05-18  410  
87d2d1a0512b70 Alice Michael 2020-05-18  411  /**
87d2d1a0512b70 Alice Michael 2020-05-18  412   * iecm_vport_rel - Delete a vport and free its resources
87d2d1a0512b70 Alice Michael 2020-05-18  413   * @vport: the vport being removed
87d2d1a0512b70 Alice Michael 2020-05-18  414   *
87d2d1a0512b70 Alice Michael 2020-05-18  415   * Returns 0 on success or < 0 on error
87d2d1a0512b70 Alice Michael 2020-05-18  416   */
87d2d1a0512b70 Alice Michael 2020-05-18 @417  int iecm_vport_rel(struct iecm_vport *vport)
87d2d1a0512b70 Alice Michael 2020-05-18  418  {
cc4354516a857e Alice Michael 2020-05-18  419  	struct iecm_adapter *adapter;
cc4354516a857e Alice Michael 2020-05-18  420  
cc4354516a857e Alice Michael 2020-05-18  421  	if (!vport->adapter)
cc4354516a857e Alice Michael 2020-05-18  422  		return -ENODEV;
cc4354516a857e Alice Michael 2020-05-18  423  	adapter = vport->adapter;
cc4354516a857e Alice Michael 2020-05-18  424  
cc4354516a857e Alice Michael 2020-05-18  425  	iecm_vport_stop(vport);
cc4354516a857e Alice Michael 2020-05-18  426  	iecm_deinit_rss(vport);
cc4354516a857e Alice Michael 2020-05-18  427  	unregister_netdev(vport->netdev);
cc4354516a857e Alice Michael 2020-05-18  428  	free_netdev(vport->netdev);
cc4354516a857e Alice Michael 2020-05-18  429  	vport->netdev = NULL;
cc4354516a857e Alice Michael 2020-05-18  430  	if (adapter->dev_ops.vc_ops.destroy_vport)
cc4354516a857e Alice Michael 2020-05-18  431  		adapter->dev_ops.vc_ops.destroy_vport(vport);
cc4354516a857e Alice Michael 2020-05-18  432  	kfree(vport);
cc4354516a857e Alice Michael 2020-05-18  433  
cc4354516a857e Alice Michael 2020-05-18  434  	return 0;
87d2d1a0512b70 Alice Michael 2020-05-18  435  }
87d2d1a0512b70 Alice Michael 2020-05-18  436  

:::::: The code at line 417 was first introduced by commit
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
Size: 63545 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200530/40fe1782/attachment-0001.bin>
