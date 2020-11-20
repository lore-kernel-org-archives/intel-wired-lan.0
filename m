From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Fri, 20 Nov 2020 10:35:37 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Add zero-initialization of
 AQ command structures
Message-ID: <20201120103537.31075-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Zero-initialize AQ command data structures to comply with
API specifications.

Signed-off-by: Andrzej Sawu?a <andrzej.sawula@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d743bd7..059e0c0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8062,6 +8062,8 @@ int i40e_add_del_cloud_filter(struct i40e_vsi *vsi,
 	if (filter->flags >= ARRAY_SIZE(flag_table))
 		return I40E_ERR_CONFIG;
 
+	memset(&cld_filter, 0, sizeof(cld_filter));
+
 	/* copy element needed to add cloud filter from filter */
 	i40e_set_cld_element(filter, &cld_filter);
 
@@ -8129,6 +8131,8 @@ int i40e_add_del_cloud_filter_big_buf(struct i40e_vsi *vsi,
 	    !ipv6_addr_any(&filter->ip.v6.src_ip6))
 		return -EOPNOTSUPP;
 
+	memset(&cld_filter, 0, sizeof(cld_filter));
+
 	/* copy element needed to add cloud filter from filter */
 	i40e_set_cld_element(filter, &cld_filter.element);
 
@@ -12209,6 +12213,8 @@ i40e_status i40e_set_partition_bw_setting(struct i40e_pf *pf)
 	struct i40e_aqc_configure_partition_bw_data bw_data;
 	i40e_status status;
 
+	memset(&bw_data, 0, sizeof(bw_data));
+
 	/* Set the valid bit for this PF */
 	bw_data.pf_valid_bits = cpu_to_le16(BIT(pf->hw.pf_id));
 	bw_data.max_bw[pf->hw.pf_id] = pf->max_bw & I40E_ALT_BW_VALUE_MASK;
-- 
2.17.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 
