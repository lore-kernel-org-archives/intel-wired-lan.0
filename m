From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:19 -0700
Subject: [Intel-wired-lan] [PATCH 02/19] fm10k: reduce scope of *p local
 variable
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce the scope of the char *p local variable to only the block where
it is used.

This was detected by cppcheck and resolves the following style warning
produced by that tool:

[fm10k_ethtool.c:229]: (style) The scope of the variable 'p' can be
reduced.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 4895dd83dd08..7b9440c0aee1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2013 - 2018 Intel Corporation. */
+/* Copyright(c) 2013 - 2019 Intel Corporation. */
 
 #include <linux/vmalloc.h>
 
@@ -222,7 +222,6 @@ static void __fm10k_add_ethtool_stats(u64 **data, void *pointer,
 				      const unsigned int size)
 {
 	unsigned int i;
-	char *p;
 
 	if (!pointer) {
 		/* memory is not zero allocated so we have to clear it */
@@ -232,7 +231,7 @@ static void __fm10k_add_ethtool_stats(u64 **data, void *pointer,
 	}
 
 	for (i = 0; i < size; i++) {
-		p = (char *)pointer + stats[i].stat_offset;
+		char *p = (char *)pointer + stats[i].stat_offset;
 
 		switch (stats[i].sizeof_stat) {
 		case sizeof(u64):
-- 
2.22.0.214.g8dca754b1e87

