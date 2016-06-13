From: kbuild test robot <lkp@intel.com>
Date: Tue, 14 Jun 2016 02:48:03 +0800
Subject: [Intel-wired-lan] [net-next PATCH 03/15] bnx2x: Move all UDP
 port notifiers to single function
In-Reply-To: <20160613174815.15186.73559.stgit@localhost.localdomain>
Message-ID: <201606140200.0FONBvE9%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

[auto build test ERROR on net/master]
[also build test ERROR on v4.7-rc3 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/Future-proof-tunnel-offload-handlers/20160614-020534
config: x86_64-allyesdebian (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:13046:26: error: 'bnx2x_add_udp_enc_port' undeclared here (not in a function)
     .ndo_add_udp_enc_port = bnx2x_add_udp_enc_port,
                             ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:13047:26: error: 'bnx2x_del_udp_enc_port' undeclared here (not in a function)
     .ndo_del_udp_enc_port = bnx2x_del_udp_enc_port,
                             ^~~~~~~~~~~~~~~~~~~~~~

vim +/bnx2x_add_udp_enc_port +13046 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c

 13040		.ndo_fcoe_get_wwn	= bnx2x_fcoe_get_wwn,
 13041	#endif
 13042	
 13043		.ndo_get_phys_port_id	= bnx2x_get_phys_port_id,
 13044		.ndo_set_vf_link_state	= bnx2x_set_vf_link_state,
 13045		.ndo_features_check	= bnx2x_features_check,
 13046		.ndo_add_udp_enc_port	= bnx2x_add_udp_enc_port,
 13047		.ndo_del_udp_enc_port	= bnx2x_del_udp_enc_port,
 13048	};
 13049	
 13050	static int bnx2x_set_coherency_mask(struct bnx2x *bp)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37219 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160614/23f69e85/attachment-0001.obj>
