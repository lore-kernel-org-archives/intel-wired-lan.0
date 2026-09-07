Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109E4C79F9E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 21:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D67B360650;
	Mon,  7 Sep 2026 21:54:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rp6aj7XQooOB; Mon,  7 Sep 2026 21:54:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3A0FC606B1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788818093;
	b=L/Bzxwc31vkS/MrxSujCHsvlNlmfiwpOz7Nt/ova6C/R4SbD+VR0PXuUV0Ksyy/vvFl0
	 bgcHPT9nr6z+k4fx8IXEFWzWlXcX+6qURcAH6mCYq/xGR3hck4Twv8PMAMbwpdchD77uz
	 pb4kmXgYw+PzvGElHRknEobysLCfxUD/5HIJR6SNWktObSayUH9Xqr1XJCja1HT9X2rhu
	 QOSJjy+kkQ92FpcjInKot41vlcXj4NNANHhRT5zZjbKC9OWyHoeAdAqVb+iMEcCH/m3vY
	 Qu04mVuMKesoY89z+vUmpOAscR2gWHdYire1hKFduPID0BnVgm/Ur79AbqzLDri1rCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788818093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EPMvbjF7fIzIRVphdYEwqQYdJVOJV5Z2qbhmmd1p55E=;
	b=SncAE5mccby3rbRuX0BEpL6sI36pTHgfxkA5KTjnUZ3mE4D6AFouTQJrycx2khpNlvJG
	 2NgmQmWLdYIm5wQJTpZLybmPSaKE4DZcNyAypM1iKdYGCQ0XxsnLCCJ4OJR/m2/lfx9nx
	 6kxo00wGwVa29YOnNtIOvraL5DVPnl53aAMr/hLqCOsrSLXAjFHgLnjjI14oJR9zkwAV+
	 GWeCxxGPOGF5NmFv0kpnP6W59Pss4aEGCq2FcoX9SKq7aNFplq6/aMmUkCwz5JADrBOBy
	 I3a4MVwFZXLZdIJFj8FuYmZKreLISzvg5VZ8OVeEfqLJdrh07FK4nk5ORSblzHF6Ghw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VOfox99Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788818093;
	bh=EPMvbjF7fIzIRVphdYEwqQYdJVOJV5Z2qbhmmd1p55E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1eFjQyrI5EnrCqDH3U93t7gd44kB3ADXwSQoB4Cy4ENTnNP44Tc1S2lXgsgCEzvJC
	 QWPko/EdaLatobXwt5N1wHpcbIhGT0cLMX7/VfbmsBJ+JB7GpHdQyMx/qdCOIjvjtT
	 QafLuDuCoPFB0sQOD4Nfb9FcSrX2HHpA4MsiT+tB+oRuzFo8stQ1rdyfjyL6/B8ZMa
	 mP6COf2ixzEpTh4ho2hVB01xV7g2pnkfiWgoy35Xw2kZE2Jm5cn2sEbBfcNi5w3h/f
	 3omtr1sTNIbDjyaQqozfDeFTqyMTIdeq1KDeL/XtaGi+T9E5iOgCHUudiyhe/xt2gR
	 LZ5DbB/ywxs1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A0FC606B1;
	Mon,  7 Sep 2026 21:54:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 50AD7D90
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F79B6068A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JphMfUpeJZem for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 21:54:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7803C6069E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788818088;
 b=r8OlmBmMHQz6uSpJSiHQYT+rsngXcdEB1ZYi5OfBpO+5zQi8Wx1MM8eyzzHKNfgeudTf
 sQ5VP31f/aXXLaujpTPaqPuhFm2VNfHdg+SKDIPx6k4IdF3yIujWOTBT5dKgBVL3PFX9e
 wVU8/S7sqBP02CFBRYJjjn9clToiC4kX2a7xIM4UUWN8t0eiZcRtzofUpAo6cIoPoJtDV
 mZq6Dzt3FFqkKxY86HcpWFUYbcsWW7Qu+PL6Z+7b0vMB/7cKYzfLmShMx5/SmJ/c5C+uv
 j3hOeGk0YQIyRVRsFSuAZlmU7oJyeRGKhDxhVOfvvSfLa+VIBhsf7p6z9ncy5H1C0rQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788818088;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=EPMvbjF7fIzIRVphdYEwqQYdJVOJV5Z2qbhmmd1p55E=;
 b=hhwSDpUW9FQvUmMgaQRwXIgzy26VY/alLGYJ7kl9Fr5D4LkFYoNgffZ52txtcDeE4QtS
 bfA4qHsTM9BQ3mzLwZP+Nfa8KD7/VAdStLqCwmzTxdoQ5zYMn6LG9d6cRk7MMHdRb0oI3
 WnlSskgUDUxM1382BYSWLc1CQRs3qeQTGWHmXqxHbNwyulypWsNVHxYUQXoSokNjZ1fWY
 k8tGiFVLHzxW882RMk0phkeWkSuUHIC5XfSqGtN83WK3+RFV45DI9zCXUVZN+4Jqu25Ng
 HXY+jSD6mZg+H2URRJT6mpM9KyDkgJl7jTxkF9uX9+mtfZ9HKsE2WQaonzB3m/YYrAg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VOfox99Z; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=VOfox99Z
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7803C6069E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:48 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-855c26cf490so25760707b3.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788818087; x=1789422887; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EPMvbjF7fIzIRVphdYEwqQYdJVOJV5Z2qbhmmd1p55E=;
 b=VOfox99ZNQLS8jxeQdwq459YG1iEXXeAVT801KG+ADR4wPPJhQHMkWgqBO+3shTuev
 SwafSCSf53bFTWL4x7S5AFlP0bBlOvCtoVTlZ5JwqMFQ57L6tI5gK9q5264XqbLaTxoY
 Oca62eEhxeCp4vF2Em2vmI0OiBuiPbcNOC38aC8aWMMLRDqFyjnmA+Z0hU6FundxZXf7
 KydDxK8uq4oh7tOOkZn0r3G+I1G1oUHO9e59QiC2H9gRWALJkw57PhBPovj6IuCT2tW4
 Znpwf+sRFhgMW/5uHMkInPnfmmdqFp/BT4l7q7PCA0XqPLYtYFJ7Ke0U8S/EoT2TBnpm
 nY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788818087; x=1789422887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EPMvbjF7fIzIRVphdYEwqQYdJVOJV5Z2qbhmmd1p55E=;
 b=Qg17m9lJ38/QutNnnKNLAWfI1xag61KMXNlp79Ry2uVJoBJeb/vMiGUHWSCCkdpV8h
 uo0iotgnAR+4Qdlj1Fk3Yt1eZgjgP1MupkdN/yy02wKGPH8q8ySwhpWLYzhNAuFM2y2j
 X57RvOi1xrFFPIh/5kzIDyOVbJ+ZiA3ibelnfq97S1HgvN8Zo709WbAR4dY/jYt63VFx
 h3M0peSit+2ZRp+l/i/sIYruGA438Jpfg++h0l1wkR4aqQ3QMpSFUnq4KGDjl9EzisS5
 EEoCsLgSgpwMNEZYZZGMmpiIKJ3gmUpjPUIh6YePMTprzKQ46y/ZTzAZfwFJavnPE5yi
 C61A==
X-Forwarded-Encrypted: i=1;
 AKwUvByL+ixpeoKF6K3pw9IRJOUWLLa31cw1ZO0uyW8aCuUp0VzbvequFGLz5sI3hz59qngutzHuNFuH5mIXdtS99xo=@lists.osuosl.org
X-Gm-Message-State: AFuF++nzW3p6zZCENS3ptG7FAyXqLTyMXFdSZ+CwZbFnR1omXctWaduL
 rLUR2EYPx5CXg92nIzOH3TRrCmil4HDMf3kb9KpRfOhLZHFFjRVowcXu
X-Gm-Gg: AYBFou1GpJxTUmbyjA2Y4vE3g55rjmd3mOHcnHWFWBzBWRCnBstJtHwvNBjKzdktdMx
 XbhdkC5L/eF0W+VqTDCTRrbWxGmbPs9taiClsba7nBV2+KLQYA0WUGDzr1K9ud1Ux8WISp4t5Q0
 K3cldU3yIRC+JdQKP5827D+LCbG5Q+TcIAmMUcRkOl62UX2lk1pcJUMFkIaArUbCLmGKMU2B4Nu
 N6tQzev3LfnGqGsa9xzCfudUvV8h7L2NeunYtOCNE1Fxdp0plbRKAThXohF8vDinKXyaIy1Rm+h
 6VFSp0UVuhPG+4Zjb7VyDN2ixIvQUbTxM3nmDWTSj4rHcX3J7uVchtvvA9D4q3c7ew0CFdbrT0i
 tjKViYVw8t8j5hf4PV0nK0odbLVCXBJZlylZ9h1SHc8i6x+NonJxCmELRTyL2tGdecf5U1W4Ee1
 awdiOwjucmqMVJummnK4kUGqjAlq0r5cg+Q/RPEHLc3cDLBeuWskMAkWbaRhccFBL7j8U/GoKsp
 4oiGrOSws20O+qEEQ==
X-Received: by 2002:a05:690c:e29b:10b0:873:5ddf:d864 with SMTP id
 00721157ae682-8735ddfdab5mr46438527b3.47.1788818086989; 
 Mon, 07 Sep 2026 14:54:46 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714b62bc77sm78551997b3.39.2026.09.07.14.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:54:46 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Raju Rangoju <Raju.Rangoju@amd.com>,
 Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-usb@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6/9] net: avoid copies before linkmode_and()
Date: Mon,  7 Sep 2026 17:54:35 -0400
Message-ID: <20260907215439.409858-7-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907215439.409858-1-ynorov@nvidia.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
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

Avoid separate linkmode_copy() calls by passing the original source
bitmap directly to linkmode_and().

In phy_ethtool_ksettings_set(), also use the return value of
linkmode_and() when validating that the requested advertisement
contains a supported link mode.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c | 5 ++---
 drivers/net/phy/phy.c                                   | 7 +++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index cf881108fa57..5801da6100b8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -205,7 +205,6 @@ int hclge_mac_connect_phy(struct hnae3_handle *handle)
 	struct hclge_dev *hdev = vport->back;
 	struct net_device *netdev = hdev->vport[0].nic.netdev;
 	struct phy_device *phydev = hdev->hw.mac.phydev;
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
 	int ret;
 
 	if (!phydev)
@@ -223,8 +222,8 @@ int hclge_mac_connect_phy(struct hnae3_handle *handle)
 		return ret;
 	}
 
-	linkmode_copy(mask, hdev->hw.mac.supported);
-	linkmode_and(phydev->supported, phydev->supported, mask);
+	linkmode_and(phydev->supported, phydev->supported,
+		     hdev->hw.mac.supported);
 	linkmode_copy(phydev->advertising, phydev->supported);
 
 	/* supported flag is Pause and Asym Pause, but default advertising
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be330..cd71186cd842 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1160,6 +1160,7 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 			      const struct ethtool_link_ksettings *cmd)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
+	bool has_advertising;
 	u8 autoneg = cmd->base.autoneg;
 	u8 duplex = cmd->base.duplex;
 	u32 speed = cmd->base.speed;
@@ -1167,17 +1168,15 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	if (cmd->base.phy_address != phydev->mdio.addr)
 		return -EINVAL;
 
-	linkmode_copy(advertising, cmd->link_modes.advertising);
-
 	/* We make sure that we don't pass unsupported values in to the PHY */
-	linkmode_and(advertising, advertising, phydev->supported);
+	has_advertising = linkmode_and(advertising, cmd->link_modes.advertising, phydev->supported);
 
 	/* Verify the settings we care about. */
 	if (autoneg != AUTONEG_ENABLE && autoneg != AUTONEG_DISABLE)
 		return -EINVAL;
 
 	if (autoneg == AUTONEG_ENABLE &&
-	    (linkmode_empty(advertising) ||
+	    (!has_advertising ||
 	     !linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 				phydev->supported)))
 		return -EINVAL;
-- 
2.53.0

