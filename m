From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 22 Sep 2015 14:35:29 -0700
Subject: [Intel-wired-lan] [net PATCH 1/3] i40e: Fix handling of napi budget
In-Reply-To: <20150922213002.2774.37924.stgit@ahduyck-vm-fedora22>
References: <20150922213002.2774.37924.stgit@ahduyck-vm-fedora22>
Message-ID: <20150922213529.2774.42390.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The polling routine for i40e was rounding up the budget for Rx cleanup to
1.  This is incorrect as netpoll will call is expecting no Rx to be
processed as the budget passed was 0.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 738aca68f665..4ca73a4be4b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1923,6 +1923,10 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		arm_wb |= ring->arm_wb;
 	}
 
+	/* Handle case where we are called by netpoll with a budget of 0 */
+	if (budget <= 0)
+		goto tx_only;
+
 	/* We attempt to distribute budget to each Rx queue fairly, but don't
 	 * allow the budget to go below 1 because that would exit polling early.
 	 */
@@ -1939,6 +1943,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 
 	/* If work not completed, return budget and polling will return */
 	if (!clean_complete) {
+tx_only:
 		if (arm_wb)
 			i40e_force_wb(vsi, q_vector);
 		return budget;

