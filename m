Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757CDC88E41
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 15:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23D614083C;
	Thu, 10 Sep 2026 15:49:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NJuoxF5yBaKq; Thu, 10 Sep 2026 15:49:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 79A5A40A4C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789055380;
	b=Dl2ZWz7evcHQLG3c6j30wWgzc2qSdf9htiIkOejWOVByycOTNQu+EdngZPjFZjsWfiwz
	 BNRuiEA3SRrBT2rsne8e4MsYYdiDCxhIUiGe6JEFUvWOgkFoNhe5kTEMpoVIcnHMNcRsn
	 ecyJazsSRHUli6kD34Y6llSXqXeFyFS41pxB/HByr0pUtg7+CIfZuDhX/NCHDMQzJYsHR
	 mTK93/Xv1otfM+UfZ8fTaQ5Bdtn93vT+J9VwawI7nMReAuwPAPyZw/2SRwzdHJk0+ln1F
	 Kb9LIzdzt92ou6fFG6yuvsxes/CX/gEqNVAI8MvpFBnFnexIz+hAm7fM7WTxGHDUllg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789055380;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-C2ProcessedOrg:
	 Content-Transfer-Encoding:X-TBoneOriginalFrom:X-TBoneOriginalTo:
	 X-TBoneOriginalCC:X-TBoneDomainSigned:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HYc1GkjMkoO0IwSEGcDUPrpgIzT7TfqZnoypA7FbSqQ=;
	b=RJ3ikS9XJVAbFgBHxa9KxncE90V2TYyV9mWVKJsbN97f+BNdoWlrMJ0A5wwJ5F1P7pF/
	 1nutoJe2arF0RF/H4BBhY4lMAFY1tZ28Ct3U0z9vVHz41rFe1jiL6/m/vF1fAeLbLxWcb
	 k9oRvfSwcEOjHNxldlHoITwrLoyzeZ4ifNMTfhBW/u6l8ATFTbS1gxLdy03Y3ROaJy6xD
	 jk2iCYHvwPSiejsN++PX+bHL8A4FM19VvNfyO5mcU8SbUkzxLyEEKkrFm+mgy0Ujx8DOE
	 OkMcZuGdwXl0WcfHIp1sAXGz+6NbEW9bLQqfcwD55id08VwPX4o7hQkB1xHpHLxY54A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789055380;
	bh=HYc1GkjMkoO0IwSEGcDUPrpgIzT7TfqZnoypA7FbSqQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jRQgRv/62JXutUI3p72G5vuGYfpOLiUaBm3AzEsKacnCY1GNWCY9N2uleOfXfK4cj
	 Zjcz5snxg2rlfsJvyLFevX6NUC41oVTNSETv/djO/F0vfI3PU7MVeg1ww290SASRgy
	 K9PpIPdVYFf+fApMTHmqalwdU2gYelPwS8VYaIy39UFffufBiM0OL3upOc+S143gUQ
	 RAOs310H+5LnNirJoNPIoc5LUWPBkWZ5qDlkjrLfY1cORXwirz14EBsrnXqsOoL3Zi
	 B0EeiNu8ERm3qItQMRHtqSxhEOL3tG13QUdEPinsYEbuCSv0Y6gy+syqPoLUsO7MtH
	 tIQyoFV8MxIMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79A5A40A4C;
	Thu, 10 Sep 2026 15:49:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 94E1543F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 11:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B41B40024
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 11:41:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jnADOaY_3ciT for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 11:41:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3D38D4006B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.228.58.149
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789040462;
 b=iRpUynd7c/Jpu0IUjp4GQuTjFFIU2sl+9O6QSANKTWKZuzSNlQq5pYP30umwTZuq6XpW
 ymBhL2S8JZm2zF3cJqZUG1R0OI87nS5kjOtqUu5XvmjoZueI+Av1UFgGhps7LRVEGZrba
 idv2SewEozsXxHj3crcAzRs29CqlpR+mdfg3w5NqfdOvb66bL/AT0e6ubWL3osTG0Z43V
 pvs6gNmKIGxek0ukdlBmZ3lJ4HAjfYmFmS40uALrc1MQ3pg4P/P7aJV0y1aUB62PpHnEj
 BhDQ7ra+KG/Pu4n4gzcvSD6g3/31NwHU7Uz8ASZSdwIkerbRN9GCro9L/itAhMIjbow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789040462;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:Received:Received:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-C2ProcessedOrg:
 Content-Transfer-Encoding:X-TBoneOriginalFrom:X-TBoneOriginalTo:
 X-TBoneOriginalCC:X-TBoneDomainSigned;
 bh=HYc1GkjMkoO0IwSEGcDUPrpgIzT7TfqZnoypA7FbSqQ=;
 b=YwIpmPAtd7wJprntQ2HzZsw7ucn1HjK6rGQmWsd0oCZ816+f8MiHkwP+Mrb3b8H1QRe/
 3hvlKe37YlIGgkhZ/ZMvue5S7HJdTrclb4iCnYVZA/kc4mqhdYUlMiiZhVb77b74XrHe6
 M4AJtRz1ViMpNpBNZw8EaEHK8L5e8rBbBVgzHIRxBBblRi7W0TFo015Fj+aV04NLYDcwX
 iXyqghBKp4+AS6yVD4WB69onCQ+YAjVdD4pWbCr75+jb60Z1UW8NAwN0dcVKYaYoPNddR
 RvmBWa3LyETv/q2dGEcgKJxdtWEZY6Q/ToKq7vUkBcBK2dlMbVxnsKIimAeOTnzHUzw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=dspace.de; 
 dkim=pass header.d=dspace.de header.i=@dspace.de header.a=rsa-sha256
 header.s=dkim1 header.b=J0XaVTy+; 
 arc=none smtp.remote-ip=80.228.58.149
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.228.58.149;
 helo=mail.dspace.de; envelope-from=prvs=706d339fd=pkneuper@dspace.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=dspace.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de
 header.a=rsa-sha256 header.s=dkim1 header.b=J0XaVTy+
Received: from mail.dspace.de (mail2.dspace.de [80.228.58.149])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D38D4006B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 11:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dspace.de; i=@dspace.de; q=dns/txt; s=dkim1; t=1789040461;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HYc1GkjMkoO0IwSEGcDUPrpgIzT7TfqZnoypA7FbSqQ=;
 b=J0XaVTy+MsXZR+c2gMAiDw8cBX6ROSkQ7TRiX3+YMoBkriztIyOsm2M8
 w+HTrq8HzlhkHzOR+gVu1EU6bKZMysWq0gej1JRHk2HIPBz+64U0F/Y0D
 5jx6v7iojdqXUw9b1jFOMvntC8MI82KpbIWDff4jF/UKniJm9A88uWQke Q=;
X-CSE-ConnectionGUID: hHALKpIESwy/OraNpp4jyg==
X-CSE-MsgGUID: wf3VMeShRv6nmsXOAm5CQw==
X-IronPort-AV: E=Sophos;i="6.27,95,1787004000"; 
   d="scan'208";a="5467930"
Received: from unknown (HELO Z1-1000) ([10.1.1.222])
 by mail.dspace.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 10 Sep 2026 13:39:55 +0200
Received: from VM-Z1-1000-LIVE.dspace.de (localhost [127.0.0.1])
 by Z1-1000 (Postfix) with ESMTP id AF51E60037;
 Thu, 10 Sep 2026 13:39:55 +0200 (CEST)
Received: from exchange.dspace.de (EX-DE-PAD-SE.dspace.de [10.100.196.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by Z1-1000 (Postfix) with ESMTPS id A195560036;
 Thu, 10 Sep 2026 13:39:55 +0200 (CEST)
Received: from PascalKW11-NB.dspace.de (10.71.5.241) by EX-DE-PAD-SE.dspace.de
 (10.100.196.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 10 Sep
 2026 13:39:55 +0200
From: Pascal Kneuper <PKneuper@dspace.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
CC: Daniel Baldin <dbaldin@dspace.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pascal Kneuper <PKneuper@dspace.de>
Subject: [PATCH net 2/2] igb: Quiesce the receive path before enabling i210
 Rx timestamping
Date: Thu, 10 Sep 2026 13:38:54 +0200 (CEST)
Message-ID: <20260910113854.13279-3-PKneuper@dspace.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910113854.13279-1-PKneuper@dspace.de>
References: <20260910113854.13279-1-PKneuper@dspace.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.5.241]
X-ClientProxiedBy: EX-DE-PAD-SE.dspace.de (10.100.196.14) To
 EX-DE-PAD-SE.dspace.de (10.100.196.14)
X-C2ProcessedOrg: 563f5800-21cf-4d8d-8aed-fddd1469e4ee
Content-Transfer-Encoding: quoted-printable
X-TBoneOriginalFrom: Pascal Kneuper <PKneuper@dspace.de>
X-TBoneOriginalTo: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
X-TBoneOriginalCC: Daniel Baldin <dbaldin@dspace.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pascal Kneuper <PKneuper@dspace.de>
X-TBoneDomainSigned: false
X-Mailman-Approved-At: Thu, 10 Sep 2026 15:49:37 +0000
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

Commit e57b8bdb4833 ("igb: Add 1588 support to I210/I211.") enables
per-packet Rx timestamping by setting RXPBS.CFG_TS_EN with Rx queues
running. On i210/i211, CFG_TS_EN makes the DMA engine prepend a 16-byte
timestamp header to every Rx packet buffer and sets RXDADV_STAT_TSIP in t=
he
Rx descriptor so igb_clean_rx_irq() strips it.

Setting CFG_TS_EN changes the buffer layout of already-armed descriptors.
Without a pipeline handshake, descriptor status and packet buffer layout
disagree for in-flight packets:

  header inserted, no TSIP -> unstripped, frame shifted 16 bytes right
  TSIP set, no header      -> 16 bytes stripped, buffer tail appended

In both cases the Ethernet header is corrupted, causing protocol demux to
drop the frame silently. Because igb_alloc_mapped_page() allocates pages
without __GFP_ZERO, the second case appends uninitialized memory.

This occurs reliably on i210/i211 under traffic when requesting hardware
timestamps at runtime, yielding corrupt frames on off-to-on transitions.

Fix by bracketing the CFG_TS_EN transition with igb_down() and igb_up()
when the interface is running, ensuring the bit is only toggled with Rx
queues stopped.

Fixes: e57b8bdb4833 ("igb: Add 1588 support to I210/I211.")
Signed-off-by: Pascal Kneuper <PKneuper@dspace.de>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ether=
net/intel/igb/igb_ptp.c
index 638d8242b66bb..4da26e997f92c 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1283,9 +1283,26 @@ int igb_ptp_hwtstamp_set(struct net_device *netdev=
,
 			 struct netlink_ext_ack *extack)
 {
 	struct igb_adapter *adapter =3D netdev_priv(netdev);
+	struct e1000_hw *hw =3D &adapter->hw;
+	bool quiesce =3D false;
 	int err;
=20
+	/* CFG_TS_EN changes the Rx buffer layout, so flipping it on a live
+	 * queue leaves the descriptor and the data disagreeing about the
+	 * 16 byte timestamp header for one window, mangling a frame.
+	 */
+	if ((hw->mac.type =3D=3D e1000_i210 || hw->mac.type =3D=3D e1000_i211) =
&&
+	    netif_running(netdev) &&
+	    !(rd32(E1000_RXPBS) & E1000_RXPBS_CFG_TS_EN)) {
+		quiesce =3D true;
+		igb_down(adapter);
+	}
+
 	err =3D igb_ptp_set_timestamp_mode(adapter, config);
+
+	if (quiesce)
+		igb_up(adapter);
+
 	if (err)
 		return err;
=20
--=20
2.47.3

