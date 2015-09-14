From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Mon, 14 Sep 2015 00:27:48 -0600
Subject: [Intel-wired-lan] [next-queue 6/8] i40e: declare rather than
	initialize int object
In-Reply-To: <1442212070-24937-1-git-send-email-sakiwit@gmail.com>
References: <1442212070-24937-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1442212070-24937-7-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

'err' would be overwritten immediately, so we should declare it only
rather than initialize it to zero.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 23e0a4b007a2..91224b38cbd3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10140,7 +10140,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	static u16 pfs_found;
 	u16 wol_nvm_bits;
 	u16 link_status;
-	int err = 0;
+	int err;
 	u32 len;
 	u32 i;
 
