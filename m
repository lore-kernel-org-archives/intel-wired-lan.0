From: Preethi Banala <preethi.banala@intel.com>
Date: Thu, 21 Apr 2016 11:40:24 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Return 64 bit stats values
Message-ID: <20160421184024.14525.87965.stgit@ixgbe-dev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The code was ignoring higher 32 bits of stats registers. This patch
correctly fills out 64 bit value in two 32 bit words.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 5d009f04e37f..b59e3057f291 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -722,8 +722,10 @@ static void ixgbe_get_regs(struct net_device *netdev,
 	regs_buff[939] = IXGBE_GET_STAT(adapter, bprc);
 	regs_buff[940] = IXGBE_GET_STAT(adapter, mprc);
 	regs_buff[941] = IXGBE_GET_STAT(adapter, gptc);
-	regs_buff[942] = IXGBE_GET_STAT(adapter, gorc);
-	regs_buff[944] = IXGBE_GET_STAT(adapter, gotc);
+	regs_buff[942] = (u32)IXGBE_GET_STAT(adapter, gorc);
+	regs_buff[943] = (u32)(IXGBE_GET_STAT(adapter, gorc) >> 32);
+	regs_buff[944] = (u32)IXGBE_GET_STAT(adapter, gotc);
+	regs_buff[945] = (u32)(IXGBE_GET_STAT(adapter, gotc) >> 32);
 	for (i = 0; i < 8; i++)
 		regs_buff[946 + i] = IXGBE_GET_STAT(adapter, rnbc[i]);
 	regs_buff[954] = IXGBE_GET_STAT(adapter, ruc);
@@ -733,7 +735,8 @@ static void ixgbe_get_regs(struct net_device *netdev,
 	regs_buff[958] = IXGBE_GET_STAT(adapter, mngprc);
 	regs_buff[959] = IXGBE_GET_STAT(adapter, mngpdc);
 	regs_buff[960] = IXGBE_GET_STAT(adapter, mngptc);
-	regs_buff[961] = IXGBE_GET_STAT(adapter, tor);
+	regs_buff[961] = (u32)IXGBE_GET_STAT(adapter, tor);
+	regs_buff[962] = (u32)(IXGBE_GET_STAT(adapter, tor) >> 32);
 	regs_buff[963] = IXGBE_GET_STAT(adapter, tpr);
 	regs_buff[964] = IXGBE_GET_STAT(adapter, tpt);
 	regs_buff[965] = IXGBE_GET_STAT(adapter, ptc64);

