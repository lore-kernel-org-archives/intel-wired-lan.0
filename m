From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 28 Jun 2019 08:03:30 -0700
Subject: [Intel-wired-lan] [PATCH S23 v2 12/15] ice: Increase size of
 Mailbox receive queue for many VFs
In-Reply-To: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
Message-ID: <20190628150332.59155-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently we use the ICE_MBXQ_LEN for both the Mailbox send and receive
queues that are used to communicate with VFs. This is fine for the send
queue because the PF driver will lock the queue for every single send,
but for the Mailbox receive queue every VF is posting to its Mailbox
send queue and the hardware is then handing the message to the PF on its
Mailbox receive queue. This becomes a problem with many VFs because it
seems to overburden the Mailbox receive queue on the PF. Fix this by
increasing the Mailbox receive queue for the PF to 512 entries.

The number 512 was determined based on the number of VFs supported by
the device. We can have a total of 256 VFs so in the worst case this
allows the VFs to put 2 messages in the PFs Mailbox receive queue at the
same time.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 3 ++-
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 1a438245f4bf..261714ff2553 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -74,7 +74,8 @@ extern const char ice_drv_ver[];
 #define ICE_INT_NAME_STR_LEN	(IFNAMSIZ + 16)
 #define ICE_ETHTOOL_FWVER_LEN	32
 #define ICE_AQ_LEN		64
-#define ICE_MBXQ_LEN		64
+#define ICE_MBXSQ_LEN		64
+#define ICE_MBXRQ_LEN		512
 #define ICE_MIN_MSIX		2
 #define ICE_NO_VSI		0xffff
 #define ICE_MAX_TXQS		2048
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e4dfde18e78d..1b00e7bec21b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1507,8 +1507,8 @@ static void ice_set_ctrlq_len(struct ice_hw *hw)
 	hw->adminq.num_sq_entries = ICE_AQ_LEN;
 	hw->adminq.rq_buf_size = ICE_AQ_MAX_BUF_LEN;
 	hw->adminq.sq_buf_size = ICE_AQ_MAX_BUF_LEN;
-	hw->mailboxq.num_rq_entries = ICE_MBXQ_LEN;
-	hw->mailboxq.num_sq_entries = ICE_MBXQ_LEN;
+	hw->mailboxq.num_rq_entries = ICE_MBXRQ_LEN;
+	hw->mailboxq.num_sq_entries = ICE_MBXSQ_LEN;
 	hw->mailboxq.rq_buf_size = ICE_MBXQ_MAX_BUF_LEN;
 	hw->mailboxq.sq_buf_size = ICE_MBXQ_MAX_BUF_LEN;
 }
-- 
2.20.1

