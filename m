From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu,  7 May 2020 14:25:45 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Warn if disabling ULP failed
Message-ID: <20200507062545.15461-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The hardware may stop working if driver failed to disable ULP mode.

Take the return value of e1000_disable_ulp_lpt_lp() into account, and
pass up the error if it fails.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 15f6c0a4dc63..9cbd2d6c7da4 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -300,7 +300,11 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 	 * so forcibly disable it.
 	 */
 	hw->dev_spec.ich8lan.ulp_state = e1000_ulp_state_unknown;
-	e1000_disable_ulp_lpt_lp(hw, true);
+	ret_val = e1000_disable_ulp_lpt_lp(hw, true);
+	if (ret_val) {
+		e_warn("Failed to disable ULP\n");
+		goto out;
+	}
 
 	ret_val = hw->phy.ops.acquire(hw);
 	if (ret_val) {
-- 
2.17.1

