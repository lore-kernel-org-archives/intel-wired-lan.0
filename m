From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 10 Sep 2020 18:23:27 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 01/11] i40e: prepare flash
 string in a simpler way
In-Reply-To: <20200911012337.14015-1-jesse.brandeburg@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
Message-ID: <20200911012337.14015-2-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The flash string handling code triggered a W=1 warning and upon
investigation it seems everything can be handled in a simpler
way with a single initialization and one strlcat.  The buffer is filled
with NULL after the end of the string by the initializer, and the
strlcat checks total length, and makes sure the buffer is terminated
cleanly.

I didn't mark this with a fixes tag as there is no apparent bug since
the existing code would limit the input data + path to be the right
size, but it does fix the W=1 warning.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ddp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 5e08f100c413..9767fdf56124 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -434,14 +434,10 @@ int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash)
 	 * stored profile.
 	 */
 	if (strncmp(flash->data, "-", 2) != 0) {
+		char profile_name[ETHTOOL_FLASH_MAX_FILENAME] = I40E_DDP_PROFILE_PATH;
 		struct i40e_ddp_old_profile_list *list_entry;
-		char profile_name[sizeof(I40E_DDP_PROFILE_PATH)
-				  + I40E_DDP_PROFILE_NAME_MAX];
 
-		profile_name[sizeof(profile_name) - 1] = 0;
-		strncpy(profile_name, I40E_DDP_PROFILE_PATH,
-			sizeof(profile_name) - 1);
-		strncat(profile_name, flash->data, I40E_DDP_PROFILE_NAME_MAX);
+		strlcat(profile_name, flash->data, ETHTOOL_FLASH_MAX_FILENAME);
 		/* Load DDP recipe. */
 		status = request_firmware(&ddp_config, profile_name,
 					  &netdev->dev);
-- 
2.27.0

