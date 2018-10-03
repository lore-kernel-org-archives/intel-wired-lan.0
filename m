From: Lance Roy <ldr709@gmail.com>
Date: Tue,  2 Oct 2018 22:38:51 -0700
Subject: [Intel-wired-lan] [PATCH 05/16] igbvf: Replace spin_is_locked()
 with lockdep
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Message-ID: <20181003053902.6910-6-ldr709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: intel-wired-lan at lists.osuosl.org
Cc: <netdev@vger.kernel.org>
---
 drivers/net/ethernet/intel/igbvf/mbx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/mbx.c b/drivers/net/ethernet/intel/igbvf/mbx.c
index 163e5838f7c2..a3cd7ac48d4b 100644
--- a/drivers/net/ethernet/intel/igbvf/mbx.c
+++ b/drivers/net/ethernet/intel/igbvf/mbx.c
@@ -241,7 +241,7 @@ static s32 e1000_write_mbx_vf(struct e1000_hw *hw, u32 *msg, u16 size)
 	s32 err;
 	u16 i;
 
-	WARN_ON_ONCE(!spin_is_locked(&hw->mbx_lock));
+	lockdep_assert_held(&hw->mbx_lock);
 
 	/* lock the mailbox to prevent pf/vf race condition */
 	err = e1000_obtain_mbx_lock_vf(hw);
@@ -279,7 +279,7 @@ static s32 e1000_read_mbx_vf(struct e1000_hw *hw, u32 *msg, u16 size)
 	s32 err;
 	u16 i;
 
-	WARN_ON_ONCE(!spin_is_locked(&hw->mbx_lock));
+	lockdep_assert_held(&hw->mbx_lock);
 
 	/* lock the mailbox to prevent pf/vf race condition */
 	err = e1000_obtain_mbx_lock_vf(hw);
-- 
2.19.0

