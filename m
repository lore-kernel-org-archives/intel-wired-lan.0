From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 30 Dec 2018 16:53:10 +0100
Subject: [Intel-wired-lan] [PATCH 3/8] i40e: increase indentation
In-Reply-To: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1546185195-25676-4-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Convert spaces to tabs to get correct alignment.

Found with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/net/ethernet/intel/i40e/i40e_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4d40878e395a..6c435b61941f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3610,7 +3610,7 @@ static void i40e_configure_msi_and_legacy(struct i40e_vsi *vsi)
 		      (I40E_QUEUE_TYPE_TX
 		       << I40E_QINT_TQCTL_NEXTQ_TYPE_SHIFT);
 
-	       wr32(hw, I40E_QINT_TQCTL(nextqp), val);
+		wr32(hw, I40E_QINT_TQCTL(nextqp), val);
 	}
 
 	val = I40E_QINT_TQCTL_CAUSE_ENA_MASK		      |

