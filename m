From: Stefan Assmann <sassmann@kpanic.de>
Date: Fri, 10 Jul 2015 15:01:12 +0200
Subject: [Intel-wired-lan] [PATCH] igb: do not re-init SR-IOV during probe
Message-ID: <1436533272-18070-1-git-send-email-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

During driver probing the following code path is triggered.
igb_probe
->igb_sw_init
  ->igb_probe_vfs
    ->igb_pci_enable_sriov
      ->igb_sriov_reinit

Doing the SR-IOV re-init is not necessary during probing since we're
starting from scratch. Here we can call igb_enable_sriov() right away.

Running igb_sriov_reinit() during igb_probe() also seems to cause
occasional packet loss on some onboard 82576 NICs. Reproduced on
Dell and HP servers with onboard 82576 NICs.
Example:
Intel Corporation 82576 Gigabit Network Connection [8086:10c9] (rev 01)
Subsystem: Dell Device [1028:0481]

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f287186..7f41237 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2847,7 +2847,7 @@ static void igb_probe_vfs(struct igb_adapter *adapter)
 		return;
 
 	pci_sriov_set_totalvfs(pdev, 7);
-	igb_pci_enable_sriov(pdev, max_vfs);
+	igb_enable_sriov(pdev, max_vfs);
 
 #endif /* CONFIG_PCI_IOV */
 }
-- 
2.4.3

