From: Alice Michael <alice.michael@intel.com>
Date: Wed,  5 Apr 2017 07:50:53 -0400
Subject: [Intel-wired-lan] [next S66 v2 01/11] i40e: update error message
	when trying to add invalid filters
Message-ID: <20170405115103.67374-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Re-word the error message displayed when adding a filter with an
invalid flow type. Additionally, report a distinct error message when
the IPv4 protocol is at fault.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Iba3d85b87f8d383c97c8bdd180df34a6adf3ee67
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ebffca0..d45f48c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -533,14 +533,15 @@ int i40e_add_del_fdir(struct i40e_vsi *vsi,
 			break;
 		default:
 			/* We cannot support masking based on protocol */
-			goto unsupported_flow;
+			dev_info(&pf->pdev->dev, "Unsupported IPv4 protocol 0x%02x\n",
+				 input->ip4_proto);
+			return -EINVAL;
 		}
 		break;
 	default:
-unsupported_flow:
-		dev_info(&pf->pdev->dev, "Could not specify spec type %d\n",
+		dev_info(&pf->pdev->dev, "Unsupported flow type 0x%02x\n",
 			 input->flow_type);
-		ret = -EINVAL;
+		return -EINVAL;
 	}
 
 	/* The buffer allocated here will be normally be freed by
-- 
2.9.3

