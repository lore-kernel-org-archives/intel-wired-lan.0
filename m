From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 21 Oct 2015 08:47:24 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 71/77]
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c:1733:2: error: too many
 arguments to function 'fm10k_dcbnl_set_ops'
Message-ID: <201510210822.8OAYxNgA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   18d709528c94cdf8c15cd0bf4deb2f5c3b9c655a
commit: c90f3cb604214aceecf2271c3d32e48159b23d7c [71/77] fm10k: conditionally compile DCB and DebugFS support
config: i386-randconfig-a0-201542 (attached as .config)
reproduce:
        git checkout c90f3cb604214aceecf2271c3d32e48159b23d7c
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/fm10k/fm10k_pci.c: In function 'fm10k_sw_init':
>> drivers/net/ethernet/intel/fm10k/fm10k_pci.c:1733:2: error: too many arguments to function 'fm10k_dcbnl_set_ops'
     fm10k_dcbnl_set_ops(netdev);
     ^
   In file included from drivers/net/ethernet/intel/fm10k/fm10k_pci.c:24:0:
   drivers/net/ethernet/intel/fm10k/fm10k.h:557:20: note: declared here
    static inline void fm10k_dcbnl_set_ops(void) {}
                       ^

vim +/fm10k_dcbnl_set_ops +1733 drivers/net/ethernet/intel/fm10k/fm10k_pci.c

0e7b3644 Alexander Duyck 2014-09-20  1727  		netdev->hw_enc_features = 0;
0e7b3644 Alexander Duyck 2014-09-20  1728  		netdev->features &= ~NETIF_F_GSO_UDP_TUNNEL;
0e7b3644 Alexander Duyck 2014-09-20  1729  		netdev->hw_features &= ~NETIF_F_GSO_UDP_TUNNEL;
0e7b3644 Alexander Duyck 2014-09-20  1730  	}
0e7b3644 Alexander Duyck 2014-09-20  1731  
9f801abc Alexander Duyck 2014-09-20  1732  	/* initialize DCBNL interface */
9f801abc Alexander Duyck 2014-09-20 @1733  	fm10k_dcbnl_set_ops(netdev);
9f801abc Alexander Duyck 2014-09-20  1734  
b7d8514c Alexander Duyck 2014-09-20  1735  	/* Initialize service timer and service task */
b7d8514c Alexander Duyck 2014-09-20  1736  	set_bit(__FM10K_SERVICE_DISABLE, &interface->state);

:::::: The code at line 1733 was first introduced by commit
:::::: 9f801abc3d4fe1e770268ae4e610556e79be6fca fm10k: Add support for IEEE DCBx

:::::: TO: Alexander Duyck <alexander.h.duyck@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 26935 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151021/c1577f8c/attachment-0001.obj>
