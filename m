From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue,  7 Jun 2016 16:09:00 -0700
Subject: [Intel-wired-lan] [PATCH v2 16/18] fm10k: force link to remain down
	for at least a second on resume events
In-Reply-To: <20160607230902.5457-1-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
Message-ID: <20160607230902.5457-17-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When we resume from an AER recovery with many active VFs, the PF sees
many spurious link up and link down events. Prevent this by delaying
link down for at least one second after the resume event.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index d4ccb2a0c585..b8245c734c96 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2158,6 +2158,10 @@ static int fm10k_handle_resume(struct fm10k_intfc *interface)
 	interface->host_ready = false;
 	fm10k_watchdog_host_not_ready(interface);
 
+	/* force link to stay down for a second to prevent link flutter */
+	interface->link_down_event = jiffies + (HZ);
+	set_bit(__FM10K_LINK_DOWN, &interface->state);
+
 	/* clear the service task disable bit to allow service task to start */
 	clear_bit(__FM10K_SERVICE_DISABLE, &interface->state);
 	fm10k_service_event_schedule(interface);
-- 
2.9.0.rc1.405.g81f467e

