From: Kees Cook <keescook@chromium.org>
Date: Wed, 16 Jun 2021 12:53:44 -0700
Subject: [Intel-wired-lan] [PATCH] e100: Avoid memcpy() over-reading of
 ETH_SS_STATS
Message-ID: <20210616195344.1231850-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally reading across neighboring array fields.

The memcpy() is copying the entire structure, not just the first array.
Adjust the source argument so the compiler can do appropriate bounds
checking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/intel/e100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 1b0958bd24f6..1ec924c556c5 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2715,10 +2715,10 @@ static void e100_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *e100_gstrings_test, sizeof(e100_gstrings_test));
+		memcpy(data, e100_gstrings_test, sizeof(e100_gstrings_test));
 		break;
 	case ETH_SS_STATS:
-		memcpy(data, *e100_gstrings_stats, sizeof(e100_gstrings_stats));
+		memcpy(data, e100_gstrings_stats, sizeof(e100_gstrings_stats));
 		break;
 	}
 }
-- 
2.25.1

