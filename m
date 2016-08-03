From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 3 Aug 2016 22:01:07 +0300
Subject: [Intel-wired-lan] [patch] i40e: remove a stray unlock
Message-ID: <20160803190107.GC775@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We shifted the locking around a bit but forgot to delete this unlock so
now it can unlock twice.

Fixes: cd3be169a5ff ('i40e: Move the mutex lock in i40e_client_unregister')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index e1370c5..1a9682f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -990,7 +990,6 @@ int i40e_unregister_client(struct i40e_client *client)
 	if (!i40e_client_is_registered(client)) {
 		pr_info("i40e: Client %s has not been registered\n",
 			client->name);
-		mutex_unlock(&i40e_client_mutex);
 		ret = -ENODEV;
 		goto out;
 	}
