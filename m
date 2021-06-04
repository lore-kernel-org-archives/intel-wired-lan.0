From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:49:00 -0700
Subject: [Intel-wired-lan] [PATCH net 8/8] iavf: Fix for setting queues to 0
In-Reply-To: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604164900.33156-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>

Now setting combine to 0 will be rejected with the
appropriate error code.
This has been implemented by adding a condition that checks
the value of combine equal to zero.
Without this patch, when the user requested it, no error was
returned and combine was set to the default value for VF.

Fixes: 5520deb15326 ("iavf: Enable support for up to 16 queues")
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 77a8a15c5410..0885fb0f0d4b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1781,7 +1781,7 @@ static int iavf_set_channels(struct net_device *netdev,
 	/* All of these should have already been checked by ethtool before this
 	 * even gets to us, but just to be sure.
 	 */
-	if (num_req > adapter->vsi_res->num_queue_pairs)
+	if (num_req == 0 || num_req > adapter->vsi_res->num_queue_pairs)
 		return -EINVAL;
 
 	if (num_req == adapter->num_active_queues)
-- 
2.20.1

