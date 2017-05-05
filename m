From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Fri,  5 May 2017 21:29:13 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: Check for memory allocation failure
Message-ID: <20170505192913.4905-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If 'kzalloc' fails, a NULL pointer will be dereferenced. Return -ENOMEM
instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index eb2896fd52a6..86e99ed7fb04 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -595,6 +595,8 @@ static int i40e_client_setup_qvlist(struct i40e_info *ldev,
 	size = sizeof(struct i40e_qvlist_info) +
 	       (sizeof(struct i40e_qv_info) * (qvlist_info->num_vectors - 1));
 	ldev->qvlist_info = kzalloc(size, GFP_KERNEL);
+	if (!ldev->qvlist_info)
+		return -ENOMEM;
 	ldev->qvlist_info->num_vectors = qvlist_info->num_vectors;
 
 	for (i = 0; i < qvlist_info->num_vectors; i++) {
-- 
2.11.0

