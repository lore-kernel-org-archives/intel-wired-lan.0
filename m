From: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 30 Mar 2018 16:05:41 -0500
Subject: [Intel-wired-lan] [PATCH v5 08/14] net/mlx5e: Use
 pcie_bandwidth_available() to compute bandwidth
In-Reply-To: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <152244394162.135666.4917184975514407800.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tal Gilboa <talgi@mellanox.com>

Use the new pci_bandwidth_available() function to calculate maximum
available bandwidth through the PCI chain instead of computing it ourselves
with mlx5e_get_pci_bw().

This is used to detect when the device is capable of more bandwidth than is
available in the current slot.  The driver may adjust compression settings
accordingly.

Note that pci_bandwidth_available() accounts for PCIe encoding overhead, so
it is more accurate than mlx5e_get_pci_bw() was.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
[bhelgaas: remove mlx5e_get_pci_bw() wrapper altogether]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |   32 +--------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 47bab842c5ee..93291ec4a3d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3864,36 +3864,6 @@ void mlx5e_build_default_indir_rqt(u32 *indirection_rqt, int len,
 		indirection_rqt[i] = i % num_channels;
 }
 
-static int mlx5e_get_pci_bw(struct mlx5_core_dev *mdev, u32 *pci_bw)
-{
-	enum pcie_link_width width;
-	enum pci_bus_speed speed;
-	int err = 0;
-
-	err = pcie_get_minimum_link(mdev->pdev, &speed, &width);
-	if (err)
-		return err;
-
-	if (speed == PCI_SPEED_UNKNOWN || width == PCIE_LNK_WIDTH_UNKNOWN)
-		return -EINVAL;
-
-	switch (speed) {
-	case PCIE_SPEED_2_5GT:
-		*pci_bw = 2500 * width;
-		break;
-	case PCIE_SPEED_5_0GT:
-		*pci_bw = 5000 * width;
-		break;
-	case PCIE_SPEED_8_0GT:
-		*pci_bw = 8000 * width;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static bool cqe_compress_heuristic(u32 link_speed, u32 pci_bw)
 {
 	return (link_speed && pci_bw &&
@@ -3979,7 +3949,7 @@ void mlx5e_build_nic_params(struct mlx5_core_dev *mdev,
 	params->num_tc       = 1;
 
 	mlx5e_get_max_linkspeed(mdev, &link_speed);
-	mlx5e_get_pci_bw(mdev, &pci_bw);
+	pci_bw = pcie_bandwidth_available(mdev->pdev, NULL, NULL, NULL);
 	mlx5_core_dbg(mdev, "Max link speed = %d, PCI BW = %d\n",
 		      link_speed, pci_bw);
 

