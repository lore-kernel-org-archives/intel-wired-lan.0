Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371291093170
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 01:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06ACD616AA;
	Fri, 20 Mar 2026 01:25:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tqZeLDYjfVsx; Fri, 20 Mar 2026 01:25:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D29CC616AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773969919;
	bh=RnwqqwAxnRG8s2vaRYDrbUdfVznpcDcr1raRDlnvaSE=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PzcMJOrJV9GG7lxhNa/QlGYQQuGQz2CvG0NmwB4Phqrhxc2grT5W4wD36gjbXfiFf
	 guCMyimtGCE3sYCYbefKZDXJ3VMH9p+i/BmciZekFGEv1LBfPW4PK+VkwmIIBnYDzn
	 FbBW9py9fuB5hlIvAqx4aLiSZgX2ayDiCkkzyDnEZpwulBCyWExZDOy9YlDHrKPJNX
	 APhmv1p6gkL8n1jwR46LKNPLAgvqMkF6WjdgOFiAWkvT8z+qZWnEs2aA8M2SsLpuko
	 bk/9VtwC7JYkfGf1B1nyQT1KeGk0uSgqWjlr8VpEcFUFYBK63s/7WGBngUvaz6T+a3
	 9LubCJl9QlGGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D29CC616AE;
	Fri, 20 Mar 2026 01:25:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 193C6298
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B339941BC0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5CiuSz_GidQu for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 01:25:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.48;
 helo=mail-dl1-f48.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 12C8341BC3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12C8341BC3
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12C8341BC3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:16 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12732e6a123so2875051c88.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 18:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773969916; x=1774574716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RnwqqwAxnRG8s2vaRYDrbUdfVznpcDcr1raRDlnvaSE=;
 b=dI72OyOY2thG7dTW8YCEyTxS2P6XjsVJ4PKajUy7FtL54f3irPzOQTy3I/xjZtCxb5
 TNEdvbVtCGmISRZvK+X2J1zAdn+y0yUWzTXT3TDewA7d4xM9z5/WOIiC2tT83/QFtq8h
 xz9HDRsxWkV4cXDVeyYq96BG675N+PwUFyrva5VtCAG1uTG2YOGXwndmL9ZcxWW/F77e
 55+d8OR0FhfqMxactY+J61E9xOAw/dZLPTM6X2tFn1D+o9BmJzRcGho35/YpLFBieccr
 h6my5SCaGl7qgN140mAEFl5chFA9D0J7GAb0I6FZzBmbKSihRCmoX88mKHTWHrhpK9a0
 Y/Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu+HMAdrpC8SiGSMW67XOsKl1iKd7+2rvyb3kmfiDbes8tRPf4sPaqz/ln92t8XImFFVx86/lU8AwgfBc34xE=@lists.osuosl.org
X-Gm-Message-State: AOJu0YykY5IgmEqd0ecPlZErifUvZegvRkTKYEZtnJWC7fg0I4QXj/0R
 JbIaFHUThe4bpxEEiHw27q588DCfc8TVoTnDoGSSX+Rj+I7Wb7aI/A8=
X-Gm-Gg: ATEYQzzvlEzMYGUmiWyK+z3gkhJxHv/kXhGJ4embpG02ABseZNcKxk5UUN0aTxVqP5Z
 7e7BChr0n16TnOkXGrM+V5xSnzn5IIM2EgYpkFoGTVw2ZHpn0UJ27ehvN8Vlu+xoPiX8CJd7VSt
 eS9I9eJkz19KJZWCxTT9eLLNkEc3GXGZHdQgzlmgD0BzeBJxRID4ZL18W28FWbZgqrenn39+6IC
 /GzAKBrcSlt8t6Q4rVI+JKsrM+3bgi65lChUyrBRY8RY2DDgwxEsAu091cn/aUrVif67KtoRwMC
 pKtOdOhMe0YE3ziS/6O13JuDy8GIrnlhp1h1bRIQ40MtucRGytqWJFN0WeROoaSOkghU84ireRX
 igfNp5Vx+EaH2MxCLREKZMMYE2FIRnbQYM1yiMGi7I4D/2NtUSUPWSlVG0gD7BRuxjUx/mGcSeu
 0V45/1XmDg8WXp6DCOxTV7AThwq9U49TJCiDT9ni7fiM7FiqjeZMP3O88cyrLzD+hbftJYbR8hc
 iwcEBMj2F3URc6o/jbq+n549U1u
X-Received: by 2002:a05:7301:4083:b0:2c0:cc90:a71 with SMTP id
 5a478bee46e88-2c1095c78d8mr746759eec.8.1773969915768; 
 Thu, 19 Mar 2026 18:25:15 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b1a88e5sm1421784eec.13.2026.03.19.18.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:25:15 -0700 (PDT)
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
Date: Thu, 19 Mar 2026 18:24:58 -0700
Message-ID: <20260320012501.2033548-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v3 10/13] netdevsim: convert to
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

Convert netdevsim from ndo_set_rx_mode to ndo_set_rx_mode_async.
The callback is a no-op stub so just update the signature and
ops struct wiring.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/netdevsim/netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 5ec028a00c62..9c9217792125 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -182,7 +182,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void nsim_set_rx_mode(struct net_device *dev)
+static void nsim_set_rx_mode(struct net_device *dev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -641,7 +643,7 @@ static const struct net_shaper_ops nsim_shaper_ops = {
 
 static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
@@ -664,7 +666,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-- 
2.53.0

