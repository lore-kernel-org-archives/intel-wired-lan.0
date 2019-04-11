From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 11 Apr 2019 09:11:32 -0700
Subject: [Intel-wired-lan] [PATCH 0/4] Introduce and use ETH_P_LLDP
Message-ID: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series introduces and uses a new define ETH_P_LLDP for the
Link Layer Discovery Protocol (LLDP) ethertype. Driver specific
defines for the same value (0x88CC) were removed.

Anirudh Venkataramanan (4):
  net: Add a define for LLDP ethertype
  i40e: Use LLDP ethertype define ETH_P_LLDP
  ixgbe: Use LLDP ethertype define ETH_P_LLDP
  net: hns3: Use LLDP ethertype define ETH_P_LLDP

 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 1 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 drivers/net/ethernet/intel/i40e/i40e.h                  | 2 --
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c          | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe.h                | 2 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c          | 2 +-
 include/uapi/linux/if_ether.h                           | 1 +
 7 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.20.1

