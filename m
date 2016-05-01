From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun,  1 May 2016 14:07:23 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: constify i40e_client_ops structure
Message-ID: <1462104443-30724-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The i40e_client_ops structure is never modified, so declare it as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/infiniband/hw/i40iw/i40iw_main.c      |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_client.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 90e5af2..e41fae24 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1863,7 +1863,7 @@ static enum i40iw_status_code i40iw_virtchnl_send(struct i40iw_sc_dev *dev,
 }
 
 /* client interface functions */
-static struct i40e_client_ops i40e_ops = {
+static const struct i40e_client_ops i40e_ops = {
 	.open = i40iw_open,
 	.close = i40iw_close,
 	.l2_param_change = i40iw_l2param_change,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.h b/drivers/net/ethernet/intel/i40e/i40e_client.h
index bf6b453..a4601d9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.h
@@ -217,7 +217,7 @@ struct i40e_client {
 #define I40E_CLIENT_FLAGS_LAUNCH_ON_PROBE	BIT(0)
 #define I40E_TX_FLAGS_NOTIFY_OTHER_EVENTS	BIT(2)
 	enum i40e_client_type type;
-	struct i40e_client_ops *ops;	/* client ops provided by the client */
+	const struct i40e_client_ops *ops; /* client ops provided by the client */
 };
 
 static inline bool i40e_client_is_registered(struct i40e_client *client)

