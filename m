From: kan.liang@intel.com <kan.liang@intel.com>
Date: Sun, 17 Jul 2016 23:56:00 -0700
Subject: [Intel-wired-lan] [RFC PATCH 06/30] net/netpolicy: get CPU
	information
In-Reply-To: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
Message-ID: <1468824984-65318-7-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kan Liang <kan.liang@intel.com>

Net policy also needs to know CPU information. Currently, online
CPU number is enough.

Signed-off-by: Kan Liang <kan.liang@intel.com>
---
 net/core/netpolicy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/netpolicy.c b/net/core/netpolicy.c
index 7c34c8a..075aaca 100644
--- a/net/core/netpolicy.c
+++ b/net/core/netpolicy.c
@@ -49,6 +49,11 @@ static void netpolicy_free_dev_info(struct netpolicy_dev_info *d_info)
 	kfree(d_info->tx_irq);
 }
 
+static u32 netpolicy_get_cpu_information(void)
+{
+	return num_online_cpus();
+}
+
 const char *policy_name[NET_POLICY_MAX] = {
 	"NONE"
 };
-- 
2.5.5

