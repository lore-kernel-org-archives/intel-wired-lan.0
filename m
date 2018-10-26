From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 11:44:33 -0700
Subject: [Intel-wired-lan] [PATCH S9 01/15] ice: Increase rx queue disable
 timeout
In-Reply-To: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026184447.13547-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Raczynski <piotr.raczynski@intel.com>

With much traffic coming into the port, rx queue disable
procedure can take more time until all pending queue
requests on PCIe finish. Reuse ICE_Q_WAIT_MAX_RETRY macro
and increase the delay itself.

Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1efd760debc2..f6e21363c8d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -174,15 +174,15 @@ static int ice_pf_rxq_wait(struct ice_pf *pf, int pf_q, bool ena)
 {
 	int i;
 
-	for (i = 0; i < ICE_Q_WAIT_RETRY_LIMIT; i++) {
+	for (i = 0; i < ICE_Q_WAIT_MAX_RETRY; i++) {
 		u32 rx_reg = rd32(&pf->hw, QRX_CTRL(pf_q));
 
 		if (ena == !!(rx_reg & QRX_CTRL_QENA_STAT_M))
 			break;
 
-		usleep_range(10, 20);
+		usleep_range(20, 40);
 	}
-	if (i >= ICE_Q_WAIT_RETRY_LIMIT)
+	if (i >= ICE_Q_WAIT_MAX_RETRY)
 		return -ETIMEDOUT;
 
 	return 0;
-- 
2.14.3

