From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 16 Jun 2021 07:19:30 +0300
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Add space to the debug
 print
Message-ID: <20210616041930.1827357-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Minor fixes to allow debug prints more readable.

Fixes: 3cf31b1a9eff ("e1000e: bump up timeout to wait when ME un-configures ULP mode")
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
v1 -> v2: addressed compilation warnings
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 5b008c88beb7..49a6f8205403 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1271,9 +1271,11 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 			usleep_range(10000, 11000);
 		}
 		if (firmware_bug)
-			e_warn("ULP_CONFIG_DONE took %dmsec.  This is a firmware bug\n", i * 10);
+			e_warn("ULP_CONFIG_DONE took %dmsec. This is a firmware bug\n",
+			       i * 10);
 		else
-			e_dbg("ULP_CONFIG_DONE cleared after %dmsec\n", i * 10);
+			e_dbg("ULP_CONFIG_DONE cleared after %d msec\n",
+			      i * 10);
 
 		if (force) {
 			mac_reg = er32(H2ME);
-- 
2.25.1

