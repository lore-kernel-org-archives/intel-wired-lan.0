From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:51 -0800
Subject: [Intel-wired-lan] [PATCH S12 04/14] ice: remove redundant variable
 and if condition
In-Reply-To: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205101.12078-5-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

In ice_pf_rxq_wait we are using an unnecessary local variable and also
we are checking if the timeout time was reached after the loop. Get rid
of the local variable and return 0 right when we get a successful
result. This makes it so we can return -ETIMEDOUT if we ever exit the
loop because we know the timeout time has been hit.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index fa61203bee26..5215180d08a3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -175,17 +175,14 @@ static int ice_pf_rxq_wait(struct ice_pf *pf, int pf_q, bool ena)
 	int i;
 
 	for (i = 0; i < ICE_Q_WAIT_MAX_RETRY; i++) {
-		u32 rx_reg = rd32(&pf->hw, QRX_CTRL(pf_q));
-
-		if (ena == !!(rx_reg & QRX_CTRL_QENA_STAT_M))
-			break;
+		if (ena == !!(rd32(&pf->hw, QRX_CTRL(pf_q)) &
+			      QRX_CTRL_QENA_STAT_M))
+			return 0;
 
 		usleep_range(20, 40);
 	}
-	if (i >= ICE_Q_WAIT_MAX_RETRY)
-		return -ETIMEDOUT;
 
-	return 0;
+	return -ETIMEDOUT;
 }
 
 /**
-- 
2.14.5

