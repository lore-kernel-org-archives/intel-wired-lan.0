From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 17 Aug 2016 16:04:06 -0700
Subject: [Intel-wired-lan] [next PATCH S43 1/3] i40e: Correcting mutex usage
	in client code
Message-ID: <1471475048-25835-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash Dayanand <avinash.dayanand@intel.com>

Correcting the mutex usage, in client_subtask(), mutex_unlock has
to be called just before client_del_instance() since this function opens
and later closes the same mutex again.
Similarly in client_is_registered removing the mutex since it closes
the mutex twice.

This is a patch suggested by RDMA team.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Change-ID: Icce519c266e4221b8a2a72a15ba5bf01750e5852
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 09a37cf..5404b32 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -576,6 +576,7 @@ void i40e_client_subtask(struct i40e_pf *pf)
 			set_bit(__I40E_CLIENT_INSTANCE_OPENED, &cdev->state);
 		} else {
 			/* remove client instance */
+			mutex_unlock(&i40e_client_instance_mutex);
 			i40e_client_del_instance(pf, client);
 			atomic_dec(&client->ref_cnt);
 			continue;
-- 
2.4.11

