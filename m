From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Tue, 26 Jul 2016 14:58:30 +0000
Subject: [Intel-wired-lan] [PATCH -next] i40e: Use list_move instead of
	list_del/list_add
Message-ID: <1469545110-32553-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Using list_move() instead of list_del() + list_add().

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index e1370c5..e6b9263 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -662,8 +662,7 @@ static int i40e_client_release(struct i40e_client *client)
 				 client->name, pf->hw.pf_id);
 		}
 		/* delete the client instance from the list */
-		list_del(&cdev->list);
-		list_add(&cdev->list, &cdevs_tmp);
+		list_move(&cdev->list, &cdevs_tmp);
 		atomic_dec(&client->ref_cnt);
 		dev_info(&pf->pdev->dev, "Deleted client instance of Client %s\n",
 			 client->name);



