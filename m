From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 20 Nov 2015 13:02:16 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix RSS limit for X550
Message-ID: <20151120210216.15810.9572.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

X550 allows for up to 64 RSS queues, but the driver can have max
of 63 (-1 MSIX vector for link).

On systems with >= 64 CPUs the driver will set the redirection table
for all 64 queues which will result in packets being dropped.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index f4c9a42..4b9156c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -317,7 +317,7 @@ enum ixgbe_ring_f_enum {
 };
 
 #define IXGBE_MAX_RSS_INDICES		16
-#define IXGBE_MAX_RSS_INDICES_X550	64
+#define IXGBE_MAX_RSS_INDICES_X550	63
 #define IXGBE_MAX_VMDQ_INDICES		64
 #define IXGBE_MAX_FDIR_INDICES		63	/* based on q_vector limit */
 #define IXGBE_MAX_FCOE_INDICES		8

