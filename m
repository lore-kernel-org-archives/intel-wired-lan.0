From: kbuild test robot <lkp@intel.com>
Date: Wed, 23 Dec 2015 19:15:43 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Use core to device
	locality interface
In-Reply-To: <1450864901-16712-2-git-send-email-daniel@numascale.com>
Message-ID: <201512231925.OCKKXQ6k%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Daniel,

[auto build test ERROR on pci/next]
[also build test ERROR on v4.4-rc6 next-20151223]

url:    https://github.com/0day-ci/linux/commits/Daniel-J-Blueman/PCI-Add-mechanism-to-find-topologically-near-cores/20151223-181947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: i386-randconfig-a0-12222034 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "cpu_near_dev" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25593 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151223/47038d47/attachment-0001.obj>
