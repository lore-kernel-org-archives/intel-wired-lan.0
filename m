From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 13 Apr 2016 14:31:23 -0700
Subject: [Intel-wired-lan] [PATCH v1 12/13] e1000e: mark shifted values as
	unsigned
In-Reply-To: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
References: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1460583084-16900-13-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The E1000_ICH_NVM_SIG_MASK value is shifted, out to the 31st bit, which
is the signed bit for signed constants. Mark these values as unsigned to
prevent compiler warnings and issues on platforms which a different
signed bit implementation.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 2311f6003f58..67163ca898ba 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -73,10 +73,10 @@
 				 (ID_LED_OFF1_ON2  <<  4) | \
 				 (ID_LED_DEF1_DEF2))
 
-#define E1000_ICH_NVM_SIG_WORD		0x13
-#define E1000_ICH_NVM_SIG_MASK		0xC000
-#define E1000_ICH_NVM_VALID_SIG_MASK	0xC0
-#define E1000_ICH_NVM_SIG_VALUE		0x80
+#define E1000_ICH_NVM_SIG_WORD		0x13u
+#define E1000_ICH_NVM_SIG_MASK		0xC000u
+#define E1000_ICH_NVM_VALID_SIG_MASK	0xC0u
+#define E1000_ICH_NVM_SIG_VALUE		0x80u
 
 #define E1000_ICH8_LAN_INIT_TIMEOUT	1500
 
-- 
2.8.1.102.ga49ec4a

