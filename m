From: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 30 Mar 2018 16:05:33 -0500
Subject: [Intel-wired-lan] [PATCH v5 07/14] net/mlx5: Report PCIe link
 properties with pcie_print_link_status()
In-Reply-To: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <152244393306.135666.8628641854997205700.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tal Gilboa <talgi@mellanox.com>

Use pcie_print_link_status() to report PCIe link speed and possible
limitations.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 2ef641c91c26..622f02d34aae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1043,6 +1043,10 @@ static int mlx5_load_one(struct mlx5_core_dev *dev, struct mlx5_priv *priv,
 	dev_info(&pdev->dev, "firmware version: %d.%d.%d\n", fw_rev_maj(dev),
 		 fw_rev_min(dev), fw_rev_sub(dev));
 
+	/* Only PFs hold the relevant PCIe information for this query */
+	if (mlx5_core_is_pf(dev))
+		pcie_print_link_status(dev->pdev);
+
 	/* on load removing any previous indication of internal error, device is
 	 * up
 	 */

