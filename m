From: kernel test robot <lkp@intel.com>
Date: Tue, 29 Jun 2021 22:07:05 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 39/95]
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:180:35: error: 'struct
 pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
Message-ID: <202106292255.d8qIkPeN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   fec579f9f042a92f57f5dfd55d3dbf713959fd2f
commit: 23c24ae19d0b5cc56ff32b2b561601fd8e330334 [39/95] i40e: Add restoration of VF MSI-X state during PCI reset
config: alpha-randconfig-r032-20210628 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=23c24ae19d0b5cc56ff32b2b561601fd8e330334
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 23c24ae19d0b5cc56ff32b2b561601fd8e330334
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_restore_all_vfs_msi_state':
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:180:35: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
     180 |    if (vfdev->is_virtfn && vfdev->physfn == pdev)
         |                                   ^~~~~~
         |                                   is_physfn


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
Size: 35288 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210629/92810f7a/attachment-0001.bin>
