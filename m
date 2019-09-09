From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon,  9 Sep 2019 09:55:38 -0700
Subject: [Intel-wired-lan] [PATCH v2] i40e: fix potential RX buffer
 starvation for AF_XDP
Message-ID: <20190909165538.8125-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

When the RX rings are created they are also populated with buffers
so that packets can be received. Usually these are kernel buffers,
but for AF_XDP in zero-copy mode, these are user-space buffers and
in this case the application might not have sent down any buffers
to the driver at this point. And if no buffers are allocated at ring
creation time, no packets can be received and no interrupts will be
generated so the NAPI poll function that allocates buffers to the
rings will never get executed.

To rectify this, we kick the NAPI context of any queue with an
attached AF_XDP zero-copy socket in two places in the code. Once
after an XDP program has loaded and once after the umem is registered.
This take care of both cases: XDP program gets loaded first then AF_XDP
socket is created, and the reverse, AF_XDP socket is created first,
then XDP program is loaded.

Fixes: 0a714186d3c0 ("i40e: add AF_XDP zero-copy Rx support")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 0373bc6c7e61..feb5bd54d840 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -157,6 +157,11 @@ static int i40e_xsk_umem_disable(struct i40e_vsi *vsi, u16 qid)
 		err = i40e_queue_pair_enable(vsi, qid);
 		if (err)
 			return err;
+
+		/* Kick start the NAPI context so that receiving will start */
+		err = i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);
+		if (err)
+			return err;
 	}
 
 	return 0;
-- 
2.21.0

