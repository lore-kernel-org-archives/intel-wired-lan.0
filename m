From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:21:21 -0700
Subject: [Intel-wired-lan] [PATCH S18 08/15] ice: Suppress false-positive
 style issues reported by static analyzer
In-Reply-To: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172128.27184-9-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

A recent version of cppcheck falsely reports-
    Variable ip.hdr is assigned a value that is never used.

ip is a union so the pointer ip.hdr is actually used when referenced as
ip.v4 and ip.v6.  Silence these false reports when using cppcheck with the
--inline-suppr command-line option.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index bf3bf98e0b1c..e9a6c866f616 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1849,6 +1849,7 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	if (err < 0)
 		return err;
 
+	/* cppcheck-suppress unreadVariable */
 	ip.hdr = skb_network_header(skb);
 	l4.hdr = skb_transport_header(skb);
 
-- 
2.20.1

