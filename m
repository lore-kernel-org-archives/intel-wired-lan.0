From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 11 Apr 2019 09:11:35 -0700
Subject: [Intel-wired-lan] [PATCH 3/4] ixgbe: Use LLDP ethertype define
 ETH_P_LLDP
In-Reply-To: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
References: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190411161136.1541-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove references to IXGBE_ETH_P_LLD and use ETH_P_LLDP instead.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h       | 2 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index aa923d6d596b..39e73ad60352 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -50,8 +50,6 @@
 #define IXGBE_MAX_RXD			   4096
 #define IXGBE_MIN_RXD			     64
 
-#define IXGBE_ETH_P_LLDP		 0x88CC
-
 /* flow control */
 #define IXGBE_MIN_FCRTL			   0x40
 #define IXGBE_MAX_FCRTL			0x7FF80
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 345701af7749..537dfff585e0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1645,7 +1645,7 @@ int ixgbe_ndo_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting)
 		IXGBE_WRITE_REG(hw, IXGBE_ETQF(IXGBE_ETQF_FILTER_LLDP),
 				(IXGBE_ETQF_FILTER_EN    |
 				 IXGBE_ETQF_TX_ANTISPOOF |
-				 IXGBE_ETH_P_LLDP));
+				 ETH_P_LLDP));
 
 		IXGBE_WRITE_REG(hw, IXGBE_ETQF(IXGBE_ETQF_FILTER_FC),
 				(IXGBE_ETQF_FILTER_EN |
-- 
2.20.1

