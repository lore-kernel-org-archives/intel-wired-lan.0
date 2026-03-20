Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BAA1093163
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 01:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F26C041BC4;
	Fri, 20 Mar 2026 01:25:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aJPzstsd3xkF; Fri, 20 Mar 2026 01:25:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69F8841BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773969920;
	bh=HbyBRqP1dM0VO6fEJ4blZH7JfwL0DV5fAiX12aFZ5no=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=50PGAP5mux4LsUJ6fHxUOKvFZD+a2zfIOJUFJvWOv9kzUWNLtPnBB0aWAmfDScR1O
	 SWmqkUV1OHVOhrg82T8VoSYM1L+f/imC3jeBPSOnywvbMhHDZmFOYpLB/lWuPmTAFe
	 e/QwvatfrPyTzXcTLKrSzybzwrdl72fRRwfMzCw6wad/G44jUew+Yad1yIm5GrAjMC
	 gSsg2vc9E1v9hFhm6Lw3gzPX0rKSLy27cSCa+vHlXewXFXoQF4one9D6BTpoxsm8WN
	 L8U2XI8nVM6YK5FUfQDLb+SKPT/fVgCupP17PcFuds7c62mleCQB7KMvUtstLq9IOm
	 Pu2BeS3WyGpWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69F8841BC0;
	Fri, 20 Mar 2026 01:25:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E2F171B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7F01616B0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2LL1qltKSnEV for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 01:25:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.181;
 helo=mail-dy1-f181.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2E6F6616AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E6F6616AB
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E6F6616AB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:18 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2c0f754e756so1326280eec.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 18:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773969917; x=1774574717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HbyBRqP1dM0VO6fEJ4blZH7JfwL0DV5fAiX12aFZ5no=;
 b=pp3dHX64i3MuxxhSUytXeUcLvkjeyMSljiyctOhQgaMuavnojcI3/8a4k2DwpitGoF
 50cBC4ct3nUtxqjCGgXtvtWtkA5Fp9YviBLl7x3M0ZAOEvWfs0SsvzpxEt81xivH0v62
 BmCiKEGiq/O6ZfzIXOQKHiwOsp6P1Y0kvuHff68KWqn3yNNQEiChIFeFlJwfauTlnhbE
 dUwqKDf7ugPv+RHbXEOc4mk/YIUIvn5R2JhwHYl4n6S8x6vV9x1ua3Ki5F4HjaruRLaM
 EOYgeyzJWrSVsFw+4O/DUsGIr43mMk4rqOD3N+VQFibOwSVi6OtDf9gUv71UrSJPTOx6
 mCFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc5zR36y07dDi7LQTf9s7A4VC5YYA1lwwyPIkyfZraxlQPo91QBq4oQWOhXNWsqoUO+OnLOsErmA8ucDsfbx8=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyS5cOE4fTQGtKJ1xB4UWmprKesVQhQILzYrJWp4p56pbWl6Xq0
 L0WWikNX/bWjYRaZ6wD1s5jdZD5Hdc1JA6qOiPdsgoi6fMNRejAVy1s=
X-Gm-Gg: ATEYQzxRVEdYdnNhsNgEVc6wr+gAfVeDtqNzliHeL8v7y1FGL4FoWwY91Fw0Z3aM90p
 YvvVgypgLc8wMFDK7s+Paue5yfUa/aSEVcNr5tATBGjrYmh6/tRH/AHYvLDjGJFIawW+jYULZBY
 0gHojmqalvIyExQX2r29ut6MnQiy//w/gjYIyZ3HtLIPB24yue8aEqmjvHCv6/2vAD35gNqf+L0
 YX+yrziiL3s+PySqoJmtwm9P7G3JdKL3QBVTxnL/6WLO09HjBX0inGBqtvuscPtt6PT3Ha8TSWA
 5gtW1Tc9ZjqFQWZCCQaSNvEKDGvvmAtTGTq3mCeKWS/ks4HbPAFzzLzqqCvuGPx0jKjQAAsarPW
 JzZspVvKjGQRL//e8OIj2L9jdpsBpa6MCR7Qeiu6jOnn4ki0l0LfRZNzIxx9OL4PTN6VS6WMAQ7
 fe+KoILdLaAd4tdRAqOWKaimVWHhrCPs7FHu1zMEjlYFMR/uIonv8sS9D76SO9BPnlXljooAXZM
 81Gn54nFV7LOfqA7A==
X-Received: by 2002:a05:7300:6da5:b0:2c0:eec6:279e with SMTP id
 5a478bee46e88-2c10974fb69mr728307eec.22.1773969916878; 
 Thu, 19 Mar 2026 18:25:16 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29c74bsm1146865eec.17.2026.03.19.18.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:25:16 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 alexanderduyck@fb.com, kernel-team@meta.com, johannes@sipsolutions.net,
 sd@queasysnail.net, jianbol@nvidia.com, dtatulea@nvidia.com,
 sdf@fomichev.me, mohsin.bashr@gmail.com, jacob.e.keller@intel.com,
 willemb@google.com, skhawaja@google.com, bestswngs@gmail.com,
 aleksandr.loktionov@intel.com, kees@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon@kernel.org
Date: Thu, 19 Mar 2026 18:24:59 -0700
Message-ID: <20260320012501.2033548-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v3 11/13] dummy: convert to
 ndo_set_rx_mode_async
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Convert dummy driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
The dummy driver's set_multicast_list is a no-op, so the conversion
is straightforward: update the signature and the ops assignment.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index d6bdad4baadd..f8a4eb365c3d 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -47,7 +47,9 @@
 static int numdummies = 1;
 
 /* fake multicast ability */
-static void set_multicast_list(struct net_device *dev)
+static void set_multicast_list(struct net_device *dev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -87,7 +89,7 @@ static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_init		= dummy_dev_init,
 	.ndo_start_xmit		= dummy_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_rx_mode	= set_multicast_list,
+	.ndo_set_rx_mode_async	= set_multicast_list,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= dummy_get_stats64,
 	.ndo_change_carrier	= dummy_change_carrier,
-- 
2.53.0

