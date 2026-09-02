Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885CDC624D0
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 03:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DFCE407E2;
	Wed,  2 Sep 2026 03:29:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pENDBMnjWQ0F; Wed,  2 Sep 2026 03:29:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788319795;
	bh=pGpqtN0vRq8epNdTDKQRGvsPqQN+AJIy2e00tUkEjAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=brg4y7CvkETi25Y6OP9CaGZkVIGOf/iXjHzXF425JLgbumgUuO4DYrd+SGkVelQS4
	 /N1kqraSReQXZ95ru/EBfD2X2nHGBn1n/lri+pwazkq53Ldzx8Aql11HGwaJ/g+00b
	 sqXEku0UmJUfQ5Bx2TLg38z1nMCSKKk8EuzQG53Voix/9o66snFrBt8+zlwPQ/pBOo
	 zHCxsob/h42dWfc+5w7lRqiKQpkqMKRM8nfpT/iYi3BIYvgTA3eP+SbGypMHELys5o
	 2f6dZz84iFfwd3Ezw1gfiXgnvOY646s45kHzcZLxd8hbmZF/SnbX8X99Is8y3wYGTn
	 xVEMv+gA4QTDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D020407B2;
	Wed,  2 Sep 2026 03:29:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B685D2FE
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A85C840076
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HDKVlle8JDWO for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 03:29:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CKpnpXrR
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B87C4002B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 03:29:52 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-398e9698a70so577576a91.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 01 Sep 2026 20:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788319792; x=1788924592; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pGpqtN0vRq8epNdTDKQRGvsPqQN+AJIy2e00tUkEjAI=;
 b=CKpnpXrRbX8tEGctZ2tCo1xtOWMYVAWfKz/WvUyJywwoFodCU3agKrJaatjesS+Hgh
 2rGdMzstDFIPovTBf4hzYV5RY3QlFVd222dF3aVmne+uPCliFJe0iDMN0y/h2ZgyDeTc
 OVl7Sfi+cRu9yVT1ycQHF60tP24FGWgSmly+9CUB8NgOYSzbKBcCYwafwBRSDVxAmlnw
 7P8Pwt+0OB/+rExoUBSLLGZSKEjdEFbtRTOTxr6Cg4Dw0dbzHfsr+32qQDV9rBRfFQdI
 PHW6JuEEzFRCix3BvTnE2GPZBgqFJR8eKY0UfygzPgvzxTUl5prun2qnAnLZJmZ/DcIr
 U7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788319792; x=1788924592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pGpqtN0vRq8epNdTDKQRGvsPqQN+AJIy2e00tUkEjAI=;
 b=n6QBFUohiD5tA7XOO0qSVUbO41fUAZQ6HL69f4JIKDtHR7nUpVaXuCTWC1uGIZg4Xm
 r03ZpN3dncBcasbZR+xZaxMe/CusleQnegKy3zlGrDBlAfETb4ycZOrLujICYMiTIPJU
 LtOYpjTRKZnvOIkep1C8zi/iMGZXC5OUw9+zmObxeD3GzCX7nbCGehYcTj/Ue7vXxx06
 hhYlEVVc36vHld1edcwh758VigdXY0mOwikgktdiOcUpUItElUd/a4YDErqtxSCGOhlN
 ycaIQHXkKpQX5AEL4zBZiDsZXwZS5/hUpt5B7/9V2exfWv5Gk2fHePpH3QSAte33uYLZ
 fFfQ==
X-Gm-Message-State: AFuF++lOhL8Z5gp/Gl6AH+6nCX5GhMva9qLmXfwm9LqCrFV5ny7ha/3p
 IcEJMZs/G0AmUpgFEFkXnYu5kixNiXunluWCxWVY9JnAET79ppvau6nkKuG4CfUy
X-Gm-Gg: AYBFou2AjlpTtvaafviPtb/+tPIr1/h5czXSJ9oFw9MyuZ3uHf0upe46rP4igA9s8xC
 AnOxeuaIQmij0kWEXelbH2VXZS7zgajv6Ub1r9s7Bsag9rHOUlhVFf21KbS0UX2lmbjrk2v1QyC
 L7gwgsVk1UpIv8nycQICD8uVrS1QePz01L0wSP/0bwyS8dwh3Bs71wrsK+QCS/TUdU0891L4yMI
 fQhB0b/Cpm6PGD5T9X841HMyKVkCKDL3mJrzbH1e5W0SHqT/pZqdQ4FjoQ8exEPshGZZdy4s/fu
 2GCEeiPIV9d/Qom3KGIZyN6n8XxCpAbctIbwgc3lvfpwQjjOZM9VcBiKdGUedDKhJpaqVjGjIFI
 j8vvwCkJ99p8bF+yUY6MeC18D1SyTP2Sqlz0FeHm+XYPQa6SM/NsBmC97nA+ZKBcPZL60eKmy5K
 xu9ySV7Byark/XvohNsN7koUyJCeug6/v6pPGF4DVq
X-Received: by 2002:a17:90b:2552:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-39aedec7bbbmr2766953a91.5.1788319792006; 
 Tue, 01 Sep 2026 20:29:52 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07baa594sm3099307eec.22.2026.09.01.20.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 20:29:51 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matt Vollrath <tactii@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH iwl-net 3/3] e1000e: fix NETIF_F_RXALL buffer overrun
Date: Tue,  1 Sep 2026 23:29:13 -0400
Message-ID: <20260902032913.661570-4-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902032913.661570-1-tactii@gmail.com>
References: <20260902032913.661570-1-tactii@gmail.com>
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

When SBP is set, the card may deliver frames which would otherwise be
filtered out by LPE being unset. This would allow the device to write
up to 526 bytes beyond the skb's data allocation: over its own shinfo,
and beyond. This bug is reachable only when MTU <= 1500 and
NETIF_F_RXALL is set ("ethtool -K <dev> rx-all on").

Ensure that buffers are large enough for an entire 2048 byte chunk when
NETIF_F_RXALL is set. Do this by moving final rx_buffer_len
determination to one place, right before RCTL.BSIZE is determined. This
will correctly re-evaluate every time the adapter is configured, not
just on MTU change.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: Claude:claude-5-fable
Fixes: cf955e6c96cb ("e1000e: Support RXALL feature flag.")
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 53 +++++++++++++---------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 063fc8cd2673..80d5a0010df8 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3036,6 +3036,33 @@ static void e1000_configure_tx(struct e1000_adapter *adapter)
 #define PAGE_USE_COUNT(S) (((S) >> PAGE_SHIFT) + \
 			   (((S) & (PAGE_SIZE - 1)) ? 1 : 0))
 
+/**
+ * e1000_set_rx_buffer_len - determine the Rx buffer size
+ * @adapter: Board private structure
+ **/
+static void e1000_set_rx_buffer_len(struct e1000_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	u32 max_frame = adapter->max_frame_size;
+
+	/* NOTE: netdev_alloc_skb reserves 16 bytes, and typically NET_IP_ALIGN
+	 * means we reserve 2 more, this pushes us to allocate from the next
+	 * larger slab size.
+	 * i.e. RXBUFFER_2048 --> size-4096 slab
+	 * However with the new *_jumbo_rx* routines, jumbo receives will use
+	 * fragmented skbs
+	 */
+	if (max_frame <= 2048)
+		adapter->rx_buffer_len = 2048;
+	else
+		adapter->rx_buffer_len = 4096;
+
+	/* adjust allocation if LPE protects us, and we aren't using SBP */
+	if (max_frame <= (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN) &&
+	    !(netdev->features & NETIF_F_RXALL))
+		adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;
+}
+
 /**
  * e1000_setup_rctl - configure the receive control registers
  * @adapter: Board private structure
@@ -3102,6 +3129,8 @@ static void e1000_setup_rctl(struct e1000_adapter *adapter)
 		e1e_wphy(hw, 22, phy_data);
 	}
 
+	e1000_set_rx_buffer_len(adapter);
+
 	/* Setup buffer sizes */
 	rctl &= ~E1000_RCTL_SZ_4096;
 	rctl |= E1000_RCTL_BSEX;
@@ -6087,30 +6116,12 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 
 	pm_runtime_get_sync(netdev->dev.parent);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev)) {
 		e1000e_down(adapter, true);
-
-	/* NOTE: netdev_alloc_skb reserves 16 bytes, and typically NET_IP_ALIGN
-	 * means we reserve 2 more, this pushes us to allocate from the next
-	 * larger slab size.
-	 * i.e. RXBUFFER_2048 --> size-4096 slab
-	 * However with the new *_jumbo_rx* routines, jumbo receives will use
-	 * fragmented skbs
-	 */
-
-	if (max_frame <= 2048)
-		adapter->rx_buffer_len = 2048;
-	else
-		adapter->rx_buffer_len = 4096;
-
-	/* adjust allocation if LPE protects us, and we aren't using SBP */
-	if (max_frame <= (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN))
-		adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;
-
-	if (netif_running(netdev))
 		e1000e_up(adapter);
-	else
+	} else {
 		e1000e_reset(adapter);
+	}
 
 	pm_runtime_put_sync(netdev->dev.parent);
 
-- 
2.43.0

