From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 19 Aug 2020 14:58:36 -0700
Subject: [Intel-wired-lan] [PATCH 1/3] ice: Change ice_info_get_dsn to be
 void
In-Reply-To: <20200819215838.3834786-1-jacob.e.keller@intel.com>
References: <20200819215838.3834786-1-jacob.e.keller@intel.com>
Message-ID: <20200819215838.3834786-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

ice_info_get_dsn always returns 0, so just make it void.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 2210eb403a8c..d8ccf177190e 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -6,7 +6,7 @@
 #include "ice_devlink.h"
 #include "ice_fw_update.h"
 
-static int ice_info_get_dsn(struct ice_pf *pf, char *buf, size_t len)
+static void ice_info_get_dsn(struct ice_pf *pf, char *buf, size_t len)
 {
 	u8 dsn[8];
 
@@ -14,8 +14,6 @@ static int ice_info_get_dsn(struct ice_pf *pf, char *buf, size_t len)
 	put_unaligned_be64(pci_get_dsn(pf->pdev), dsn);
 
 	snprintf(buf, len, "%8phD", dsn);
-
-	return 0;
 }
 
 static int ice_info_pba(struct ice_pf *pf, char *buf, size_t len)
@@ -178,11 +176,7 @@ static int ice_devlink_info_get(struct devlink *devlink,
 		return err;
 	}
 
-	err = ice_info_get_dsn(pf, buf, sizeof(buf));
-	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Unable to obtain serial number");
-		return err;
-	}
+	ice_info_get_dsn(pf, buf, sizeof(buf));
 
 	err = devlink_info_serial_number_put(req, buf);
 	if (err) {
-- 
2.28.0.218.ge27853923b9d.dirty

