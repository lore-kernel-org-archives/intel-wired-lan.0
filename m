From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 25 Apr 2017 11:31:06 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: enable L3/L4 filtering for Tx
	switched packets
Message-ID: <20170425183106.14275.33565.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This will ensure that VF-to-VF traffic on the same PF
is filtered to allow RSS operation.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d8b959a..9cae585 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3803,6 +3803,9 @@ static void ixgbe_setup_mrqc(struct ixgbe_adapter *adapter)
 				mrqc = IXGBE_MRQC_VMDQRSS32EN;
 			else
 				mrqc = IXGBE_MRQC_VMDQRSS64EN;
+
+			/* Enable L3/L4 for Tx Switched packets */
+			mrqc |= IXGBE_MRQC_L3L4TXSWEN;
 		} else {
 			if (tcs > 4)
 				mrqc = IXGBE_MRQC_RTRSS8TCEN;

