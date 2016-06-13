From: kbuild test robot <lkp@intel.com>
Date: Tue, 14 Jun 2016 03:42:37 +0800
Subject: [Intel-wired-lan] [PATCH v6 3/3] PCI: Add PTM clock granularity
	information
In-Reply-To: <20160613190550.12503.18319.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <201606140328.v6pgxin6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

[auto build test WARNING on pci/next]
[also build test WARNING on v4.7-rc3 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bjorn-Helgaas/PCI-Precision-Time-Measurement-support/20160614-031902
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: i386-defconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/pci/pcie/ptm.c: In function 'pci_enable_ptm':
>> drivers/pci/pcie/ptm.c:129:28: warning: 'ups' may be used uninitialized in this function [-Wmaybe-uninitialized]
     dev->ptm_granularity = ups->ptm_granularity;
                            ~~~^~~~~~~~~~~~~~~~~

vim +/ups +129 drivers/pci/pcie/ptm.c

   113		 * For Root Complex Integrated Endpoints, there is no upstream
   114		 * device, so there must be some implementation-specific way to
   115		 * associate the endpoint with a time source.
   116		 */
   117		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
   118			/* PTM is only useful if an upstream device has it enabled */
   119			ups = pci_upstream_bridge(dev);
   120			if (!ups || !ups->ptm_enabled)
   121				return -EINVAL;
   122		} else if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END)
   123			return -EINVAL;
   124	
   125		pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
   126		if (!(cap & PCI_PTM_CAP_REQ))
   127			return -EINVAL;
   128	
 > 129		dev->ptm_granularity = ups->ptm_granularity;
   130	
   131		ctrl = PCI_PTM_CTRL_ENABLE;
   132		pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
   133		dev->ptm_enabled = 1;
   134	
   135		pci_ptm_info(dev);
   136	
   137		if (granularity)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24885 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160614/3a2d613a/attachment-0001.obj>
