From: Greg Thelen <gthelen@google.com>
Date: Sat, 13 Jun 2020 23:11:22 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: add ifdef to avoid dead code
Message-ID: <20200614061122.35928-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME
systems") added e1000e_check_me() but it's only called from
CONFIG_PM_SLEEP protected code.  Thus builds without CONFIG_PM_SLEEP
see:
  drivers/net/ethernet/intel/e1000e/netdev.c:137:13: warning: 'e1000e_check_me' defined but not used [-Wunused-function]

Add CONFIG_PM_SLEEP ifdef guard to avoid dead code.

Fixes: e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME systems")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index a279f4fa9962..165f0aea22c9 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -107,6 +107,7 @@ static const struct e1000_reg_info e1000_reg_info_tbl[] = {
 	{0, NULL}
 };
 
+#ifdef CONFIG_PM_SLEEP
 struct e1000e_me_supported {
 	u16 device_id;		/* supported device ID */
 };
@@ -145,6 +146,7 @@ static bool e1000e_check_me(u16 device_id)
 
 	return false;
 }
+#endif /* CONFIG_PM_SLEEP */
 
 /**
  * __ew32_prepare - prepare to write to MAC CSR register on certain parts
-- 
2.27.0.290.gba653c62da-goog

