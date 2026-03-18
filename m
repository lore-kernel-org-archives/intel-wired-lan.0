Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56624103E199
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Mar 2026 15:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16C3B60A3E;
	Wed, 18 Mar 2026 15:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RqVJICugUrSE; Wed, 18 Mar 2026 15:03:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6679060A67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773846193;
	bh=bCbPYXsJyjrslfVQf+TqWui1no/uksX6ojvJaHIhI9s=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sqr77AabBizj7QCreLegkeDRM8ej1bzZMO0FvynwOSxX2rSuovFM+IzA+VNWoMVBk
	 U3d3Yv8NHQaC2e9LiOlscV/gEyDXKCyO+3p6tHfsTWctZw2aCv+pEOmlLsng63Z9vj
	 MAZp0W06goDPYFCP5R6oAxf4zlEVxXC7ra8pI7Of7ed+7TGJHyuWcN9MTgmS4Kq4Kj
	 7CCLO2090k2J+VK8H8z1GtdAy0W1/xxxE+wgLW2+Q1kP4lmCQJEWH7pVNxydOrMz3k
	 cjzRAOn1zcCS59PbehawCm9bvPsBWbPnul5uHwAAenH89z+8QYi0buOVkLcsbHq1KU
	 QmPtsgFNcfFPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6679060A67;
	Wed, 18 Mar 2026 15:03:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40E0F1AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26CE360A67
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H9OEYQa5-6Tp for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Mar 2026 15:03:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.49;
 helo=mail-dl1-f49.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5ADB060A3E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ADB060A3E
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5ADB060A3E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 15:03:11 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-128d2e3082eso150470c88.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 08:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773846190; x=1774450990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bCbPYXsJyjrslfVQf+TqWui1no/uksX6ojvJaHIhI9s=;
 b=P6mEaCBbVNJNDf10478xo2FxjBjvVc7uZNd9J/CSiY6umJIuvNu0pW47GgAYT3Uh+C
 KlXmF5AgBla5THgkqlWBEMf7YXnSr9zGNZCDtVnnTbEgVQyXQgIpPwvjonmZH8CACtI2
 s9NqCMFBmqHk3vvQwPY9+OR8XCZfMBFXHJrZ2Sd7zJ01gtxrdS578iBfigsrYRda4zBd
 es2gD8ha6Y7EIYKmATiUOtK4BZb0+yabEs0jvqfTAnzNMVjRMRTYt9L4AusDzCYcx+fs
 66Tu2yx2F/Jje8SRGvwdkkwJEIQu0YgosS5/t8o0vblconNWMFplTA9XbwR/gQN9MWcb
 e+iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF+N9GpUBmft2wVI5GGiColaDTU/jA6ur2nF9ipnF/KP1Xfng1jdUj0DebBcNZQuxCgIiRKvbnkK//SG92WLU=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwQTzR7kAU0y+YNKJhL//8CyclsS18PremSqkyc1wrYMcHM0sVJ
 hYSpNQhUWw6jR1dV7aqbL7K9zFfhq6CdYZrCIsJuO+2hl6/r4v3PMus=
X-Gm-Gg: ATEYQzwj8ZLKPLb1IX1tjXnaVl570LcQ/izvIvZQ+F4w/qh5ykwLnwoNdMFWfda8rlp
 MdhviO771W31Ljb75RFBDm5nbDTG3WWA6Uyps3Bb7cDnszdGB8shCjaJhUyHmoJKS46ZXS7qI/j
 UsfnOrbOfR96ahlMHb1sK8ceeG/iYsELSKMlwqsTbxcYIVu0R+QumO5BRfpyPaU+OCheEggMMr1
 x6d2D6gnB+lJ5+QKjzMY9P4XYrGpHRcNJU5PynLmlH9fliV2UtZ6C/G3XxuAePdnV9vZgk625EM
 21Ci5PfO4bwWWP3u6rg6A6LOhJDCHBCa8V20EGFuItCUr4p4jfXYowvxCJYuqL5cLDKGm75WVb+
 EuJgOyc6KIB4TY8t4ZIzvRn+1GbPG0o2Ex0n+TQD2vN2ifnFiJLkufZ/zKV+Hnm8f4Q8tJlWdCz
 GuLPM9HAOUNPB/JolOq99kk1nQTz8thB4+zvI6ggxsnabf/c1fpmzwgfDJsih+Y1CHXFzu8+8PA
 LNgHZ9Z9peRFooKXw==
X-Received: by 2002:a05:7022:6a5:b0:122:153:d161 with SMTP id
 a92af1059eb24-1299ba3e35fmr1920293c88.17.1773846189957; 
 Wed, 18 Mar 2026 08:03:09 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-129b413930esm3529158c88.13.2026.03.18.08.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:03:09 -0700 (PDT)
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
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 leon@kernel.org
Date: Wed, 18 Mar 2026 08:02:54 -0700
Message-ID: <20260318150305.123900-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v2 02/13] wifi: cfg80211: use
 __rtnl_unlock in nl80211_pre_doit
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

nl80211_pre_doit acquires rtnl_lock and then wiphy_lock, releasing
rtnl while keeping wiphy_lock held until post_doit. With the
introduction of rx_mode_wq and its flush in netdev_run_todo, calling
rtnl_unlock here creates a circular lock dependency:

  Chain exists of:
    (wq_completion)rx_mode_wq --> rtnl_mutex --> &rdev->wiphy.mtx

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&rdev->wiphy.mtx);
                                 lock(rtnl_mutex);
                                 lock(&rdev->wiphy.mtx);
    lock((wq_completion)rx_mode_wq);

Switch to __rtnl_unlock to skip netdev_run_todo in nl80211_pre_doit.
This seems safe because we run before the op.

Link: http://lore.kernel.org/netdev/69b5ad67.a00a0220.3b25d1.001a.GAE@google.com
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2225f5d0b124..ce5f25d4c87e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18192,7 +18192,7 @@ static int nl80211_pre_doit(const struct genl_split_ops *ops,
 		__release(&rdev->wiphy.mtx);
 	}
 	if (!(internal_flags & NL80211_FLAG_NEED_RTNL))
-		rtnl_unlock();
+		__rtnl_unlock();
 
 	return 0;
 out_unlock:
-- 
2.53.0

