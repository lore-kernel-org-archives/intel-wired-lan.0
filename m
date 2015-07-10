From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 10 Jul 2015 19:36:04 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][next PATCH S8 09/15] i40e:
	correct spelling error
In-Reply-To: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
References: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1436571370-103673-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Turns out that 'inavlid' is an inavlid spelling for 'invalid'.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ie1fe2d0f8d1ba75ab880594875ec2e4152a76f61
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 62824f5..e972b5e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2546,7 +2546,7 @@ static int i40e_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
  * @indir: indirection table
  * @key: hash key
  *
- * Returns -EINVAL if the table specifies an inavlid queue id, otherwise
+ * Returns -EINVAL if the table specifies an invalid queue id, otherwise
  * returns 0 after programming the table.
  **/
 static int i40e_set_rxfh(struct net_device *netdev, const u32 *indir,
-- 
1.9.3

