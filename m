Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E77FF8855
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 May 2026 22:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63E6640C3C;
	Tue,  5 May 2026 22:41:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yybySLaqI6gt; Tue,  5 May 2026 22:41:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5F8E40C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778020862;
	bh=SsKY674gEcmVloxh8QcPPtKruXs8CJmiJS+7itrX6N0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1eAPeCHQwGKWonckF62WH5sEe6x+YuIOX4xLzcoXsD+w6ZIRy7q+Mdq0KrnjFipGL
	 MkuW5ycLXc6RDwSqlClWFecwop2HMXrJoNzkXTzeV3fBdwVAgZzQD6jdnVZA3pS0QP
	 tcbVr3aMhXoqUOI6ir97MLnkQ0BJOSvCVAA6McVf1sOOpyN3QiBVEL/xGWuI1ZbQLh
	 TLBLRl7/FUovgViwLp4N+YXP6E3WkGoF+9gAQMWDWMpIv975uDu3kRvtByXPkrJ4OK
	 gvP0rB+foKEIrbC+86R0EoQjMYmUJqKZ2XUh1jaEs1hxh4Y3vf0CgXeEzF7HM9uJOO
	 e+vSSDUQ3ys3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5F8E40C41;
	Tue,  5 May 2026 22:41:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 714CA204
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 May 2026 06:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C27C416E5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 May 2026 06:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Di6tBzi-UEQT for <intel-wired-lan@lists.osuosl.org>;
 Mon,  4 May 2026 06:23:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=devnexen@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7C505416D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C505416D2
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C505416D2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 May 2026 06:23:03 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso32710965e9.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 03 May 2026 23:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777875781; x=1778480581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsKY674gEcmVloxh8QcPPtKruXs8CJmiJS+7itrX6N0=;
 b=kiCzc70mzSgrkk20WEDcAv4Uf5XXUWdKs+ezfzmJW4YXVX3/HIzJZVNV6F+yPQDrXV
 Sixqn5RjFXptsucHCOxUykM/NxLuhRQxt1kh6cT2Ces0jxF0w7tfgTZNeFoetq60e0BM
 f2WmrO0WKZASrPvB6p6+P8/TJUG7orqg+xX3EPLaAc96fpd5jcYgDE3q+w52ubvjQJqs
 sxJF14zzZ1f0XRx6m9f84KiKM0D/HpB3MJXsC57JFkDhDBZPjOZZUwJ0eVsLgrm5Knps
 k3P7wzJtcg1Z+1W5yCrHXznYNtgbeOlidxSaLvAcQc2518DdsFQ8IvkUhh4IUyNNk/rJ
 lPFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IqsIOsTwliOmWhCPhIYlK7uPekAuBRClVIVGzZns8GgEkdY7iq1hyLZuqZ4aHDQi2L4Y320oMvN++6ADyYLI=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwumEsIXiojY1fN/mPssgqSGIk8Z9A2RftKESKA9fbzZ+ufs+Mj
 Fl+HKcSkPmDTiuiSfzLYmx1XBnsRkR6TXTxQtT/JGAnxFMST/ekGgvpu
X-Gm-Gg: AeBDiesbOaxFUfHz/yB472/UIk/UXHzFqiKmyPbGLNlOtWzDmf3Z+4b8yXVXzgI1gKG
 1Ho2bQWpkMjnQswZWAHENzEH6Ka9w038nZ1UMfz10htIm4j0/0EqzF6/SdgnNCpXOHLiQ4cd89z
 QDZGTmXpkGWjQfDV6UmvhdtzqVEwQLI0am3wpG/wKpmXR5j1pJiNLPnxA+0WlZN7zEPcfYh1aFD
 ixCRjty6zLgr5S0RTCkE9FRTKsMPAbTlJkA2lQzRtkiHF/SlfREOWh6bqYaqZe3fLc1s1G3Czub
 vlwsWNmysi10XrAC7MM0OHaVMpBTtpWmxcrEq5NjkeRD1gWmlIjirGtQbU1zF6iVN669eoKKo/j
 MWeEGbXIjGzh+zuHzYww9qaJaKoXu2s6qQJIIX6DmPabc5/RlI1uTBTOY0vfk6y8xrCJgnQcHn4
 XLGPlxS5yf6TwmsQcUHBSpyThS005M377VEo0VHoav0yyTpZ/YiyFiCJJ8e/QxRaFAjybervz20
 wIlBG7YXXGFlzEGvFL+3w==
X-Received: by 2002:a05:600c:8590:b0:489:1f3e:5f6f with SMTP id
 5b1f17b1804b1-48a98636c00mr95678385e9.12.1777875780935; 
 Sun, 03 May 2026 23:23:00 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81b99127sm297500385e9.0.2026.05.03.23.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 23:23:00 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>
Date: Mon,  4 May 2026 07:22:57 +0100
Message-ID: <20260504062257.77460-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 22:41:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777875781; x=1778480581; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SsKY674gEcmVloxh8QcPPtKruXs8CJmiJS+7itrX6N0=;
 b=J3Zo3Z8NAL5K1VSV8VFHdAtvOr/b886p1ho0ETqdU3E6EyLbLTDfBLRe6ipQI3dGJ+
 GG6ufyBbwRcDhnCdju0UjL3gvHRXo+oMcnxBSPsNVO+K9ju5PZ66/OykklmW69CvLJqh
 gZGFxH0VVqpKW1B4JFrtnKxYX2p0Xa/RXQV7LhxYdaEq8DQavP59tGJb5dKZLCSzBc0s
 V3o89OpW5W9OPamYL9G72HNqiSx67NGWlXKCCXI5QniNFYPa7YSztx9dMnMLixt4CUNw
 MSyCNw+mwKzTj+iQ70/au80c3Ehw5LFl3YWeeh+jgtlBdgEjnpTWA4kiZ64QI456GfNc
 Rqqg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=J3Zo3Z8N
Subject: [Intel-wired-lan] [PATCH] ixgbe: E610: do not fill EEE
 lp_advertised from local PHY caps
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

ixgbe_get_eee_e610() fills kedata->lp_advertised from pcaps.eee_cap
returned by ixgbe_aci_get_phy_caps() with IXGBE_ACI_REPORT_ACTIVE_CFG.
That report mode (and the other IXGBE_ACI_REPORT_* modes) describe the
local PHY only, not the link partner. The X550 path uses a separate
FW_PHY_ACT_UD_2 activity for partner data; the E610 ACI has no
equivalent.

Leave lp_advertised zeroed via the existing linkmode_zero() and drop
the now-unused ixgbe_eee_cap_map[]. eee_active/eee_enabled are
unaffected (sourced from link.eee_status).

Fixes: b61dbdeff3a9 ("ixgbe: E610: add EEE support")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 6990fe53f049..36e43b5e88d1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3558,17 +3558,6 @@ static const struct {
 	{ FW_PHY_ACT_UD_2_10G_KR_EEE, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
 };
 
-static const struct {
-	u16 eee_cap_bit;
-	u32 link_mode;
-} ixgbe_eee_cap_map[] = {
-	{ IXGBE_ACI_PHY_EEE_EN_100BASE_TX, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_1000BASE_T, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_10GBASE_T, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_5GBASE_T, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
-	{ IXGBE_ACI_PHY_EEE_EN_2_5GBASE_T, ETHTOOL_LINK_MODE_2500baseT_Full_BIT },
-};
-
 static int ixgbe_validate_keee(struct net_device *netdev,
 			       struct ethtool_keee *keee_requested)
 {
@@ -3645,7 +3634,6 @@ static int ixgbe_get_eee_e610(struct net_device *netdev,
 	struct ixgbe_aci_cmd_get_phy_caps_data pcaps;
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct ixgbe_link_status link;
-	u16 eee_cap;
 	int err;
 
 	linkmode_zero(kedata->lp_advertised);
@@ -3670,14 +3658,6 @@ static int ixgbe_get_eee_e610(struct net_device *netdev,
 	if (kedata->eee_enabled)
 		kedata->tx_lpi_timer = le16_to_cpu(pcaps.eee_entry_delay);
 
-	eee_cap = le16_to_cpu(pcaps.eee_cap);
-
-	for (int i = 0; i < ARRAY_SIZE(ixgbe_eee_cap_map); i++) {
-		if (eee_cap & ixgbe_eee_cap_map[i].eee_cap_bit)
-			linkmode_set_bit(ixgbe_eee_cap_map[i].link_mode,
-					 kedata->lp_advertised);
-	}
-
 	for (int i = 0; i < ARRAY_SIZE(ixgbe_ls_map); i++) {
 		if (hw->phy.eee_speeds_supported &
 		    ixgbe_ls_map[i].mac_speed)
-- 
2.53.0

