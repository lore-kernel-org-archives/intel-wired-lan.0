From: =?unknown-8bit?q?J=C4=99drzej?= Jagielski <jedrzej.jagielski@intel.com>
Date: Wed,  2 Jun 2021 00:43:24 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix to various static
 analysis warnings
Message-ID: <20210602004324.392848-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix static analysis warnings from sparse.

Fixes: e793095e8a57 ("i40e: add parsing of flexible filter fields from userdef")
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Suggested-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 14 +++++++-------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 3e822bad4..cbd640e0e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3138,8 +3138,8 @@ static int i40e_parse_rx_flow_user_data(struct ethtool_rx_flow_spec *fsp,
 	if (!(fsp->flow_type & FLOW_EXT))
 		return 0;
 
-	value = be64_to_cpu(*((__be64 *)fsp->h_ext.data));
-	mask = be64_to_cpu(*((__be64 *)fsp->m_ext.data));
+	value = be64_to_cpu(*((__force __be64 *)fsp->h_ext.data));
+	mask = be64_to_cpu(*((__force __be64 *)fsp->m_ext.data));
 
 #define I40E_USERDEF_FLEX_WORD		GENMASK_ULL(15, 0)
 #define I40E_USERDEF_FLEX_OFFSET	GENMASK_ULL(31, 16)
@@ -3180,8 +3180,8 @@ static void i40e_fill_rx_flow_user_data(struct ethtool_rx_flow_spec *fsp,
 	if (value || mask)
 		fsp->flow_type |= FLOW_EXT;
 
-	*((__be64 *)fsp->h_ext.data) = cpu_to_be64(value);
-	*((__be64 *)fsp->m_ext.data) = cpu_to_be64(mask);
+	*((__force __be64 *)fsp->h_ext.data) = cpu_to_be64(value);
+	*((__force __be64 *)fsp->m_ext.data) = cpu_to_be64(mask);
 }
 
 /**
@@ -4150,9 +4150,9 @@ static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
 				     struct ethtool_rx_flow_spec *fsp,
 				     struct i40e_rx_flow_userdef *userdef)
 {
-	static const __be32 ipv6_full_mask[4] = {cpu_to_be32(0xffffffff),
+	static const __be32 ipv6_full_mask[4] = {
 		cpu_to_be32(0xffffffff), cpu_to_be32(0xffffffff),
-		cpu_to_be32(0xffffffff)};
+		cpu_to_be32(0xffffffff), cpu_to_be32(0xffffffff)};
 	struct ethtool_tcpip6_spec *tcp_ip6_spec;
 	struct ethtool_usrip6_spec *usr_ip6_spec;
 	struct ethtool_tcpip4_spec *tcp_ip4_spec;
@@ -5599,7 +5599,7 @@ static int i40e_set_eee(struct net_device *netdev, struct ethtool_eee *edata)
 		config.eeer |= cpu_to_le32(I40E_PRTPM_EEER_TX_LPI_EN_MASK);
 	} else {
 		config.eee_capability = 0;
-		config.eeer &= cpu_to_le32(~I40E_PRTPM_EEER_TX_LPI_EN_MASK);
+		config.eeer &= ~cpu_to_le32(I40E_PRTPM_EEER_TX_LPI_EN_MASK);
 	}
 
 	/* Apply modified PHY configuration */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 49575a640..e406fee93 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -77,7 +77,7 @@ struct i40e_vf {
 	u16 stag;
 
 	struct virtchnl_ether_addr default_lan_addr;
-	u16 port_vlan_id;
+	s16 port_vlan_id;
 	bool pf_set_mac;	/* The VMM admin set the VF MAC address */
 	bool trusted;
 
-- 
2.18.2

Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

