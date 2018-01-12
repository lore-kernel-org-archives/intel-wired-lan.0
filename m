From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 13 Jan 2018 07:19:08 +0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher-next-queue] i40e:
 i40e_find_vsi_from_seid() can be static
In-Reply-To: <201801130740.nIajnAAm%fengguang.wu@intel.com>
References: <201801130740.nIajnAAm%fengguang.wu@intel.com>
Message-ID: <20180112231907.GA40910@xian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: 5a2f5288e803 ("i40e: Add and delete cloud filter")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 i40e_virtchnl_pf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index d0c8183..04120bc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3054,7 +3054,7 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
  * @vf: pointer to the VF info
  * @seid - seid of the vsi it is searching for
  **/
-struct i40e_vsi *i40e_find_vsi_from_seid(struct i40e_vf *vf, u16 seid)
+static struct i40e_vsi *i40e_find_vsi_from_seid(struct i40e_vf *vf, u16 seid)
 {
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
@@ -3074,7 +3074,7 @@ struct i40e_vsi *i40e_find_vsi_from_seid(struct i40e_vf *vf, u16 seid)
  *
  * This function deletes all cloud filters
  **/
-void i40e_del_all_cloud_filters(struct i40e_vf *vf)
+static void i40e_del_all_cloud_filters(struct i40e_vf *vf)
 {
 	struct i40e_cloud_filter *cfilter = NULL;
 	struct i40e_pf *pf = vf->pf;
