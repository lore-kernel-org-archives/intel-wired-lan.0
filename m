From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Thu, 14 Apr 2016 06:19:23 -0700
Subject: [Intel-wired-lan] [next PATCH S35 03/14] i40e: Add elements to fd
	filter compare
In-Reply-To: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460639974-2556-4-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Make sure we're comparing enough elements between filters to
know whether they are really the same.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-Id: Ibbf097906a4a8c4fe8d973e3092a8fcbd09ce6ff
---
Testing Hints :
	Add a flow director filter and then print the content
	Add the same filter, but with a different queue
	Print the output and make sure it reflects the new queue
	Make sure the traffic goes to the new queue

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index ea8afde..3409702 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2422,7 +2422,11 @@ static bool i40e_match_fdir_input_set(struct i40e_fdir_filter *rule,
 	if ((rule->dst_ip[0] != input->dst_ip[0]) ||
 	    (rule->src_ip[0] != input->src_ip[0]) ||
 	    (rule->dst_port != input->dst_port) ||
-	    (rule->src_port != input->src_port))
+	    (rule->src_port != input->src_port) ||
+	    (rule->flow_type != input->flow_type) ||
+	    (rule->ip4_proto != input->ip4_proto) ||
+	    (rule->sctp_v_tag != input->sctp_v_tag) ||
+	    (rule->q_index != input->q_index))
 		return false;
 	return true;
 }
-- 
2.4.3

