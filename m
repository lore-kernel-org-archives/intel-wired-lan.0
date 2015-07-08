From: Vasily Averin <vvs@virtuozzo.com>
Date: Wed, 08 Jul 2015 15:04:26 +0300
Subject: [Intel-wired-lan] [PATCH] rtnl_lock called twice in
	i40e_pci_error_resume()
Message-ID: <559D11CA.6090006@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 48a52b3..ef091d4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10226,7 +10226,7 @@ static void i40e_pci_error_resume(struct pci_dev *pdev)
 
 	rtnl_lock();
 	i40e_handle_reset_warning(pf);
-	rtnl_lock();
+	rtnl_unlock();
 }
 
 /**
-- 
1.9.1

