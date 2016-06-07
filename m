From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 8 Jun 2016 07:15:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 42/43]
 drivers/net/ethernet/intel/e1000e/netdev.c:7336:2: error: implicit
 declaration of function 'pci_release_mem_regions'
Message-ID: <201606080714.prSj96xd%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a078f654f7c05b787fc25f065db5fcb4ba25ea98
commit: f415332b9f716889afccde9c88dedfc9680eae1c [42/43] ethernet/intel: Use pci_(request|release)_mem_regions
config: x86_64-randconfig-i0-201623 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        git checkout f415332b9f716889afccde9c88dedfc9680eae1c
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/e1000e/netdev.c: In function 'e1000_probe':
>> drivers/net/ethernet/intel/e1000e/netdev.c:7336:2: error: implicit declaration of function 'pci_release_mem_regions' [-Werror=implicit-function-declaration]
     pci_release_mem_regions(pdev);
     ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/intel/igb/igb_main.c: In function 'igb_probe':
>> drivers/net/ethernet/intel/igb/igb_main.c:2327:8: error: implicit declaration of function 'pci_request_mem_regions' [-Werror=implicit-function-declaration]
     err = pci_request_mem_regions(pdev, igb_driver_name);
           ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/igb/igb_main.c:2751:2: error: implicit declaration of function 'pci_release_mem_regions' [-Werror=implicit-function-declaration]
     pci_release_mem_regions(pdev);
     ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_probe':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9404:8: error: implicit declaration of function 'pci_request_mem_regions' [-Werror=implicit-function-declaration]
     err = pci_request_mem_regions(pdev, ixgbe_driver_name);
           ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9790:2: error: implicit declaration of function 'pci_release_mem_regions' [-Werror=implicit-function-declaration]
     pci_release_mem_regions(pdev);
     ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pci_release_mem_regions +7336 drivers/net/ethernet/intel/e1000e/netdev.c

  7330		e1000e_reset_interrupt_capability(adapter);
  7331	err_flashmap:
  7332		iounmap(adapter->hw.hw_addr);
  7333	err_ioremap:
  7334		free_netdev(netdev);
  7335	err_alloc_etherdev:
> 7336		pci_release_mem_regions(pdev);
  7337	err_pci_reg:
  7338	err_dma:
  7339		pci_disable_device(pdev);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23308 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160608/ec1ce81a/attachment-0001.obj>
