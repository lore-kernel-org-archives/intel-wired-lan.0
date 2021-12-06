From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Mon,  6 Dec 2021 11:36:42 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Remove non-inclusive
 language from Intel code.
Message-ID: <20211206103642.7399-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove non-inclusive language from Intel code.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_status.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index f81a674..56cb2c6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -154,8 +154,8 @@ const char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err)
 		return "I40E_ERR_INVALID_MAC_ADDR";
 	case I40E_ERR_DEVICE_NOT_SUPPORTED:
 		return "I40E_ERR_DEVICE_NOT_SUPPORTED";
-	case I40E_ERR_MASTER_REQUESTS_PENDING:
-		return "I40E_ERR_MASTER_REQUESTS_PENDING";
+	case I40E_ERR_PRIMARY_REQUESTS_PENDING:
+		return "I40E_ERR_PRIMARY_REQUESTS_PENDING";
 	case I40E_ERR_INVALID_LINK_SETTINGS:
 		return "I40E_ERR_INVALID_LINK_SETTINGS";
 	case I40E_ERR_AUTONEG_NOT_COMPLETE:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_status.h b/drivers/net/ethernet/intel/i40e/i40e_status.h
index 77be070..db3714a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_status.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_status.h
@@ -18,7 +18,7 @@ enum i40e_status_code {
 	I40E_ERR_ADAPTER_STOPPED		= -9,
 	I40E_ERR_INVALID_MAC_ADDR		= -10,
 	I40E_ERR_DEVICE_NOT_SUPPORTED		= -11,
-	I40E_ERR_MASTER_REQUESTS_PENDING	= -12,
+	I40E_ERR_PRIMARY_REQUESTS_PENDING	= -12,
 	I40E_ERR_INVALID_LINK_SETTINGS		= -13,
 	I40E_ERR_AUTONEG_NOT_COMPLETE		= -14,
 	I40E_ERR_RESET_FAILED			= -15,
-- 
2.27.0

