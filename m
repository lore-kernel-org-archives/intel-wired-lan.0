From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 15 Oct 2015 15:54:34 -0700
Subject: [Intel-wired-lan] [next-queue v4 10/17] fm10k: add TEB check to
	fm10k_gre_is_nvgre
In-Reply-To: <1444949681-14464-1-git-send-email-jacob.e.keller@intel.com>
References: <1444949681-14464-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1444949681-14464-10-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The NVGRE protocol should be run over transparent ethernet bridge
protocol, so we should verify this in our check whether the GRE tunnel
is NVGRE. While we're touching fm10k_main.c, update the copyright year.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 746a1986690b..c5f7e0d919dc 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1,5 +1,5 @@
 /* Intel Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2014 Intel Corporation.
+ * Copyright(c) 2013 - 2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -708,6 +708,10 @@ static struct ethhdr *fm10k_gre_is_nvgre(struct sk_buff *skb)
 	if (nvgre_hdr->flags & FM10K_NVGRE_RESERVED0_FLAGS)
 		return NULL;
 
+	/* verify protocol is transparent Ethernet bridging */
+	if (nvgre_hdr->proto != htons(ETH_P_TEB))
+		return NULL;
+
 	/* report start of ethernet header */
 	if (nvgre_hdr->flags & NVGRE_TNI)
 		return (struct ethhdr *)(nvgre_hdr + 1);
-- 
2.6.1.264.gbab76a9

