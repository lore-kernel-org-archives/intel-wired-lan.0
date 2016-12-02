From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  2 Dec 2016 12:32:55 -0800
Subject: [Intel-wired-lan] [next PATCH S56 1/8] i40e: Clean up dead code
In-Reply-To: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
References: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480710782-9195-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The function i40e_client_prepare() can never return an error. So make it
void and quit checking its return value.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I9ff311e2324dde329eb68648efb2c94aaff856db
---
Testing Hints : Found by static code analysis. Not
possible to test, just code cleanup.

 drivers/net/ethernet/intel/i40e/i40e_client.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index f6409f9..337d417 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -653,13 +653,11 @@ static int i40e_client_release(struct i40e_client *client)
  * i40e_client_prepare - prepare client specific resources
  * @client: pointer to the registered client
  *
- * Return 0 on success or < 0 on error
  **/
-static int i40e_client_prepare(struct i40e_client *client)
+static void i40e_client_prepare(struct i40e_client *client)
 {
 	struct i40e_device *ldev;
 	struct i40e_pf *pf;
-	int ret = 0;
 
 	mutex_lock(&i40e_device_mutex);
 	list_for_each_entry(ldev, &i40e_devices, list) {
@@ -669,7 +667,6 @@ static int i40e_client_prepare(struct i40e_client *client)
 		i40e_service_event_schedule(pf);
 	}
 	mutex_unlock(&i40e_device_mutex);
-	return ret;
 }
 
 /**
@@ -926,13 +923,9 @@ int i40e_register_client(struct i40e_client *client)
 	set_bit(__I40E_CLIENT_REGISTERED, &client->state);
 	mutex_unlock(&i40e_client_mutex);
 
-	if (i40e_client_prepare(client)) {
-		ret = -EIO;
-		goto out;
-	}
+	i40e_client_prepare(client);
 
-	pr_info("i40e: Registered client %s with return code %d\n",
-		client->name, ret);
+	pr_info("i40e: Registered client %s\n",	client->name);
 out:
 	return ret;
 }
-- 
2.4.11

