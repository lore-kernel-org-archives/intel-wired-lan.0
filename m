From: kbuild test robot <lkp@intel.com>
Date: Thu, 14 Apr 2016 07:39:09 +0800
Subject: [Intel-wired-lan] [PATCH] [net-next] net: ixgbe: Match on
 multiple headers for cls_u32 offloads
In-Reply-To: <20160413233059.6737.4065.stgit@sdncamp.jf.intel.com>
Message-ID: <201604140711.lY1h6VUh%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Amritha,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[cannot apply to v4.6-rc3 next-20160413]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Amritha-Nambiar/net-ixgbe-Match-on-multiple-headers-for-cls_u32-offloads/20160414-073100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: i386-randconfig-x003-201615 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_sw_init':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:5617:7: error: 'j' undeclared (first use in this function)
     for (j = 1; j < IXGBE_MAX_LINK_HANDLE; j++)
          ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:5617:7: note: each undeclared identifier is reported only once for each function it appears in

vim +/j +5617 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  5611		adapter->jump_tables[0] = kzalloc(sizeof(*adapter->jump_tables[0]),
  5612						  GFP_KERNEL);
  5613		if (!adapter->jump_tables[0])
  5614			return -ENOMEM;
  5615		adapter->jump_tables[0]->mat = ixgbe_ipv4_fields;
  5616	
> 5617		for (j = 1; j < IXGBE_MAX_LINK_HANDLE; j++)
  5618			adapter->jump_tables[j] = NULL;
  5619	
  5620		adapter->mac_table = kzalloc(sizeof(struct ixgbe_mac_addr) *

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 30233 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160414/0ba3ce88/attachment-0001.obj>
