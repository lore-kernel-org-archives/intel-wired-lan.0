From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon,  8 Jul 2019 12:55:46 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] e1000e: disable force K1-off feature
In-Reply-To: <20190708045546.30160-1-kai.heng.feng@canonical.com>
References: <20190708045546.30160-1-kai.heng.feng@canonical.com>
Message-ID: <20190708045546.30160-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Forwardport from http://mails.dpdk.org/archives/dev/2016-November/050658.html

MAC-PHY desync may occur causing misdetection of link up event.
Disabling K1-off feature can work around the problem.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204057

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/hw.h      | 1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index eff75bd8a8f0..e3c71fd093ee 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -662,6 +662,7 @@ struct e1000_dev_spec_ich8lan {
 	bool kmrn_lock_loss_workaround_enabled;
 	struct e1000_shadow_ram shadow_ram[E1000_ICH8_SHADOW_RAM_WORDS];
 	bool nvm_k1_enabled;
+	bool disable_k1_off;
 	bool eee_disable;
 	u16 eee_lp_ability;
 	enum e1000_ulp_state ulp_state;
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 56f88a4e538c..c1e0e03dc5cb 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1538,6 +1538,9 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 				fextnvm6 &= ~E1000_FEXTNVM6_K1_OFF_ENABLE;
 		}
 
+		if (hw->dev_spec.ich8lan.disable_k1_off == true)
+			fextnvm6 &= ~E1000_FEXTNVM6_K1_OFF_ENABLE;
+
 		ew32(FEXTNVM6, fextnvm6);
 	}
 
-- 
2.17.1

