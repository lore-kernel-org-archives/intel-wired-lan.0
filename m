From: Colin King <colin.king@canonical.com>
Date: Mon, 15 Feb 2021 16:19:23 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix incorrect use of ip6src due to
 copy-paste coding error
Message-ID: <20210215161923.83682-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

It appears that the call of ipv6_add_any for the destination address
is using ip6src instead of ip6dst, this looks like a copy-paste
coding error. Fix this by replacing ip6src with ip6dst.

Addresses-Coverity: ("Copy-paste error")
Fixes: efca91e89b67 ("i40e: Add flow director support for IPv6")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 8a4dd77a12da..a8a2b5f683a2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4250,7 +4250,7 @@ static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
 				    (struct in6_addr *)&ipv6_full_mask))
 			new_mask |= I40E_L3_V6_DST_MASK;
 		else if (ipv6_addr_any((struct in6_addr *)
-				       &tcp_ip6_spec->ip6src))
+				       &tcp_ip6_spec->ip6dst))
 			new_mask &= ~I40E_L3_V6_DST_MASK;
 		else
 			return -EOPNOTSUPP;
-- 
2.30.0

