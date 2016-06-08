From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 8 Jun 2016 09:07:19 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 42/43]
 drivers/net/ethernet/intel/i40e/i40e_main.c:10801:2: error: implicit
 declaration of function 'pci_request_mem_regions'
Message-ID: <201606080917.4Intz6Dd%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a078f654f7c05b787fc25f065db5fcb4ba25ea98
commit: f415332b9f716889afccde9c88dedfc9680eae1c [42/43] ethernet/intel: Use pci_(request|release)_mem_regions
config: x86_64-rhel (attached as .config)
compiler: gcc-4.9 (Debian 4.9.3-14) 4.9.3
reproduce:
        git checkout f415332b9f716889afccde9c88dedfc9680eae1c
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_probe':
>> drivers/net/ethernet/intel/i40e/i40e_main.c:10801:2: error: implicit declaration of function 'pci_request_mem_regions' [-Werror=implicit-function-declaration]
     err = pci_request_mem_regions(pdev, i40e_driver_name);
     ^
>> drivers/net/ethernet/intel/i40e/i40e_main.c:11298:2: error: implicit declaration of function 'pci_release_mem_regions' [-Werror=implicit-function-declaration]
     pci_release_mem_regions(pdev);
     ^
   cc1: some warnings being treated as errors

vim +/pci_request_mem_regions +10801 drivers/net/ethernet/intel/i40e/i40e_main.c

 10795					"DMA configuration failed: 0x%x\n", err);
 10796				goto err_dma;
 10797			}
 10798		}
 10799	
 10800		/* set up pci connections */
 10801		err = pci_request_mem_regions(pdev, i40e_driver_name);
 10802		if (err) {
 10803			dev_info(&pdev->dev,
 10804				 "pci_request_selected_regions failed %d\n", err);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37226 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160608/f49dc3c5/attachment-0001.obj>
