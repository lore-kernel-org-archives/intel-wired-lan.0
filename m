From: Alexander Duyck <aduyck@mirantis.com>
Date: Fri, 18 Mar 2016 16:06:53 -0700
Subject: [Intel-wired-lan] [next PATCH 2/2] igb: Fix sparse warning about
 passing __beXX into leXX_to_cpup
In-Reply-To: <20160318230425.14801.87895.stgit@localhost.localdomain>
References: <20160318230425.14801.87895.stgit@localhost.localdomain>
Message-ID: <20160318230653.14801.86163.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We were casting the addr as __beXX and then passing it into le32_to_cpu
because the device expects the MAC address to be in network order even
though the register set is little endian.  Instead of casting it as __beXX
we can just cast it as __leXX in order to maintain consistency since the
region of memory is already in little endian order as far as we are
concerned.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 7f7e4a2a5fe2..f3fd43e1c4e8 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7850,11 +7850,13 @@ static void igb_rar_set_qsel(struct igb_adapter *adapter, u8 *addr, u32 index,
 	struct e1000_hw *hw = &adapter->hw;
 	u32 rar_low, rar_high;
 
-	/* HW expects these in little endian so we reverse the byte order
-	 * from network order (big endian) to CPU endian
+	/* HW expects these to be in network order when they are plugged
+	 * into the registers which are little endian.  In order to guarantee
+	 * that ordering we need to do an leXX_to_cpup here in order to be
+	 * ready for the byteswap that occurs with writel
 	 */
-	rar_low = le32_to_cpup((__be32 *)(addr));
-	rar_high = le16_to_cpup((__be16 *)(addr + 4));
+	rar_low = le32_to_cpup((__le32 *)(addr));
+	rar_high = le16_to_cpup((__le16 *)(addr + 4));
 
 	/* Indicate to hardware the Address is Valid. */
 	rar_high |= E1000_RAH_AV;

