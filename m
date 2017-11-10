From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 10 Nov 2017 10:55:52 -0800
Subject: [Intel-wired-lan] [PATCH 2/3] ethtool: show vf and queue in the
 help for -N
In-Reply-To: <20171110185553.14657-1-jacob.e.keller@intel.com>
References: <20171110185553.14657-1-jacob.e.keller@intel.com>
Message-ID: <20171110185553.14657-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Show that you can use vf and queue instead of action in the help output,
and not only in the manual page.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index 1a2b7ccd2edf..4149bb4eeda2 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4856,7 +4856,7 @@ static const struct option {
 	  "			[ vlan %x [m %x] ]\n"
 	  "			[ user-def %x [m %x] ]\n"
 	  "			[ dst-mac %x:%x:%x:%x:%x:%x [m %x:%x:%x:%x:%x:%x] ]\n"
-	  "			[ action %d ]\n"
+	  "			[ action %d ] | [ vf %d queue %d ]\n"
 	  "			[ loc %d]] |\n"
 	  "		delete %d\n" },
 	{ "-T|--show-time-stamping", 1, do_tsinfo,
-- 
2.15.0

