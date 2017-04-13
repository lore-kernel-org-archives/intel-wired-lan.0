From: Alice Michael <alice.michael@intel.com>
Date: Thu, 13 Apr 2017 04:45:55 -0400
Subject: [Intel-wired-lan] [next PATCH S70 12/12] i40e: make use of
	i40e_reset_all_vfs when initializing new VFs
In-Reply-To: <20170413084555.6962-1-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
Message-ID: <20170413084555.6962-12-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When allocating a large number of VFs, the driver previously used
i40e_reset_vf in a sequence. Just as when performing a normal reset,
this accumulates a large amount of delay for handling all of the VFs in
sequence. This delay is mainly due to a hardware requirement to wait
after initiating a reset on the VF.

We recently added a new function, i40e_reset_all_vfs() which can be used
to amortize the delay time, by first triggering all VF resets, then
waiting once, and finally cleaning up and allocating the VFs. This is
almost as good as truly running the resets in parallel.

In order to avoid sending a spurious reset message to a client
interface, we have a check to see whether we've assigned
pf->num_alloc_vfs yet. This was originally intended as a way to
distinquish the "initialization" case from the regular reset case.

Unfortunately, this means that we can't directly use i40e_reset_all_vfs
yet. Lets avoid this check of pf->num_alloc_vfs by replacing it with
a proper VSI state bit which we can use instead. This makes the
intention much clearer and allows us to re-use the i40e_reset_all_vfs
function directly.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
Change-ID: I694279b37eb6b5a91b6670182d0c15d10244fd6e
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++++---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b97f9f2..355821b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1007,7 +1007,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
 		set_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
 		clear_bit(I40E_VF_STATE_DISABLED, &vf->vf_states);
 		/* Do not notify the client during VF init */
-		if (vf->pf->num_alloc_vfs)
+		if (test_and_clear_bit(I40E_VF_STATE_PRE_ENABLE,
+				       &vf->vf_states))
 			i40e_notify_client_of_vf_reset(pf, abs_vf_id);
 		vf->num_vlan = 0;
 	}
@@ -1283,8 +1284,8 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_vfs)
 		/* assign default capabilities */
 		set_bit(I40E_VIRTCHNL_VF_CAP_L2, &vfs[i].vf_caps);
 		vfs[i].spoofchk = true;
-		/* VF resources get allocated during reset */
-		i40e_reset_vf(&vfs[i], false);
+
+		set_bit(I40E_VF_STATE_PRE_ENABLE, &vfs[i].vf_states);
 
 		if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_SWITCHDEV) {
 			ret = i40e_alloc_port_netdev(&vfs[i],
@@ -1295,6 +1296,9 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_vfs)
 	}
 	pf->num_alloc_vfs = num_alloc_vfs;
 
+	/* VF resources get allocated during reset */
+	i40e_reset_all_vfs(pf, false);
+
 	i40e_notify_client_of_vf_enable(pf, num_alloc_vfs);
 
 err_alloc:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 7ff45df..3b122ac 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -63,6 +63,7 @@ enum i40e_vf_states {
 	I40E_VF_STATE_DISABLED,
 	I40E_VF_STATE_MC_PROMISC,
 	I40E_VF_STATE_UC_PROMISC,
+	I40E_VF_STATE_PRE_ENABLE,
 };
 
 /* VF capabilities */
-- 
2.9.3

