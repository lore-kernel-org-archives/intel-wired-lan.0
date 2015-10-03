From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 4 Oct 2015 07:07:57 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 69/157]
 drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit
 declaration of function 'e1000e_disable_aspm_locked'
Message-ID: <201510040751.XwdNMXgx%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   f2e6d66d803276c3063ac0efa631e2fd6fe3e88a
commit: 7cce8a848cb361f73055c70dc4957d2bfeb439bd [69/157] e1000: fix e1000e_disable_aspm_locked() warning
config: microblaze-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7cce8a848cb361f73055c70dc4957d2bfeb439bd
        # save the attached .config to linux build tree
        make.cross ARCH=microblaze 

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/e1000e/netdev.c: In function 'e1000_io_slot_reset':
>> drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
      e1000e_disable_aspm_locked(pdev, aspm_disable_flag);
      ^
   cc1: some warnings being treated as errors

vim +/e1000e_disable_aspm_locked +6785 drivers/net/ethernet/intel/e1000e/netdev.c

bc7f75fa drivers/net/e1000e/netdev.c                Auke Kok       2007-09-17  6779  
78cd29d5 drivers/net/e1000e/netdev.c                Bruce Allan    2011-03-24  6780  	if (adapter->flags2 & FLAG2_DISABLE_ASPM_L0S)
78cd29d5 drivers/net/e1000e/netdev.c                Bruce Allan    2011-03-24  6781  		aspm_disable_flag = PCIE_LINK_STATE_L0S;
6f461f6c drivers/net/e1000e/netdev.c                Bruce Allan    2010-04-27  6782  	if (adapter->flags2 & FLAG2_DISABLE_ASPM_L1)
78cd29d5 drivers/net/e1000e/netdev.c                Bruce Allan    2011-03-24  6783  		aspm_disable_flag |= PCIE_LINK_STATE_L1;
78cd29d5 drivers/net/e1000e/netdev.c                Bruce Allan    2011-03-24  6784  	if (aspm_disable_flag)
2758f9ed drivers/net/ethernet/intel/e1000e/netdev.c Raanan Avargil 2015-07-06 @6785  		e1000e_disable_aspm_locked(pdev, aspm_disable_flag);
78cd29d5 drivers/net/e1000e/netdev.c                Bruce Allan    2011-03-24  6786  
6e4f6f6b drivers/net/e1000e/netdev.c                Taku Izumi     2008-06-20  6787  	err = pci_enable_device_mem(pdev);
6e4f6f6b drivers/net/e1000e/netdev.c                Taku Izumi     2008-06-20  6788  	if (err) {

:::::: The code at line 6785 was first introduced by commit
:::::: 2758f9edb7bd5a06a2ecee83cc2ebaf8822a0cb5 e1000e: Fix incorrect ASPM locking

:::::: TO: Raanan Avargil <raanan.avargil@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 42075 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151004/b605695d/attachment-0001.obj>
