From: Nicholas Nunley <nicholas.d.nunley@intel.com>
Date: Mon, 11 Feb 2019 11:22:27 -0800
Subject: [Intel-wired-lan] [PATCH v3 6/6] ethtool: fix up dump_coalesce
 output to match actual option names
In-Reply-To: <20190211192227.34960-1-nicholas.d.nunley@intel.com>
References: <20190211192227.34960-1-nicholas.d.nunley@intel.com>
Message-ID: <20190211192227.34960-6-nicholas.d.nunley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the coalesce settings are printed with --show-coalesce a few of the
option names lack the pluralization that is present in the man page and
usage info, but are otherwise identical.

This inconsistency could lead to some confusion if a user attempts to set
the coalesce settings by matching the output they see from --show-coalesce,
so fix this.

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
---
 ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 2296578..8e20616 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -1373,14 +1373,14 @@ static int dump_coalesce(const struct ethtool_coalesce *ecoal)
 		"tx-frames-irq: %u\n"
 		"\n"
 		"rx-usecs-low: %u\n"
-		"rx-frame-low: %u\n"
+		"rx-frames-low: %u\n"
 		"tx-usecs-low: %u\n"
-		"tx-frame-low: %u\n"
+		"tx-frames-low: %u\n"
 		"\n"
 		"rx-usecs-high: %u\n"
-		"rx-frame-high: %u\n"
+		"rx-frames-high: %u\n"
 		"tx-usecs-high: %u\n"
-		"tx-frame-high: %u\n"
+		"tx-frames-high: %u\n"
 		"\n",
 		ecoal->stats_block_coalesce_usecs,
 		ecoal->rate_sample_interval,
-- 
2.14.4

