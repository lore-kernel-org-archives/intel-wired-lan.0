From: kernel test robot <lkp@intel.com>
Date: Mon, 27 Jul 2020 11:22:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:200GbE 14/15]
 drivers/net/ethernet/intel/iecm/iecm_txrx.c:1370:12: error: 'struct
 iecm_tx_buf' has no member named 'dma'
Message-ID: <202007271137.4zcFMGM6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alice,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git 200GbE
head:   d0bd59215c59721d6506c3084e70f5d4d673af01
commit: 4fe98e8b3d542b22498737b9f4c71aecdea88230 [14/15] iecm: Add iecm to the kernel build system
config: riscv-randconfig-m031-20200727 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4fe98e8b3d542b22498737b9f4c71aecdea88230
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

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

vim +1370 drivers/net/ethernet/intel/iecm/iecm_txrx.c

001487d2c6ea3f Alice Michael 2020-07-15  1346  
001487d2c6ea3f Alice Michael 2020-07-15  1347  /**
001487d2c6ea3f Alice Michael 2020-07-15  1348   * iecm_stash_flow_sch_buffers - store buffere parameter info to be freed at a
001487d2c6ea3f Alice Michael 2020-07-15  1349   * later time (only relevant for flow scheduling mode)
001487d2c6ea3f Alice Michael 2020-07-15  1350   * @txq: Tx queue to clean
001487d2c6ea3f Alice Michael 2020-07-15  1351   * @tx_buf: buffer to store
001487d2c6ea3f Alice Michael 2020-07-15  1352   */
001487d2c6ea3f Alice Michael 2020-07-15  1353  static int
001487d2c6ea3f Alice Michael 2020-07-15  1354  iecm_stash_flow_sch_buffers(struct iecm_queue *txq, struct iecm_tx_buf *tx_buf)
001487d2c6ea3f Alice Michael 2020-07-15  1355  {
0dc640099a9b6a Alice Michael 2020-07-15  1356  	struct iecm_adapter *adapter = txq->vport->adapter;
0dc640099a9b6a Alice Michael 2020-07-15  1357  	struct iecm_tx_buf *shadow_buf;
0dc640099a9b6a Alice Michael 2020-07-15  1358  
0dc640099a9b6a Alice Michael 2020-07-15  1359  	shadow_buf = iecm_buf_lifo_pop(&txq->buf_stack);
0dc640099a9b6a Alice Michael 2020-07-15  1360  	if (!shadow_buf) {
0dc640099a9b6a Alice Michael 2020-07-15  1361  		dev_err(&adapter->pdev->dev,
0dc640099a9b6a Alice Michael 2020-07-15  1362  			"No out-of-order TX buffers left!\n");
0dc640099a9b6a Alice Michael 2020-07-15  1363  		return -ENOMEM;
0dc640099a9b6a Alice Michael 2020-07-15  1364  	}
0dc640099a9b6a Alice Michael 2020-07-15  1365  
0dc640099a9b6a Alice Michael 2020-07-15  1366  	/* Store buffer params in shadow buffer */
0dc640099a9b6a Alice Michael 2020-07-15  1367  	shadow_buf->skb = tx_buf->skb;
0dc640099a9b6a Alice Michael 2020-07-15  1368  	shadow_buf->bytecount = tx_buf->bytecount;
0dc640099a9b6a Alice Michael 2020-07-15  1369  	shadow_buf->gso_segs = tx_buf->gso_segs;
0dc640099a9b6a Alice Michael 2020-07-15 @1370  	shadow_buf->dma = tx_buf->dma;
0dc640099a9b6a Alice Michael 2020-07-15 @1371  	shadow_buf->len = tx_buf->len;
0dc640099a9b6a Alice Michael 2020-07-15  1372  	shadow_buf->compl_tag = tx_buf->compl_tag;
0dc640099a9b6a Alice Michael 2020-07-15  1373  
0dc640099a9b6a Alice Michael 2020-07-15  1374  	/* Add buffer to buf_hash table to be freed
0dc640099a9b6a Alice Michael 2020-07-15  1375  	 * later
0dc640099a9b6a Alice Michael 2020-07-15  1376  	 */
0dc640099a9b6a Alice Michael 2020-07-15  1377  	hash_add(txq->sched_buf_hash, &shadow_buf->hlist,
0dc640099a9b6a Alice Michael 2020-07-15  1378  		 shadow_buf->compl_tag);
0dc640099a9b6a Alice Michael 2020-07-15  1379  
0dc640099a9b6a Alice Michael 2020-07-15  1380  	memset(tx_buf, 0, sizeof(struct iecm_tx_buf));
0dc640099a9b6a Alice Michael 2020-07-15  1381  
0dc640099a9b6a Alice Michael 2020-07-15  1382  	return 0;
001487d2c6ea3f Alice Michael 2020-07-15  1383  }
001487d2c6ea3f Alice Michael 2020-07-15  1384  

:::::: The code at line 1370 was first introduced by commit
:::::: 0dc640099a9b6adc353924b4d1d5a3cda7af57f2 iecm: Add splitq TX/RX

:::::: TO: Alice Michael <alice.michael@intel.com>
:::::: CC: Tony Nguyen <anthony.l.nguyen@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29505 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200727/8666de01/attachment-0001.bin>
