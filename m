Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0D0C61DD9
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Aug 2026 23:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09B4480C70;
	Sun, 30 Aug 2026 23:22:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZvVEaOxXser2; Sun, 30 Aug 2026 23:22:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788132171;
	bh=Fd5hG6IpG5o8TUROEcOULk2y6pmfLKU1xp6Eswg0FX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A5moI/CgZ9Ydv16m0v4W4lKsF/aldlG9nQm1/U3SLGjBpN5eLhEsWXujnsPD68p+Q
	 npGi8TxcSGvECDlq/roKA+OKtNYicbspL5TYS6oqAoXzxAMPF5RSkmNJuZXAkNQtmV
	 Q8QyQUiyNMKuIujgQIUirZavkqb9kreTWkcnbqy3lgNS14QufHsAKL9PutR6Bi0cZP
	 GAo7UzRUEPqn2p+VSP3Uj4eWbcB1TzHBsly1xuA5nnOlRC8/aKCKV+L0rwjXIUuCM7
	 eZpQ6EPn+r+l+WVTTqm05qpMNQuBEnCUvFKHK1Tkm8gdeM3ApMpGkU8+iO40lmvDoN
	 w8OlQUoQ2Z+EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8805D80C5C;
	Sun, 30 Aug 2026 23:22:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D4C42334
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C650E605D9
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 12Y5wBA0UXGW for <intel-wired-lan@lists.osuosl.org>;
 Sun, 30 Aug 2026 23:22:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UlvgrtX2
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD785605D3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:46 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-836c4474028so36085727b3.0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788132165; x=1788736965; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fd5hG6IpG5o8TUROEcOULk2y6pmfLKU1xp6Eswg0FX8=;
 b=UlvgrtX2BrZm5I9C8VdEuMUmwOlKOh4hejsboAuqIfdq3WPpc34FPlp+zsEMvcCYbS
 7vynGNyazL8xxdBMboO7i1xUFdFJxLBx5tD8UgHyp3m8roQs5NCwYr2+ZZF56Es2Fwx/
 mNwIDZ5O8Xq/084BQcXROkzGEqq4UnYHEs0eKjXuNayCfV7OqCnhl3ep5PQBoY4mCG9G
 jTO5OcWZyEgFjeV2iq2YJSxlLFNwTbo9Y9i55QEya4vJumd29qg3VNwdgZqiZDYT3X1K
 CSrXeq5D6z8k+3HVmku2yJy5IOqvLM8oaAaQTOLoko9GQAfMaDSuSdGhbrvNbsVgHJoL
 A+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788132165; x=1788736965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fd5hG6IpG5o8TUROEcOULk2y6pmfLKU1xp6Eswg0FX8=;
 b=VTdm/SZ8Btm3j33DpaMpd1w8vEhXP0UllSXMAKm3l8ltop55+4x13e/yBWLOjCoucQ
 gyOZSssMevQ3DTfTKMr1cbyCqnPaAQ986kL28dDesSQMwW9djOtVxvd2pJrJAKqUxXBs
 z5JypEmopCrZqZ3rzS5oO8u26bey/ZatLKVXxHWgJt+Z/9108RTcdTIqHiX3vOdUFlXk
 RYNnbpccXPXU5Fx1jwcd16Nes2Lmuv/9mmAM8qdPS30rwMUYi/WhiBTzRCvqrm9vUvk9
 +H06jsmTrxK+J5aTTFkeeXI1q46cD0LyX7vdR/xzV9AgY1wCyNptWm0XBP2gLYTQsFvC
 BuAw==
X-Gm-Message-State: AFuF++m5NmwNvIz8vVYiwtSE05R1C4jxw6ABcqbnmms0VnZA7uoErSc0
 6cHLOaYtd/Cie07T+/JhIw/7iesfzAkudevqI3QfRYfjvdMDqSt9h4oe9RyRO2N6gpA=
X-Gm-Gg: AYBFou2d6o+RgF4f5FKjSaDqj2488b8jSDDlOCne6YwrDTy7OVQQ2TsrUW3RyTwP/aE
 fRvtw5IbyBV1zd4NJy65TqgEVSei1L70k24CtYrGGyvA0ITl5VeUhDBH1D/cZD+Ss/W7rOjoeu5
 62tkE6NHQkfDGcanlBuFK927Gq8wanaqtkScKQDcWbLsUXI6beZijeoTAdJVYKlxxDKStldOPOn
 uT4dHUMySoQ/oGyB8MM6u2AEkgYkY4CVFRR3ErQBe5FpqgqpKWTSlFGYOhKXRz2ac0OUjvzuZk8
 TLud1hdqkO8EqPrvlVS4kb9XO0t4dxANSIl+EmvNk9Lh5RpNPF4YHyr/WC8Yg9PkbHSyhLekbKe
 jn+Z1Ida3h8hj7ISixbwi2rQ4SNVyBsJOIqfQEy39/LDhr85uxQTgpiM+zW+G3Q4j4Qsf71roo+
 IJm9MHbnC28B9GLdkBMdV+XRmJNvZq9S0tDFUXc16aNQ==
X-Received: by 2002:a05:690c:e3cd:b0:812:a680:e10d with SMTP id
 00721157ae682-85d69e059efmr88937707b3.12.1788132165247; 
 Sun, 30 Aug 2026 16:22:45 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e677606aesm39025937b3.45.2026.08.30.16.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 16:22:44 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-next 7/8] e1000e: use libeth page_pool for Rx
Date: Sun, 30 Aug 2026 19:21:45 -0400
Message-ID: <20260830232146.36948-8-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830232146.36948-1-tactii@gmail.com>
References: <20260830232146.36948-1-tactii@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

Convert this driver's Rx to use a page pool managed by libeth. This
change potentially eliminates most DMA map/unmap operations from the Rx
hot path, which was most of the overhead with IOMMU enabled.

The previous standard path's behavior of publishing descriptors back to
the hardware every 16 iterations is retained because it was the safest
choice.

libeth is pulled in as a dependency because it is a convenient wrapper
around pool creation, destruction, and geometry.

The copybreak feature has been removed because it no longer consistently
avoids the cost of DMA remapping (which was broken in this driver).

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 .../device_drivers/ethernet/intel/e1000e.rst  |  15 -
 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/e1000e/e1000.h     |  32 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    | 567 ++++++++++--------
 drivers/net/ethernet/intel/e1000e/param.c     |   6 -
 5 files changed, 332 insertions(+), 289 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/e1000e.rst b/Documentation/networking/device_drivers/ethernet/intel/e1000e.rst
index d8f810afdd49..fab6ebc0cf95 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/e1000e.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/e1000e.rst
@@ -163,21 +163,6 @@ It ensures that an interrupt is generated after the initial Packet is sent on
 the wire within the set amount of time. Proper tuning, along with TxIntDelay,
 may improve traffic throughput in specific network conditions.
 
-copybreak
----------
-:Valid Range: 0-xxxxxxx (0=off)
-:Default Value: 256
-
-The driver copies all packets below or equaling this size to a fresh receive
-buffer before handing it up the stack.
-This parameter differs from other parameters because it is a single (not 1,1,1
-etc.) parameter applied to all driver instances and it is also available
-during runtime at /sys/module/e1000e/parameters/copybreak.
-
-To use copybreak, type::
-
-    modprobe e1000e.ko copybreak=128
-
 SmartPowerDownEnable
 --------------------
 :Valid Range: 0,1
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 780f113986ea..86fddcdabda3 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -63,6 +63,7 @@ config E1000E
 	depends on PCI && (!SPARC32 || BROKEN)
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select CRC32
+	select LIBETH
 	help
 	  This driver supports the PCI-Express Intel(R) PRO/1000 gigabit
 	  ethernet family of adapters. For PCI or PCI-X e1000 adapters,
diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index e0e4b72c13f3..f8e9f3fecf3e 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -23,6 +23,7 @@
 #include <linux/mdio.h>
 #include <linux/mutex.h>
 #include <linux/pm_qos.h>
+#include <net/libeth/rx.h>
 #include "hw.h"
 
 struct e1000_info;
@@ -121,25 +122,18 @@ enum e1000_boards {
 	board_pch_ptp
 };
 
-/* wrappers around a pointer to a socket buffer,
+/* wrapper around a pointer to a Tx socket buffer,
  * so a DMA handle can be stored along with the buffer
  */
 struct e1000_buffer {
 	dma_addr_t dma;
 	struct sk_buff *skb;
-	union {
-		/* Tx */
-		struct {
-			unsigned long time_stamp;
-			u16 length;
-			u16 next_to_watch;
-			unsigned int segs;
-			unsigned int bytecount;
-			u16 mapped_as_page;
-		};
-		/* Rx */
-		struct page *page;
-	};
+	unsigned long time_stamp;
+	u16 length;
+	u16 next_to_watch;
+	unsigned int segs;
+	unsigned int bytecount;
+	u16 mapped_as_page;
 };
 
 struct e1000_ring {
@@ -158,6 +152,13 @@ struct e1000_ring {
 	/* array of buffer information structs */
 	struct e1000_buffer *buffer_info;
 
+	/* libeth fill queue backing the Rx path */
+	struct page_pool *pp;
+	struct libeth_fqe *rx_fqes;
+	u32 rx_truesize;
+	u32 rx_buf_len;
+	u32 rx_fq_mtu;			/* MTU the fill queue was sized for */
+
 	char name[IFNAMSIZ + 5];
 	u32 ims_val;
 	u32 itr_val;
@@ -192,7 +193,6 @@ struct e1000_adapter {
 
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	u32 bd_number;
-	u32 rx_buffer_len;
 	u16 mng_vlan_id;
 	u16 link_speed;
 	u16 link_duplex;
@@ -491,8 +491,6 @@ void e1000e_get_hw_control(struct e1000_adapter *adapter);
 void e1000e_release_hw_control(struct e1000_adapter *adapter);
 void e1000e_write_itr(struct e1000_adapter *adapter, u32 itr);
 
-extern unsigned int copybreak;
-
 extern const struct e1000_info e1000_82571_info;
 extern const struct e1000_info e1000_82572_info;
 extern const struct e1000_info e1000_82573_info;
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6d846cacb026..c906175ad38d 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -201,7 +201,7 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 	struct e1000_buffer *buffer_info;
 	struct e1000_ring *rx_ring = adapter->rx_ring;
 	union e1000_rx_desc_extended *rx_desc;
-	u32 staterr;
+	u32 staterr, hr;
 	int i = 0;
 
 	if (!netif_msg_hw(adapter))
@@ -311,8 +311,10 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 		0, rx_ring->next_to_use, rx_ring->next_to_clean);
 
 	/* Print Rx Ring */
-	if (!netif_msg_rx_status(adapter))
+	if (!netif_msg_rx_status(adapter) || !rx_ring->pp)
 		return;
+	/* frames land past the pool's headroom, as the cleaner reads them */
+	hr = rx_ring->pp->p.offset;
 
 	dev_info(&adapter->pdev->dev, "Rx Ring Dump\n");
 	/* Extended Receive Descriptor (Read) Format
@@ -323,7 +325,7 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 	 * 8 |                      Reserved                       |
 	 *   +-----------------------------------------------------+
 	 */
-	pr_info("R  [desc]      [buf addr 63:0 ] [reserved 63:0 ] [bi->dma       ] [bi->skb] <-- Ext (Read) format\n");
+	pr_info("R  [desc]      [buf addr 63:0 ] [reserved 63:0 ] [fqe page      ] offs <-- Ext (Read) format\n");
 	/* Extended Receive Descriptor (Write-Back) Format
 	 *
 	 *   63       48 47    32 31    24 23            4 3        0
@@ -337,12 +339,23 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 	 *   +------------------------------------------------------+
 	 *   63       48 47    32 31            20 19               0
 	 */
-	pr_info("RWB[desc]      [cs ipid    mrq] [vt   ln xe  xs] [bi->skb] <-- Ext (Write-Back) format\n");
+	pr_info("RWB[desc]      [cs ipid    mrq] [vt   ln xe  xs] [fqe page      ] offs <-- Ext (Write-Back) format\n");
 
 	for (i = 0; i < rx_ring->count; i++) {
+		const struct libeth_fqe *fqe = &rx_ring->rx_fqes[i];
 		const char *next_desc;
+		struct page *page;
+		bool posted;
+
+		/* fill queue entries outside the posted window are stale */
+		if (rx_ring->next_to_use >= rx_ring->next_to_clean)
+			posted = i >= rx_ring->next_to_clean &&
+				 i < rx_ring->next_to_use;
+		else
+			posted = i >= rx_ring->next_to_clean ||
+				 i < rx_ring->next_to_use;
+		page = posted ? __netmem_to_page(fqe->netmem) : NULL;
 
-		buffer_info = &rx_ring->buffer_info[i];
 		rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
 		u0 = (struct my_u0 *)rx_desc;
 		staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
@@ -354,27 +367,17 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 		else
 			next_desc = "";
 
-		if (staterr & E1000_RXD_STAT_DD) {
-			/* Descriptor Done */
-			pr_info("%s[0x%03X]     %016llX %016llX ---------------- %p%s\n",
-				"RWB", i,
-				(unsigned long long)le64_to_cpu(u0->a),
-				(unsigned long long)le64_to_cpu(u0->b),
-				buffer_info->skb, next_desc);
-		} else {
-			pr_info("%s[0x%03X]     %016llX %016llX %016llX %p%s\n",
-				"R  ", i,
-				(unsigned long long)le64_to_cpu(u0->a),
-				(unsigned long long)le64_to_cpu(u0->b),
-				(unsigned long long)buffer_info->dma,
-				buffer_info->skb, next_desc);
-
-			if (netif_msg_pktdata(adapter) && buffer_info->page)
-				print_hex_dump(KERN_INFO, "",
-					       DUMP_PREFIX_ADDRESS, 16, 1,
-					       page_address(buffer_info->page),
-					       adapter->rx_buffer_len, true);
-		}
+		pr_info("%s[0x%03X]     %016llX %016llX %p %04X%s\n",
+			(staterr & E1000_RXD_STAT_DD) ? "RWB" : "R  ", i,
+			(unsigned long long)le64_to_cpu(u0->a),
+			(unsigned long long)le64_to_cpu(u0->b),
+			page, page ? fqe->offset : 0, next_desc);
+
+		if (netif_msg_pktdata(adapter) && page)
+			print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS,
+				       16, 1,
+				       page_address(page) + fqe->offset + hr,
+				       rx_ring->rx_buf_len, true);
 	}
 }
 
@@ -550,87 +553,124 @@ static void e1000e_update_tdt_wa(struct e1000_ring *tx_ring, unsigned int i)
 	}
 }
 
+/**
+ * e1000_setup_rx_fq - create the libeth fill queue for the Rx path
+ * @rx_ring: Rx descriptor ring
+ *
+ * Returns 0 on success, negative on failure
+ **/
+static int e1000_setup_rx_fq(struct e1000_ring *rx_ring)
+{
+	struct e1000_adapter *adapter = rx_ring->adapter;
+	struct libeth_fq fq = {
+		.count		= rx_ring->count,
+		.type		= LIBETH_FQE_SHORT,
+		.buf_len	= 2048,	/* per-descriptor HW capacity (RCTL) */
+		.nid		= NUMA_NO_NODE,
+	};
+	int err;
+
+	/* At MTU <= 1500 we are guaranteed that all frames fit in a 2 KB
+	 * buffer because h/w discards frames longer than 1522 bytes when
+	 * LPE is off.
+	 * At higher MTU, LPE is enabled and we need to reserve the entire
+	 * page to fit a 2 KB chunk from h/w plus overhead.
+	 */
+	if (adapter->netdev->mtu > ETH_DATA_LEN)
+		fq.truesize = 4096;
+	else
+		fq.truesize = 2048;
+
+	err = libeth_rx_fq_create(&fq, &adapter->napi);
+	if (err)
+		return err;
+
+	rx_ring->pp = fq.pp;
+	rx_ring->rx_fqes = fq.fqes;
+	rx_ring->rx_truesize = fq.truesize;
+	rx_ring->rx_buf_len = fq.buf_len;
+	rx_ring->rx_fq_mtu = adapter->netdev->mtu;
+
+	return 0;
+}
+
+/**
+ * e1000_free_rx_fq - destroy the libeth fill queue, if any
+ * @rx_ring: Rx descriptor ring
+ *
+ * The ring must be cleaned first: all fill queue buffers recycled.
+ **/
+static void e1000_free_rx_fq(struct e1000_ring *rx_ring)
+{
+	struct libeth_fq fq = {
+		.fqes	= rx_ring->rx_fqes,
+		.pp	= rx_ring->pp,
+	};
+
+	if (!rx_ring->pp)
+		return;
+
+	libeth_rx_fq_destroy(&fq);
+	rx_ring->rx_fqes = NULL;
+	rx_ring->pp = NULL;
+}
+
 /**
  * e1000_alloc_rx_buffers - Replace used receive buffers
  * @rx_ring: Rx descriptor ring
- * @cleaned_count: number of buffers to allocate this pass
- * @gfp: flags for allocation
+ * @cleaned_count: number to reallocate
  **/
 static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
-				   int cleaned_count, gfp_t gfp)
-{
+				   int cleaned_count)
+{
+	const struct libeth_fq_fp fq = {
+		.pp		= rx_ring->pp,
+		.fqes		= rx_ring->rx_fqes,
+		.truesize	= rx_ring->rx_truesize,
+		.count		= rx_ring->count,
+	};
 	struct e1000_adapter *adapter = rx_ring->adapter;
-	struct net_device *netdev = adapter->netdev;
-	struct pci_dev *pdev = adapter->pdev;
 	union e1000_rx_desc_extended *rx_desc;
-	struct e1000_buffer *buffer_info;
-	struct sk_buff *skb;
 	unsigned int i;
-	unsigned int bufsz = 256 - 16;	/* for skb_reserve */
+
+	if (unlikely(!fq.pp)) {
+		adapter->alloc_rx_buff_failed += cleaned_count;
+		return;
+	}
 
 	i = rx_ring->next_to_use;
-	buffer_info = &rx_ring->buffer_info[i];
 
 	while (cleaned_count--) {
-		skb = buffer_info->skb;
-		if (skb) {
-			skb_trim(skb, 0);
-			goto check_page;
-		}
+		dma_addr_t addr;
 
-		skb = __netdev_alloc_skb_ip_align(netdev, bufsz, gfp);
-		if (unlikely(!skb)) {
+		addr = libeth_rx_alloc(&fq, i);
+		if (unlikely(addr == DMA_MAPPING_ERROR)) {
 			/* Better luck next round */
 			adapter->alloc_rx_buff_failed++;
 			break;
 		}
 
-		buffer_info->skb = skb;
-check_page:
-		/* allocate a new page if necessary */
-		if (!buffer_info->page) {
-			buffer_info->page = alloc_page(gfp);
-			if (unlikely(!buffer_info->page)) {
-				adapter->alloc_rx_buff_failed++;
-				break;
-			}
-		}
-
-		if (!buffer_info->dma) {
-			buffer_info->dma = dma_map_page(&pdev->dev,
-							buffer_info->page, 0,
-							PAGE_SIZE,
-							DMA_FROM_DEVICE);
-			if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
-				adapter->alloc_rx_buff_failed++;
-				break;
-			}
-		}
-
 		rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
-		rx_desc->read.buffer_addr = cpu_to_le64(buffer_info->dma);
+		rx_desc->read.buffer_addr = cpu_to_le64(addr);
 
-		if (unlikely(++i == rx_ring->count))
+		if (unlikely(!(i & (E1000_RX_BUFFER_WRITE - 1)))) {
+			/* Force memory writes to complete before letting h/w
+			 * know there are new descriptors to fetch.  (Only
+			 * applicable for weak-ordered memory model archs,
+			 * such as IA-64).
+			 */
+			wmb();
+			if (adapter->flags2 & FLAG2_PCIM2PCI_ARBITER_WA)
+				e1000e_update_rdt_wa(rx_ring, i);
+			else
+				writel(i, rx_ring->tail);
+		}
+		i++;
+		if (i == rx_ring->count)
 			i = 0;
-		buffer_info = &rx_ring->buffer_info[i];
 	}
 
-	if (likely(rx_ring->next_to_use != i)) {
-		rx_ring->next_to_use = i;
-		if (unlikely(i-- == 0))
-			i = (rx_ring->count - 1);
-
-		/* Force memory writes to complete before letting h/w
-		 * know there are new descriptors to fetch.  (Only
-		 * applicable for weak-ordered memory model archs,
-		 * such as IA-64).
-		 */
-		wmb();
-		if (adapter->flags2 & FLAG2_PCIM2PCI_ARBITER_WA)
-			e1000e_update_rdt_wa(rx_ring, i);
-		else
-			writel(i, rx_ring->tail);
-	}
+	rx_ring->next_to_use = i;
 }
 
 static inline void e1000_rx_hash(struct net_device *netdev, __le32 rss,
@@ -640,6 +680,37 @@ static inline void e1000_rx_hash(struct net_device *netdev, __le32 rss,
 		skb_set_hash(skb, le32_to_cpu(rss), PKT_HASH_TYPE_L3);
 }
 
+/**
+ * e1000_build_rx_skb - build an skb around a fill queue buffer
+ * @fqe: fill queue buffer holding the received frame
+ * @size: frame length
+ * @hr: buffer headroom, loop-invariant in the caller
+ *
+ * Returns the skb, or NULL on allocation failure.  The buffer escapes to
+ * the stack and returns to the page pool when the skb is freed.
+ **/
+static struct sk_buff *e1000_build_rx_skb(const struct libeth_fqe *fqe,
+					  u32 size, u32 hr)
+{
+	struct page *page = __netmem_to_page(fqe->netmem);
+	struct sk_buff *skb;
+	void *va;
+
+	/* the caller prefetched the headers at the top of its loop */
+	va = page_address(page) + fqe->offset;
+
+	skb = napi_build_skb(va, fqe->truesize);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_mark_for_recycle(skb);
+
+	skb_reserve(skb, hr);
+	__skb_put(skb, size);
+
+	return skb;
+}
+
 static void e1000_put_txbuf(struct e1000_ring *tx_ring,
 			    struct e1000_buffer *buffer_info,
 			    bool drop)
@@ -879,144 +950,129 @@ static bool e1000_clean_tx_irq(struct e1000_ring *tx_ring)
 	return count < tx_ring->count;
 }
 
-static void e1000_consume_page(struct e1000_buffer *bi, struct sk_buff *skb,
-			       u16 length)
-{
-	bi->page = NULL;
-	skb->len += length;
-	skb->data_len += length;
-	skb->truesize += PAGE_SIZE;
-}
-
 /**
  * e1000_clean_rx_irq - Send received data up the network stack
  * @rx_ring: Rx descriptor ring
  * @work_done: output parameter for indicating completed work
  * @work_to_do: how many packets we can clean
+ *
+ * On an skb allocation failure the descriptor is left in place and the
+ * full budget is claimed, so the frame is retried on the next poll
+ * instead of dropped.
  **/
 static void e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 			       int work_to_do)
 {
 	struct e1000_adapter *adapter = rx_ring->adapter;
 	struct net_device *netdev = adapter->netdev;
-	struct pci_dev *pdev = adapter->pdev;
+	struct page_pool *pp = rx_ring->pp;
 	union e1000_rx_desc_extended *rx_desc, *next_rxd;
-	struct e1000_buffer *buffer_info, *next_buffer;
-	u32 length, staterr;
+	struct sk_buff *skb = rx_ring->rx_skb_top;
+	u32 hr, length, staterr;
 	unsigned int i;
 	int cleaned_count = 0;
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
-	struct skb_shared_info *shinfo;
+
+	/* The fill queue can be missing after failing to recreate it in
+	 * e1000_configure_rx(). We may still end up here, because any
+	 * MSI or legacy interrupt will schedule a poll.
+	 */
+	if (unlikely(!pp))
+		return;
+	hr = pp->p.offset;
 
 	i = rx_ring->next_to_clean;
 	rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
 	staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
-	buffer_info = &rx_ring->buffer_info[i];
 
 	while (staterr & E1000_RXD_STAT_DD) {
-		struct sk_buff *skb;
+		const struct libeth_fqe *fqe;
+		struct page *page;
+		unsigned int next_i;
 
 		if (*work_done >= work_to_do)
 			break;
 		(*work_done)++;
-		dma_rmb();	/* read descriptor and rx_buffer_info after status DD */
+		dma_rmb();	/* read descriptor after status DD */
 
-		skb = buffer_info->skb;
-		buffer_info->skb = NULL;
+		fqe = &rx_ring->rx_fqes[i];
+		page = __netmem_to_page(fqe->netmem);
 
-		++i;
-		if (i == rx_ring->count)
-			i = 0;
-		next_rxd = E1000_RX_DESC_EXT(*rx_ring, i);
-		prefetch(next_rxd);
+		/* Every outcome of this iteration touches the buffer's struct
+		 * page.
+		 */
+		prefetch(page);
 
-		next_buffer = &rx_ring->buffer_info[i];
+		/* If this is the first chunk of a frame, pull in the headers
+		 * too.
+		 */
+		if (!skb)
+			net_prefetch(page_address(page) + fqe->offset + hr);
 
-		cleaned_count++;
-		dma_unmap_page(&pdev->dev, buffer_info->dma, PAGE_SIZE,
-			       DMA_FROM_DEVICE);
-		buffer_info->dma = 0;
+		next_i = i + 1;
+		if (next_i == rx_ring->count)
+			next_i = 0;
+		next_rxd = E1000_RX_DESC_EXT(*rx_ring, next_i);
+		prefetch(next_rxd);
 
 		length = le16_to_cpu(rx_desc->wb.upper.length);
 
-		/* errors is only valid for DD + EOP descriptors */
-		if (unlikely((staterr & E1000_RXD_STAT_EOP) &&
-			     ((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
-			      !(netdev->features & NETIF_F_RXALL)))) {
-			/* recycle both page and skb */
-			buffer_info->skb = skb;
+		/* Errors are only valid for DD + EOP descriptors. Test the
+		 * rarely-set error mask first.
+		 */
+		if (unlikely((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
+			     (staterr & E1000_RXD_STAT_EOP) &&
+			     !(netdev->features & NETIF_F_RXALL))) {
 			/* an error means any chain goes out the window too */
-			if (rx_ring->rx_skb_top)
-				dev_kfree_skb_irq(rx_ring->rx_skb_top);
-			rx_ring->rx_skb_top = NULL;
-			goto next_desc;
-		}
-#define rxtop (rx_ring->rx_skb_top)
-		if (!(staterr & E1000_RXD_STAT_EOP)) {
-			/* this descriptor is only the beginning (or middle) */
-			if (!rxtop) {
-				/* this is the beginning of a chain */
-				rxtop = skb;
-				skb_fill_page_desc(rxtop, 0, buffer_info->page,
-						   0, length);
-			} else {
-				/* this is the middle of a chain */
-				shinfo = skb_shinfo(rxtop);
-				skb_fill_page_desc(rxtop, shinfo->nr_frags,
-						   buffer_info->page, 0,
-						   length);
-				/* re-use the skb, only consumed the page */
-				buffer_info->skb = skb;
+			if (skb) {
+				dev_kfree_skb_any(skb);
+				skb = NULL;
 			}
-			e1000_consume_page(buffer_info, rxtop, length);
+			/* the cleaner only runs in the pool's NAPI context, so
+			 * the buffer can go straight back to the pool's cache
+			 */
+			page_pool_put_full_netmem(pp, fqe->netmem, true);
 			goto next_desc;
+		}
+
+		/* A zero-length fragment only returns to the pool; it can
+		 * still carry EOP when a frame ends on a buffer boundary.
+		 */
+		if (!libeth_rx_sync_for_cpu(fqe, length))
+			goto no_data;
+
+		if (skb) {
+			/* the frame continues from the previous descriptor */
+			skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
+					       fqe->netmem, fqe->offset + hr,
+					       length, fqe->truesize);
 		} else {
-			if (rxtop) {
-				/* end of the chain */
-				shinfo = skb_shinfo(rxtop);
-				skb_fill_page_desc(rxtop, shinfo->nr_frags,
-						   buffer_info->page, 0,
-						   length);
-				/* re-use the current skb, we only consumed the
-				 * page
+			skb = e1000_build_rx_skb(fqe, length, hr);
+			if (unlikely(!skb)) {
+				/* leave the descriptor in place to retry the
+				 * frame on the next poll, and claim the full
+				 * budget to keep NAPI polling
 				 */
-				buffer_info->skb = skb;
-				skb = rxtop;
-				rxtop = NULL;
-				e1000_consume_page(buffer_info, skb, length);
-			} else {
-				/* no chain, got EOP, this buf is the packet
-				 * copybreak to save the put_page/alloc_page
-				 */
-				if (length <= copybreak &&
-				    skb_tailroom(skb) >= length) {
-					memcpy(skb_tail_pointer(skb),
-					       page_address(buffer_info->page),
-					       length);
-					/* re-use the page, so don't erase
-					 * buffer_info->page
-					 */
-					skb_put(skb, length);
-				} else {
-					skb_fill_page_desc(skb, 0,
-							   buffer_info->page, 0,
-							   length);
-					e1000_consume_page(buffer_info, skb,
-							   length);
-				}
+				adapter->alloc_rx_buff_failed++;
+				*work_done = work_to_do;
+				break;
 			}
 		}
 
+no_data:
+		/* non-EOP: hold the partial frame for the next descriptor */
+		if (!(staterr & E1000_RXD_STAT_EOP))
+			goto next_desc;
+
+		/* a zero-length frame with nothing accumulated */
+		if (unlikely(!skb))
+			goto next_desc;
+
 		/* strip the Ethernet CRC; it may span fragments */
 		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
 		    !(netdev->features & NETIF_F_RXFCS))
 			pskb_trim(skb, skb->len - 4);
 
-		/* Receive Checksum Offload */
-		e1000_rx_checksum(adapter, staterr, skb);
-
-		e1000_rx_hash(netdev, rx_desc->wb.lower.hi_dword.rss, skb);
-
 		total_rx_bytes += skb->len;
 		/* If configured to store CRC, keep the FCS bytes out of the
 		 * total_rx_bytes counter
@@ -1026,37 +1082,38 @@ static void e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 			total_rx_bytes -= 4;
 		total_rx_packets++;
 
-		/* eth type trans needs skb->data to point to something */
-		if (!pskb_may_pull(skb, ETH_HLEN)) {
-			e_err("pskb_may_pull failed.\n");
-			dev_kfree_skb_irq(skb);
-			goto next_desc;
-		}
+		/* Receive Checksum Offload */
+		e1000_rx_checksum(adapter, staterr, skb);
+
+		e1000_rx_hash(netdev, rx_desc->wb.lower.hi_dword.rss, skb);
 
 		e1000_receive_skb(adapter, netdev, skb, staterr,
 				  rx_desc->wb.upper.vlan);
+		skb = NULL;
 
 next_desc:
 		rx_desc->wb.upper.status_error &= cpu_to_le32(~0xFF);
+		cleaned_count++;
 
 		/* return some buffers to hardware, one at a time is too slow */
-		if (unlikely(cleaned_count >= E1000_RX_BUFFER_WRITE)) {
-			e1000_alloc_rx_buffers(rx_ring, cleaned_count,
-					       GFP_ATOMIC);
+		if (cleaned_count >= E1000_RX_BUFFER_WRITE) {
+			e1000_alloc_rx_buffers(rx_ring, cleaned_count);
 			cleaned_count = 0;
 		}
 
 		/* use prefetched values */
+		i = next_i;
 		rx_desc = next_rxd;
-		buffer_info = next_buffer;
 
 		staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
 	}
 	rx_ring->next_to_clean = i;
+	/* an incomplete frame is finished on a later poll */
+	rx_ring->rx_skb_top = skb;
 
 	cleaned_count = e1000_desc_unused(rx_ring);
 	if (cleaned_count)
-		e1000_alloc_rx_buffers(rx_ring, cleaned_count, GFP_ATOMIC);
+		e1000_alloc_rx_buffers(rx_ring, cleaned_count);
 
 	adapter->total_rx_bytes += total_rx_bytes;
 	adapter->total_rx_packets += total_rx_packets;
@@ -1068,28 +1125,15 @@ static void e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
  **/
 static void e1000_clean_rx_ring(struct e1000_ring *rx_ring)
 {
-	struct e1000_adapter *adapter = rx_ring->adapter;
-	struct e1000_buffer *buffer_info;
-	struct pci_dev *pdev = adapter->pdev;
 	unsigned int i;
 
-	/* Free all the Rx ring sk_buffs */
-	for (i = 0; i < rx_ring->count; i++) {
-		buffer_info = &rx_ring->buffer_info[i];
-		if (buffer_info->dma) {
-			dma_unmap_page(&pdev->dev, buffer_info->dma,
-				       PAGE_SIZE, DMA_FROM_DEVICE);
-			buffer_info->dma = 0;
-		}
+	/* Return fill queue buffers owned by hardware to the page pool */
+	if (rx_ring->pp) {
+		for (i = rx_ring->next_to_clean; i != rx_ring->next_to_use;) {
+			libeth_rx_recycle_slow(rx_ring->rx_fqes[i].netmem);
 
-		if (buffer_info->page) {
-			put_page(buffer_info->page);
-			buffer_info->page = NULL;
-		}
-
-		if (buffer_info->skb) {
-			dev_kfree_skb(buffer_info->skb);
-			buffer_info->skb = NULL;
+			if (unlikely(++i == rx_ring->count))
+				i = 0;
 		}
 	}
 
@@ -1734,33 +1778,29 @@ int e1000e_setup_tx_resources(struct e1000_ring *tx_ring)
 int e1000e_setup_rx_resources(struct e1000_ring *rx_ring)
 {
 	struct e1000_adapter *adapter = rx_ring->adapter;
-	int size, desc_len, err = -ENOMEM;
-
-	size = sizeof(struct e1000_buffer) * rx_ring->count;
-	rx_ring->buffer_info = vzalloc(size);
-	if (!rx_ring->buffer_info)
-		goto err;
-
-	desc_len = sizeof(union e1000_rx_desc_extended);
+	int err;
 
 	/* Round up to nearest 4K */
-	rx_ring->size = rx_ring->count * desc_len;
+	rx_ring->size = rx_ring->count * sizeof(union e1000_rx_desc_extended);
 	rx_ring->size = ALIGN(rx_ring->size, 4096);
 
 	err = e1000_alloc_ring_dma(adapter, rx_ring);
-	if (err)
-		goto err;
+	if (err) {
+		e_err("Unable to allocate memory for the receive descriptor ring\n");
+		return err;
+	}
 
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 	rx_ring->rx_skb_top = NULL;
 
-	return 0;
+	/* the fill queue belongs to the old ring resources until freed;
+	 * e1000_configure_rx() creates one for this ring when needed
+	 */
+	rx_ring->pp = NULL;
+	rx_ring->rx_fqes = NULL;
 
-err:
-	vfree(rx_ring->buffer_info);
-	e_err("Unable to allocate memory for the receive descriptor ring\n");
-	return err;
+	return 0;
 }
 
 /**
@@ -1822,9 +1862,7 @@ void e1000e_free_rx_resources(struct e1000_ring *rx_ring)
 	struct pci_dev *pdev = adapter->pdev;
 
 	e1000_clean_rx_ring(rx_ring);
-
-	vfree(rx_ring->buffer_info);
-	rx_ring->buffer_info = NULL;
+	e1000_free_rx_fq(rx_ring);
 
 	dma_free_coherent(&pdev->dev, rx_ring->size, rx_ring->desc,
 			  rx_ring->dma);
@@ -2435,25 +2473,13 @@ static void e1000_setup_rctl(struct e1000_adapter *adapter)
 		e1e_wphy(hw, 22, phy_data);
 	}
 
-	/* Setup buffer sizes */
-	rctl &= ~E1000_RCTL_SZ_4096;
-	rctl |= E1000_RCTL_BSEX;
-	switch (adapter->rx_buffer_len) {
-	case 2048:
-	default:
-		rctl |= E1000_RCTL_SZ_2048;
-		rctl &= ~E1000_RCTL_BSEX;
-		break;
-	case 4096:
-		rctl |= E1000_RCTL_SZ_4096;
-		break;
-	case 8192:
-		rctl |= E1000_RCTL_SZ_8192;
-		break;
-	case 16384:
-		rctl |= E1000_RCTL_SZ_16384;
-		break;
-	}
+	/* Default to maximum-size 2048-byte chunks (E1000_RCTL_SZ_256 is the
+	 * BSIZE field mask); e1000_configure_rx() lowers the chunk size if
+	 * the fill queue buffers are smaller.  Frames longer than one chunk
+	 * are chained across descriptors.
+	 */
+	rctl &= ~(E1000_RCTL_BSEX | E1000_RCTL_SZ_256);
+	rctl |= E1000_RCTL_SZ_2048;
 
 	/* Enable Extended Status in all Receive Descriptors */
 	rfctl = er32(RFCTL);
@@ -2497,8 +2523,42 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
 
 	rdlen = rx_ring->count * sizeof(union e1000_rx_desc_extended);
 
+	/* The fill queue geometry depends on the MTU.  e1000e_open() creates
+	 * the fill queue and can fail cleanly; here a creation failure only
+	 * logs, and the guards in the allocator and the cleaner keep an
+	 * fq-less ring safe: no buffers are ever posted, so the hardware
+	 * drops frames in silicon until a reconfigure retries.
+	 */
+	if (rx_ring->pp && rx_ring->rx_fq_mtu != adapter->netdev->mtu)
+		e1000_free_rx_fq(rx_ring);
+	if (!rx_ring->pp && e1000_setup_rx_fq(rx_ring))
+		e_err("Failed to create Rx fill queue\n");
+
 	/* disable receives while setting up the descriptors */
 	rctl = er32(RCTL);
+
+	/* Pair the per-descriptor chunk size with the fill queue buffers: a
+	 * chunk must never overrun one buffer.  Without LPE the hardware
+	 * caps frames at 1522 bytes, so any buffer at least that large
+	 * takes every frame in a single maximum-size chunk.
+	 */
+	if (rx_ring->pp) {
+		u32 bsize = E1000_RCTL_SZ_2048;
+
+		if (rx_ring->rx_buf_len < 2048 &&
+		    ((rctl & E1000_RCTL_LPE) ||
+		     rx_ring->rx_buf_len < VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)) {
+			if (rx_ring->rx_buf_len >= 1024)
+				bsize = E1000_RCTL_SZ_1024;
+			else if (rx_ring->rx_buf_len >= 512)
+				bsize = E1000_RCTL_SZ_512;
+			else
+				bsize = E1000_RCTL_SZ_256;
+		}
+
+		rctl &= ~(E1000_RCTL_BSEX | E1000_RCTL_SZ_256);
+		rctl |= bsize;
+	}
 	if (!(adapter->flags2 & FLAG2_NO_DISABLE_RX))
 		ew32(RCTL, rctl & ~E1000_RCTL_EN);
 	e1e_flush();
@@ -3062,7 +3122,7 @@ static void e1000_configure(struct e1000_adapter *adapter)
 		e1000e_setup_rss_hash(adapter);
 	e1000_setup_rctl(adapter);
 	e1000_configure_rx(adapter);
-	e1000_alloc_rx_buffers(rx_ring, e1000_desc_unused(rx_ring), GFP_KERNEL);
+	e1000_alloc_rx_buffers(rx_ring, e1000_desc_unused(rx_ring));
 }
 
 /**
@@ -3752,7 +3812,6 @@ static int e1000_sw_init(struct e1000_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 
-	adapter->rx_buffer_len = 2048;
 	adapter->max_frame_size = netdev->mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
 	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
 	adapter->tx_ring_count = E1000_DEFAULT_TXD;
@@ -3945,6 +4004,11 @@ int e1000e_open(struct net_device *netdev)
 	if (err)
 		goto err_setup_rx;
 
+	/* create the Rx fill queue backing the receive descriptors */
+	err = e1000_setup_rx_fq(adapter->rx_ring);
+	if (err)
+		goto err_setup_fq;
+
 	/* If AMT is enabled, let the firmware know that the network
 	 * interface is now open and reset the part to a known state.
 	 */
@@ -4013,6 +4077,7 @@ int e1000e_open(struct net_device *netdev)
 	cpu_latency_qos_remove_request(&adapter->pm_qos_req);
 	e1000e_release_hw_control(adapter);
 	e1000_power_down_phy(adapter);
+err_setup_fq:
 	e1000e_free_rx_resources(adapter->rx_ring);
 err_setup_rx:
 	e1000e_free_tx_resources(adapter->tx_ring);
@@ -5383,10 +5448,9 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev))
 		e1000e_down(adapter, true);
 
-	if (max_frame <= 2048)
-		adapter->rx_buffer_len = 2048;
-	else
-		adapter->rx_buffer_len = 4096;
+	/* the Rx fill queue geometry and the RCTL chunk size are derived
+	 * from the new MTU when the interface comes back up
+	 */
 
 	if (netif_running(netdev))
 		e1000e_up(adapter);
@@ -7520,5 +7584,6 @@ module_exit(e1000_exit_module);
 
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("LIBETH");
 
 /* netdev.c */
diff --git a/drivers/net/ethernet/intel/e1000e/param.c b/drivers/net/ethernet/intel/e1000e/param.c
index 3132d8f2f207..bf8a006686d5 100644
--- a/drivers/net/ethernet/intel/e1000e/param.c
+++ b/drivers/net/ethernet/intel/e1000e/param.c
@@ -16,12 +16,6 @@
 #define OPTION_DISABLED 0
 #define OPTION_ENABLED  1
 
-#define COPYBREAK_DEFAULT 256
-unsigned int copybreak = COPYBREAK_DEFAULT;
-module_param(copybreak, uint, 0644);
-MODULE_PARM_DESC(copybreak,
-		 "Maximum size of packet that is copied to a new buffer on receive");
-
 /* All parameters are treated the same, as an integer array of values.
  * This macro just reduces the need to repeat the same declaration code
  * over and over (plus this helps to avoid typo bugs).
-- 
2.43.0

