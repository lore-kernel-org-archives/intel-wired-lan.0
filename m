From: Colin King <colin.king@canonical.com>
Date: Mon,  7 Jan 2019 22:59:28 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: clean up several indentation issues
Message-ID: <20190107225928.12855-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

There are several statements that have incorrect levels of indentation,
fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 8 ++++----
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 6 +++---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index a6bc7847346b..fe84f054f0c1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2440,10 +2440,10 @@ static int i40e_set_phys_id(struct net_device *netdev,
 	default:
 		break;
 	}
-		if (ret)
-			return -ENOENT;
-		else
-			return 0;
+	if (ret)
+		return -ENOENT;
+	else
+		return 0;
 }
 
 /* NOTE: i40e hardware uses a conversion factor of 2 for Interrupt
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4d40878e395a..76dac65bf0ca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3610,7 +3610,7 @@ static void i40e_configure_msi_and_legacy(struct i40e_vsi *vsi)
 		      (I40E_QUEUE_TYPE_TX
 		       << I40E_QINT_TQCTL_NEXTQ_TYPE_SHIFT);
 
-	       wr32(hw, I40E_QINT_TQCTL(nextqp), val);
+		wr32(hw, I40E_QINT_TQCTL(nextqp), val);
 	}
 
 	val = I40E_QINT_TQCTL_CAUSE_ENA_MASK		      |
@@ -8131,8 +8131,8 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 		i40e_service_event_schedule(pf);
 	} else {
 		i40e_pf_unquiesce_all_vsi(pf);
-	set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
-	set_bit(__I40E_CLIENT_L2_CHANGE, pf->state);
+		set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
+		set_bit(__I40E_CLIENT_L2_CHANGE, pf->state);
 	}
 
 exit:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 2ac23ebfbf31..46054634e68c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3384,8 +3384,8 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		dev_info(&pf->pdev->dev,
 			 "VF %d: Invalid input/s, can't apply cloud filter\n",
 			 vf->vf_id);
-			aq_ret = I40E_ERR_PARAM;
-			goto err;
+		aq_ret = I40E_ERR_PARAM;
+		goto err;
 	}
 
 	cfilter = kzalloc(sizeof(*cfilter), GFP_KERNEL);
-- 
2.19.1

