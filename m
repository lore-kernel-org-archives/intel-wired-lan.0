From: kernel test robot <lkp@intel.com>
Date: Mon, 21 Feb 2022 20:46:59 +0800
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Add restoration of VF
 MSI-X state during PCI reset
In-Reply-To: <20220221103115.32319-1-mateusz.palczewski@intel.com>
References: <20220221103115.32319-1-mateusz.palczewski@intel.com>
Message-ID: <202202212032.vtYT36Q4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mateusz,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net/master]

url:    https://github.com/0day-ci/linux/commits/Mateusz-Palczewski/i40e-Add-restoration-of-VF-MSI-X-state-during-PCI-reset/20220221-183514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 8940e6b669ca1196ce0a0549c819078096390f76
config: ia64-buildonly-randconfig-r002-20220221 (https://download.01.org/0day-ci/archive/20220221/202202212032.vtYT36Q4-lkp at intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c0bd3a5312cdc4bfebb4724cc4e881f747b4f80b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mateusz-Palczewski/i40e-Add-restoration-of-VF-MSI-X-state-during-PCI-reset/20220221-183514
        git checkout c0bd3a5312cdc4bfebb4724cc4e881f747b4f80b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/ethernet/intel/i40e/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_restore_all_vfs_msi_state':
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:180:66: warning: comparison between pointer and integer
     180 |                         if (vfdev->is_virtfn && vfdev->is_physfn == pdev)
         |                                                                  ^~


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
 > 180				if (vfdev->is_virtfn && vfdev->is_physfn == pdev)
   181					pci_restore_msi_state(vfdev);
   182				vfdev = pci_get_device(pdev->vendor, vf_id, vfdev);
   183			}
   184		}
   185	}
   186	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
