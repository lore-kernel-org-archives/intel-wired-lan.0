From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:42:25 -0700
Subject: [Intel-wired-lan] [PATCH S44 13/14] ice: fix kernel BUG if
 register_netdev fails
In-Reply-To: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516004226.4795-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

If register_netdev() fails, the driver will attempt to cleanup the
q_vectors and inadvertently trigger a kernel BUG due to a NULL pointer
dereference.

This occurs because cleaning up q_vectors attempts to call
netif_napi_del on napi_structs which were never initialized.

Resolve this by releasing the netdev in ice_cfg_netdev and setting
vsi->netdev to NULL. This ensures that after ice_cfg_netdev fails the
state is rewound to match as if ice_cfg_netdev was never called.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 943fde5abdb7..14aa02b000cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2435,7 +2435,7 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
 
 	err = register_netdev(vsi->netdev);
 	if (err)
-		goto err_destroy_devlink_port;
+		goto err_free_netdev;
 
 	devlink_port_type_eth_set(&pf->devlink_port, vsi->netdev);
 
@@ -2446,9 +2446,11 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
 
 	return 0;
 
+err_free_netdev:
+	free_netdev(vsi->netdev);
+	vsi->netdev = NULL;
 err_destroy_devlink_port:
 	ice_devlink_destroy_port(pf);
-
 	return err;
 }
 
-- 
2.20.1

