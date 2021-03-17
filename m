From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 16 Mar 2021 17:30:36 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 01/10] ethtool: Add common
 function for filling out strings
In-Reply-To: <161594093708.5644.11391417312031401152.stgit@localhost.localdomain>
References: <161594093708.5644.11391417312031401152.stgit@localhost.localdomain>
Message-ID: <161594103620.5644.13159023537924919629.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexanderduyck@fb.com>

Add a function to handle the common pattern of printing a string into the
ethtool strings interface and incrementing the string pointer by the
ETH_GSTRING_LEN. Most of the drivers end up doing this and several have
implemented their own versions of this function so it would make sense to
consolidate on one implementation.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 include/linux/ethtool.h |    9 +++++++++
 net/ethtool/ioctl.c     |   12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index ec4cd3921c67..3583f7fc075c 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -571,4 +571,13 @@ struct ethtool_phy_ops {
  */
 void ethtool_set_ethtool_phy_ops(const struct ethtool_phy_ops *ops);
 
+/**
+ * ethtool_sprintf - Write formatted string to ethtool string data
+ * @data: Pointer to start of string to update
+ * @fmt: Format of string to write
+ *
+ * Write formatted string to data. Update data to point at start of
+ * next string.
+ */
+extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 24783b71c584..0788cc3b3114 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1844,6 +1844,18 @@ static int ethtool_get_strings(struct net_device *dev, void __user *useraddr)
 	return ret;
 }
 
+__printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(*data, ETH_GSTRING_LEN, fmt, args);
+	va_end(args);
+
+	*data += ETH_GSTRING_LEN;
+}
+EXPORT_SYMBOL(ethtool_sprintf);
+
 static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_value id;


