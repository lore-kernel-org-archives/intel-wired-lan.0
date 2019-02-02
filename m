From: kbuild test robot <lkp@intel.com>
Date: Sat, 2 Feb 2019 12:32:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 34/35]
 include/linux/pci.h:1430:24: error: expected '; ' before '}' token
Message-ID: <201902021221.5yB9l7M6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   e28dbaae40bb2490a64d53ad205b4813ada4fbcd
commit: 7c0787107a92381676fd221dc3d7bc87c60f41e1 [34/35] PCI/MSI: Free MSI-X resources by group
config: i386-randconfig-x006-201904 (attached as .config)
compiler: gcc-8 (Debian 8.2.0-14) 8.2.0
reproduce:
        git checkout 7c0787107a92381676fd221dc3d7bc87c60f41e1
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/setup.c:47:
   include/linux/pci.h: In function 'pci_disable_msix_grp':
>> include/linux/pci.h:1430:24: error: expected ';' before '}' token
           { return -ENOSYS}
                           ^
   include/linux/pci.h: In function 'pci_free_irq_vectors_grp':
   include/linux/pci.h:1469:9: warning: 'return' with a value, in function returning void
     return 0;
            ^
   include/linux/pci.h:1467:20: note: declared here
    static inline void pci_free_irq_vectors_grp(struct pci_dev *dev, int group_id)
                       ^~~~~~~~~~~~~~~~~~~~~~~~

vim +1430 include/linux/pci.h

  1423	
  1424	#else
  1425	static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
  1426	static inline void pci_disable_msi(struct pci_dev *dev) { }
  1427	static inline int pci_msix_vec_count(struct pci_dev *dev) { return -ENOSYS; }
  1428	static inline void pci_disable_msix(struct pci_dev *dev) { }
  1429	static inline int pci_disable_msix_grp(struct pci_dev *dev, int group_id)
> 1430								{ return -ENOSYS}
  1431	static inline void pci_restore_msi_state(struct pci_dev *dev) { }
  1432	static inline int pci_msi_enabled(void) { return 0; }
  1433	static inline int pci_enable_msi(struct pci_dev *dev)
  1434	{ return -ENOSYS; }
  1435	static inline int pci_enable_msix_range(struct pci_dev *dev,
  1436				struct msix_entry *entries, int minvec, int maxvec)
  1437	{ return -ENOSYS; }
  1438	static inline int pci_enable_msix_exact(struct pci_dev *dev,
  1439				struct msix_entry *entries, int nvec)
  1440	{ return -ENOSYS; }
  1441	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33598 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190202/5439ff7a/attachment-0001.bin>
