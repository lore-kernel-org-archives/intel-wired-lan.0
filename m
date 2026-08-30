Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A809AC61DE2
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Aug 2026 23:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 748A54058C;
	Sun, 30 Aug 2026 23:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uggsiXKQsMvl; Sun, 30 Aug 2026 23:22:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788132177;
	bh=TGMddz4oxHyMD/VYwjKLQUQ8UAQjzIFIQ1x/LerDgfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wOD4RLkvtXBK2gE3RhHLeClx9Hf8rVIaEGbywCGclKdu7gE1CMPWbyamPhcK4qOxG
	 lL9Z0EEcgunFURfFcg0Qy4YEnk2CJfUTYNfIuhLfOgMcZI1j8OhmuIXe6nGKdbJ6V0
	 LAn+UhInsawcq80ya65AMI7xcIiVVWh8sjOm10ILFA/3GHEZqfMGhuOUg4nNQOOCwW
	 0nH4OnygEZJg4/P4cggnS6q+i2rgklcMhVRljt+4NpKjMx+nHR6s8tPMylGaNVc94/
	 pJtpiA/Ccmn4qAnnOcpK0X2rLSivYKmvoYkpdNpFG7DONhbHPItfYb4TjvUITWbvpE
	 ztJXT8mJA6OLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DF714058B;
	Sun, 30 Aug 2026 23:22:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 096C32AA
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF1D2605D9
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ApXWcjMtAn7a for <intel-wired-lan@lists.osuosl.org>;
 Sun, 30 Aug 2026 23:22:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Xe7bJ3GQ
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EB3D605D3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:54 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-81ed2a06b9eso18435657b3.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 16:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788132173; x=1788736973; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGMddz4oxHyMD/VYwjKLQUQ8UAQjzIFIQ1x/LerDgfU=;
 b=Xe7bJ3GQz9zEU6aIdfg5M3/cdPjVyTVlx9YNKuXXPvsY9I+NQGZZfCp2D5tWhlKBv7
 YwgpE7e3iapLCjsLmvlG/GeulG73nhozXvGqTO7jOGzrTrrEWSv6zgLza9mIxU4flWNq
 PIWq0c3+KXvG4dY+v/ZWct/VBgsqQ2x7s3X7ukUE/zC/UDKk/6AlVc3t0EF4MJdx2LWi
 jFxMl96e82KQ/RKrbvsNljayK06H8J6BFfGTNBV95LPp3Y3Fb87/OL9Cfc3XVUZRDAV2
 sjSttKh5lWUTqI1zDkRBquxG2vtLYtnJw1BtoE6Lw+QZIKPXrgQ4jQCjLgVXpHOb4LAJ
 nAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788132173; x=1788736973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGMddz4oxHyMD/VYwjKLQUQ8UAQjzIFIQ1x/LerDgfU=;
 b=NZwd/DV5SfhaLsqMICsV8sm+eYP4/7wcaXg12B7EihSXMqpnqpPqkVz1FPaq/ulsZE
 qQHM83pmNOCquuDogXVQmj4pjjLsE/73oJVwK/NV7I634E2sNio5x35kMsUNDTf30ORs
 b9fOI1KEI7xiD2+HLh0gi2pW8KPvnswkWEftbfQSZHnX8YYdC11d38szpGX8jWl+GXgr
 XeL73HBV71wXwNlW0lN2v+y1KlNBHu4ZZ+hJmspAtWheKni/X4eDDBqivFRYYke6dRXi
 oLvozQ9R026fBXjTO1WFhpu4jYygSO7PF3geZONKup+KBU0f4ybgG05tO7kYHlOQYn8D
 gglA==
X-Gm-Message-State: AFuF++ktqNG26aMfXZPAU5v5wIuXvVUQI3kvvkDlzge6T/JVWfIopLz4
 3ajQKE5an876Aw3pwrm3u541kG17NNsNjjIrB0JnkFgf1vY6E9M5wSUUzj2WOaFOw5M=
X-Gm-Gg: AYBFou219brkmTPb1zt0D66ssyCW35W/HxBZKNaW8wDVkvzeFQ68XYBGua26zuXa89N
 qmSFuIIGFcu5597Bk/p/lc1hjQH+zaf6kJ/MOyhKvliieUdWOL0q36qXANampsmkoOzGtmBhuZe
 Op8s/1tiBVMKq4vkq/iqaa0KBI+fFG0NUw2MakIwXq9NsopSf/YXl2l0GZABAObFUsfNbrm9K4G
 Ew1DdQJM7OfCijXYESkcdhbk6Ql/iJLZvD1C0MLdhew/ORxg2XOqJmTSn/f8JGs41vPt6XkQRJA
 tDICHWwjWsYWZRNr4kpHmwUrOdXtjyPu4j4C6srOCoVahldw6EO9fEm8ZMruBI9xirSGj2RjxTl
 P10foW2HxZ6FXmoIwjhodWFLGAwpksxiN9Mg47giG5NJp/ZlVuyfxewLZnpWR+ImAlbuTpmqqMm
 3ogahKmBFeoq4GW7zpj6FBNOha7ofujT3e6Nxw0Wjh
X-Received: by 2002:a05:690c:e15c:20b0:81d:e7d2:a46d with SMTP id
 00721157ae682-85d65ee90b5mr61045247b3.5.1788132173517; 
 Sun, 30 Aug 2026 16:22:53 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e677606aesm39025937b3.45.2026.08.30.16.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 16:22:53 -0700 (PDT)
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
Subject: [PATCH iwl-next 8/8] e1000e: return skbs to NAPI cache
Date: Sun, 30 Aug 2026 19:21:46 -0400
Message-ID: <20260830232146.36948-9-tactii@gmail.com>
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

Use napi_consume_skb to hand skbs back to the NAPI cache. This closes
the loop with changes to the Rx path.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index c906175ad38d..a28ee0750f4b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -713,7 +713,7 @@ static struct sk_buff *e1000_build_rx_skb(const struct libeth_fqe *fqe,
 
 static void e1000_put_txbuf(struct e1000_ring *tx_ring,
 			    struct e1000_buffer *buffer_info,
-			    bool drop)
+			    bool drop, int budget)
 {
 	struct e1000_adapter *adapter = tx_ring->adapter;
 
@@ -730,7 +730,7 @@ static void e1000_put_txbuf(struct e1000_ring *tx_ring,
 		if (drop)
 			dev_kfree_skb_any(buffer_info->skb);
 		else
-			dev_consume_skb_any(buffer_info->skb);
+			napi_consume_skb(buffer_info->skb, budget);
 		buffer_info->skb = NULL;
 	}
 	buffer_info->time_stamp = 0;
@@ -860,11 +860,12 @@ static void e1000e_tx_hwtstamp_work(struct work_struct *work)
 /**
  * e1000_clean_tx_irq - Reclaim resources after transmit completes
  * @tx_ring: Tx descriptor ring
+ * @napi_budget: NAPI polling budget, or 0 when called outside NAPI context
  *
  * the return value indicates whether actual cleaning was done, there
  * is no guarantee that everything was cleaned
  **/
-static bool e1000_clean_tx_irq(struct e1000_ring *tx_ring)
+static bool e1000_clean_tx_irq(struct e1000_ring *tx_ring, int napi_budget)
 {
 	struct e1000_adapter *adapter = tx_ring->adapter;
 	struct net_device *netdev = adapter->netdev;
@@ -899,7 +900,8 @@ static bool e1000_clean_tx_irq(struct e1000_ring *tx_ring)
 				}
 			}
 
-			e1000_put_txbuf(tx_ring, buffer_info, false);
+			e1000_put_txbuf(tx_ring, buffer_info, false,
+					napi_budget);
 			tx_desc->upper.data = 0;
 
 			i++;
@@ -1340,7 +1342,7 @@ static irqreturn_t e1000_intr_msix_tx(int __always_unused irq, void *data)
 	adapter->total_tx_bytes = 0;
 	adapter->total_tx_packets = 0;
 
-	if (!e1000_clean_tx_irq(tx_ring))
+	if (!e1000_clean_tx_irq(tx_ring, 0))
 		/* Ring was not completely cleaned, so fire another interrupt */
 		ew32(ICS, tx_ring->ims_val);
 
@@ -1816,7 +1818,7 @@ static void e1000_clean_tx_ring(struct e1000_ring *tx_ring)
 
 	for (i = 0; i < tx_ring->count; i++) {
 		buffer_info = &tx_ring->buffer_info[i];
-		e1000_put_txbuf(tx_ring, buffer_info, false);
+		e1000_put_txbuf(tx_ring, buffer_info, false, 0);
 	}
 
 	netdev_reset_queue(adapter->netdev);
@@ -2060,7 +2062,7 @@ static int e1000e_poll(struct napi_struct *napi, int budget)
 
 	if (!adapter->msix_entries ||
 	    (adapter->rx_ring->ims_val & adapter->tx_ring->ims_val))
-		tx_cleaned = e1000_clean_tx_irq(adapter->tx_ring);
+		tx_cleaned = e1000_clean_tx_irq(adapter->tx_ring, budget);
 
 	e1000_clean_rx_irq(adapter->rx_ring, &work_done, budget);
 
@@ -5019,7 +5021,7 @@ static int e1000_tx_map(struct e1000_ring *tx_ring, struct sk_buff *skb,
 			i += tx_ring->count;
 		i--;
 		buffer_info = &tx_ring->buffer_info[i];
-		e1000_put_txbuf(tx_ring, buffer_info, true);
+		e1000_put_txbuf(tx_ring, buffer_info, true, 0);
 	}
 
 	return 0;
-- 
2.43.0

