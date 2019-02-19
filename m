From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 19 Feb 2019 15:04:10 -0800
Subject: [Intel-wired-lan] [PATCH S15 10/14] ice: Update comment regarding
 the ITR_GRAN_S
In-Reply-To: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190219230414.25627-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Since the driver now hardcodes the ITR granularity to 2 us in the
GLINT_CTL register the comment next to ITR_GRAN_S needs to be updated.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 2c8af98ff640..60131b84b021 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -128,7 +128,7 @@ enum ice_rx_dtype {
 #define ICE_ITR_DYNAMIC	0x8000  /* used as flag for itr_setting */
 #define ITR_IS_DYNAMIC(setting) (!!((setting) & ICE_ITR_DYNAMIC))
 #define ITR_TO_REG(setting)	((setting) & ~ICE_ITR_DYNAMIC)
-#define ICE_ITR_GRAN_S		1	/* Assume ITR granularity is 2us */
+#define ICE_ITR_GRAN_S		1	/* ITR granularity is always 2us */
 #define ICE_ITR_GRAN_US		BIT(ICE_ITR_GRAN_S)
 #define ICE_ITR_MASK		0x1FFE	/* ITR register value alignment mask */
 #define ITR_REG_ALIGN(setting)	__ALIGN_MASK(setting, ~ICE_ITR_MASK)
-- 
2.14.5

