Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549DDC982CF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 10:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD77080816;
	Thu, 17 Sep 2026 10:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TU3gpKyqlsuT; Thu, 17 Sep 2026 10:52:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1A4C6807B3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789642336;
	b=MI6yGzIi+wo57Zj+pwhtpQku+QXa7OSrYOsA4x5aSkv1Uq8MbntmFUgWtcpUc4ctFkp3
	 s0x2T9HSSXLE1kD20L79JgXrnMDLBU3nYC6lh6Omdpr0J7P3JRC+1o/DvmNBXmCMh7uet
	 IxLr3mmR3GKgdMeWCJJTd05+WumIMl7m5Y+AdONXqy23yWWMUFb5F2WJ12+qAb9uti6eX
	 W8Iy/SJ0XAa6ijaAWVtCyxMbYg8aDDRCOEXLdug7h11A248RQ2FD78YdGSvaOeNp1x3wp
	 QUTaB89jP7E/YMVd0RogPV3cT/nxxVwvuPR5vBnDyH4rv7V7d3MGvESXazFeEQ71ViA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789642336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Q+A3V8/x5c21vazgS32hcx7O6vB4HwRW8LEwa4hezrA=;
	b=d2fiiR8ZpLa7ygBULAZdpd9+Mu1jShYHVuHFavWI/i+uxpScOrCtEsTIGxuR4k1vSFd8
	 MXtAxUes42S8jNyASChuSOWCmaXtX1FxNGgpwSi9QY4v05JDb0wLbuzRH1QJmNx3QKOij
	 Xseip6GiQ7Rvviuj7HtI6Id8YRaVMRc+6GtrbtNvqrj2okk/UkKX9NRhNpQP5XnCtzSXo
	 6cg01kjYBl1AkeVSSvSHnzhwMZzj9ofNWIwlqcWoMfSJ2xIcNCq9bWoUk99T2CmVBPuwU
	 co3fb4x4lTDRe/fqOlssyofO9Ef0Cfao1imaoyWtsQxJQk7xYq+OlDQC4Qs/QG1Gg5A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789642336;
	bh=Q+A3V8/x5c21vazgS32hcx7O6vB4HwRW8LEwa4hezrA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PHlF46Sqd+izdVdpiot/Ft2Rc5b335mIpvlHP8PUE/VPeUMIYkDJlp3Nps2Sxn96f
	 zGvY3PzZNjkp4qqXWnNg5Kd+DgoFdrlzh5gAHjC5pI8+ZD1zqeUNIkEQO/ZCzldfHU
	 QQ/jOm7iV/V3R/jmAmAU9nXyQ1gFcV5udbjzu3gvDQlxsC5lqu0azNOXlR4p8VtNFZ
	 Vs/SqK1GCo+jOrsTVkHtuCW50gEwk2d6D9q7cv8k/I+P/0JwrOx5+Hl6uaoaohW72X
	 4DfR1ofXM+wOltuG9fzIGivVWDDw+GqheVgg90ja/9JbywdSeDuZl3Ue3XJr6xwCJq
	 Jht6I+9cLi+oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A4C6807B3;
	Thu, 17 Sep 2026 10:52:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 89DE824D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FDA640050
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id japf6Coi0l-9 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 10:52:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AAD02400F3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789642333;
 b=aTQPwZoMAzJh7h9lnFuSHAdbP+LmKr/4p5SUf8nxwhCaJ0x0BkyNwL1Y9CtqRurkrICB
 y8sUGIyYsyuTC6/w7D6LOT9PtlgqQEUEcM7ZUMJDbU8kCPsLUj9tu6F3Bjsr8MR2xbczu
 J/yA5Jt0Ba86p0xFOPW8pbrCieoqMS8QJ2ZRxNkLdf7UIkpUMHWQBuJMMoU7esHtNstkW
 CCI4OyvWZBgKcqDSxRsf6WuIcjKuj5Jo5ukYrsAbedNipSKFp7HwG78YFOaym+3es+1iv
 e+1OIskQtk4olBEiWp7GIM3wn+nGMU1hc6GP84XS3MvzH9xxv7m2+ETOMsbocz15A8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789642333;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Q+A3V8/x5c21vazgS32hcx7O6vB4HwRW8LEwa4hezrA=;
 b=Qv3b5xm++f7tt3MRXhbhAhZw2drLwrrd+2cCZJpgaXhnD9OD9XPWx2Qqdmn3VyLH0lYZ
 Jg5iwgq3vQ6ajH7GbWQLlFV20ptNrkoK2J7cKU/V1cfKFRkkr451HI+jMqNXw7raA4KOD
 6xm1y0OmKKdT4DyHSpRmooETaalx01Ocl2FXxwPyQ85G+D4gPAhnH1C+OdWmGrsNxduwP
 UgeoKecyIssLDBI03zEHeGyoi93qQFY9IIatoLchNrtaLScZsvaas9oT4aLc8B2gCbSJg
 vo+DFFKp4ZPq9YtLrU+9AwrNUB/NTiS9IA9ZmuX278TowRptf9wPxCw2zURx5oeQ2dQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YZdTFXsF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::e;
 helo=mail-yx2-x0e.google.com; envelope-from=tactii@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=YZdTFXsF
Received: from mail-yx2-x0e.google.com (mail-yx2-x0e.google.com
 [IPv6:2607:f8b0:4864:41::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AAD02400F3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:13 +0000 (UTC)
Received: by mail-yx2-x0e.google.com with SMTP id
 00721157ae682-895fd505832so1270837b3.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 03:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789642332; x=1790247132; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q+A3V8/x5c21vazgS32hcx7O6vB4HwRW8LEwa4hezrA=;
 b=YZdTFXsF/zigFmxx6L7k3tHKeyfjrvO61Mza42BbeB1gZVWltgpDxLWmig4CwNuSW9
 7OdRAmoRZFXk4Ba9upEfmJ7ley9/ONEibXdNcAlaRP5Nlm0qxAVs3JARVDMiQuQ5qic5
 dO6stehLH6LMVqi2BZ5kIKLvVyWpajf95THabV+IwD863cuv/n1qLj0Fz4p+IfamBBbx
 1Hne0yR6cNsFpmN97CvEbSTx6+Gkr0xJmaeVBIQDGPchko6Zjqz7+f36GTsX9aPCM6sq
 T20PJ8qwO4nW5+dTEUVlObGpLnWLAf4Z04dqkv/1EVkDjFy1OXc2pkErtvaTjBvazHo7
 EANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789642332; x=1790247132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q+A3V8/x5c21vazgS32hcx7O6vB4HwRW8LEwa4hezrA=;
 b=tCUogmI0oqjqjuU+zfzKiTAiYkMmLFExH+By537HBpg7my81VOTVsgzs3LKkkb10EZ
 fxxsBZtXG4ObISLBsU515pXmigNP06GjCXr4+S63JQolBuz7meVK/5h+z6yonT1Bk7Wr
 JOC8T9tZR6IncHIyycM6+XXwGkbJ7a8NXrE3xK9FrmfFK+7LzRzN/SYRrQ12O2u4+kcL
 Vz1kkzOrznJoZhK3ZLmCOLQ4TGUfnJ7AZur2lQd+XWeCRITDi5MqApWR+EwVBam99vlU
 UUBtPJ/ErcaYY1XpkkmE12k1e1ZtGTxs7dIWhXqMBomtbY+nLN7DJoQ6Ybd0OvO3OxM9
 gskQ==
X-Gm-Message-State: AFuF++lZFaSRPHmZKrT7bqDvMyu35VMaXbxI3xmHzMhhStZR2yq0MMu0
 I7XoQXo+4KjSkN1k1n3mVIXTTmDBRkK+ndNzk1S9Vx+9mRoVJNTklwLdvsDH5YMAos4=
X-Gm-Gg: AYBFou2YmjcZ5QynAQ9WGIz13F8KnzvfQ4n++s72qbRcVwkWxlqHVQ1j4Gqico6ivwk
 HbrWmMg7rzZHLrBaMrR3NEdYVRKYyHqLm1xrNLrfUs+ENryQFRv5aBadCv8chNTytazOJCPqFED
 aQf9ueXN9PEwYyEFXOsptCFBCxgiajrGiEX9MEMTr67YkSGCGz8sE7TQQ5mbfrxPW4F5omQ141K
 1HWtyW4yPjbrT/ojvA/3sk9/jbSdhS6XX9KiqSjApGCcSIl+qh8cfwmuugWl15xOIOrFifHCDiU
 Cy7DIxvDf6gfwHYhxkhrV36B21uqY60VKF5yNj66vIgn3qPtLwhBAU4k1qBJ5MODrG9//PhNXtR
 7OgCesEBBzOhn+VkWc3aBITtWJ7Xofl0PNoRW+2UzddG3HOoG62PpZFxGxGkJwYgg9DKv7bYWKS
 RmwE7uJ61Eho+LGvSGX56arVCFsrziBcyxGhZuohuUvu7I6Zxkjqe99g/T7gxFMg==
X-Received: by 2002:a05:690c:c50d:b0:87e:2404:444d with SMTP id
 00721157ae682-892264eedcemr20325507b3.59.1789642331820; 
 Thu, 17 Sep 2026 03:52:11 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8928ff17829sm13960517b3.40.2026.09.17.03.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 03:52:11 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ben Greear <greearb@candelatech.com>,
 Matt Vollrath <tactii@gmail.com>, stable@vger.kernel.org
Subject: [PATCH iwl-net v2] e1000e: fix NETIF_F_RXALL buffer overrun
Date: Thu, 17 Sep 2026 06:51:44 -0400
Message-ID: <20260917105144.11308-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
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
NETIF_F_RXALL is set by ethtool.

To reproduce, build a kernel with CONFIG_SLUB_DEBUG=y and boot with
slub_debug=FZP. Enable RXALL with 'ethtool -K <iface> rx-all on'. Leave
MTU at 1500. Directly link with a remote machine and set the remote
link to MTU 9000. Send oversized frames from the remote machine with
'ping -f -M do -s 8972 -p 00'. Unload e1000e on the machine under test.
Observe slub_debug faults in 'dmesg'. If IOMMU is enabled, you may also
see IOMMU faults during pings.

Fix this by ensuring that buffers are large enough for an entire 2048
byte chunk when NETIF_F_RXALL is set. Do this by moving final
rx_buffer_len determination to one place, right before RCTL.BSIZE is
determined. This will correctly re-evaluate every time the adapter is
configured, not just on MTU change.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: Claude:claude-5-1-fable
Fixes: cf955e6c96cb ("e1000e: Support RXALL feature flag.")
Cc: stable@vger.kernel.org
---
v2:
* Don't make a new function for setting rx_buffer_len.
* Rewording.
* Add steps to reproduce.
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 41 +++++++++++-----------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..f31dd5886b09 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3094,6 +3094,23 @@ static void e1000_setup_rctl(struct e1000_adapter *adapter)
 		e1e_wphy(hw, 22, phy_data);
 	}
 
+	/* NOTE: netdev_alloc_skb reserves 16 bytes, and typically NET_IP_ALIGN
+	 * means we reserve 2 more, this pushes us to allocate from the next
+	 * larger slab size.
+	 * i.e. RXBUFFER_2048 --> size-4096 slab
+	 * However with the new *_jumbo_rx* routines, jumbo receives will use
+	 * fragmented skbs
+	 */
+	if (adapter->max_frame_size <= 2048)
+		adapter->rx_buffer_len = 2048;
+	else
+		adapter->rx_buffer_len = 4096;
+
+	/* adjust allocation if LPE protects us, and we aren't using SBP */
+	if (adapter->max_frame_size <= (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN) &&
+	    !(adapter->netdev->features & NETIF_F_RXALL))
+		adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;
+
 	/* Setup buffer sizes */
 	rctl &= ~E1000_RCTL_SZ_4096;
 	rctl |= E1000_RCTL_BSEX;
@@ -6079,30 +6096,12 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 
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

