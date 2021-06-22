From: kernel test robot <lkp@intel.com>
Date: Tue, 22 Jun 2021 22:14:32 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 39/99]
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:180:35: error: no member
 named 'physfn' in 'struct pci_dev'
Message-ID: <202106222222.1oUMfsZm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   3717c1342e201571591f4602ca40b1858f15b47d
commit: 5086ff5c93e51e66935ddc19d6e536e92ab41b44 [39/99] i40e: Add restoration of VF MSI-X state during PCI reset
config: arm-randconfig-r016-20210622 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project b3634d3e88b7f26534a5057bff182b7dced584fc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=5086ff5c93e51e66935ddc19d6e536e92ab41b44
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 5086ff5c93e51e66935ddc19d6e536e92ab41b44
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:180:35: error: no member named 'physfn' in 'struct pci_dev'
                           if (vfdev->is_virtfn && vfdev->physfn == pdev)
                                                   ~~~~~  ^
   1 error generated.


vim +180 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

   154	
   155	/**
   156	 * i40e_restore_all_vfs_msi_state - restore VF MSI state after PF FLR
   157	 * @pdev: pointer to a pci_dev structure
   158	 *
   159	 * Called when recovering from a PF FLR to restore interrupt capability to
   160	 * the VFs.
   161	 */
   162	void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev)
   163	{
   164		struct pci_dev *vfdev;
   165		u16 vf_id;
   166		int pos;
   167	
   168		/* Continue only if this is a PF */
   169		if (!pdev->is_physfn)
   170			return;
   171	
   172		if (!pci_num_vf(pdev))
   173			return;
   174	
   175		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
   176		if (pos) {
   177			pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_id);
   178			vfdev = pci_get_device(pdev->vendor, vf_id, NULL);
   179			while (vfdev) {
 > 180				if (vfdev->is_virtfn && vfdev->physfn == pdev)
   181					pci_restore_msi_state(vfdev);
   182				vfdev = pci_get_device(pdev->vendor, vf_id, vfdev);
   183			}
   184		}
   185	}
   186	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25370 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210622/22615b8f/attachment-0001.bin>
