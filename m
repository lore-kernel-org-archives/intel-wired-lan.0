From: Joshua Hay <joshua.a.hay@intel.com>
Date: Mon, 11 Jan 2016 15:18:19 -0800
Subject: [Intel-wired-lan] [next PATCH S27 07/15] i40evf: Change vf driver
	string to reflect all products i40evf supports
In-Reply-To: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
References: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452554307-20937-8-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

Change the driver string to 40-10 Gigabit instead of XL710/X710 for X722
and all future products.

Also update copyright year in file header.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I57fae656b36dc4eb682b2b7a054f8f48f3589149
---
Testing Hints: Make sure the new driver string is in dmesg upon driver
load.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 5918e0f..561b182 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Virtual Function Driver
- * Copyright(c) 2013 - 2015 Intel Corporation.
+ * Copyright(c) 2013 - 2016 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -32,7 +32,7 @@ static int i40evf_close(struct net_device *netdev);
 
 char i40evf_driver_name[] = "i40evf";
 static const char i40evf_driver_string[] =
-	"Intel(R) XL710/X710 Virtual Function Network Driver";
+	"Intel(R) 40-10 Gigabit Virtual Function Network Driver";
 
 #define DRV_KERN "-k"
 
-- 
2.1.0

