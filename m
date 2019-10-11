From: kbuild test robot <lkp@intel.com>
Date: Fri, 11 Oct 2019 11:50:05 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 41/42]
 drivers/net/ethernet/intel/e1000e/netdev.c:7087:2: error: implicit
 declaration of function 'e1000e_pm_thaw'; did you mean 'e1000e_pm_freeze'?
Message-ID: <201910111125.ocuCRCAm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a66faf201b1e169f5c2cd8660f8a9923ce697b5e
commit: e39f323ba1731ebb9c0a53b70829f01f77cd486b [41/42] e1000e: Use rtnl_lock to prevent race conditions between net and pci/pm
config: sparc64-defconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e39f323ba1731ebb9c0a53b70829f01f77cd486b
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/e1000e/netdev.c: In function 'e1000_io_resume':
>> drivers/net/ethernet/intel/e1000e/netdev.c:7087:2: error: implicit declaration of function 'e1000e_pm_thaw'; did you mean 'e1000e_pm_freeze'? [-Werror=implicit-function-declaration]
     e1000e_pm_thaw(&pdev->dev);
     ^~~~~~~~~~~~~~
     e1000e_pm_freeze
   At top level:
   drivers/net/ethernet/intel/e1000e/netdev.c:6407:12: warning: 'e1000e_s0ix_exit_flow' defined but not used [-Wunused-function]
    static int e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/e1000e/netdev.c:6298:12: warning: 'e1000e_s0ix_entry_flow' defined but not used [-Wunused-function]
    static int e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
               ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +7087 drivers/net/ethernet/intel/e1000e/netdev.c

  7071	
  7072	/**
  7073	 * e1000_io_resume - called when traffic can start flowing again.
  7074	 * @pdev: Pointer to PCI device
  7075	 *
  7076	 * This callback is called when the error recovery driver tells us that
  7077	 * its OK to resume normal operation. Implementation resembles the
  7078	 * second-half of the e1000e_pm_resume routine.
  7079	 */
  7080	static void e1000_io_resume(struct pci_dev *pdev)
  7081	{
  7082		struct net_device *netdev = pci_get_drvdata(pdev);
  7083		struct e1000_adapter *adapter = netdev_priv(netdev);
  7084	
  7085		e1000_init_manageability_pt(adapter);
  7086	
> 7087		e1000e_pm_thaw(&pdev->dev);
  7088	
  7089		/* If the controller has AMT, do not set DRV_LOAD until the interface
  7090		 * is up.  For all other cases, let the f/w know that the h/w is now
  7091		 * under the control of the driver.
  7092		 */
  7093		if (!(adapter->flags & FLAG_HAS_AMT))
  7094			e1000e_get_hw_control(adapter);
  7095	}
  7096	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 18919 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191011/7a1b45a0/attachment-0001.bin>
