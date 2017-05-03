From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 May 2017 16:51:47 -0700
Subject: [Intel-wired-lan] [PATCH] ethtool: show vf and queue in the help
	for -N
Message-ID: <20170503235147.17709-1-jacob.e.keller@intel.com>
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
index 7af039e26b50..d4b204c2a04b 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4780,7 +4780,7 @@ static const struct option {
 	  "			[ vlan %x [m %x] ]\n"
 	  "			[ user-def %x [m %x] ]\n"
 	  "			[ dst-mac %x:%x:%x:%x:%x:%x [m %x:%x:%x:%x:%x:%x] ]\n"
-	  "			[ action %d ]\n"
+	  "			[ action %d ] | [ vf %d queue %d ]\n"
 	  "			[ loc %d]] |\n"
 	  "		delete %d\n" },
 	{ "-T|--show-time-stamping", 1, do_tsinfo,
-- 
2.13.0.rc0.317.gcc792a6cad5a

