From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:41 -0700
Subject: [Intel-wired-lan] [next PATCH S37 11/15] i40e: Fix RSS to not be
	limited by the number of CPUs
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-12-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

Limiting qcount to pf->num_lan_msix, effectively limits the RSS queues
to only use the number of CPUs, and ignore all other queues. We don't
want to do this. If the user has changed the RSS settings to use more
queues then CPUS, we want to trust they know what they are doing and
let them. More importantly, if we tell them that is what we did, we want
to actually do it and allow traffic into all of the queues we have
allocated. This does not change the default setting to initially
allocate only the number of CPUS of queue pairs.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: Ie941a96e806e4bcd016addb4e17affb46770ada5
---
Testing Hints: Make sure that RSS can hit all queues up to the maximum
for XL710,X710,X722, including a NPAR nic.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ae4d089..b749b46 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1584,14 +1584,8 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 	vsi->tc_config.numtc = numtc;
 	vsi->tc_config.enabled_tc = enabled_tc ? enabled_tc : 1;
 	/* Number of queues per enabled TC */
-	/* In MFP case we can have a much lower count of MSIx
-	 * vectors available and so we need to lower the used
-	 * q count.
-	 */
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED)
-		qcount = min_t(int, vsi->alloc_queue_pairs, pf->num_lan_msix);
-	else
-		qcount = vsi->alloc_queue_pairs;
+	qcount = vsi->alloc_queue_pairs;
+
 	num_tc_qps = qcount / numtc;
 	num_tc_qps = min_t(int, num_tc_qps, i40e_pf_get_max_q_per_tc(pf));
 
-- 
2.4.11

