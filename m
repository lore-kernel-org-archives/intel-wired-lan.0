From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 25 Jul 2016 16:15:43 -0700
Subject: [Intel-wired-lan] [next PATCH S40 01/13] i40e: Fix a bug where a
	client close can be called before an open is complete
In-Reply-To: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
References: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1469488555-28187-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

The client->open call in this path was not protected with the
client instance mutex. And hence the client->close can get initiated
before the open completes.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-Id: I0ed60c38868dd3f44966b6ed49a063d0e5b7edf5
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index a3d6bb4..e8d9e47 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -561,6 +561,7 @@ void i40e_client_subtask(struct i40e_pf *pf)
 				 pf->hw.bus.device, pf->hw.bus.func);
 		}
 
+		mutex_lock(&i40e_client_instance_mutex);
 		/* Send an Open request to the client */
 		atomic_inc(&cdev->ref_cnt);
 		if (client->ops && client->ops->open)
@@ -574,6 +575,7 @@ void i40e_client_subtask(struct i40e_pf *pf)
 			atomic_dec(&client->ref_cnt);
 			continue;
 		}
+		mutex_unlock(&i40e_client_instance_mutex);
 	}
 	mutex_unlock(&i40e_client_mutex);
 }
-- 
2.4.11

