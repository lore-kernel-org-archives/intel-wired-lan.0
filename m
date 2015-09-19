From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Sat, 19 Sep 2015 05:08:45 -0600
Subject: [Intel-wired-lan] [next-queue v2 6/8] i40e: declare rather than
	initialize int object
In-Reply-To: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
References: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1442660927-30431-6-git-send-email-sakiwit@gmail.com>
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
v2: No changes.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2d8c0cc23fcf..7551732a2b52 100644
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
 
