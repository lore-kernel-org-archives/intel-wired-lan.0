From: Sasha Levin <sashal@kernel.org>
Date: Fri, 14 Feb 2020 10:48:47 -0500
Subject: [Intel-wired-lan] [PATCH AUTOSEL 5.5 535/542] i40e: Relax
 i40e_xsk_wakeup's return value when PF is busy
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
Message-ID: <20200214154854.6746-535-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit c77e9f09143822623dd71a0fdc84331129e97c3a ]

Return -EAGAIN instead of -ENETDOWN to provide a slightly milder
information to user space so that an application will know to retry the
syscall when __I40E_CONFIG_BUSY bit is set on pf->state.

Fixes: b3873a5be757 ("net/i40e: Fix concurrency issues between config flow and XSK")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>
Link: https://lore.kernel.org/bpf/20200205045834.56795-2-maciej.fijalkowski at intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index f73cd917c44f7..3156de786d955 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -791,7 +791,7 @@ int i40e_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 	struct i40e_ring *ring;
 
 	if (test_bit(__I40E_CONFIG_BUSY, pf->state))
-		return -ENETDOWN;
+		return -EAGAIN;
 
 	if (test_bit(__I40E_VSI_DOWN, vsi->state))
 		return -ENETDOWN;
-- 
2.20.1

