From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Fri, 26 Mar 2021 19:43:41 +0100
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse error: uninitialized
 symbol 'ring'
In-Reply-To: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
References: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
Message-ID: <20210326184343.133396-2-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Init pointer with NULL in default switch case statement.

Previously the error was produced when compiling against sparse.
i40e_debugfs.c:582 i40e_dbg_dump_desc() error: uninitialized symbol 'ring'.

Fixes: 44ea803e2fa7 ("i40e: introduce new dump desc XDP command")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index d7c13ca..d627b59 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -578,6 +578,9 @@ static void i40e_dbg_dump_desc(int cnt, int vsi_seid, int ring_id, int desc_n,
 	case RING_TYPE_XDP:
 		ring = kmemdup(vsi->xdp_rings[ring_id], sizeof(*ring), GFP_KERNEL);
 		break;
+	default:
+		ring = NULL;
+		break;
 	}
 	if (!ring)
 		return;

base-commit: ca4303103f33952646218db4e0869e6f6aa1c840
-- 
2.26.0

