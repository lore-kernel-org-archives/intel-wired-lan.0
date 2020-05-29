From: kbuild test robot <lkp@intel.com>
Date: Fri, 29 May 2020 11:12:20 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 89/101]
 drivers/net/ethernet/intel/iecm/iecm_lib.c:417:5: warning: no previous
 prototype for 'iecm_vport_rel'
Message-ID: <202005291119.Sn7Pscq0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alice,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   f36d7886648711bfad7440e2572b1b06e29866f1
commit: 53bf8465909bc9a7f1c715ed0044b9d82a90c008 [89/101] iecm: Add iecm to the kernel build system
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 53bf8465909bc9a7f1c715ed0044b9d82a90c008
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

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

vim +/iecm_vport_rel +417 drivers/net/ethernet/intel/iecm/iecm_lib.c

8772d2ebbe79de Alice Michael 2020-05-18  410  
8772d2ebbe79de Alice Michael 2020-05-18  411  /**
8772d2ebbe79de Alice Michael 2020-05-18  412   * iecm_vport_rel - Delete a vport and free its resources
8772d2ebbe79de Alice Michael 2020-05-18  413   * @vport: the vport being removed
8772d2ebbe79de Alice Michael 2020-05-18  414   *
8772d2ebbe79de Alice Michael 2020-05-18  415   * Returns 0 on success or < 0 on error
8772d2ebbe79de Alice Michael 2020-05-18  416   */
8772d2ebbe79de Alice Michael 2020-05-18 @417  int iecm_vport_rel(struct iecm_vport *vport)
8772d2ebbe79de Alice Michael 2020-05-18  418  {
6598ae114cd6a7 Alice Michael 2020-05-18  419  	struct iecm_adapter *adapter;
6598ae114cd6a7 Alice Michael 2020-05-18  420  
6598ae114cd6a7 Alice Michael 2020-05-18  421  	if (!vport->adapter)
6598ae114cd6a7 Alice Michael 2020-05-18  422  		return -ENODEV;
6598ae114cd6a7 Alice Michael 2020-05-18  423  	adapter = vport->adapter;
6598ae114cd6a7 Alice Michael 2020-05-18  424  
6598ae114cd6a7 Alice Michael 2020-05-18  425  	iecm_vport_stop(vport);
6598ae114cd6a7 Alice Michael 2020-05-18  426  	iecm_deinit_rss(vport);
6598ae114cd6a7 Alice Michael 2020-05-18  427  	unregister_netdev(vport->netdev);
6598ae114cd6a7 Alice Michael 2020-05-18  428  	free_netdev(vport->netdev);
6598ae114cd6a7 Alice Michael 2020-05-18  429  	vport->netdev = NULL;
6598ae114cd6a7 Alice Michael 2020-05-18  430  	if (adapter->dev_ops.vc_ops.destroy_vport)
6598ae114cd6a7 Alice Michael 2020-05-18  431  		adapter->dev_ops.vc_ops.destroy_vport(vport);
6598ae114cd6a7 Alice Michael 2020-05-18  432  	kfree(vport);
6598ae114cd6a7 Alice Michael 2020-05-18  433  
6598ae114cd6a7 Alice Michael 2020-05-18  434  	return 0;
8772d2ebbe79de Alice Michael 2020-05-18  435  }
8772d2ebbe79de Alice Michael 2020-05-18  436  

:::::: The code at line 417 was first introduced by commit
:::::: 8772d2ebbe79de1190287367aa42b2efa247788d iecm: Common module introduction and function stubs

:::::: TO: Alice Michael <alice.michael@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57850 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200529/cb8de42f/attachment-0001.bin>
