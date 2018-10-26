From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 11:44:37 -0700
Subject: [Intel-wired-lan] [PATCH S9 05/15] ice: Remove ICE_MAX_TXQ_PER_TXQG
 check when configuring Tx queue
In-Reply-To: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026184447.13547-6-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>

This patch removes the condition checking of VSI TX queue number to
ICE_MAX_TXQ_PER_TXQG. This is an unnecessary check and causes a driver
load error on hosts that have more than 128 cores.

Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 53685a66125b..a5961a8fe73c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1633,10 +1633,6 @@ int ice_vsi_cfg_txqs(struct ice_vsi *vsi)
 	if (!qg_buf)
 		return -ENOMEM;
 
-	if (vsi->num_txq > ICE_MAX_TXQ_PER_TXQG) {
-		err = -EINVAL;
-		goto err_cfg_txqs;
-	}
 	qg_buf->num_txqs = 1;
 	num_q_grps = 1;
 
-- 
2.14.3

