From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Thu, 23 Jun 2016 14:08:46 -0700
Subject: [Intel-wired-lan] [next PATCH S39 3/3] i40e: Move the mutex lock in
	i40e_client_unregister
Message-ID: <1466716126-9971-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

We need to lock the client list around the i40e_client_release call to
prevent the release from interrupting the client instances while they are
being added.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-Id: I99993f20179aaf8730207833e7d0869d2ccffa1d
---
Testing Hints: Do a insmod/rmmod of i40iw quickly and see if there is a
kernel paging failure.

HSD-number: 7661337

 drivers/net/ethernet/intel/i40e/i40e_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index c6557d4..0d15f7e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -1007,13 +1007,13 @@ int i40e_unregister_client(struct i40e_client *client)
 	 * a close for each of the client instances that were opened.
 	 * client_release function is called to handle this.
 	 */
+	mutex_lock(&i40e_client_mutex);
 	if (!client || i40e_client_release(client)) {
 		ret = -EIO;
 		goto out;
 	}
 
 	/* TODO: check if device is in reset, or if that matters? */
-	mutex_lock(&i40e_client_mutex);
 	if (!i40e_client_is_registered(client)) {
 		pr_info("i40e: Client %s has not been registered\n",
 			client->name);
@@ -1032,8 +1032,8 @@ int i40e_unregister_client(struct i40e_client *client)
 		       client->name);
 	}
 
-	mutex_unlock(&i40e_client_mutex);
 out:
+	mutex_unlock(&i40e_client_mutex);
 	return ret;
 }
 EXPORT_SYMBOL(i40e_unregister_client);
-- 
2.4.11

