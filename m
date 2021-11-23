From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Tue, 23 Nov 2021 15:00:13 +0100
Subject: [Intel-wired-lan] [PATCH net-next v3] i40e: Update FW API version
Message-ID: <20211123140013.21336-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update FW API versions to the newest supported NVM images.

Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 v3: Made one more fix to commit title 
 v2: Fixed commit title and message
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 140b677..60f9e0a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -11,8 +11,8 @@
  */
 
 #define I40E_FW_API_VERSION_MAJOR	0x0001
-#define I40E_FW_API_VERSION_MINOR_X722	0x0009
-#define I40E_FW_API_VERSION_MINOR_X710	0x0009
+#define I40E_FW_API_VERSION_MINOR_X722	0x000C
+#define I40E_FW_API_VERSION_MINOR_X710	0x000F
 
 #define I40E_FW_MINOR_VERSION(_h) ((_h)->mac.type == I40E_MAC_XL710 ? \
 					I40E_FW_API_VERSION_MINOR_X710 : \
-- 
2.27.0

