From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Wed, 10 Jan 2018 07:13:51 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40e: Make local function
 i40e_get_link_speed static
Message-ID: <1515568431-190497-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixes the following sparse warning:

drivers/net/ethernet/intel/i40e/i40e_main.c:5440:5: warning:
 symbol 'i40e_get_link_speed' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 42dcaef..0d4a7c69 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5437,7 +5437,7 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
  * @vsi: VSI to be configured
  *
  **/
-int i40e_get_link_speed(struct i40e_vsi *vsi)
+static int i40e_get_link_speed(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;

