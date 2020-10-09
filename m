From: Pujin Shi <shipujin.t@gmail.com>
Date: Fri,  9 Oct 2020 14:18:27 +0800
Subject: [Intel-wired-lan] [PATCH] net: intel: ice: Use uintptr_t for
 casting data
Message-ID: <20201009061827.1279-1-shipujin.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix up a compiler error on 64bit architectures where pointers.

In file included from drivers/net/ethernet/intel/ice/ice_flex_pipe.c:6:0:
drivers/net/ethernet/intel/ice/ice_flex_pipe.c: In function 'ice_free_flow_profs':
drivers/net/ethernet/intel/ice/ice_flow.h:197:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
 #define ICE_FLOW_ENTRY_HNDL(e) ((u64)e)
                                 ^
drivers/net/ethernet/intel/ice/ice_flex_pipe.c:2882:9: note: in expansion of macro 'ICE_FLOW_ENTRY_HNDL'
         ICE_FLOW_ENTRY_HNDL(e));
         ^
In file included from drivers/net/ethernet/intel/ice/ice_flow.c:5:0:
drivers/net/ethernet/intel/ice/ice_flow.c: In function 'ice_flow_add_entry':
drivers/net/ethernet/intel/ice/ice_flow.h:197:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
 #define ICE_FLOW_ENTRY_HNDL(e) ((u64)e)
                                 ^
drivers/net/ethernet/intel/ice/ice_flow.c:946:13: note: in expansion of macro 'ICE_FLOW_ENTRY_HNDL'
  *entry_h = ICE_FLOW_ENTRY_HNDL(e);
             ^

2 warnings generated

Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index 3913da2116d2..b9a5c208e484 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -194,7 +194,7 @@ struct ice_flow_entry {
 	u16 entry_sz;
 };
 
-#define ICE_FLOW_ENTRY_HNDL(e)	((u64)e)
+#define ICE_FLOW_ENTRY_HNDL(e)	((uintptr_t)e)
 #define ICE_FLOW_ENTRY_PTR(h)	((struct ice_flow_entry *)(h))
 
 struct ice_flow_prof {
-- 
2.18.1

