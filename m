From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue,  1 Aug 2017 12:11:07 -0700
Subject: [Intel-wired-lan] [PATCH net 2/7] i40e: Initialize 64-bit
	statistics TX ring seqcount
In-Reply-To: <20170801191113.8754-1-f.fainelli@gmail.com>
References: <20170801191113.8754-1-f.fainelli@gmail.com>
Message-ID: <20170801191113.8754-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 32-bit hosts and with CONFIG_DEBUG_LOCK_ALLOC we should be seeing a
lockdep splat indicating this seqcount is not correctly initialized, fix
that.

Fixes: 980e9b118642 ("i40e: Add support for 64 bit netstats")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b936febc315a..2194960d5855 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1113,6 +1113,8 @@ int i40e_setup_tx_descriptors(struct i40e_ring *tx_ring)
 	if (!tx_ring->tx_bi)
 		goto err;
 
+	u64_stats_init(&tx_ring->syncp);
+
 	/* round up to nearest 4K */
 	tx_ring->size = tx_ring->count * sizeof(struct i40e_tx_desc);
 	/* add u32 for head writeback, align after this takes care of
-- 
2.9.3

