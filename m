From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 04 Nov 2015 16:02:21 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbevf: minor cleanups for
	ixgbevf_set_itr()
Message-ID: <20151105000221.27372.83040.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

adapter->rx_itr_setting is not a mask so check it with == instead of &
do not default to 12K interrupts in ixgbevf_set_itr()

There should be no functional effect from these changes.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 3d25727..4f949d5 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1045,7 +1045,7 @@ static int ixgbevf_poll(struct napi_struct *napi, int budget)
 		return budget;
 	/* all work done, exit the polling mode */
 	napi_complete_done(napi, work_done);
-	if (adapter->rx_itr_setting & 1)
+	if (adapter->rx_itr_setting == 1)
 		ixgbevf_set_itr(q_vector);
 	if (!test_bit(__IXGBEVF_DOWN, &adapter->state) &&
 	    !test_bit(__IXGBEVF_REMOVING, &adapter->state))
@@ -1248,9 +1248,10 @@ static void ixgbevf_set_itr(struct ixgbevf_q_vector *q_vector)
 		new_itr = IXGBE_20K_ITR;
 		break;
 	case bulk_latency:
-	default:
 		new_itr = IXGBE_12K_ITR;
 		break;
+	default:
+		break;
 	}
 
 	if (new_itr != q_vector->itr) {

