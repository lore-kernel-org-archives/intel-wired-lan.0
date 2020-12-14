From: Mario Limonciello <mario.limonciello@dell.com>
Date: Mon, 14 Dec 2020 09:34:48 -0600
Subject: [Intel-wired-lan] [PATCH 2/4] e1000e: bump up timeout to wait when
 ME un-configure ULP mode
In-Reply-To: <20201214153450.874339-1-mario.limonciello@dell.com>
References: <20201214153450.874339-1-mario.limonciello@dell.com>
Message-ID: <20201214153450.874339-3-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Per guidance from Intel ethernet architecture team, it may take
up to 1 second for unconfiguring ULP mode.

Suggested-by: Aaron Ma <aaron.ma@canonical.com>
Suggested-by: Sasha Netfin <sasha.neftin@intel.com>
Fixes: f15bb6dde738cc8fa0 ("e1000e: Add support for S0ix")
BugLink: https://bugs.launchpad.net/bugs/1865570
Link: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20200323191639.48826-1-aaron.ma at canonical.com/
Link: https://lkml.org/lkml/2020/12/13/15
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 9aa6fad8ed47..4621d01e8a24 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1248,9 +1248,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 			ew32(H2ME, mac_reg);
 		}
 
-		/* Poll up to 300msec for ME to clear ULP_CFG_DONE. */
+		/* Poll up to 1 second for ME to clear ULP_CFG_DONE. */
 		while (er32(FWSM) & E1000_FWSM_ULP_CFG_DONE) {
-			if (i++ == 30) {
+			if (i++ == 100) {
 				ret_val = -E1000_ERR_PHY;
 				goto out;
 			}
-- 
2.25.1

