From: Alice Michael <alice.michael@intel.com>
Date: Fri, 27 Oct 2017 11:06:54 -0400
Subject: [Intel-wired-lan] [next PATCH S81-V3 7/9] i40e: add helper
	conversion function for link_speed
In-Reply-To: <20171027150656.68250-1-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
Message-ID: <20171027150656.68250-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We introduced the virtchnl interface in order to have an interface for
talking to a virtual device driver which was host-driver agnostic. This
interface has its own definitions, including one for link speed.

The host driver has to talk to the virtchnl interface using these new
definitions in order to remain compatible. Today, the i40e link_speed
enumerations are value-exact matches for the virtchnl interface, so it
was originally decided to simply use a typecast.

However, this is unsafe, and makes it easier for future drivers to
continue this unsafe practice. There is nothing guaranteeing these
values are exact, and the type-cast would hide any compiler warning
which indicates the problem.

Rather than rely on this type cast, introduce a helper function which
can convert the AdminQ link speed definition into a virtchnl
definition. This can then be used by host driver implementations in
order to safely convert to the interface recognized by the virtual
functions.

If the link speed is not able to be represented by the virtchnl
definitions we'll report UNKNOWN which is the safest result.

This will ensure that should the driver specific link_speeds actual bit
definitions change, we do not report them incorrectly according to the
VF.

Additionally, this provides a better pattern for future drivers to copy,
as it is more likely a future device may not use the exact same bit-wise
definition as the current virtchnl interface.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   | 31 ++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 +--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 3bb6659..e70bebc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -343,6 +343,37 @@ static inline struct i40e_rx_ptype_decoded decode_rx_desc_ptype(u8 ptype)
 	return i40e_ptype_lookup[ptype];
 }
 
+/**
+ * i40e_virtchnl_link_speed - Convert AdminQ link_speed to virtchnl definition
+ * @link_speed: the speed to convert
+ *
+ * Returns the link_speed in terms of the virtchnl interface, for use in
+ * converting link_speed as reported by the AdminQ into the format used for
+ * talking to virtchnl devices. If we can't represent the link speed properly,
+ * report LINK_SPEED_UNKNOWN.
+ **/
+static inline enum virtchnl_link_speed
+i40e_virtchnl_link_speed(enum i40e_aq_link_speed link_speed)
+{
+	switch (link_speed) {
+	case I40E_LINK_SPEED_100MB:
+		return VIRTCHNL_LINK_SPEED_100MB;
+	case I40E_LINK_SPEED_1GB:
+		return VIRTCHNL_LINK_SPEED_1GB;
+	case I40E_LINK_SPEED_10GB:
+		return VIRTCHNL_LINK_SPEED_10GB;
+	case I40E_LINK_SPEED_40GB:
+		return VIRTCHNL_LINK_SPEED_40GB;
+	case I40E_LINK_SPEED_20GB:
+		return VIRTCHNL_LINK_SPEED_20GB;
+	case I40E_LINK_SPEED_25GB:
+		return VIRTCHNL_LINK_SPEED_25GB;
+	case I40E_LINK_SPEED_UNKNOWN:
+	default:
+		return VIRTCHNL_LINK_SPEED_UNKNOWN;
+	}
+}
+
 /* prototype for functions used for SW locks */
 
 /* i40e_common for VF drivers*/
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 5c5113c..bfba60f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -81,12 +81,12 @@ static void i40e_vc_notify_vf_link_state(struct i40e_vf *vf)
 	if (vf->link_forced) {
 		pfe.event_data.link_event.link_status = vf->link_up;
 		pfe.event_data.link_event.link_speed =
-			(vf->link_up ? I40E_LINK_SPEED_40GB : 0);
+			(vf->link_up ? VIRTCHNL_LINK_SPEED_40GB : 0);
 	} else {
 		pfe.event_data.link_event.link_status =
 			ls->link_info & I40E_AQ_LINK_UP;
 		pfe.event_data.link_event.link_speed =
-			(enum virtchnl_link_speed)ls->link_speed;
+			i40e_virtchnl_link_speed(ls->link_speed);
 	}
 	i40e_aq_send_msg_to_vf(hw, abs_vf_id, VIRTCHNL_OP_EVENT,
 			       0, (u8 *)&pfe, sizeof(pfe), NULL);
-- 
2.9.5

