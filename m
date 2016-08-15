From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 15 Aug 2016 14:17:19 -0700
Subject: [Intel-wired-lan] [next PATCH S42-V2 2/2] i40e: Initialize pointer
	in client_release function
In-Reply-To: <1471295839-13587-1-git-send-email-bimmy.pujari@intel.com>
References: <1471295839-13587-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1471295839-13587-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

The function i40e_client_release has a print statement that uses an
adapter pointer which is not initialized if a previous if statement
is not true. Hence, intialize it in the right place.

Testing Hints: Compile check

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Change-ID: I1afdaa2c46771ac42be56edcc41bb56b455b06c8
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 1035f88..09a37cf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -662,7 +662,7 @@ int i40e_lan_del_device(struct i40e_pf *pf)
 static int i40e_client_release(struct i40e_client *client)
 {
 	struct i40e_client_instance *cdev, *tmp;
-	struct i40e_pf *pf = NULL;
+	struct i40e_pf *pf;
 	int ret = 0;
 
 	LIST_HEAD(cdevs_tmp);
@@ -672,12 +672,12 @@ static int i40e_client_release(struct i40e_client *client)
 		if (strncmp(cdev->client->name, client->name,
 			    I40E_CLIENT_STR_LENGTH))
 			continue;
+		pf = (struct i40e_pf *)cdev->lan_info.pf;
 		if (test_bit(__I40E_CLIENT_INSTANCE_OPENED, &cdev->state)) {
 			if (atomic_read(&cdev->ref_cnt) > 0) {
 				ret = I40E_ERR_NOT_READY;
 				goto out;
 			}
-			pf = (struct i40e_pf *)cdev->lan_info.pf;
 			if (client->ops && client->ops->close)
 				client->ops->close(&cdev->lan_info, client,
 						   false);
-- 
2.4.11

