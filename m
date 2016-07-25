From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 25 Jul 2016 16:15:50 -0700
Subject: [Intel-wired-lan] [next PATCH S40 08/13] i40e: Force register
	writes to mitigate sync issues with iwarp VF driver
In-Reply-To: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
References: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1469488555-28187-9-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash Dayanand <avinash.dayanand@intel.com>

This patch is a fix for the bug i.e. unable to create iwarp device
in VF. This is a sync issue and the iwarp device open is called even
before the PCI register writes are done.

Forcing the PCI register writes to happen just before it exits the
function.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Change-ID: I60c6a2c709da89e845f2764cc50ce8b7373c8c44
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index e8d9e47..cc7403a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -815,7 +815,8 @@ static int i40e_client_setup_qvlist(struct i40e_info *ldev,
 			wr32(hw, I40E_PFINT_AEQCTL, reg);
 		}
 	}
-
+	/* Mitigate sync problems with iwarp VF driver */
+	i40e_flush(hw);
 	return 0;
 err:
 	kfree(ldev->qvlist_info);
-- 
2.4.11

