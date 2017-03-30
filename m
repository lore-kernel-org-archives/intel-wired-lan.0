From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 30 Mar 2017 00:46:07 -0700
Subject: [Intel-wired-lan] [next S65 2/3 v2] i40e: register existing client
	on probe
In-Reply-To: <20170330074608.52108-1-jeffrey.t.kirsher@intel.com>
References: <20170330074608.52108-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170330074608.52108-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

In some cases, a client (i40iw) may already be present when probe is
called. Check for this, and add a client instance if necessary.

Testing Hints (required if no HSD): On OFED 4.x, run 'driverctl
unset-override' then reload i40e

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I2009312694b7ad81f1023919e4c6c86181f21689
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index d05296a7078e..eb2896fd52a6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -436,6 +436,12 @@ int i40e_lan_add_device(struct i40e_pf *pf)
 		 pf->hw.pf_id, pf->hw.bus.bus_id,
 		 pf->hw.bus.device, pf->hw.bus.func);
 
+	/* If a client has already been registered, we need to add an instance
+	 * of it to our new LAN device.
+	 */
+	if (registered_client)
+		i40e_client_add_instance(pf);
+
 	/* Since in some cases register may have happened before a device gets
 	 * added, we can schedule a subtask to go initiate the clients if
 	 * they can be launched at probe time.
-- 
2.12.0

