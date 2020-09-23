From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 23 Sep 2020 15:47:51 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Power cycle phy on PM resume
Message-ID: <20200923074751.10527-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We are seeing the following error after S3 resume:
[  704.746874] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
[  704.844232] e1000e 0000:00:1f.6 eno1: MDI Write did not complete
[  704.902817] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
[  704.903075] e1000e 0000:00:1f.6 eno1: reading PHY page 769 (or 0x6020 shifted) reg 0x17
[  704.903281] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
[  704.903486] e1000e 0000:00:1f.6 eno1: writing PHY page 769 (or 0x6020 shifted) reg 0x17
[  704.943155] e1000e 0000:00:1f.6 eno1: MDI Error
...
[  705.108161] e1000e 0000:00:1f.6 eno1: Hardware Error

Since we don't know what platform firmware may do to the phy, so let's
power cycle the phy upon system resume to resolve the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 664e8ccc88d2..c2a87a408102 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6968,6 +6968,8 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
 	    !e1000e_check_me(hw->adapter->pdev->device))
 		e1000e_s0ix_exit_flow(adapter);
 
+	e1000_power_down_phy(adapter);
+
 	rc = __e1000_resume(pdev);
 	if (rc)
 		return rc;
-- 
2.17.1

