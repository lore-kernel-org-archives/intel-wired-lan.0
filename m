From: Alan Brady <alan.brady@intel.com>
Date: Thu,  5 Oct 2017 14:53:40 -0700
Subject: [Intel-wired-lan] [PATCH v3 10/14 net-next] ethtool: add
	ethtool_intersect_link_masks
In-Reply-To: <20171005215344.2886-1-alan.brady@intel.com>
References: <20171005215344.2886-1-alan.brady@intel.com>
Message-ID: <20171005215344.2886-11-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This function provides a way to intersect two link masks together to
find the common ground between them.  For example in i40e, the driver
first generates link masks for what is supported by the PHY type.  The
driver then gets the link masks for what the NVM supports.  The
resulting intersection between them yields what can truly be supported.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 include/linux/ethtool.h | 10 ++++++++++
 net/core/ethtool.c      | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 4587a4c36923..c77fa3529e15 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -163,6 +163,16 @@ extern int
 __ethtool_get_link_ksettings(struct net_device *dev,
 			     struct ethtool_link_ksettings *link_ksettings);
 
+/**
+ * ethtool_intersect_link_masks - Given two link masks, AND them together
+ * @dst: first mask and where result is stored
+ * @src: second mask to intersect with
+ *
+ * Given two link mode masks, AND them together and save the result in dst.
+ */
+void ethtool_intersect_link_masks(struct ethtool_link_ksettings *dst,
+				  struct ethtool_link_ksettings *src);
+
 void ethtool_convert_legacy_u32_to_link_mode(unsigned long *dst,
 					     u32 legacy_u32);
 
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index 3228411ada0f..0c406306792a 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -403,6 +403,22 @@ static int __ethtool_set_flags(struct net_device *dev, u32 data)
 	return 0;
 }
 
+/* Given two link masks, AND them together and save the result in dst. */
+void ethtool_intersect_link_masks(struct ethtool_link_ksettings *dst,
+				  struct ethtool_link_ksettings *src)
+{
+	unsigned int size = BITS_TO_LONGS(__ETHTOOL_LINK_MODE_MASK_NBITS);
+	unsigned int idx = 0;
+
+	for (; idx < size; idx++) {
+		dst->link_modes.supported[idx] &=
+			src->link_modes.supported[idx];
+		dst->link_modes.advertising[idx] &=
+			src->link_modes.advertising[idx];
+	}
+}
+EXPORT_SYMBOL(ethtool_intersect_link_masks);
+
 void ethtool_convert_legacy_u32_to_link_mode(unsigned long *dst,
 					     u32 legacy_u32)
 {
-- 
2.14.1

