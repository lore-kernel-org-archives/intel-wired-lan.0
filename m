From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:03 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 03/13] i40e: use dev_dbg
	instead of dev_info when warning about missing routine
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <20170607094313.32060-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When searching for the vf_capability client routine, dev_info() was
used, instead of the normal dev_dbg(). This causes the message to be
displayed at standard log levels which can cause administrators to
worry. Avoid this by using dev_dbg instead.

Copyright updated to 2017.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 36f694c..1b1e2ac 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
- * Copyright(c) 2013 - 2015 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -273,8 +273,8 @@ int i40e_vf_client_capable(struct i40e_pf *pf, u32 vf_id)
 	if (!cdev || !cdev->client)
 		goto out;
 	if (!cdev->client->ops || !cdev->client->ops->vf_capable) {
-		dev_info(&pf->pdev->dev,
-			 "Cannot locate client instance VF capability routine\n");
+		dev_dbg(&pf->pdev->dev,
+			"Cannot locate client instance VF capability routine\n");
 		goto out;
 	}
 	if (!test_bit(__I40E_CLIENT_INSTANCE_OPENED, &cdev->state))
-- 
2.9.3

