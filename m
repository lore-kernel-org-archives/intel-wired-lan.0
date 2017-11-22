From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:56:22 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 02/16] ixgbe: Perform
 reinit any time number of VFs change
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185622.29785.67698.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

If the number of VFs are changed we need to reinitialize the part since the
offset for the device and the number of pools will be incorrect. Without
this change we can end up seeing Tx hangs and dropped Rx frames for
incoming traffic.

In addition we should drop the code that is arbitrarily changing the
default pool and queue configuration. Instead we should wait until the port
is reset and reconfigured via ixgbe_sriov_reinit.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 112d24c6c9ce..15d89258fbc3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -227,9 +227,6 @@ void ixgbe_enable_sriov(struct ixgbe_adapter *adapter, unsigned int max_vfs)
 int ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
 {
 	unsigned int num_vfs = adapter->num_vfs, vf;
-	struct ixgbe_hw *hw = &adapter->hw;
-	u32 gpie;
-	u32 vmdctl;
 	int rss;
 
 	/* set num VFs to 0 to prevent access to vfinfo */
@@ -271,18 +268,6 @@ int ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
 	pci_disable_sriov(adapter->pdev);
 #endif
 
-	/* turn off device IOV mode */
-	IXGBE_WRITE_REG(hw, IXGBE_GCR_EXT, 0);
-	gpie = IXGBE_READ_REG(hw, IXGBE_GPIE);
-	gpie &= ~IXGBE_GPIE_VTMODE_MASK;
-	IXGBE_WRITE_REG(hw, IXGBE_GPIE, gpie);
-
-	/* set default pool back to 0 */
-	vmdctl = IXGBE_READ_REG(hw, IXGBE_VT_CTL);
-	vmdctl &= ~IXGBE_VT_CTL_POOL_MASK;
-	IXGBE_WRITE_REG(hw, IXGBE_VT_CTL, vmdctl);
-	IXGBE_WRITE_FLUSH(hw);
-
 	/* Disable VMDq flag so device will be set in VM mode */
 	if (adapter->ring_feature[RING_F_VMDQ].limit == 1) {
 		adapter->flags &= ~IXGBE_FLAG_VMDQ_ENABLED;
@@ -378,13 +363,15 @@ static int ixgbe_pci_sriov_disable(struct pci_dev *dev)
 	int err;
 #ifdef CONFIG_PCI_IOV
 	u32 current_flags = adapter->flags;
+	int prev_num_vf = pci_num_vf(dev);
 #endif
 
 	err = ixgbe_disable_sriov(adapter);
 
 	/* Only reinit if no error and state changed */
 #ifdef CONFIG_PCI_IOV
-	if (!err && current_flags != adapter->flags)
+	if (!err && (current_flags != adapter->flags ||
+		     prev_num_vf != pci_num_vf(dev)))
 		ixgbe_sriov_reinit(adapter);
 #endif
 

