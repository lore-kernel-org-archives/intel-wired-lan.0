From: Mario Limonciello <mario.limonciello@dell.com>
Date: Tue,  8 Dec 2020 12:56:32 -0600
Subject: [Intel-wired-lan] [PATCH RESEND] e1000e: fix S0ix flow to allow
 S0i3.2 subset entry
Message-ID: <20201208185632.151052-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Changed a configuration in the flows to align with
architecture requirements to achieve S0i3.2 substate.

This helps both i219V and i219LM configurations.

Also fixed a typo in the previous commit 632fbd5eb5b0
("e1000e: fix S0ix flows for cable connected case").

Fixes: 632fbd5eb5b0 ("e1000e: fix S0ix flows for cable connected case").
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
This patch was originally part of 
https://marc.info/?l=linux-netdev&m=160677194809564&w=2
which requested fixes. It was then resubmitted as part of:
https://patchwork.ozlabs.org/project/netdev/list/?series=218712
However there is discussion on the other patches of the series.
As it fixes existing hardware that is not blocked by ME check (i219V)
resubmit it separately to at least fix that hardware.

 drivers/net/ethernet/intel/e1000e/netdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 3ecd05b28fe6..6588f5d4a2be 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6475,13 +6475,13 @@ static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 
 	/* Ungate PGCB clock */
 	mac_data = er32(FEXTNVM9);
-	mac_data |= BIT(28);
+	mac_data &= ~BIT(28);
 	ew32(FEXTNVM9, mac_data);
 
 	/* Enable K1 off to enable mPHY Power Gating */
 	mac_data = er32(FEXTNVM6);
 	mac_data |= BIT(31);
-	ew32(FEXTNVM12, mac_data);
+	ew32(FEXTNVM6, mac_data);
 
 	/* Enable mPHY power gating for any link and speed */
 	mac_data = er32(FEXTNVM8);
@@ -6525,11 +6525,11 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 	/* Disable K1 off */
 	mac_data = er32(FEXTNVM6);
 	mac_data &= ~BIT(31);
-	ew32(FEXTNVM12, mac_data);
+	ew32(FEXTNVM6, mac_data);
 
 	/* Disable Ungate PGCB clock */
 	mac_data = er32(FEXTNVM9);
-	mac_data &= ~BIT(28);
+	mac_data |= BIT(28);
 	ew32(FEXTNVM9, mac_data);
 
 	/* Cancel not waking from dynamic
-- 
2.25.1

