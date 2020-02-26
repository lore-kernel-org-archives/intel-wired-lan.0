From: Jiri Pirko <jiri@resnulli.us>
Date: Wed, 26 Feb 2020 09:21:57 +0100
Subject: [Intel-wired-lan] [patch net-next v2] iavf: use
 tc_cls_can_offload_and_chain0() instead of chain check
Message-ID: <20200226082157.13848-1-jiri@resnulli.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jiri Pirko <jiri@mellanox.com>

Looks like the iavf code actually experienced a race condition, when a
developer took code before the check for chain 0 was put to helper.
So use tc_cls_can_offload_and_chain0() helper instead of direct check and
move the check to _cb() so this is similar to i40e code.

Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
v1->v2:
- rebased on top of net-next (using the correct helper name)
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 62fe56ddcb6e..76361bd468db 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3061,9 +3061,6 @@ static int iavf_delete_clsflower(struct iavf_adapter *adapter,
 static int iavf_setup_tc_cls_flower(struct iavf_adapter *adapter,
 				    struct flow_cls_offload *cls_flower)
 {
-	if (cls_flower->common.chain_index)
-		return -EOPNOTSUPP;
-
 	switch (cls_flower->command) {
 	case FLOW_CLS_REPLACE:
 		return iavf_configure_clsflower(adapter, cls_flower);
@@ -3087,6 +3084,11 @@ static int iavf_setup_tc_cls_flower(struct iavf_adapter *adapter,
 static int iavf_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 				  void *cb_priv)
 {
+	struct iavf_adapter *adapter = cb_priv;
+
+	if (!tc_cls_can_offload_and_chain0(adapter->netdev, type_data))
+		return -EOPNOTSUPP;
+
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
 		return iavf_setup_tc_cls_flower(cb_priv, type_data);
-- 
2.21.1

