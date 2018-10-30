From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 30 Oct 2018 10:50:45 -0700
Subject: [Intel-wired-lan] [next S97 v2 4/6] i40e: Protect access to vf
 control methods
In-Reply-To: <20181030175047.18874-1-jeffrey.t.kirsher@intel.com>
References: <20181030175047.18874-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20181030175047.18874-4-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jan Sokolowski <jan.sokolowski@intel.com>

A scenario has been found in which simultaneous
addition/removal and modification of VF's might cause
unstable behaviour, up to and including kernel panics.

Protect the methods that create/modify/destroy VF's
by locking them behind an atomically set bit in PF status
bitfield.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 64 +++++++++++++++++--
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 11f0987f16c7..f575b03bc3ed 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -147,6 +147,7 @@ enum i40e_state_t {
 	__I40E_CLIENT_SERVICE_REQUESTED,
 	__I40E_CLIENT_L2_CHANGE,
 	__I40E_CLIENT_RESET,
+	__I40E_VIRTCHNL_OP_PENDING,
 	/* This must be last as it determines the size of the BITMAP */
 	__I40E_STATE_SIZE__,
 };
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index ac5698ed0b11..8e0a247e7e5a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1675,13 +1675,20 @@ static int i40e_pci_sriov_enable(struct pci_dev *pdev, int num_vfs)
 int i40e_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
+	int ret = 0;
+
+	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
+		dev_warn(&pdev->dev, "Unable to configure VFs, other operation is pending.\n");
+		return -EAGAIN;
+	}
 
 	if (num_vfs) {
 		if (!(pf->flags & I40E_FLAG_VEB_MODE_ENABLED)) {
 			pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
 			i40e_do_reset_safe(pf, I40E_PF_RESET_FLAG);
 		}
-		return i40e_pci_sriov_enable(pdev, num_vfs);
+		ret = i40e_pci_sriov_enable(pdev, num_vfs);
+		goto sriov_configure_out;
 	}
 
 	if (!pci_vfs_assigned(pf->pdev)) {
@@ -1690,9 +1697,12 @@ int i40e_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 		i40e_do_reset_safe(pf, I40E_PF_RESET_FLAG);
 	} else {
 		dev_warn(&pdev->dev, "Unable to free VFs because some are assigned to VMs.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto sriov_configure_out;
 	}
-	return 0;
+sriov_configure_out:
+	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
+	return ret;
 }
 
 /***********************virtual channel routines******************/
@@ -3893,6 +3903,11 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 		goto error_param;
 	}
 
+	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
+		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
+		return -EAGAIN;
+	}
+
 	if (is_multicast_ether_addr(mac)) {
 		dev_err(&pf->pdev->dev,
 			"Invalid Ethernet address %pM for VF %d\n", mac, vf_id);
@@ -3941,6 +3956,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	dev_info(&pf->pdev->dev, "Bring down and up the VF interface to make this change effective.\n");
 
 error_param:
+	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
 	return ret;
 }
 
@@ -3992,6 +4008,11 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	struct i40e_vf *vf;
 	int ret = 0;
 
+	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
+		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
+		return -EAGAIN;
+	}
+
 	/* validate the request */
 	ret = i40e_validate_vf(pf, vf_id);
 	if (ret)
@@ -4107,6 +4128,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	ret = 0;
 
 error_pvid:
+	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
 	return ret;
 }
 
@@ -4128,6 +4150,11 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 	struct i40e_vf *vf;
 	int ret = 0;
 
+	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
+		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
+		return -EAGAIN;
+	}
+
 	/* validate the request */
 	ret = i40e_validate_vf(pf, vf_id);
 	if (ret)
@@ -4154,6 +4181,7 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 
 	vf->tx_rate = max_tx_rate;
 error:
+	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
 	return ret;
 }
 
@@ -4174,6 +4202,11 @@ int i40e_ndo_get_vf_config(struct net_device *netdev,
 	struct i40e_vf *vf;
 	int ret = 0;
 
+	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
+		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
+		return -EAGAIN;
+	}
+
 	/* validate the request */
 	ret = i40e_validate_vf(pf, vf_id);
 	if (ret)
@@ -4209,6 +4242,7 @@ int i40e_ndo_get_vf_config(struct net_device *netdev,
 	ret = 0;
 
 error_param:
+	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
 	return ret;
 }
 
@@ -4230,6 +4264,11 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	int abs_vf_id;
 	int ret = 0;
 
+	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
+		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
+		return -EAGAIN;
+	}
+
 	/* validate the request */
 	if (vf_id >= pf->num_alloc_vfs) {
 		dev_err(&pf->pdev->dev, "Invalid VF Identifier %d\n", vf_id);
@@ -4273,6 +4312,7 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 			       0, (u8 *)&pfe, sizeof(pfe), NULL);
 
 error_out:
+	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
 	return ret;
 }
 
@@ -4294,6 +4334,11 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
 	struct i40e_vf *vf;
 	int ret = 0;
 
+	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
+		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
+		return -EAGAIN;
+	}
+
 	/* validate the request */
 	if (vf_id >= pf->num_alloc_vfs) {
 		dev_err(&pf->pdev->dev, "Invalid VF Identifier %d\n", vf_id);
@@ -4327,6 +4372,7 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
 		ret = -EIO;
 	}
 out:
+	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
 	return ret;
 }
 
@@ -4345,15 +4391,22 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 	struct i40e_vf *vf;
 	int ret = 0;
 
+	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
+		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
+		return -EAGAIN;
+	}
+
 	/* validate the request */
 	if (vf_id >= pf->num_alloc_vfs) {
 		dev_err(&pf->pdev->dev, "Invalid VF Identifier %d\n", vf_id);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if (pf->flags & I40E_FLAG_MFP_ENABLED) {
 		dev_err(&pf->pdev->dev, "Trusted VF not supported in MFP mode.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	vf = &pf->vf[vf_id];
@@ -4376,5 +4429,6 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 	}
 
 out:
+	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
 	return ret;
 }
-- 
2.17.2

