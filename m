From: Corentin Labbe <clabbe@baylibre.com>
Date: Mon, 29 Jan 2018 12:17:54 +0000
Subject: [Intel-wired-lan] [PATCH] Documentation: networking: ixgb: Remove
 reference to IXGB_NAPI
Message-ID: <1517228274-1305-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

NAPI is enabled by default and IXGB_NAPI was removed since
commit 6d37ab282e24 ("ixgb: make NAPI the only option and the default")
Update the doc accordingly.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/networking/ixgb.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/networking/ixgb.txt b/Documentation/networking/ixgb.txt
index b10f360c57d4..82f9dc9ba399 100644
--- a/Documentation/networking/ixgb.txt
+++ b/Documentation/networking/ixgb.txt
@@ -324,8 +324,7 @@ Additional Configurations
   NAPI
   ----
 
-  NAPI (Rx polling mode) is supported in the ixgb driver.  NAPI is enabled
-  or disabled based on the configuration of the kernel.  see CONFIG_IXGB_NAPI
+  NAPI (Rx polling mode) is supported in the ixgb driver.
 
   See www.cyberus.ca/~hadi/usenix-paper.tgz for more information on NAPI.
 
-- 
2.13.6

