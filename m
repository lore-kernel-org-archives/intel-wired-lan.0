From: Aaron Ma <aaron.ma@canonical.com>
Date: Thu, 18 Jun 2020 14:45:04 +0800
Subject: [Intel-wired-lan] [v3][PATCH] e1000e: continue to init phy even
 when failed to disable ULP
In-Reply-To: <20200616100512.22512-1-aaron.ma@canonical.com>
References: <20200616100512.22512-1-aaron.ma@canonical.com>
Message-ID: <20200618064504.11588-1-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

After commit: e086ba2fccda4 ("e1000e: disable s0ix entry and exit flows
 for ME systems").
ThinkPad P14s always failed to disable ULP by ME.
commit: 0c80cdbf3320 ("e1000e: Warn if disabling ULP failed")
break out of init phy:

error log:
[   42.364753] e1000e 0000:00:1f.6 enp0s31f6: Failed to disable ULP
[   42.524626] e1000e 0000:00:1f.6 enp0s31f6: PHY Wakeup cause - Unicast Packet
[   42.822476] e1000e 0000:00:1f.6 enp0s31f6: Hardware Error

When disable s0ix, E1000_FWSM_ULP_CFG_DONE will never be 1.
If continue to init phy like before, it can work as before.
iperf test result good too.

Fixes: 0c80cdbf3320 ("e1000e: Warn if disabling ULP failed")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index f999cca37a8a..be7475c5529d 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -303,7 +303,6 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 	ret_val = e1000_disable_ulp_lpt_lp(hw, true);
 	if (ret_val) {
 		e_warn("Failed to disable ULP\n");
-		goto out;
 	}
 
 	ret_val = hw->phy.ops.acquire(hw);
-- 
2.26.2

