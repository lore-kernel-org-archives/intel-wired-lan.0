From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:34:56 -0700
Subject: [Intel-wired-lan] [PATCH S21 07/14] ice: Change minimum descriptor
 count value for Tx/Rx rings
In-Reply-To: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173503.29847-8-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Preethi Banala <preethi.banala@intel.com>

Change minimum number of descriptor count from 32 to 64. This is to have
a feature parity with previous Intel NIC drivers.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fe7241df8ee5..7c9647082939 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -44,7 +44,7 @@
 extern const char ice_drv_ver[];
 #define ICE_BAR0		0
 #define ICE_REQ_DESC_MULTIPLE	32
-#define ICE_MIN_NUM_DESC	ICE_REQ_DESC_MULTIPLE
+#define ICE_MIN_NUM_DESC	64
 #define ICE_MAX_NUM_DESC	8160
 #define ICE_DFLT_MIN_RX_DESC	512
 /* if the default number of Rx descriptors between ICE_MAX_NUM_DESC and the
-- 
2.20.1

