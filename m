From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 26 Jan 2022 10:55:44 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: remove enum i40e_client_state
Message-ID: <20220126185544.2787111-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It's not used.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/net/intel/i40e_client.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/net/intel/i40e_client.h b/include/linux/net/intel/i40e_client.h
index 6b3267b49755..ed42bd5f639f 100644
--- a/include/linux/net/intel/i40e_client.h
+++ b/include/linux/net/intel/i40e_client.h
@@ -26,11 +26,6 @@ struct i40e_client_version {
 	u8 rsvd;
 };
 
-enum i40e_client_state {
-	__I40E_CLIENT_NULL,
-	__I40E_CLIENT_REGISTERED
-};
-
 enum i40e_client_instance_state {
 	__I40E_CLIENT_INSTANCE_NONE,
 	__I40E_CLIENT_INSTANCE_OPENED,
@@ -190,11 +185,6 @@ struct i40e_client {
 	const struct i40e_client_ops *ops; /* client ops provided by the client */
 };
 
-static inline bool i40e_client_is_registered(struct i40e_client *client)
-{
-	return test_bit(__I40E_CLIENT_REGISTERED, &client->state);
-}
-
 void i40e_client_device_register(struct i40e_info *ldev, struct i40e_client *client);
 void i40e_client_device_unregister(struct i40e_info *ldev);
 
-- 
2.34.1

