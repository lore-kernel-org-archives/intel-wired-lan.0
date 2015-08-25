From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 24 Aug 2015 17:02:00 -0700
Subject: [Intel-wired-lan] [next-queue] fm10k: do not use enum as boolean
In-Reply-To: <1440460921-28318-1-git-send-email-jacob.e.keller@intel.com>
References: <1440460921-28318-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1440460921-28318-3-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Check for actual value NETREG_UNINITIALIZED in case it ever changes from
the current value of zero.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index cb5e3150048b..000f2b5ab3e5 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1905,7 +1905,7 @@ static void fm10k_init_reta(struct fm10k_intfc *interface)
 	u32 reta, base;
 
 	/* If the netdev is initialized we have to maintain table if possible */
-	if (interface->netdev->reg_state) {
+	if (interface->netdev->reg_state != NETREG_UNINITIALIZED) {
 		for (i = FM10K_RETA_SIZE; i--;) {
 			reta = interface->reta[i];
 			if ((((reta << 24) >> 24) < rss_i) &&
-- 
2.5.0.280.g4aaba03

