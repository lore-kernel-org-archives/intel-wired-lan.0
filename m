From: Jablonski, Pawel <pawel.jablonski@intel.com>
Date: Mon, 23 Apr 2018 08:55:53 +0000
Subject: [Intel-wired-lan] [next PATCH S90 4/8] i40evf: Fix turning TSO,
 GSO and GRO on after
In-Reply-To: <20180420084140.8081-4-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
 <20180420084140.8081-4-alice.michael@intel.com>
Message-ID: <2D74C616BCD7994CBB86279EC09C10B429DF85C2@IRSMSX101.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK,

Thanks!

-----Original Message-----
From: Michael, Alice 
Sent: Friday, April 20, 2018 10:42 AM
To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Jablonski, Pawel <pawel.jablonski@intel.com>
Subject: [next PATCH S90 4/8] i40evf: Fix turning TSO, GSO and GRO on after

From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>

This patch fixes the problem where each MTU change turns TSO, GSO and GRO on from off state.

Now when TSO, GSO or GRO is turned off, MTU change does not turn them on.

Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 28a8cc4..3f04a182 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -3357,6 +3357,24 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 	if (vfres->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN)
 		netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
+	/* Do not turn on offloads when they are requested to be turned off.
+	 * TSO needs minimum 576 bytes to work correctly.
+	 */
+	if (netdev->wanted_features) {
+		if (!(netdev->wanted_features & NETIF_F_TSO) ||
+		    netdev->mtu < 576)
+			netdev->features &= ~NETIF_F_TSO;
+		if (!(netdev->wanted_features & NETIF_F_TSO6) ||
+		    netdev->mtu < 576)
+			netdev->features &= ~NETIF_F_TSO6;
+		if (!(netdev->wanted_features & NETIF_F_TSO_ECN))
+			netdev->features &= ~NETIF_F_TSO_ECN;
+		if (!(netdev->wanted_features & NETIF_F_GRO))
+			netdev->features &= ~NETIF_F_GRO;
+		if (!(netdev->wanted_features & NETIF_F_GSO))
+			netdev->features &= ~NETIF_F_GSO;
+	}
+
 	adapter->vsi.id = adapter->vsi_res->vsi_id;
 
 	adapter->vsi.back = adapter;
--
2.9.5

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.
