From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 21 Oct 2017 18:12:29 -0700
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] i40e: Add programming
 descriptors to cleaned_count
Message-ID: <20171022011222.12997.53593.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch updates the i40e driver to include programming descriptors in
the cleaned_count. Without this change it becomes possible for us to leak
memory as we don't trigger a large enough allocation when the time comes to
allocate new buffers and we end up overwriting a number of rx_buffers equal
to the number of programming descriptors we encountered.

Fixes: 0e626ff7ccbf ("i40e: Fix support for flow director programming status")
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 368722defacb..d6d352a6e6ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2102,6 +2102,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 
 		if (unlikely(i40e_rx_is_programming_status(qword))) {
 			i40e_clean_programming_status(rx_ring, rx_desc, qword);
+			cleaned_count++;
 			continue;
 		}
 		size = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>

