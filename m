From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Thu, 24 Mar 2016 09:58:40 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix default mac->ops.setup_link
	for X550EM
Message-ID: <20160324165840.23586.31133.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

X550EM_a/x did not have a default value for mac->ops.setup_link which
was causing link issues for backplane devices.

This patch sets mac->ops.setup_link to ixgbe_setup_mac_link_X540 for
X550EM_a/x which is also default for X550. This will result in
mac->ops.setup_link calling the link setup function for the respective
PHY type in case we do not need a special function to deal with it.

Reported-by: Ken Cox <jkc@redhat.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 0dadf2b..c8064a0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2619,7 +2619,7 @@ static const struct ixgbe_mac_operations mac_ops_X550EM_x = {
 	.get_media_type		= &ixgbe_get_media_type_X550em,
 	.get_san_mac_addr	= NULL,
 	.get_wwn_prefix		= NULL,
-	.setup_link		= NULL, /* defined later */
+	.setup_link		= &ixgbe_setup_mac_link_X540,
 	.get_link_capabilities	= &ixgbe_get_link_capabilities_X550em,
 	.get_bus_info		= &ixgbe_get_bus_info_X550em,
 	.setup_sfp		= ixgbe_setup_sfp_modules_X550em,
@@ -2637,7 +2637,7 @@ static struct ixgbe_mac_operations mac_ops_x550em_a = {
 	.get_media_type		= ixgbe_get_media_type_X550em,
 	.get_san_mac_addr	= NULL,
 	.get_wwn_prefix		= NULL,
-	.setup_link		= NULL, /* defined later */
+	.setup_link		= &ixgbe_setup_mac_link_X540,
 	.get_link_capabilities	= ixgbe_get_link_capabilities_X550em,
 	.get_bus_info		= ixgbe_get_bus_info_X550em,
 	.setup_sfp		= ixgbe_setup_sfp_modules_X550em,

