From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 02 Nov 2015 17:09:29 -0800
Subject: [Intel-wired-lan] [next PATCH 01/11] ixgbe: Return error on failure
 to allocate mac_table
In-Reply-To: <20151103005850.28233.63113.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
Message-ID: <20151103010929.28233.47017.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a check to make certain mac_table was actually allocated and is not
NULL.  If it is NULL return -ENOMEM and allow the probe routine to fail
rather then causing a NULL pointer dereference further down the line.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a5abcb2f9cbd..af5f367a1a22 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5381,6 +5381,8 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
 	adapter->mac_table = kzalloc(sizeof(struct ixgbe_mac_addr) *
 				     hw->mac.num_rar_entries,
 				     GFP_ATOMIC);
+	if (!adapter->mac_table)
+		return -ENOMEM;
 
 	/* Set MAC specific capability flags and exceptions */
 	switch (hw->mac.type) {

