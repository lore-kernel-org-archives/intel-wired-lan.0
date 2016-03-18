From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 18 Mar 2016 20:57:20 +0800
Subject: [Intel-wired-lan] [linux-next:master 4434/12950]
 drivers/net/ethernet/intel/igb/igb_main.c:5968:6: sparse: symbol
 'igb_update_pf_vlvf' was not declared. Should it be static?
Message-ID: <201603182037.3GXZMnJi%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   5e3497cca281616e7930b74a0076b7324dcc2057
commit: 16903caa339961b9f8a68b64f4f313789de48599 [4434/12950] igb: Add support for VLAN promiscuous with SR-IOV and NTUPLE
reproduce:
        # apt-get install sparse
        git checkout 16903caa339961b9f8a68b64f4f313789de48599
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/igb/igb_main.c:7785:33: sparse: incorrect type in argument 1 (different base types)
   drivers/net/ethernet/intel/igb/igb_main.c:7785:33:    expected restricted __le32 const [usertype] *p
   drivers/net/ethernet/intel/igb/igb_main.c:7785:33:    got restricted __be32 [usertype] *<noident>
   drivers/net/ethernet/intel/igb/igb_main.c:7786:34: sparse: incorrect type in argument 1 (different base types)
   drivers/net/ethernet/intel/igb/igb_main.c:7786:34:    expected restricted __le16 const [usertype] *p
   drivers/net/ethernet/intel/igb/igb_main.c:7786:34:    got restricted __be16 [usertype] *<noident>
   drivers/net/ethernet/intel/igb/igb_main.c:454:25: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igb/igb_main.c:454:25: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igb/igb_main.c:534:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igb/igb_main.c:534:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igb/igb_main.c:540:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igb/igb_main.c:540:33: sparse: cast to restricted __le64
>> drivers/net/ethernet/intel/igb/igb_main.c:5968:6: sparse: symbol 'igb_update_pf_vlvf' was not declared. Should it be static?
   drivers/net/ethernet/intel/igb/igb_main.c:6987:31: sparse: cast to restricted __be16
   drivers/net/ethernet/intel/igb/igb_main.c:6987:31: sparse: cast from restricted __le16
   drivers/net/ethernet/intel/igb/igb_main.c:6987:31: sparse: cast to restricted __be16
   drivers/net/ethernet/intel/igb/igb_main.c:6987:31: sparse: cast from restricted __le16
   drivers/net/ethernet/intel/igb/igb_main.c:6987:31: sparse: cast to restricted __be16
   drivers/net/ethernet/intel/igb/igb_main.c:6987:31: sparse: cast from restricted __le16
   drivers/net/ethernet/intel/igb/igb_main.c:6987:31: sparse: cast to restricted __be16
   drivers/net/ethernet/intel/igb/igb_main.c:6987:31: sparse: cast from restricted __le16

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
