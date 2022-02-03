From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Thu,  3 Feb 2022 11:25:18 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Remove non-inclusive
 language from Intel code.
Message-ID: <20220203102518.2701-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove non-inclusive language from Intel code in iavf driver.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_common.c | 4 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_status.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index e9cc7f6..34e46a2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -131,8 +131,8 @@ const char *iavf_stat_str(struct iavf_hw *hw, enum iavf_status stat_err)
 		return "IAVF_ERR_INVALID_MAC_ADDR";
 	case IAVF_ERR_DEVICE_NOT_SUPPORTED:
 		return "IAVF_ERR_DEVICE_NOT_SUPPORTED";
-	case IAVF_ERR_MASTER_REQUESTS_PENDING:
-		return "IAVF_ERR_MASTER_REQUESTS_PENDING";
+	case IAVF_ERR_PRIMARY_REQUESTS_PENDING:
+		return "IAVF_ERR_PRIMARY_REQUESTS_PENDING";
 	case IAVF_ERR_INVALID_LINK_SETTINGS:
 		return "IAVF_ERR_INVALID_LINK_SETTINGS";
 	case IAVF_ERR_AUTONEG_NOT_COMPLETE:
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 16742f3..e558644 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -90,7 +90,7 @@ int iavf_status_to_errno(enum iavf_status status)
 	case IAVF_ERR_UNKNOWN_PHY:
 	case IAVF_ERR_LINK_SETUP:
 	case IAVF_ERR_ADAPTER_STOPPED:
-	case IAVF_ERR_MASTER_REQUESTS_PENDING:
+	case IAVF_ERR_PRIMARY_REQUESTS_PENDING:
 	case IAVF_ERR_AUTONEG_NOT_COMPLETE:
 	case IAVF_ERR_RESET_FAILED:
 	case IAVF_ERR_BAD_PTR:
diff --git a/drivers/net/ethernet/intel/iavf/iavf_status.h b/drivers/net/ethernet/intel/iavf/iavf_status.h
index 46e3d1f6..2ea5c7c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_status.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_status.h
@@ -18,7 +18,7 @@ enum iavf_status {
 	IAVF_ERR_ADAPTER_STOPPED		= -9,
 	IAVF_ERR_INVALID_MAC_ADDR		= -10,
 	IAVF_ERR_DEVICE_NOT_SUPPORTED		= -11,
-	IAVF_ERR_MASTER_REQUESTS_PENDING	= -12,
+	IAVF_ERR_PRIMARY_REQUESTS_PENDING	= -12,
 	IAVF_ERR_INVALID_LINK_SETTINGS		= -13,
 	IAVF_ERR_AUTONEG_NOT_COMPLETE		= -14,
 	IAVF_ERR_RESET_FAILED			= -15,
-- 
2.27.0

