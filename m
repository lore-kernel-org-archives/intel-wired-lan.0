From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 18 Nov 2016 09:45:39 -0800
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: remove FM10K_FLAG_DEBUG_STATS
In-Reply-To: <20161118174539.30191-1-jacob.e.keller@intel.com>
References: <20161118174539.30191-1-jacob.e.keller@intel.com>
Message-ID: <20161118174539.30191-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The debug statistics were removed due to complications with the ethtool
statistics API which are not possible to resolve without a new
statistics interface. The flag was left behind, but we no longer need
it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 75d2c8018815..52b979443cde 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -261,7 +261,6 @@ struct fm10k_intfc {
 #define FM10K_FLAG_RSS_FIELD_IPV4_UDP		(u32)(BIT(1))
 #define FM10K_FLAG_RSS_FIELD_IPV6_UDP		(u32)(BIT(2))
 #define FM10K_FLAG_SWPRI_CONFIG			(u32)(BIT(3))
-#define FM10K_FLAG_DEBUG_STATS			(u32)(BIT(4))
 	int xcast_mode;
 
 	/* Tx fast path data */
-- 
2.11.0.rc2.152.g4d04e67

