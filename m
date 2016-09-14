From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 14 Sep 2016 16:24:31 -0700
Subject: [Intel-wired-lan] [next PATCH S47 1/9] i40e: Fix client interaction
In-Reply-To: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
References: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473895479-23035-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch fixes a problem in the client interface that
was causing random stack traces in RDMA driver load and
unload tests.  This patch fixes the problem by checking
for an existing client before trying to open it.  Without
this patch, there is a timing related null pointer deref.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: Ib73d30671a27f6f9770dd53b3e5292b88d6b62da
---
Testing Hints:  See HSD for repro script

 drivers/net/ethernet/intel/i40e/i40e_client.c | 29 ++++++++++++---------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 250db0b..6ffac03 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -565,7 +565,7 @@ void i40e_client_subtask(struct i40e_pf *pf)
 			if (test_bit(__I40E_DOWN, &pf->vsi[pf->lan_vsi]->state))
 				continue;
 		} else {
-			dev_warn(&pf->pdev->dev, "This client %s is being instanciated at probe\n",
+			dev_warn(&pf->pdev->dev, "This client %s is being instantiated at probe\n",
 				 client->name);
 		}
 
@@ -582,24 +582,21 @@ void i40e_client_subtask(struct i40e_pf *pf)
 			dev_info(&pf->pdev->dev, "Added instance of Client %s to PF%d bus=0x%02x func=0x%02x\n",
 				 client->name, pf->hw.pf_id,
 				 pf->hw.bus.device, pf->hw.bus.func);
-		}
-
-		mutex_lock(&i40e_client_instance_mutex);
-		/* Send an Open request to the client */
-		atomic_inc(&cdev->ref_cnt);
-		if (client->ops && client->ops->open)
-			ret = client->ops->open(&cdev->lan_info, client);
-		atomic_dec(&cdev->ref_cnt);
-		if (!ret) {
+			mutex_lock(&i40e_client_instance_mutex);
+			atomic_inc(&cdev->ref_cnt);
+			if (client->ops && client->ops->open)
+				ret = client->ops->open(&cdev->lan_info,
+							client);
+			atomic_dec(&cdev->ref_cnt);
+			if (ret < 0) {
+				mutex_unlock(&i40e_client_instance_mutex);
+				i40e_client_del_instance(pf, client);
+				atomic_dec(&client->ref_cnt);
+				continue;
+			}
 			set_bit(__I40E_CLIENT_INSTANCE_OPENED, &cdev->state);
-		} else {
-			/* remove client instance */
 			mutex_unlock(&i40e_client_instance_mutex);
-			i40e_client_del_instance(pf, client);
-			atomic_dec(&client->ref_cnt);
-			continue;
 		}
-		mutex_unlock(&i40e_client_instance_mutex);
 	}
 	mutex_unlock(&i40e_client_mutex);
 }
-- 
2.4.11

