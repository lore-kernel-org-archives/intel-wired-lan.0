From: kbuild test robot <lkp@intel.com>
Date: Tue, 19 May 2020 16:22:22 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 182/183]
 drivers/net/ethernet/intel/iecm/iecm_lib.c:49:13: warning: no previous
 prototype for function 'iecm_mb_intr_clean'
Message-ID: <202005191617.lel3zQBD%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alice,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   7c7dd63d321082aff5fb170d27beab8a756e3434
commit: cbcbf4f29548030710cedcaccbdacb5851a1f112 [182/183] iecm: Add iecm to the kernel build system
config: x86_64-allyesconfig (attached as .config)
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        git checkout cbcbf4f29548030710cedcaccbdacb5851a1f112
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> drivers/net/ethernet/intel/iecm/iecm_lib.c:49:13: warning: no previous prototype for function 'iecm_mb_intr_clean' [-Wmissing-prototypes]
irqreturn_t iecm_mb_intr_clean(int __always_unused irq, void *data)
^
drivers/net/ethernet/intel/iecm/iecm_lib.c:49:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
irqreturn_t iecm_mb_intr_clean(int __always_unused irq, void *data)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:63:6: warning: no previous prototype for function 'iecm_mb_irq_enable' [-Wmissing-prototypes]
void iecm_mb_irq_enable(struct iecm_adapter *adapter)
^
drivers/net/ethernet/intel/iecm/iecm_lib.c:63:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_mb_irq_enable(struct iecm_adapter *adapter)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:77:5: warning: no previous prototype for function 'iecm_mb_intr_req_irq' [-Wmissing-prototypes]
int iecm_mb_intr_req_irq(struct iecm_adapter *adapter)
^
drivers/net/ethernet/intel/iecm/iecm_lib.c:77:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
int iecm_mb_intr_req_irq(struct iecm_adapter *adapter)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:104:6: warning: no previous prototype for function 'iecm_get_mb_vec_id' [-Wmissing-prototypes]
void iecm_get_mb_vec_id(struct iecm_adapter *adapter)
^
drivers/net/ethernet/intel/iecm/iecm_lib.c:104:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_get_mb_vec_id(struct iecm_adapter *adapter)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:122:5: warning: no previous prototype for function 'iecm_mb_intr_init' [-Wmissing-prototypes]
int iecm_mb_intr_init(struct iecm_adapter *adapter)
^
drivers/net/ethernet/intel/iecm/iecm_lib.c:122:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
int iecm_mb_intr_init(struct iecm_adapter *adapter)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:140:6: warning: no previous prototype for function 'iecm_intr_distribute' [-Wmissing-prototypes]
void iecm_intr_distribute(struct iecm_adapter *adapter)
^
drivers/net/ethernet/intel/iecm/iecm_lib.c:140:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_intr_distribute(struct iecm_adapter *adapter)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:417:5: warning: no previous prototype for function 'iecm_vport_rel' [-Wmissing-prototypes]
int iecm_vport_rel(struct iecm_vport *vport)
^
drivers/net/ethernet/intel/iecm/iecm_lib.c:417:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
int iecm_vport_rel(struct iecm_vport *vport)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_lib.c:748:6: warning: no previous prototype for function 'iecm_deinit_task' [-Wmissing-prototypes]
void iecm_deinit_task(struct iecm_adapter *adapter)
^
drivers/net/ethernet/intel/iecm/iecm_lib.c:748:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_deinit_task(struct iecm_adapter *adapter)
^
static
8 warnings generated.
--
>> drivers/net/ethernet/intel/iecm/iecm_virtchnl.c:12:6: warning: no previous prototype for function 'iecm_recv_event_msg' [-Wmissing-prototypes]
void iecm_recv_event_msg(struct iecm_vport *vport)
^
drivers/net/ethernet/intel/iecm/iecm_virtchnl.c:12:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_recv_event_msg(struct iecm_vport *vport)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_virtchnl.c:61:1: warning: no previous prototype for function 'iecm_mb_clean' [-Wmissing-prototypes]
iecm_mb_clean(struct iecm_adapter *adapter)
^
drivers/net/ethernet/intel/iecm/iecm_virtchnl.c:60:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
enum iecm_status
^
static
2 warnings generated.
--
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:84:6: warning: no previous prototype for function 'iecm_tx_buf_rel_all' [-Wmissing-prototypes]
void iecm_tx_buf_rel_all(struct iecm_queue *txq)
^
drivers/net/ethernet/intel/iecm/iecm_txrx.c:84:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_tx_buf_rel_all(struct iecm_queue *txq)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:115:6: warning: no previous prototype for function 'iecm_tx_desc_rel' [-Wmissing-prototypes]
void iecm_tx_desc_rel(struct iecm_queue *txq, bool bufq)
^
drivers/net/ethernet/intel/iecm/iecm_txrx.c:115:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_tx_desc_rel(struct iecm_queue *txq, bool bufq)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:136:6: warning: no previous prototype for function 'iecm_tx_desc_rel_all' [-Wmissing-prototypes]
void iecm_tx_desc_rel_all(struct iecm_vport *vport)
^
drivers/net/ethernet/intel/iecm/iecm_txrx.c:136:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_tx_desc_rel_all(struct iecm_vport *vport)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:312:6: warning: no previous prototype for function 'iecm_rx_buf_rel_all' [-Wmissing-prototypes]
void iecm_rx_buf_rel_all(struct iecm_queue *rxq)
^
drivers/net/ethernet/intel/iecm/iecm_txrx.c:312:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_rx_buf_rel_all(struct iecm_queue *rxq)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:341:6: warning: no previous prototype for function 'iecm_rx_desc_rel' [-Wmissing-prototypes]
void iecm_rx_desc_rel(struct iecm_queue *rxq, bool bufq,
^
drivers/net/ethernet/intel/iecm/iecm_txrx.c:341:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_rx_desc_rel(struct iecm_queue *rxq, bool bufq,
^
static
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:371:6: warning: no previous prototype for function 'iecm_rx_desc_rel_all' [-Wmissing-prototypes]
void iecm_rx_desc_rel_all(struct iecm_vport *vport)
^
drivers/net/ethernet/intel/iecm/iecm_txrx.c:371:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_rx_desc_rel_all(struct iecm_vport *vport)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:486:6: warning: no previous prototype for function 'iecm_rx_hdr_buf_hw_alloc' [-Wmissing-prototypes]
bool iecm_rx_hdr_buf_hw_alloc(struct iecm_queue *rxq,
^
drivers/net/ethernet/intel/iecm/iecm_txrx.c:486:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
bool iecm_rx_hdr_buf_hw_alloc(struct iecm_queue *rxq,
^
static
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:3565:5: warning: no previous prototype for function 'iecm_vport_splitq_napi_poll' [-Wmissing-prototypes]
int iecm_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
^
drivers/net/ethernet/intel/iecm/iecm_txrx.c:3565:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
int iecm_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:3603:6: warning: no previous prototype for function 'iecm_vport_intr_map_vector_to_qs' [-Wmissing-prototypes]
void iecm_vport_intr_map_vector_to_qs(struct iecm_vport *vport)
^
drivers/net/ethernet/intel/iecm/iecm_txrx.c:3603:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void iecm_vport_intr_map_vector_to_qs(struct iecm_vport *vport)
^
static
>> drivers/net/ethernet/intel/iecm/iecm_txrx.c:3715:5: warning: no previous prototype for function 'iecm_vport_intr_alloc' [-Wmissing-prototypes]
int iecm_vport_intr_alloc(struct iecm_vport *vport)
^
drivers/net/ethernet/intel/iecm/iecm_txrx.c:3715:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
int iecm_vport_intr_alloc(struct iecm_vport *vport)
^
static
10 warnings generated.

vim +/iecm_mb_intr_clean +49 drivers/net/ethernet/intel/iecm/iecm_lib.c

abb358c18f4525 Alice Michael 2020-05-18   43  
abb358c18f4525 Alice Michael 2020-05-18   44  /**
abb358c18f4525 Alice Michael 2020-05-18   45   * iecm_mb_intr_clean - Interrupt handler for the mailbox
abb358c18f4525 Alice Michael 2020-05-18   46   * @irq: interrupt number
abb358c18f4525 Alice Michael 2020-05-18   47   * @data: pointer to the adapter structure
abb358c18f4525 Alice Michael 2020-05-18   48   */
abb358c18f4525 Alice Michael 2020-05-18  @49  irqreturn_t iecm_mb_intr_clean(int __always_unused irq, void *data)
abb358c18f4525 Alice Michael 2020-05-18   50  {
4227a8f4f793dc Alice Michael 2020-05-18   51  	struct iecm_adapter *adapter = (struct iecm_adapter *)data;
4227a8f4f793dc Alice Michael 2020-05-18   52  
4227a8f4f793dc Alice Michael 2020-05-18   53  	set_bit(__IECM_MB_INTR_TRIGGER, adapter->flags);
4227a8f4f793dc Alice Michael 2020-05-18   54  	queue_delayed_work(adapter->serv_wq, &adapter->serv_task,
4227a8f4f793dc Alice Michael 2020-05-18   55  			   msecs_to_jiffies(0));
4227a8f4f793dc Alice Michael 2020-05-18   56  	return IRQ_HANDLED;
abb358c18f4525 Alice Michael 2020-05-18   57  }
abb358c18f4525 Alice Michael 2020-05-18   58  
abb358c18f4525 Alice Michael 2020-05-18   59  /**
abb358c18f4525 Alice Michael 2020-05-18   60   * iecm_mb_irq_enable - Enable MSIX interrupt for the mailbox
abb358c18f4525 Alice Michael 2020-05-18   61   * @adapter: adapter to get the hardware address for register write
abb358c18f4525 Alice Michael 2020-05-18   62   */
abb358c18f4525 Alice Michael 2020-05-18  @63  void iecm_mb_irq_enable(struct iecm_adapter *adapter)
abb358c18f4525 Alice Michael 2020-05-18   64  {
4227a8f4f793dc Alice Michael 2020-05-18   65  	struct iecm_hw *hw = &adapter->hw;
4227a8f4f793dc Alice Michael 2020-05-18   66  	struct iecm_intr_reg *intr = &adapter->mb_vector.intr_reg;
4227a8f4f793dc Alice Michael 2020-05-18   67  	u32 val;
4227a8f4f793dc Alice Michael 2020-05-18   68  
4227a8f4f793dc Alice Michael 2020-05-18   69  	val = intr->dyn_ctl_intena_m | intr->dyn_ctl_itridx_m;
4227a8f4f793dc Alice Michael 2020-05-18   70  	writel_relaxed(val, (u8 *)(hw->hw_addr + intr->dyn_ctl));
abb358c18f4525 Alice Michael 2020-05-18   71  }
abb358c18f4525 Alice Michael 2020-05-18   72  
abb358c18f4525 Alice Michael 2020-05-18   73  /**
abb358c18f4525 Alice Michael 2020-05-18   74   * iecm_mb_intr_req_irq - Request irq for the mailbox interrupt
abb358c18f4525 Alice Michael 2020-05-18   75   * @adapter: adapter structure to pass to the mailbox irq handler
abb358c18f4525 Alice Michael 2020-05-18   76   */
abb358c18f4525 Alice Michael 2020-05-18  @77  int iecm_mb_intr_req_irq(struct iecm_adapter *adapter)
abb358c18f4525 Alice Michael 2020-05-18   78  {
4227a8f4f793dc Alice Michael 2020-05-18   79  	struct iecm_q_vector *mb_vector = &adapter->mb_vector;
4227a8f4f793dc Alice Michael 2020-05-18   80  	int irq_num, mb_vidx = 0, err;
4227a8f4f793dc Alice Michael 2020-05-18   81  
4227a8f4f793dc Alice Michael 2020-05-18   82  	irq_num = adapter->msix_entries[mb_vidx].vector;
4227a8f4f793dc Alice Michael 2020-05-18   83  	snprintf(mb_vector->name, sizeof(mb_vector->name) - 1,
4227a8f4f793dc Alice Michael 2020-05-18   84  		 "%s-%s-%d", dev_driver_string(&adapter->pdev->dev),
4227a8f4f793dc Alice Michael 2020-05-18   85  		 "Mailbox", mb_vidx);
4227a8f4f793dc Alice Michael 2020-05-18   86  	err = request_irq(irq_num, adapter->irq_mb_handler, 0,
4227a8f4f793dc Alice Michael 2020-05-18   87  			  mb_vector->name, adapter);
4227a8f4f793dc Alice Michael 2020-05-18   88  	if (err) {
4227a8f4f793dc Alice Michael 2020-05-18   89  		dev_err(&adapter->pdev->dev,
4227a8f4f793dc Alice Michael 2020-05-18   90  			"Request_irq for mailbox failed, error: %d\n", err);
4227a8f4f793dc Alice Michael 2020-05-18   91  		return err;
4227a8f4f793dc Alice Michael 2020-05-18   92  	}
4227a8f4f793dc Alice Michael 2020-05-18   93  	set_bit(__IECM_MB_INTR_MODE, adapter->flags);
4227a8f4f793dc Alice Michael 2020-05-18   94  	return 0;
abb358c18f4525 Alice Michael 2020-05-18   95  }
abb358c18f4525 Alice Michael 2020-05-18   96  
abb358c18f4525 Alice Michael 2020-05-18   97  /**
abb358c18f4525 Alice Michael 2020-05-18   98   * iecm_get_mb_vec_id - Get vector index for mailbox
abb358c18f4525 Alice Michael 2020-05-18   99   * @adapter: adapter structure to access the vector chunks
abb358c18f4525 Alice Michael 2020-05-18  100   *
abb358c18f4525 Alice Michael 2020-05-18  101   * The first vector id in the requested vector chunks from the CP is for
abb358c18f4525 Alice Michael 2020-05-18  102   * the mailbox
abb358c18f4525 Alice Michael 2020-05-18  103   */
abb358c18f4525 Alice Michael 2020-05-18 @104  void iecm_get_mb_vec_id(struct iecm_adapter *adapter)
abb358c18f4525 Alice Michael 2020-05-18  105  {
4227a8f4f793dc Alice Michael 2020-05-18  106  	struct virtchnl_vector_chunks *vchunks;
4227a8f4f793dc Alice Michael 2020-05-18  107  	struct virtchnl_vector_chunk *chunk;
4227a8f4f793dc Alice Michael 2020-05-18  108  
4227a8f4f793dc Alice Michael 2020-05-18  109  	if (adapter->req_vec_chunks) {
4227a8f4f793dc Alice Michael 2020-05-18  110  		vchunks = &adapter->req_vec_chunks->vchunks;
4227a8f4f793dc Alice Michael 2020-05-18  111  		chunk = &vchunks->num_vchunk[0];
4227a8f4f793dc Alice Michael 2020-05-18  112  		adapter->mb_vector.v_idx = chunk->start_vector_id;
4227a8f4f793dc Alice Michael 2020-05-18  113  	} else {
4227a8f4f793dc Alice Michael 2020-05-18  114  		adapter->mb_vector.v_idx = 0;
4227a8f4f793dc Alice Michael 2020-05-18  115  	}
abb358c18f4525 Alice Michael 2020-05-18  116  }
abb358c18f4525 Alice Michael 2020-05-18  117  
abb358c18f4525 Alice Michael 2020-05-18  118  /**
abb358c18f4525 Alice Michael 2020-05-18  119   * iecm_mb_intr_init - Initialize the mailbox interrupt
abb358c18f4525 Alice Michael 2020-05-18  120   * @adapter: adapter structure to store the mailbox vector
abb358c18f4525 Alice Michael 2020-05-18  121   */
abb358c18f4525 Alice Michael 2020-05-18 @122  int iecm_mb_intr_init(struct iecm_adapter *adapter)
abb358c18f4525 Alice Michael 2020-05-18  123  {
4227a8f4f793dc Alice Michael 2020-05-18  124  	int err = 0;
4227a8f4f793dc Alice Michael 2020-05-18  125  
4227a8f4f793dc Alice Michael 2020-05-18  126  	iecm_get_mb_vec_id(adapter);
4227a8f4f793dc Alice Michael 2020-05-18  127  	adapter->dev_ops.reg_ops.mb_intr_reg_init(adapter);
4227a8f4f793dc Alice Michael 2020-05-18  128  	adapter->irq_mb_handler = iecm_mb_intr_clean;
4227a8f4f793dc Alice Michael 2020-05-18  129  	err = iecm_mb_intr_req_irq(adapter);
4227a8f4f793dc Alice Michael 2020-05-18  130  	return err;
abb358c18f4525 Alice Michael 2020-05-18  131  }
abb358c18f4525 Alice Michael 2020-05-18  132  
abb358c18f4525 Alice Michael 2020-05-18  133  /**
abb358c18f4525 Alice Michael 2020-05-18  134   * iecm_intr_distribute - Distribute MSIX vectors
abb358c18f4525 Alice Michael 2020-05-18  135   * @adapter: adapter structure to get the vports
abb358c18f4525 Alice Michael 2020-05-18  136   *
abb358c18f4525 Alice Michael 2020-05-18  137   * Distribute the MSIX vectors acquired from the OS to the vports based on the
abb358c18f4525 Alice Michael 2020-05-18  138   * num of vectors requested by each vport
abb358c18f4525 Alice Michael 2020-05-18  139   */
abb358c18f4525 Alice Michael 2020-05-18 @140  void iecm_intr_distribute(struct iecm_adapter *adapter)
abb358c18f4525 Alice Michael 2020-05-18  141  {
4227a8f4f793dc Alice Michael 2020-05-18  142  	struct iecm_vport *vport;
4227a8f4f793dc Alice Michael 2020-05-18  143  
4227a8f4f793dc Alice Michael 2020-05-18  144  	vport = adapter->vports[0];
4227a8f4f793dc Alice Michael 2020-05-18  145  	if (adapter->num_msix_entries != adapter->num_req_msix)
4227a8f4f793dc Alice Michael 2020-05-18  146  		vport->num_q_vectors = adapter->num_msix_entries -
4227a8f4f793dc Alice Michael 2020-05-18  147  				       IECM_MAX_NONQ_VEC - IECM_MIN_RDMA_VEC;
abb358c18f4525 Alice Michael 2020-05-18  148  }
abb358c18f4525 Alice Michael 2020-05-18  149  

:::::: The code at line 49 was first introduced by commit
:::::: abb358c18f452548c4540e1de514e231a4ff587a iecm: Common module introduction and function stubs

:::::: TO: Alice Michael <alice.michael@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 73620 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200519/8b34eff6/attachment-0001.bin>
