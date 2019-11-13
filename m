From: kbuild test robot <lkp@intel.com>
Date: Thu, 14 Nov 2019 06:42:14 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 33/33]
 drivers/net/ethernet/intel/igc/igc_main.c:4768:2: error: implicit
 declaration of function '__igc_shutdown'; did you mean 'igc_shutdown'?
Message-ID: <201911140612.yL53VnO4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   71b7746c376d545a3c62d5b9ddcee7aa742f1782
commit: 71b7746c376d545a3c62d5b9ddcee7aa742f1782 [33/33] igc: Add legacy power management support
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 71b7746c376d545a3c62d5b9ddcee7aa742f1782
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/igc/igc_main.c: In function 'igc_shutdown':
>> drivers/net/ethernet/intel/igc/igc_main.c:4768:2: error: implicit declaration of function '__igc_shutdown'; did you mean 'igc_shutdown'? [-Werror=implicit-function-declaration]
     __igc_shutdown(pdev, &wake, 0);
     ^~~~~~~~~~~~~~
     igc_shutdown
   cc1: some warnings being treated as errors

vim +4768 drivers/net/ethernet/intel/igc/igc_main.c

  4763	
  4764	static void igc_shutdown(struct pci_dev *pdev)
  4765	{
  4766		bool wake;
  4767	
> 4768		__igc_shutdown(pdev, &wake, 0);
  4769	
  4770		if (system_state == SYSTEM_POWER_OFF) {
  4771			pci_wake_from_d3(pdev, wake);
  4772			pci_set_power_state(pdev, PCI_D3hot);
  4773		}
  4774	}
  4775	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58658 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191114/4d4f9043/attachment-0001.bin>
