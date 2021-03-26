From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 25 Mar 2021 17:38:27 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 04/11] igb/igc: use strongly
 typed pointer
In-Reply-To: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
Message-ID: <20210326003834.3886241-5-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The igb and igc driver both use a trick of creating a local type
pointer on the stack to ease dealing with a receive descriptor in
64 bit chunks for printing.  Sparse however was not taken into
account and receive descriptors are always in little endian
order, so just make the unions use __le64 instead of u64.

No functional change.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Warning Detail:
  CHECK   .../igb/igb_main.c
.../igb/igb_main.c:442:25: warning: cast to restricted __le64
.../igb/igb_main.c:442:25: warning: cast to restricted __le64
.../igb/igb_main.c:522:33: warning: cast to restricted __le64
.../igb/igb_main.c:522:33: warning: cast to restricted __le64
.../igb/igb_main.c:528:33: warning: cast to restricted __le64
.../igb/igb_main.c:528:33: warning: cast to restricted __le64
  CHECK   .../igc/igc_dump.c
.../igc/igc_dump.c:192:40: warning: cast to restricted __le64
.../igc/igc_dump.c:193:37: warning: cast to restricted __le64
.../igc/igc_dump.c:275:45: warning: cast to restricted __le64
.../igc/igc_dump.c:276:45: warning: cast to restricted __le64
.../igc/igc_dump.c:281:45: warning: cast to restricted __le64
.../igc/igc_dump.c:282:45: warning: cast to restricted __le64
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_dump.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 109279e1d667..697aa238ff16 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -356,7 +356,7 @@ static void igb_dump(struct igb_adapter *adapter)
 	struct igb_reg_info *reginfo;
 	struct igb_ring *tx_ring;
 	union e1000_adv_tx_desc *tx_desc;
-	struct my_u0 { u64 a; u64 b; } *u0;
+	struct my_u0 { __le64 a; __le64 b; } *u0;
 	struct igb_ring *rx_ring;
 	union e1000_adv_rx_desc *rx_desc;
 	u32 staterr;
diff --git a/drivers/net/ethernet/intel/igc/igc_dump.c b/drivers/net/ethernet/intel/igc/igc_dump.c
index 495bed47ed0a..c09c95cc5f70 100644
--- a/drivers/net/ethernet/intel/igc/igc_dump.c
+++ b/drivers/net/ethernet/intel/igc/igc_dump.c
@@ -112,7 +112,7 @@ static void igc_regdump(struct igc_hw *hw, struct igc_reg_info *reginfo)
 void igc_rings_dump(struct igc_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	struct my_u0 { u64 a; u64 b; } *u0;
+	struct my_u0 { __le64 a; __le64 b; } *u0;
 	union igc_adv_tx_desc *tx_desc;
 	union igc_adv_rx_desc *rx_desc;
 	struct igc_ring *tx_ring;
-- 
2.30.2

