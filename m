Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4A7C61DD9
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Aug 2026 23:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C68480C5C;
	Sun, 30 Aug 2026 23:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id umBc1eJ5UUS3; Sun, 30 Aug 2026 23:22:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788132161;
	bh=vHTh4/G6yLLnZYuzVJvCKYxiKkfKxjmaUFwS7wQ+xSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+R5ORVxnp4PK7MO81rRHY3DgE3jF/wgfk9Bm7hhnWHd8cVxLlinGZoM93lLdw7K1
	 nCaq3djvqAqg+4XJ41ASRgeu7Kktmj1wUknfVLphC6RSkNavujRz5975uYmH4BQso2
	 4228hjQU9hKVkFPlCYlGLBygmaZ9XR3bg+4BnJm2asgH9sr/FjeBPx9wemXEQl5QgD
	 xMSE+plrUUwKNryl6yDXivXgBSzB6IghnfV9KEx+lZsI72ezWwH3jlO80HPebHMtq5
	 5ai9HbsMpLLO3AtQ6Dr1XvewmKMc1KLMgG1tYseW8UGaGfyEuHnOCQ9tNa5psLCDNX
	 wzJ/gQsNTUbEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 730EC80C5D;
	Sun, 30 Aug 2026 23:22:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 059502AA
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E011E40056
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UtQX4Iy2unKF for <intel-wired-lan@lists.osuosl.org>;
 Sun, 30 Aug 2026 23:22:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=AWwAjjie
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8ACBD40050
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:38 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8623b1e7cb2so7753017b3.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788132157; x=1788736957; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vHTh4/G6yLLnZYuzVJvCKYxiKkfKxjmaUFwS7wQ+xSw=;
 b=AWwAjjieYN9UOLHMIS4+wnVEqZNNFi+tOgeOOr81OV4XE7MGtntWlCyW1wSvFMVZqx
 PYIer+wGIj7Vyhg7i6JfF6VXjDINUQJuKr/TduOv2Z2pt4G0yz6P7hUTmQGGGiZ7Dz3e
 miiFsBpYC2PP9W2fco+fPARJh2NgNazN4ZGpdwBGW/yTgAyPdqR8VzNyxcuGcFw7s4eS
 mQKAR/mi4C69b6ECQ+OCLAhI/U0y3ORuhmUdCb6ZaUPr0+U2/ku2BDhIF9Ti45qwXqOv
 974S/QskBgGNpa097Yab5AQ8AXMJf42V7dUs92bM/5abnzKUUIl1kgZ+aYlWD+fhx4JS
 Zdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788132157; x=1788736957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vHTh4/G6yLLnZYuzVJvCKYxiKkfKxjmaUFwS7wQ+xSw=;
 b=D743JHxjKJ92n0DMAHzI00AUF0/g6CjqcJEl/3PfdzLLhWvY0KN1ZCObO8dbLNij5Z
 gj6aH2NRXubizWhOo4Q+mXrZi/uCwMOMqnH37AEBXNIhJkMcew1K4Fd7TAMT1iqLrsxY
 ImHttyt7sPl1bynFeGOnbVQpkaFqYaFymZf83QccR01Xq4EQU2ZghoFti9tkS8CVnZpR
 ZTuZ8008BIiwQpaoY5jmrGFJoj57j6OwWX9NEf0Qofeb0WUEMO9opkaAfP6hznbpqNUv
 n7XdWa4wYMXAoIXC1v9rPbAyR8e2BzTKhXW98F7VnVXKOdCW3v93UY/+K0um2fXHYAmM
 OiPg==
X-Gm-Message-State: AFuF++mzRyq0zvhYeR0npvi80WBaxdDDLerYTykN0u18ztPGsoiVzLiN
 0xHuAd5MSSRYPTz4dQpIwuL6A0pfebk5cOvTLHpc8TJ3RkAZ1Khrt7ueGMIQdIAqaRE=
X-Gm-Gg: AYBFou2qC4/75841wmVE4yOkKlK0g15mceCSIeSSvqdzeu34ddUjIqmgtJDrKfPIZML
 RvHdsY1fYmPVG5P8yT2aok1ax8xAK1icDgQ/mIYdrG1I1gfhlqfBnyf2F3nzGTKT4iuuAW60Id1
 4MPTI9zGs+m7Zq0BLUSp/reoTmGKi5vMbRGckjB/IzAEi/Me1ts1rHl9dUK/bQjiZddRteG+MuT
 X3rLCVbn7y37xt9WntuFaWT/kM7Ls8EQhNQeTi0M+9ycQTwsz51jtIeuPuIaUEC+oQUswQWfYBz
 0dI+ZuFw2boJm90An7A6onTE2UvlCVj2B9Cy/KlmP5tREzKWyvD7cGeiDBT5FVn1EIkvCDfSTSN
 TKB8JaUUkGaQSFDd6Wkz8KQh2AZmGsiaft6LhIZ5gZskPiwdHxEkhxdHRMgkJ2sy/JdLwVqQD49
 G1YzoxdAKtrJcue+W6g0N3jVeayTEvd6CeSSvDQxfq
X-Received: by 2002:a05:690c:c50d:b0:862:ec8:d142 with SMTP id
 00721157ae682-8620ec8da39mr31302587b3.15.1788132156979; 
 Sun, 30 Aug 2026 16:22:36 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e677606aesm39025937b3.45.2026.08.30.16.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 16:22:36 -0700 (PDT)
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
Subject: [PATCH iwl-next 5/8] e1000e: always use jumbo Rx path
Date: Sun, 30 Aug 2026 19:21:43 -0400
Message-ID: <20260830232146.36948-6-tactii@gmail.com>
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

Converge on the Rx path which can support any combination of page size
and MTU.

Rename the jumbo path's clean and allocate functions to the standard
path's names. Also, drop the unused return value from the clean
function.

Factor out the function pointers for cleaning and allocation.

Remove the discarding flag because we no longer desire to discard frames
that don't fit in a single descriptor.

Remove rx_buffer_len clamping because buffers are now whole pages.

Additional cost for standard MTU operation will be addressed by the
proceeding page pool conversion.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |   7 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 311 ++-------------------
 2 files changed, 18 insertions(+), 300 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 533d1981eb5e..e0e4b72c13f3 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -244,11 +244,7 @@ struct e1000_adapter {
 	u32 tx_hwtstamp_skipped;
 
 	/* Rx */
-	bool (*clean_rx)(struct e1000_ring *ring, int *work_done,
-			 int work_to_do) ____cacheline_aligned_in_smp;
-	void (*alloc_rx_buf)(struct e1000_ring *ring, int cleaned_count,
-			     gfp_t gfp);
-	struct e1000_ring *rx_ring;
+	struct e1000_ring *rx_ring ____cacheline_aligned_in_smp;
 
 	u32 rx_int_delay;
 	u32 rx_abs_int_delay;
@@ -436,7 +432,6 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
 
 #define FLAG2_CRC_STRIPPING               BIT(0)
 #define FLAG2_HAS_PHY_WAKEUP              BIT(1)
-#define FLAG2_IS_DISCARDING               BIT(2)
 #define FLAG2_DISABLE_ASPM_L1             BIT(3)
 #define FLAG2_HAS_PHY_STATS               BIT(4)
 #define FLAG2_HAS_EEE                     BIT(5)
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 4dc3eeb01329..194166531bc8 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -369,29 +369,11 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 				(unsigned long long)buffer_info->dma,
 				buffer_info->skb, next_desc);
 
-			/* Jumbo buffers land in the page; a cleaned
-			 * jumbo slot keeps only its small shell skb
-			 * until it is refilled, so only dump an skb
-			 * that can hold a whole buffer.
-			 */
-			if (netif_msg_pktdata(adapter) &&
-			    buffer_info->page)
+			if (netif_msg_pktdata(adapter) && buffer_info->page)
 				print_hex_dump(KERN_INFO, "",
-					       DUMP_PREFIX_ADDRESS, 16,
-					       1,
+					       DUMP_PREFIX_ADDRESS, 16, 1,
 					       page_address(buffer_info->page),
-					       adapter->rx_buffer_len,
-					       true);
-			else if (netif_msg_pktdata(adapter) &&
-				 buffer_info->skb &&
-				 skb_tailroom(buffer_info->skb) >=
-				 adapter->rx_buffer_len)
-				print_hex_dump(KERN_INFO, "",
-					       DUMP_PREFIX_ADDRESS, 16,
-					       1,
-					       buffer_info->skb->data,
-					       adapter->rx_buffer_len,
-					       true);
+					       adapter->rx_buffer_len, true);
 		}
 	}
 }
@@ -571,82 +553,11 @@ static void e1000e_update_tdt_wa(struct e1000_ring *tx_ring, unsigned int i)
 /**
  * e1000_alloc_rx_buffers - Replace used receive buffers
  * @rx_ring: Rx descriptor ring
- * @cleaned_count: number to reallocate
+ * @cleaned_count: number of buffers to allocate this pass
  * @gfp: flags for allocation
  **/
 static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
 				   int cleaned_count, gfp_t gfp)
-{
-	struct e1000_adapter *adapter = rx_ring->adapter;
-	struct net_device *netdev = adapter->netdev;
-	struct pci_dev *pdev = adapter->pdev;
-	union e1000_rx_desc_extended *rx_desc;
-	struct e1000_buffer *buffer_info;
-	struct sk_buff *skb;
-	unsigned int i;
-	unsigned int bufsz = adapter->rx_buffer_len;
-
-	i = rx_ring->next_to_use;
-	buffer_info = &rx_ring->buffer_info[i];
-
-	while (cleaned_count--) {
-		skb = buffer_info->skb;
-		if (skb) {
-			skb_trim(skb, 0);
-			goto map_skb;
-		}
-
-		skb = __netdev_alloc_skb_ip_align(netdev, bufsz, gfp);
-		if (!skb) {
-			/* Better luck next round */
-			adapter->alloc_rx_buff_failed++;
-			break;
-		}
-
-		buffer_info->skb = skb;
-map_skb:
-		buffer_info->dma = dma_map_single(&pdev->dev, skb->data,
-						  adapter->rx_buffer_len,
-						  DMA_FROM_DEVICE);
-		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
-			dev_err(&pdev->dev, "Rx DMA map failed\n");
-			adapter->rx_dma_failed++;
-			break;
-		}
-
-		rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
-		rx_desc->read.buffer_addr = cpu_to_le64(buffer_info->dma);
-
-		if (unlikely(!(i & (E1000_RX_BUFFER_WRITE - 1)))) {
-			/* Force memory writes to complete before letting h/w
-			 * know there are new descriptors to fetch.  (Only
-			 * applicable for weak-ordered memory model archs,
-			 * such as IA-64).
-			 */
-			wmb();
-			if (adapter->flags2 & FLAG2_PCIM2PCI_ARBITER_WA)
-				e1000e_update_rdt_wa(rx_ring, i);
-			else
-				writel(i, rx_ring->tail);
-		}
-		i++;
-		if (i == rx_ring->count)
-			i = 0;
-		buffer_info = &rx_ring->buffer_info[i];
-	}
-
-	rx_ring->next_to_use = i;
-}
-
-/**
- * e1000_alloc_jumbo_rx_buffers - Replace used jumbo receive buffers
- * @rx_ring: Rx descriptor ring
- * @cleaned_count: number of buffers to allocate this pass
- * @gfp: flags for allocation
- **/
-
-static void e1000_alloc_jumbo_rx_buffers(struct e1000_ring *rx_ring,
-					 int cleaned_count, gfp_t gfp)
 {
 	struct e1000_adapter *adapter = rx_ring->adapter;
 	struct net_device *netdev = adapter->netdev;
@@ -729,163 +640,6 @@ static inline void e1000_rx_hash(struct net_device *netdev, __le32 rss,
 		skb_set_hash(skb, le32_to_cpu(rss), PKT_HASH_TYPE_L3);
 }
 
-/**
- * e1000_clean_rx_irq - Send received data up the network stack
- * @rx_ring: Rx descriptor ring
- * @work_done: output parameter for indicating completed work
- * @work_to_do: how many packets we can clean
- *
- * the return value indicates whether actual cleaning was done, there
- * is no guarantee that everything was cleaned
- **/
-static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
-			       int work_to_do)
-{
-	struct e1000_adapter *adapter = rx_ring->adapter;
-	struct net_device *netdev = adapter->netdev;
-	struct pci_dev *pdev = adapter->pdev;
-	struct e1000_hw *hw = &adapter->hw;
-	union e1000_rx_desc_extended *rx_desc, *next_rxd;
-	struct e1000_buffer *buffer_info, *next_buffer;
-	u32 length, staterr;
-	unsigned int i;
-	int cleaned_count = 0;
-	bool cleaned = false;
-	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
-
-	i = rx_ring->next_to_clean;
-	rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
-	staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
-	buffer_info = &rx_ring->buffer_info[i];
-
-	while (staterr & E1000_RXD_STAT_DD) {
-		struct sk_buff *skb;
-
-		if (*work_done >= work_to_do)
-			break;
-		(*work_done)++;
-		dma_rmb();	/* read descriptor and rx_buffer_info after status DD */
-
-		skb = buffer_info->skb;
-		buffer_info->skb = NULL;
-
-		prefetch(skb->data - NET_IP_ALIGN);
-
-		i++;
-		if (i == rx_ring->count)
-			i = 0;
-		next_rxd = E1000_RX_DESC_EXT(*rx_ring, i);
-		prefetch(next_rxd);
-
-		next_buffer = &rx_ring->buffer_info[i];
-
-		cleaned = true;
-		cleaned_count++;
-		dma_unmap_single(&pdev->dev, buffer_info->dma,
-				 adapter->rx_buffer_len, DMA_FROM_DEVICE);
-		buffer_info->dma = 0;
-
-		length = le16_to_cpu(rx_desc->wb.upper.length);
-
-		/* !EOP means multiple descriptors were used to store a single
-		 * packet, if that's the case we need to toss it.  In fact, we
-		 * need to toss every packet with the EOP bit clear and the
-		 * next frame that _does_ have the EOP bit set, as it is by
-		 * definition only a frame fragment
-		 */
-		if (unlikely(!(staterr & E1000_RXD_STAT_EOP)))
-			adapter->flags2 |= FLAG2_IS_DISCARDING;
-
-		if (adapter->flags2 & FLAG2_IS_DISCARDING) {
-			/* All receives must fit into a single buffer */
-			e_dbg("Receive packet consumed multiple buffers\n");
-			/* recycle */
-			buffer_info->skb = skb;
-			if (staterr & E1000_RXD_STAT_EOP)
-				adapter->flags2 &= ~FLAG2_IS_DISCARDING;
-			goto next_desc;
-		}
-
-		if (unlikely((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
-			     !(netdev->features & NETIF_F_RXALL))) {
-			/* recycle */
-			buffer_info->skb = skb;
-			goto next_desc;
-		}
-
-		/* adjust length to remove Ethernet CRC */
-		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING)) {
-			/* If configured to store CRC, don't subtract FCS,
-			 * but keep the FCS bytes out of the total_rx_bytes
-			 * counter
-			 */
-			if (netdev->features & NETIF_F_RXFCS)
-				total_rx_bytes -= 4;
-			else
-				length -= 4;
-		}
-
-		total_rx_bytes += length;
-		total_rx_packets++;
-
-		/* code added for copybreak, this should improve
-		 * performance for small packets with large amounts
-		 * of reassembly being done in the stack
-		 */
-		if (length < copybreak) {
-			struct sk_buff *new_skb =
-				napi_alloc_skb(&adapter->napi, length);
-			if (new_skb) {
-				skb_copy_to_linear_data_offset(new_skb,
-							       -NET_IP_ALIGN,
-							       (skb->data -
-								NET_IP_ALIGN),
-							       (length +
-								NET_IP_ALIGN));
-				/* save the skb in buffer_info as good */
-				buffer_info->skb = skb;
-				skb = new_skb;
-			}
-			/* else just continue with the old one */
-		}
-		/* end copybreak code */
-		skb_put(skb, length);
-
-		/* Receive Checksum Offload */
-		e1000_rx_checksum(adapter, staterr, skb);
-
-		e1000_rx_hash(netdev, rx_desc->wb.lower.hi_dword.rss, skb);
-
-		e1000_receive_skb(adapter, netdev, skb, staterr,
-				  rx_desc->wb.upper.vlan);
-
-next_desc:
-		rx_desc->wb.upper.status_error &= cpu_to_le32(~0xFF);
-
-		/* return some buffers to hardware, one at a time is too slow */
-		if (cleaned_count >= E1000_RX_BUFFER_WRITE) {
-			adapter->alloc_rx_buf(rx_ring, cleaned_count,
-					      GFP_ATOMIC);
-			cleaned_count = 0;
-		}
-
-		/* use prefetched values */
-		rx_desc = next_rxd;
-		buffer_info = next_buffer;
-
-		staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
-	}
-	rx_ring->next_to_clean = i;
-
-	cleaned_count = e1000_desc_unused(rx_ring);
-	if (cleaned_count)
-		adapter->alloc_rx_buf(rx_ring, cleaned_count, GFP_ATOMIC);
-
-	adapter->total_rx_bytes += total_rx_bytes;
-	adapter->total_rx_packets += total_rx_packets;
-	return cleaned;
-}
-
 static void e1000_put_txbuf(struct e1000_ring *tx_ring,
 			    struct e1000_buffer *buffer_info,
 			    bool drop)
@@ -1135,16 +889,13 @@ static void e1000_consume_page(struct e1000_buffer *bi, struct sk_buff *skb,
 }
 
 /**
- * e1000_clean_jumbo_rx_irq - Send received data up the network stack; legacy
+ * e1000_clean_rx_irq - Send received data up the network stack
  * @rx_ring: Rx descriptor ring
  * @work_done: output parameter for indicating completed work
  * @work_to_do: how many packets we can clean
- *
- * the return value indicates whether actual cleaning was done, there
- * is no guarantee that everything was cleaned
  **/
-static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
-				     int work_to_do)
+static void e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
+			       int work_to_do)
 {
 	struct e1000_adapter *adapter = rx_ring->adapter;
 	struct net_device *netdev = adapter->netdev;
@@ -1154,7 +905,6 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 	u32 length, staterr;
 	unsigned int i;
 	int cleaned_count = 0;
-	bool cleaned = false;
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	struct skb_shared_info *shinfo;
 
@@ -1182,7 +932,6 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 
 		next_buffer = &rx_ring->buffer_info[i];
 
-		cleaned = true;
 		cleaned_count++;
 		dma_unmap_page(&pdev->dev, buffer_info->dma, PAGE_SIZE,
 			       DMA_FROM_DEVICE);
@@ -1292,8 +1041,8 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 
 		/* return some buffers to hardware, one at a time is too slow */
 		if (unlikely(cleaned_count >= E1000_RX_BUFFER_WRITE)) {
-			adapter->alloc_rx_buf(rx_ring, cleaned_count,
-					      GFP_ATOMIC);
+			e1000_alloc_rx_buffers(rx_ring, cleaned_count,
+					       GFP_ATOMIC);
 			cleaned_count = 0;
 		}
 
@@ -1307,11 +1056,10 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 
 	cleaned_count = e1000_desc_unused(rx_ring);
 	if (cleaned_count)
-		adapter->alloc_rx_buf(rx_ring, cleaned_count, GFP_ATOMIC);
+		e1000_alloc_rx_buffers(rx_ring, cleaned_count, GFP_ATOMIC);
 
 	adapter->total_rx_bytes += total_rx_bytes;
 	adapter->total_rx_packets += total_rx_packets;
-	return cleaned;
 }
 
 /**
@@ -1329,13 +1077,8 @@ static void e1000_clean_rx_ring(struct e1000_ring *rx_ring)
 	for (i = 0; i < rx_ring->count; i++) {
 		buffer_info = &rx_ring->buffer_info[i];
 		if (buffer_info->dma) {
-			if (adapter->clean_rx == e1000_clean_rx_irq)
-				dma_unmap_single(&pdev->dev, buffer_info->dma,
-						 adapter->rx_buffer_len,
-						 DMA_FROM_DEVICE);
-			else if (adapter->clean_rx == e1000_clean_jumbo_rx_irq)
-				dma_unmap_page(&pdev->dev, buffer_info->dma,
-					       PAGE_SIZE, DMA_FROM_DEVICE);
+			dma_unmap_page(&pdev->dev, buffer_info->dma,
+				       PAGE_SIZE, DMA_FROM_DEVICE);
 			buffer_info->dma = 0;
 		}
 
@@ -1361,7 +1104,6 @@ static void e1000_clean_rx_ring(struct e1000_ring *rx_ring)
 
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
-	adapter->flags2 &= ~FLAG2_IS_DISCARDING;
 }
 
 static void e1000e_downshift_workaround(struct work_struct *work)
@@ -2282,7 +2024,7 @@ static int e1000e_poll(struct napi_struct *napi, int budget)
 	    (adapter->rx_ring->ims_val & adapter->tx_ring->ims_val))
 		tx_cleaned = e1000_clean_tx_irq(adapter->tx_ring);
 
-	adapter->clean_rx(adapter->rx_ring, &work_done, budget);
+	e1000_clean_rx_irq(adapter->rx_ring, &work_done, budget);
 
 	if (!tx_cleaned || work_done == budget)
 		return budget;
@@ -2754,13 +2496,6 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
 	u32 rdlen, rctl, rxcsum, ctrl_ext;
 
 	rdlen = rx_ring->count * sizeof(union e1000_rx_desc_extended);
-	if (adapter->netdev->mtu > ETH_FRAME_LEN + ETH_FCS_LEN) {
-		adapter->clean_rx = e1000_clean_jumbo_rx_irq;
-		adapter->alloc_rx_buf = e1000_alloc_jumbo_rx_buffers;
-	} else {
-		adapter->clean_rx = e1000_clean_rx_irq;
-		adapter->alloc_rx_buf = e1000_alloc_rx_buffers;
-	}
 
 	/* disable receives while setting up the descriptors */
 	rctl = er32(RCTL);
@@ -3327,7 +3062,7 @@ static void e1000_configure(struct e1000_adapter *adapter)
 		e1000e_setup_rss_hash(adapter);
 	e1000_setup_rctl(adapter);
 	e1000_configure_rx(adapter);
-	adapter->alloc_rx_buf(rx_ring, e1000_desc_unused(rx_ring), GFP_KERNEL);
+	e1000_alloc_rx_buffers(rx_ring, e1000_desc_unused(rx_ring), GFP_KERNEL);
 }
 
 /**
@@ -4015,7 +3750,7 @@ static int e1000_sw_init(struct e1000_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 
-	adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;
+	adapter->rx_buffer_len = 2048;
 	adapter->max_frame_size = netdev->mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
 	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
 	adapter->tx_ring_count = E1000_DEFAULT_TXD;
@@ -4227,8 +3962,8 @@ int e1000e_open(struct net_device *netdev)
 
 	/* before we allocate an interrupt, we must be ready to handle it.
 	 * Setting DEBUG_SHIRQ in the kernel makes it fire an interrupt
-	 * as soon as we call pci_request_irq, so we have to setup our
-	 * clean_rx handler before we do so.
+	 * as soon as we call pci_request_irq, so we have to configure the
+	 * Rx ring before we do so.
 	 */
 	e1000_configure(adapter);
 
@@ -5647,23 +5382,11 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev))
 		e1000e_down(adapter, true);
 
-	/* NOTE: netdev_alloc_skb reserves 16 bytes, and typically NET_IP_ALIGN
-	 * means we reserve 2 more, this pushes us to allocate from the next
-	 * larger slab size.
-	 * i.e. RXBUFFER_2048 --> size-4096 slab
-	 * However with the new *_jumbo_rx* routines, jumbo receives will use
-	 * fragmented skbs
-	 */
-
 	if (max_frame <= 2048)
 		adapter->rx_buffer_len = 2048;
 	else
 		adapter->rx_buffer_len = 4096;
 
-	/* adjust allocation if LPE protects us, and we aren't using SBP */
-	if (max_frame <= (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN))
-		adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;
-
 	if (netif_running(netdev))
 		e1000e_up(adapter);
 	else
-- 
2.43.0

