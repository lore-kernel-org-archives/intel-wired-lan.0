From: kernel test robot <lkp@intel.com>
Date: Thu, 18 Jun 2020 14:24:35 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:100GbE 15/15]
 drivers/net/ethernet/intel/idpf/idpf_main.c:46:5: warning: no previous
 prototype for 'idpf_probe'
Message-ID: <202006181433.J5dNOFGw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git 100GbE
head:   2c89ef0b849b5d1bdba9bcc93a70f52c4752bc23
commit: 2c89ef0b849b5d1bdba9bcc93a70f52c4752bc23 [15/15] idpf: Introduce idpf driver
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2c89ef0b849b5d1bdba9bcc93a70f52c4752bc23
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> drivers/net/ethernet/intel/idpf/idpf_main.c:46:5: warning: no previous prototype for 'idpf_probe' [-Wmissing-prototypes]
46 | int idpf_probe(struct pci_dev *pdev,
|     ^~~~~~~~~~
In file included from include/linux/net/intel/iecm.h:50,
from drivers/net/ethernet/intel/idpf/idpf_dev.h:7,
from drivers/net/ethernet/intel/idpf/idpf_main.c:6:
include/linux/net/intel/iecm_txrx.h:293:30: warning: 'iecm_rx_ptype_lkup' defined but not used [-Wunused-const-variable=]
293 | struct iecm_rx_ptype_decoded iecm_rx_ptype_lkup[IECM_RX_SUPP_PTYPE] = {
|                              ^~~~~~~~~~~~~~~~~~

vim +/idpf_probe +46 drivers/net/ethernet/intel/idpf/idpf_main.c

    38	
    39	/**
    40	 * idpf_probe - Device initialization routine
    41	 * @pdev: PCI device information struct
    42	 * @ent: entry in idpf_pci_tbl
    43	 *
    44	 * Returns 0 on success, negative on failure
    45	 */
  > 46	int idpf_probe(struct pci_dev *pdev,
    47		       const struct pci_device_id __always_unused *ent)
    48	{
    49		struct iecm_adapter *adapter = NULL;
    50		int err;
    51	
    52		err = pcim_enable_device(pdev);
    53		if (err)
    54			return err;
    55	
    56		adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
    57		if (!adapter)
    58			return -ENOMEM;
    59	
    60		adapter->dev_ops.reg_ops_init = idpf_reg_ops_init;
    61	
    62		err = iecm_probe(pdev, ent, adapter);
    63		if (err)
    64			kfree(adapter);
    65	
    66		return err;
    67	}
    68	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65023 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200618/39568e10/attachment-0001.bin>
