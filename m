From: Alice Michael <alice.michael@intel.com>
Date: Fri, 20 Apr 2018 01:41:40 -0700
Subject: [Intel-wired-lan] [next PATCH S90 8/8] i40e: use %pI4b instead of
 byte swapping before dev_err
In-Reply-To: <20180420084140.8081-1-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
Message-ID: <20180420084140.8081-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Fix warnings regarding restricted __be32 type usage by strictly
specifying the type of the ipv4 address being printed in the dev_err
statement.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b500bbf..c8659fb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7213,8 +7213,7 @@ static int i40e_parse_cls_flower(struct i40e_vsi *vsi,
 			if (mask->dst == cpu_to_be32(0xffffffff)) {
 				field_flags |= I40E_CLOUD_FIELD_IIP;
 			} else {
-				mask->dst = be32_to_cpu(mask->dst);
-				dev_err(&pf->pdev->dev, "Bad ip dst mask %pI4\n",
+				dev_err(&pf->pdev->dev, "Bad ip dst mask %pI4b\n",
 					&mask->dst);
 				return I40E_ERR_CONFIG;
 			}
@@ -7224,8 +7223,7 @@ static int i40e_parse_cls_flower(struct i40e_vsi *vsi,
 			if (mask->src == cpu_to_be32(0xffffffff)) {
 				field_flags |= I40E_CLOUD_FIELD_IIP;
 			} else {
-				mask->src = be32_to_cpu(mask->src);
-				dev_err(&pf->pdev->dev, "Bad ip src mask %pI4\n",
+				dev_err(&pf->pdev->dev, "Bad ip src mask %pI4b\n",
 					&mask->src);
 				return I40E_ERR_CONFIG;
 			}
-- 
2.9.5

