From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Mon, 14 Sep 2015 00:27:45 -0600
Subject: [Intel-wired-lan] [next-queue 3/8] e1000e: clean up the local
	variable
In-Reply-To: <1442212070-24937-1-git-send-email-sakiwit@gmail.com>
References: <1442212070-24937-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1442212070-24937-4-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

The local variable 'ret' doesn't serve much purpose so we might as well
clean it up.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7be339eb9927..a501e7744597 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7504,14 +7504,11 @@ static struct pci_driver e1000_driver = {
  **/
 static int __init e1000_init_module(void)
 {
-	int ret;
-
 	pr_info("Intel(R) PRO/1000 Network Driver - %s\n",
 		e1000e_driver_version);
 	pr_info("Copyright(c) 1999 - 2015 Intel Corporation.\n");
-	ret = pci_register_driver(&e1000_driver);
 
-	return ret;
+	return pci_register_driver(&e1000_driver);
 }
 module_init(e1000_init_module);
 
