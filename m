From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 24 Sep 2015 09:04:26 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 1/3] i40e/i40evf: Fix handling
	of napi budget
In-Reply-To: <20150924160027.22015.15754.stgit@ahduyck-vm-fedora22>
References: <20150924160027.22015.15754.stgit@ahduyck-vm-fedora22>
Message-ID: <20150924160426.22015.37868.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The polling routine for i40e was rounding up the budget for Rx cleanup to
1.  This is incorrect as the netpoll poll call is expecting no Rx to be
processed as the budget passed was 0.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    5 +++++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index d51b8edebfee..66b1fd26f0fc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1923,6 +1923,10 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		ring->arm_wb = false;
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
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 7b20f53a414a..c60e9cf016c2 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1367,6 +1367,10 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
 		ring->arm_wb = false;
 	}
 
+	/* Handle case where we are called by netpoll with a budget of 0 */
+	if (budget <= 0)
+		goto tx_only;
+
 	/* We attempt to distribute budget to each Rx queue fairly, but don't
 	 * allow the budget to go below 1 because that would exit polling early.
 	 */
@@ -1383,6 +1387,7 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
 
 	/* If work not completed, return budget and polling will return */
 	if (!clean_complete) {
+tx_only:
 		if (arm_wb)
 			i40e_force_wb(vsi, q_vector);
 		return budget;

