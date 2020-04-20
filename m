From: Jason Yan <yanaijie@huawei.com>
Date: Mon, 20 Apr 2020 20:34:48 +0800
Subject: [Intel-wired-lan] [PATCH] i40e: Remove unneeded conversion to bool
Message-ID: <20200420123448.7382-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The '==' expression itself is bool, no need to convert it to bool again.
This fixes the following coccicheck warning:

drivers/net/ethernet/intel/i40e/i40e_main.c:1614:52-57: WARNING:
conversion to bool not needed here
drivers/net/ethernet/intel/i40e/i40e_main.c:11439:52-57: WARNING:
conversion to bool not needed here

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8c3e753bfb9d..2a037ec244b9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1611,7 +1611,7 @@ static int i40e_config_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 		}
 	}
 	if (lut) {
-		bool pf_lut = vsi->type == I40E_VSI_MAIN ? true : false;
+		bool pf_lut = vsi->type == I40E_VSI_MAIN;
 
 		ret = i40e_aq_set_rss_lut(hw, vsi->id, pf_lut, lut, lut_size);
 		if (ret) {
@@ -11436,7 +11436,7 @@ static int i40e_get_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 	}
 
 	if (lut) {
-		bool pf_lut = vsi->type == I40E_VSI_MAIN ? true : false;
+		bool pf_lut = vsi->type == I40E_VSI_MAIN;
 
 		ret = i40e_aq_get_rss_lut(hw, vsi->id, pf_lut, lut, lut_size);
 		if (ret) {
-- 
2.21.1

