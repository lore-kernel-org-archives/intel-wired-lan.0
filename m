From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 15 Oct 2018 12:21:28 -0700
Subject: [Intel-wired-lan] [net-next 4/3] fm10k: bump driver version to
 match out-of-tree release
Message-ID: <20181015192128.876-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The upstream and out-of-tree drivers are once again at comparable
functionality. It's been a while since we updated the upstream driver
version, so bump it now.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Woops, forgot to send the patch to bump the version number as well.

 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 503bbc017792..5b2a50e5798f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -11,7 +11,7 @@
 
 #include "fm10k.h"
 
-#define DRV_VERSION	"0.23.4-k"
+#define DRV_VERSION	"0.26.1-k"
 #define DRV_SUMMARY	"Intel(R) Ethernet Switch Host Interface Driver"
 const char fm10k_driver_version[] = DRV_VERSION;
 char fm10k_driver_name[] = "fm10k";
-- 
2.18.0.219.gaf81d287a9da

