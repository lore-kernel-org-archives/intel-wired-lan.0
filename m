From: Raanan Avargil <raanan.avargil@intel.com>
Date: Wed,  5 Aug 2015 17:13:55 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: Cosmetic change - wrap line
In-Reply-To: <eb0fc1b6ebdfe79027886fbf2f64f985a413614d.1437312332.git.raanan.avargil@intel.com>
References: <eb0fc1b6ebdfe79027886fbf2f64f985a413614d.1437312332.git.raanan.avargil@intel.com>
Message-ID: <1438784035-4741-1-git-send-email-raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Wrap line as it was too long

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index b3e6c4a..10cb550 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4297,7 +4297,8 @@ static cycle_t e1000e_cyclecounter_read(const struct cyclecounter *cc)
 		systim = (cycle_t)systimel_1;
 		systim |= (cycle_t)systimeh << 32;
 	} else {
-		/* There was an overflow, read again SYSTIMH, and use systimel_2 */
+		/* There was an overflow.
+		 * Read again SYSTIMH, and use systimel_2 */
 		systimeh = er32(SYSTIMH);
 		systim = (cycle_t)systimel_2;
 		systim |= (cycle_t)systimeh << 32;
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

