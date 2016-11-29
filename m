From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 28 Nov 2016 16:06:05 -0800
Subject: [Intel-wired-lan] [next PATCH S55 08/14] i40evf: fix client warnings
In-Reply-To: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480377971-23412-9-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Faisal Latif <faisal.latif@intel.com>

The function prototype in i40evf_client.h are giving warnings while
compiling i40iwvf module. Move these function prototypes to i40evf.h.
Also fix return code from u32 to int and this return code is
consistent with i40e_client.h

Signed-off-by: Faisal Latif <faisal.latif@intel.com>
Change-Id: Ie3757f844993aabc27654aaf02ec14fb985ad2c4
---
 drivers/net/ethernet/intel/i40evf/i40evf.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index fffe4cf..1789266 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -336,4 +336,11 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 				enum i40e_virtchnl_ops v_opcode,
 				i40e_status v_retval, u8 *msg, u16 msglen);
 int i40evf_config_rss(struct i40evf_adapter *adapter);
+int i40evf_lan_add_device(struct i40evf_adapter *adapter);
+int i40evf_lan_del_device(struct i40evf_adapter *adapter);
+void i40evf_client_subtask(struct i40evf_adapter *adapter);
+void i40evf_notify_client_message(struct i40e_vsi *vsi, u8 *msg, u16 len);
+void i40evf_notify_client_l2_params(struct i40e_vsi *vsi);
+void i40evf_notify_client_open(struct i40e_vsi *vsi);
+void i40evf_notify_client_close(struct i40e_vsi *vsi);
 #endif /* _I40EVF_H_ */
-- 
2.4.11

