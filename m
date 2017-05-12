From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 12 May 2017 11:38:07 -0700
Subject: [Intel-wired-lan] [PATCH 1/4] ixgbe: Resolve truncation warning for
	q_vector->name
Message-ID: <20170512183810.26185-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following warning is now shown as a result of new checks added for
gcc 7:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function ?ixgbe_open?:
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3118:13: warning: ?%d? directive output may be truncated writing between 1 and 10 bytes into a region of size between 3 and 18 [-Wformat-truncation=]
      "%s-%s-%d", netdev->name, "TxRx", ri++);
             ^~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3118:6: note: directive argument in the range [0, 2147483647]
      "%s-%s-%d", netdev->name, "TxRx", ri++);
      ^~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3117:4: note: ?snprintf? output between 8 and 32 bytes into a destination of size 24
    snprintf(q_vector->name, sizeof(q_vector->name) - 1,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      "%s-%s-%d", netdev->name, "TxRx", ri++);
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Resolve this warning by making a couple of changes.
 - Don't reserve space for the null terminator.  Since snprintf adds the
   null terminator automatically, there is no need for us to reserve a byte
   for it.

 - Change a couple variables that can never be negative from int to
   unsigned int.

While we're making changes to the format string, move the constant strings
into the format string instead of providing them as specifiers.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ee20a2b..04ccb64 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3105,23 +3105,23 @@ int ixgbe_poll(struct napi_struct *napi, int budget)
 static int ixgbe_request_msix_irqs(struct ixgbe_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	unsigned int ri = 0, ti = 0;
 	int vector, err;
-	int ri = 0, ti = 0;
 
 	for (vector = 0; vector < adapter->num_q_vectors; vector++) {
 		struct ixgbe_q_vector *q_vector = adapter->q_vector[vector];
 		struct msix_entry *entry = &adapter->msix_entries[vector];
 
 		if (q_vector->tx.ring && q_vector->rx.ring) {
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "%s-%s-%d", netdev->name, "TxRx", ri++);
+			snprintf(q_vector->name, sizeof(q_vector->name),
+				 "%s-TxRx-%u", netdev->name, ri++);
 			ti++;
 		} else if (q_vector->rx.ring) {
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "%s-%s-%d", netdev->name, "rx", ri++);
+			snprintf(q_vector->name, sizeof(q_vector->name),
+				 "%s-rx-%u", netdev->name, ri++);
 		} else if (q_vector->tx.ring) {
-			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
-				 "%s-%s-%d", netdev->name, "tx", ti++);
+			snprintf(q_vector->name, sizeof(q_vector->name),
+				 "%s-tx-%u", netdev->name, ti++);
 		} else {
 			/* skip this unused q_vector */
 			continue;
-- 
2.9.3

