From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 28 Nov 2016 16:06:10 -0800
Subject: [Intel-wired-lan] [next PATCH S55 13/14] i40e: update comment
	explaining where FDIR buffers are freed
In-Reply-To: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480377971-23412-14-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The original comment implies that the only location where the raw_packet
buffer will be freed is in i40e_clean_tx_ring() which is incorrect. In
fact this isn't even the normal case. Update the comment explaining
where the memory is freed.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Ie0defc35ed1c3af183f81fdc60b6d783707a5595
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 3e99206..e88e335 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -432,7 +432,12 @@ int i40e_add_del_fdir(struct i40e_vsi *vsi,
 		ret = -EINVAL;
 	}
 
-	/* The buffer allocated here is freed by the i40e_clean_tx_ring() */
+	/* The buffer allocated here will be normally be freed by
+	 * i40e_clean_fdir_tx_irq() as it reclaims resources after transmit
+	 * completion. In the event of an error adding the buffer to the FDIR
+	 * ring, it will immediately be freed. It may also be freed by
+	 * i40e_clean_tx_ring() when closing the VSI.
+	 */
 	return ret;
 }
 
-- 
2.4.11

