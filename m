From: kbuild test robot <lkp@intel.com>
Date: Wed, 4 Jan 2017 21:37:36 +0800
Subject: [Intel-wired-lan] [PATCH 1/2] PCI: introduce locked
 pci_add/remove_virtfn
In-Reply-To: <20170104004826.17866.77074.stgit@localhost6.localdomain6>
Message-ID: <201701042115.UtFyvd0F%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Emil,

[auto build test ERROR on pci/next]
[also build test ERROR on v4.10-rc2 next-20170104]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Emil-Tantilov/PCI-introduce-locked-pci_add-remove_virtfn/20170104-193518
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/eeh_driver.c: In function 'eeh_add_virt_device':
>> arch/powerpc/kernel/eeh_driver.c:444:2: error: implicit declaration of function 'pci_iov_add_virtfn_locked' [-Werror=implicit-function-declaration]
     pci_iov_add_virtfn_locked(edev->physfn, pdn->vf_index, 0);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/eeh_driver.c: In function 'eeh_rmv_device':
>> arch/powerpc/kernel/eeh_driver.c:502:3: error: implicit declaration of function 'pci_iov_remove_virtfn_locked' [-Werror=implicit-function-declaration]
      pci_iov_remove_virtfn_locked(edev->physfn, pdn->vf_index, 0);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/pci_iov_add_virtfn_locked +444 arch/powerpc/kernel/eeh_driver.c

   438			eeh_pcid_put(dev);
   439			if (driver->err_handler)
   440				return NULL;
   441		}
   442	
   443	#ifdef CONFIG_PPC_POWERNV
 > 444		pci_iov_add_virtfn_locked(edev->physfn, pdn->vf_index, 0);
   445	#endif
   446		return NULL;
   447	}
   448	
   449	static void *eeh_rmv_device(void *data, void *userdata)
   450	{
   451		struct pci_driver *driver;
   452		struct eeh_dev *edev = (struct eeh_dev *)data;
   453		struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
   454		struct eeh_rmv_data *rmv_data = (struct eeh_rmv_data *)userdata;
   455		int *removed = rmv_data ? &rmv_data->removed : NULL;
   456	
   457		/*
   458		 * Actually, we should remove the PCI bridges as well.
   459		 * However, that's lots of complexity to do that,
   460		 * particularly some of devices under the bridge might
   461		 * support EEH. So we just care about PCI devices for
   462		 * simplicity here.
   463		 */
   464		if (!dev || (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE))
   465			return NULL;
   466	
   467		/*
   468		 * We rely on count-based pcibios_release_device() to
   469		 * detach permanently offlined PEs. Unfortunately, that's
   470		 * not reliable enough. We might have the permanently
   471		 * offlined PEs attached, but we needn't take care of
   472		 * them and their child devices.
   473		 */
   474		if (eeh_dev_removed(edev))
   475			return NULL;
   476	
   477		driver = eeh_pcid_get(dev);
   478		if (driver) {
   479			eeh_pcid_put(dev);
   480			if (removed &&
   481			    eeh_pe_passed(edev->pe))
   482				return NULL;
   483			if (removed &&
   484			    driver->err_handler &&
   485			    driver->err_handler->error_detected &&
   486			    driver->err_handler->slot_reset)
   487				return NULL;
   488		}
   489	
   490		/* Remove it from PCI subsystem */
   491		pr_debug("EEH: Removing %s without EEH sensitive driver\n",
   492			 pci_name(dev));
   493		edev->bus = dev->bus;
   494		edev->mode |= EEH_DEV_DISCONNECTED;
   495		if (removed)
   496			(*removed)++;
   497	
   498		if (edev->physfn) {
   499	#ifdef CONFIG_PPC_POWERNV
   500			struct pci_dn *pdn = eeh_dev_to_pdn(edev);
   501	
 > 502			pci_iov_remove_virtfn_locked(edev->physfn, pdn->vf_index, 0);
   503			edev->pdev = NULL;
   504	
   505			/*

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22266 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170104/faa65774/attachment-0001.bin>
