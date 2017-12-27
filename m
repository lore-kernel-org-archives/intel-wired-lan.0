From: Alice Michael <alice.michael@intel.com>
Date: Wed, 27 Dec 2017 07:32:42 -0500
Subject: [Intel-wired-lan] [next PATCH S84-V2 13/13] i40e: fix reported mask
 for ntuple filters
In-Reply-To: <20171227123242.22356-1-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
Message-ID: <20171227123242.22356-13-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

In commit 36777d9fa24c ("i40e: check current configured input set when
adding ntuple filters") some code was added to report the input set
mask for a given filter when reporting it to the user.

This code is necessary so that the reported filter correctly displays
that it is or is not masking certain fields.

Unfortunately the code was incorrect. Development error accidentally
swapped the mask values for the IPv4 addresses with the L4 port numbers.
The port numbers are only 16bits wide while IPv4 addresses are 32 bits.
Unfortunately we assigned only 16 bits to the IPv4 address masks.
Additionally we assigned 32bit value 0xFFFFFFF to the TCP port numbers.
This second part does not matter as the value would be truncated to
16bits regardless, but it is unnecessary.

Fix the reported masks to properly report that the entire field is
masked.

Testing-hints:
  Upstream commit message will need to reword to target the equivalent
  upstream commit for the "Fixes" line.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 83021c7..8236689 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2749,16 +2749,16 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 
 no_input_set:
 	if (input_set & I40E_L3_SRC_MASK)
-		fsp->m_u.tcp_ip4_spec.ip4src = htonl(0xFFFF);
+		fsp->m_u.tcp_ip4_spec.ip4src = htonl(0xFFFFFFFF);
 
 	if (input_set & I40E_L3_DST_MASK)
-		fsp->m_u.tcp_ip4_spec.ip4dst = htonl(0xFFFF);
+		fsp->m_u.tcp_ip4_spec.ip4dst = htonl(0xFFFFFFFF);
 
 	if (input_set & I40E_L4_SRC_MASK)
-		fsp->m_u.tcp_ip4_spec.psrc = htons(0xFFFFFFFF);
+		fsp->m_u.tcp_ip4_spec.psrc = htons(0xFFFF);
 
 	if (input_set & I40E_L4_DST_MASK)
-		fsp->m_u.tcp_ip4_spec.pdst = htons(0xFFFFFFFF);
+		fsp->m_u.tcp_ip4_spec.pdst = htons(0xFFFF);
 
 	if (rule->dest_ctl == I40E_FILTER_PROGRAM_DESC_DEST_DROP_PACKET)
 		fsp->ring_cookie = RX_CLS_FLOW_DISC;
-- 
2.9.5

