From: Alice Michael <alice.michael@intel.com>
Date: Mon,  7 Aug 2017 09:18:11 -0400
Subject: [Intel-wired-lan] [next PATCH S78-V5 11/12] i40e: fix client notify
	of VF reset
In-Reply-To: <20170807131812.86747-1-alice.michael@intel.com>
References: <20170807131812.86747-1-alice.michael@intel.com>
Message-ID: <20170807131812.86747-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

Currently there is a bug in which the PF driver fails to inform clients
of a VF reset which then causes clients to leak resources.  The bug
exists because we were incorrectly checking the I40E_VF_STATE_PRE_ENABLE
bit.

When a VF is first init we go through a reset to initialize variables
and allocate resources but we don't want to inform clients of this first
reset since the client isn't fully enabled yet so we set a state bit
signifying we're in a "pre-enabled" client state.  During the first
reset we should be clearing the bit, allowing all following resets to
notify the client of the reset when the bit is not set.  This patch
fixes the issue by negating the 'test_and_clear_bit' check to accurately
reflect the behavior we want.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index e65ecaf..137254e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1047,8 +1047,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
 		set_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
 		clear_bit(I40E_VF_STATE_DISABLED, &vf->vf_states);
 		/* Do not notify the client during VF init */
-		if (test_and_clear_bit(I40E_VF_STATE_PRE_ENABLE,
-				       &vf->vf_states))
+		if (!test_and_clear_bit(I40E_VF_STATE_PRE_ENABLE,
+					&vf->vf_states))
 			i40e_notify_client_of_vf_reset(pf, abs_vf_id);
 		vf->num_vlan = 0;
 	}
-- 
2.9.4

