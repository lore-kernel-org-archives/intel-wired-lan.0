Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80054109316E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 01:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 582E8616A7;
	Fri, 20 Mar 2026 01:25:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id znPpU53muFkK; Fri, 20 Mar 2026 01:25:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47F1B616B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773969922;
	bh=LWBQoO52uK1jdWWUCzjHOfQ7E5wdgkDdRoNSlPpZPUc=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YYgZ0UNJcziq1DrGjwWvfdYr05zDPE5MFhTpQ+4QrtzRD6n9XwSCuddryO1RSMep/
	 25xtCSiNAPkvcZ7aJ5rfcYthL9MGmS81ls+D4N53nAmZNPFAvif8+WPxlxznwZxquA
	 mejZLQ0hGKkqOAdOrFWosrodpT8xVRAzyXiLT/La30wIfoBXbHOkgWfclT3UsTrjNG
	 RETIZ7MQtezWtO1Ci3OGt/ksbDfju01lMkEL0WaavsUwoWI2Ek3ZiQFUD8XZitSeY3
	 WPOAlGsR98r3UoVYZxXNHM0mFppnbWQ6/M5NUPzV+QPeW7noWzlOYW5Rs0B9f90KoQ
	 wzggrEnTQDMMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47F1B616B4;
	Fri, 20 Mar 2026 01:25:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AA9D1B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06A5C616B1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O7wpAOBW0wER for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 01:25:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.41;
 helo=mail-dl1-f41.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 26C4E616AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 26C4E616AD
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 26C4E616AD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:18 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12732e6a123so2875134c88.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 18:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773969918; x=1774574718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LWBQoO52uK1jdWWUCzjHOfQ7E5wdgkDdRoNSlPpZPUc=;
 b=K4zPxJjcmeEjktK6Fme7PeqvO+1ooNGppv86t247pU8fv5604bd8KfDI+iY+Z8BpwH
 0zgWfdRsoEDSDYcYlR2QeyTXpFcV1roWzSqKh6c0kFkznUebNb8+3viVjIenKcw1l1A8
 KPrpKUy9wePW1nZ150s1vhpBo0rV8awQTDFHNEZRHBWT/c/Trbs+cWEWCPtHB8D4Nya5
 iyG6z2KzYVcqm+eS5u/nJB0DJ54xjKS864h9aQBIaxm5aTgmzz+3omUHFIAioZmORPox
 af8tYN0AlENMSu3Oni2eKPgtUjjqJfQLBh71uslcBKX6iNOl0HWeVIRyUcnBF2EMMbEB
 Uoig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoI1PF66wHkCIcfV0RICC77UEYN7y51WEvHUv0KDofOO9Ca3r4JiOJkINMt2kOhRGI3quKHAsnRiWl0HVszGw=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yz7ix6TxNm8S6vd5TwZbOzVr2xv+w0/ysGkfmF9I20glySPTW/2
 yuv0jlGgLbFgWPXdnICMkwdJoHtOb0d4czzleVRvnGFGY9+dU3+VepM=
X-Gm-Gg: ATEYQzyAH6dNDSLtDKyxGbdTNWxMkRIw0jnKoaw+gaaHdcYpz6o1HXR1ZNm12ae9LEC
 SQXJf6uJwRmrqi8W5Cc9gRAtXUB0QWUxebIjJ/GJ5V1YibhM+ITvktQh4MGoxbaHmt3RpVBDsSZ
 +rH4/DrQusQnJ61Xv5wYDdi3JtAhTgZ1eM92QjmQ+noT3Uiw6xBurnxF1pO50jD/j3I5Rhonbxa
 Hs2oxwkiIHXfqYRFfxpAJyWDJKxSp/LmMxHNnHdd5785OOrUpHc+YqVv8tXbE5fLXq/FDX4uz4a
 cdqp6yjhJM1uMMutlEMIzp1tZitr40x5too8yNR/AmS8zTtGP97rRtpfPK/lZIEX3jm9YfJqgU9
 7+N0F6EFo4RN0ZVJFNUBi6IZNwTzMh0woVZcJw20AgXaxuvJa0ymHrH/RaKZi7E7Vh1fJA8DyOW
 gQyGjufwcXkmfywT+pt/TtzBGFg0Ynyn+4cyBL5qnERU5O2Exlc2jwS8LDmyS9ZhB4nn9hBp1Is
 n4vMvI8RAo/fhRVsQ==
X-Received: by 2002:a05:7022:e08:b0:128:d737:d7a6 with SMTP id
 a92af1059eb24-12a7266cdddmr651698c88.3.1773969917836; 
 Thu, 19 Mar 2026 18:25:17 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a734bbbc5sm747251c88.11.2026.03.19.18.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:25:17 -0700 (PDT)
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
Date: Thu, 19 Mar 2026 18:25:00 -0700
Message-ID: <20260320012501.2033548-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v3 12/13] net: warn ops-locked
 drivers still using ndo_set_rx_mode
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

Now that all in-tree ops-locked drivers have been converted to
ndo_set_rx_mode_async, add a warning in register_netdevice to catch
any remaining or newly added drivers that use ndo_set_rx_mode with
ops locking. This ensures future driver authors are guided toward
the async path.

Also route ops-locked devices through dev_rx_mode_work even if they
lack rx_mode NDOs, to ensure netdev_ops_assert_locked() does not fire
on the legacy path where only RTNL is held.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index fc5c9b14faa0..f38ab254708b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9779,7 +9779,8 @@ void __dev_set_rx_mode(struct net_device *dev)
 	if (!netif_up_and_present(dev))
 		return;
 
-	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
+	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags ||
+	    netdev_need_ops_lock(dev)) {
 		queue_work(rx_mode_wq, &dev->rx_mode_work);
 		return;
 	}
@@ -11471,6 +11472,11 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
+	if (netdev_need_ops_lock(dev) &&
+	    dev->netdev_ops->ndo_set_rx_mode &&
+	    !dev->netdev_ops->ndo_set_rx_mode_async)
+		netdev_WARN(dev, "ops-locked drivers should use ndo_set_rx_mode_async\n");
+
 	ret = netdev_do_alloc_pcpu_stats(dev);
 	if (ret)
 		goto err_uninit;
-- 
2.53.0

