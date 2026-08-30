Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EE8C61DE2
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Aug 2026 23:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 409BD80C69;
	Sun, 30 Aug 2026 23:22:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7nvG8gS3wpe; Sun, 30 Aug 2026 23:22:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788132152;
	bh=l1d2o7Bv+elIT7N1ffI/14l1K9kWTm1+Hxafq5ZWY3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JWxRnmHApEeOpnbvUAC69V+C/ENNNAGSTAvppsbDjLWj/CWjUu2jEeHAf7r7svqRR
	 1ED9qsbdXmI/2ygz18dtX0wX5Io8FljZGsLZhoScUjTXrlF7/7p5QcwLtZ6gkv5dA9
	 sgU8Gt+Jcx43HiL+EeVJyIBYx4HtRq/H5rfHNbLAJt1IbDXDZL6gBZbKRXwXQX6IUv
	 x7UgKX+Y9K6D4x1rSmoVhOTLdh0cNCAqYpPeQTxS+D3nlOrjoKWyp0t2IuMLbLRKVF
	 QkY/2dX5UmIj7BltOmjKDS25aZpv2tXeGRs6oUKserf8Z6t7HW3istksHGuWG5e6xM
	 xHip1W2doDqUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80C1780C4D;
	Sun, 30 Aug 2026 23:22:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 26554334
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1826E80C41
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yXFFF5PsLob9 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 30 Aug 2026 23:22:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dAPEogoO
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B3C280C47
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:29 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-855de2d0d4dso33183307b3.0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 16:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788132149; x=1788736949; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l1d2o7Bv+elIT7N1ffI/14l1K9kWTm1+Hxafq5ZWY3U=;
 b=dAPEogoOjEPrl/3SoDRECtYxTtP1jIZklkvLRqQ0rVQ00la/ME/NGIDfYzEX6yXhGR
 McyWEfAtHVo6yRxCdplmvn+U+dA8sEhaBuJmaOe+pOtJSVX566xo8TTRQUoe3KwKxfog
 7x3468LjljTxOM3RCkhmkqz5Kep4krqkBejttjQGLuluNk7oUafZ9Wx8RhPHFTl0u5VD
 kUC3FmrrnQQuN3A5RCMp8rCOUGyGvvT8RtadH314WGbylLShlTc5KzuR6ZtA5FfzsOhu
 IXbSI8Au925wGN+l/3SZPNgX7HBsYkZiPGfQzmZBNubf/1PM/4dvVkDU8sFBugvFKwrH
 a/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788132149; x=1788736949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l1d2o7Bv+elIT7N1ffI/14l1K9kWTm1+Hxafq5ZWY3U=;
 b=rqBrT7nhT9aFNaMwA3/Pt01Vh2zr6GOYIrhaUHfcpndeiI8eSTjPJhtAfDz6IU7AoZ
 ZqLKiH9jC8XyBxzbeQEhwGUUku8EmSMX43ImKHfXMKrA1aruZEcJpqsTdJPJ4ShUrmql
 PO+io/ZbmGinW18QhRQR5WU51KeB+RtSq7iAeN/0fHPBSIZJppM6rezsWlEeg7ZgbAQL
 777uRqmwHnWpfbXkKL9t5kh99BnmNgv5I8SXif3Vwq2FurKSpOzs22OozC9kEjXdgdw2
 jNxmtol6b/tBoj9W6njYukpbsXDTMc+Oz4fSsqsHC1vszlxSciy1XIww881R1ch7xw26
 Sztw==
X-Gm-Message-State: AFuF++mciqlmfkYi4CJqkW8W100UfvyGSq4MIBZklELWw7slUlGEaQfY
 C3O2KRfULH82zABUdtAvUsNYl8RYKmAi/tsOmRJ6AHFwLrRc5CTYIYL/j3MLgwdFqLM=
X-Gm-Gg: AYBFou2QmEaSJvi1kzVJtVNCmRx1z5+9dIs5TCy9JDzO4IknUEWXj7/E6hznAzMIhXH
 qjP9FHTaeN56avnq/h23xw3GSbhBG9FeSI1HtXS2QWvBPpRTyHXFTvYuzZWXKVRCF/DxChtSz7i
 f+QKaH0YuIe//IGzzm+UID36LDnXgcD3Mg+gOq0nKK8qsd3z5lZL6sIJJeOogjUJbg8OmE6jutt
 g9zE5rh6hDzq5Ux0pyK+dUlwd0VVWqB+RRdvvJh13u5+Uk7T5Yt/9TWeOz56E7udaySZortmEAJ
 R8LTRVdn+bQ7FUP8dfivTmeO+LLLHEg41cLbWW7TAa8n9Y+CqCBdJqxImJ0b/MAcx3R1wY7g90f
 BbBBYov1pz5qk+FSix81qyCC7fvzNzwdFi+t03X+duHNuuwIjRYkTj2ELv4DBaWyn0jdyMlxu1J
 eMQQwI7POEKXHQHoE57UFvmuqboAPT9lgL8L7SPboVIg==
X-Received: by 2002:a05:690c:e3ca:b0:858:bf8e:d0a4 with SMTP id
 00721157ae682-864f634fffbmr13982757b3.18.1788132148676; 
 Sun, 30 Aug 2026 16:22:28 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e677606aesm39025937b3.45.2026.08.30.16.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 16:22:28 -0700 (PDT)
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
 Matt Vollrath <tactii@gmail.com>, stable@vger.kernel.org
Subject: [PATCH iwl-next 3/8] e1000e: prevent race between PM and reset task
Date: Sun, 30 Aug 2026 19:21:41 -0400
Message-ID: <20260830232146.36948-4-tactii@gmail.com>
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

e1000e_down could be entered simultaneously by the reset task and the
runtime PM suspend callback. Prevent this by acquiring a runtime PM
reference in the reset task.

The intention is that:
* A reset attempted during runtime suspend should drop silently; the
  interface is already going down.
* A runtime suspend attempted during a reset will be retried later.
* All callers of e1000e_down are now serialized.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Fixes: 23606cf5d119 ("e1000e / PCI / PM: Add basic runtime PM support (rev. 4)")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 25 ++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 47ff3c6ab451..4c15ca307b08 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6004,20 +6004,37 @@ static void e1000_tx_timeout(struct net_device *netdev, unsigned int __always_un
 static void e1000_reset_task(struct work_struct *work)
 {
 	struct e1000_adapter *adapter;
+	struct device *dev;
+	int rc;
+
 	adapter = container_of(work, struct e1000_adapter, reset_task);
+	dev = &adapter->pdev->dev;
 
 	rtnl_lock();
+
+	/* Runtime suspend downs the device without holding rtnl.  Hold a
+	 * runtime PM reference so it cannot start underneath the reset, and
+	 * skip the reset if the device is already suspending or suspended:
+	 * resuming resets the hardware anyway.
+	 */
+	rc = pm_runtime_get_if_active(dev);
+	if (!rc)
+		goto out_unlock;
+
 	/* don't run the task if already down */
-	if (test_bit(__E1000_DOWN, &adapter->state)) {
-		rtnl_unlock();
-		return;
-	}
+	if (test_bit(__E1000_DOWN, &adapter->state))
+		goto out_put;
 
 	if (!(adapter->flags & FLAG_RESTART_NOW)) {
 		e1000e_dump(adapter);
 		e_err("Reset adapter unexpectedly\n");
 	}
 	e1000e_reinit_locked(adapter);
+
+out_put:
+	if (rc > 0)
+		pm_runtime_put(dev);
+out_unlock:
 	rtnl_unlock();
 }
 
-- 
2.43.0

