Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95DCC79FBF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 15:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B461460B90;
	Thu, 10 Sep 2026 15:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id go_lMzZwhhVE; Thu, 10 Sep 2026 15:49:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9305160740
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789055379;
	b=qBnX0A9yc1IcRJFPG0oN1RStcTwwnz1C9KFwdpZ2oCKb/5d/J3lgzwneC5TzFyAOG57Z
	 fUci8R2aZKe8WaO5YFWF2xFeL4zR3yxtFnG4VIxA0BZdm3EEmfoyTk1lwYZierAA9K5d0
	 JwOObTEPctOOMeSmP1lIoynKHaZAyQAxHWiBvmq0EuhjmP3cFH1Pk2o5cveqPm5X5Bq02
	 9CfuRbFROxc6Xr3Fsk7udArf1Lx+cNzfPeWSSbDiJyVi5zfvRtKlYPdbxKhNwJ/1AKCLq
	 kzYFsTKA98MZHLrNojkB1R5A+WrdegYbwTX9lXfulL2lRFtAyQn1lBsIh54hhzY1eIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789055379;
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
	bh=cCdgCovM884FfdUWP8JorqJdxM/aXjJe2TbERbkQhls=;
	b=ZPW1AJogi+Azfh7cHRTvVvVbmmGotWhy6rCG2cPScHuO2f9SVpK+yG+9PsgHdUqxFRIn
	 xGF50rgncnx8Njr2ywyl+bu46WNz2E2NmOYRUCEp1s6+RxzDVNuCBLEHWwUTUwDPd8oE8
	 HaLQyV6n7zGdJPFoefAAsvbjfnI6u36X/9TmvgENXkKfd9CeqZBYyj2gPHRy1GNSNKRb1
	 r6fX28MtCd/WCAOYCdHLFA4IiqKjd+6I3yNEmvJflCQI88Ig0+BYYZb/p1na2IHxj9XEZ
	 JLrMZGA9IaHao/2h2FMjI8Bd8vVHtgFyzTaBiWPa70KF2aWiMi0j6OPy+JFe+UpRdnQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789055379;
	bh=cCdgCovM884FfdUWP8JorqJdxM/aXjJe2TbERbkQhls=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LJqtqh/9Cq/PgIAi79YxzzWbxFrLSX/Yo5TMqMJ6XXlil+N+ugFrTxGQgYPqvVllL
	 yZ9VLWIbTaf0b6dVavabQjZx9jr1uT+nP6ookOKQgcIw/NK3hDWP1q1BbLf894fc66
	 Acpms0d3Xz2ZIBRgyVlE2Gtu/g16KUhVhn8AF2p7gMZ/YNSnAC5dxpffcw/xvb+kwA
	 +P2BsAX5LsSalPI1cEMrKNoKY0lJW8Y0ZD16A5+5nPpKIRvziqAdMluNy8muXfooda
	 9izKp3zyY7tabgy7XGC4ZC3kkHzDBkKYA18pw/25+WYICSWfDbWZ0mAuZGjxckXkhA
	 r3OyTp1Gp2KMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9305160740;
	Thu, 10 Sep 2026 15:49:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 74FFD43F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 11:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B35F40073
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 11:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nroAeoEZXPQx for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 11:41:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EB07D40024
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.228.58.149
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789040460;
 b=dueho+/71oKIRt/5AycZJwfhGuTS/Wq+GRXQ7Cx+niUCtYPPBbSqD5O+wpI7eFgNTES9
 knF8sy6hGFSirQC2ij8eH+C8OAqfLQo2MPEVeBoY5R1F/HJNlcN/irOJ0a1HZlnJHWZB4
 7b+iNHrWW2hL5kEMO6q9qKGD0OYmz4aoXVMyfC5ZiBEmWnOgC/8dx9Y3kiUjNKh2qKkDc
 6SxsTkov8yLmwul2J4CT8G/lCzG9QON2+MLuagKiG4NcY+pHWpZcHiXPP5UjiDG0RIyJV
 O4p6mAQZRRr/5YLk0MVmu+GTBOeFJuT0UsGQBaTHLxdLPUaMV7nPmNFKxuVGoY2VdaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789040460;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:Received:Received:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-C2ProcessedOrg:
 Content-Transfer-Encoding:X-TBoneOriginalFrom:X-TBoneOriginalTo:
 X-TBoneOriginalCC:X-TBoneDomainSigned;
 bh=cCdgCovM884FfdUWP8JorqJdxM/aXjJe2TbERbkQhls=;
 b=s/oKKbEHFV7PxQqWUGYv67xHccXV3JADNef9VdJdu9HVHhMKZXZQBS9r0lc6RQDZk/i3
 l12EDSIN8plsUb7pf8zJbK+XCQfUU2wPZZTIDZTP6yvXk8+HSwjHgulraY60rtanYnakH
 kNmv6KtdQUB8S9wP1ld5/lBBY101VeLCXu6iwFrcoKe0hoTONK4NGLkjVwYlXBv/8lxkZ
 LTYdl3hdz3jP194Azuc2dZMxwlXNdsmfDGAKCrInX/6MNxFZ0aR2boD2Io62nBXeMLUhG
 /oLzzLqA9CIjRstkAlItg0heF8HdoENZwfdBts7zOa790mAIIA+IYRHXxOMvymi3dKg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=dspace.de; 
 dkim=pass header.d=dspace.de header.i=@dspace.de header.a=rsa-sha256
 header.s=dkim1 header.b=KVufQaYG; 
 arc=none smtp.remote-ip=80.228.58.149
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.228.58.149;
 helo=mail.dspace.de; envelope-from=prvs=706d339fd=pkneuper@dspace.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=dspace.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de
 header.a=rsa-sha256 header.s=dkim1 header.b=KVufQaYG
Received: from mail.dspace.de (mail2.dspace.de [80.228.58.149])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB07D40024
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dspace.de; i=@dspace.de; q=dns/txt; s=dkim1; t=1789040460;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cCdgCovM884FfdUWP8JorqJdxM/aXjJe2TbERbkQhls=;
 b=KVufQaYGJgc0wIPksy9O82NEs7s5p73jzB3ijeEyQFkinCWak2MNpKb/
 vcSsbj78w1IVSfXoK/caAJ7Q7xK6KaLPe2z8eEFHmFgpYF4EWK1S+i9vz
 FntpxjpapKaOUA7TXdRXDCLqEuqx8RsH3Vp3MR9LtRbsvfRMrCOUGZlA5 E=;
X-CSE-ConnectionGUID: RGGjoQFnRrSdIgTK5XABdQ==
X-CSE-MsgGUID: WQgWWFUlTiSxiE+/M71TNA==
X-IronPort-AV: E=Sophos;i="6.27,95,1787004000"; 
   d="scan'208";a="5467928"
Received: from unknown (HELO Z1-1000) ([10.1.1.222])
 by mail.dspace.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 10 Sep 2026 13:39:55 +0200
Received: from VM-Z1-1000-LIVE.dspace.de (localhost [127.0.0.1])
 by Z1-1000 (Postfix) with ESMTP id 7578960037;
 Thu, 10 Sep 2026 13:39:55 +0200 (CEST)
Received: from exchange.dspace.de (EX-DE-PAD-SE.dspace.de [10.100.196.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by Z1-1000 (Postfix) with ESMTPS id 6895260036;
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
Subject: [PATCH net 1/2] igb: Preserve RXPBS.CFG_TS_EN in igb_setup_tx_mode
Date: Thu, 10 Sep 2026 13:38:53 +0200 (CEST)
Message-ID: <20260910113854.13279-2-PKneuper@dspace.de>
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

Commit 05f9d3e1ae6e ("igb: Add support for CBS offload") restores the i21=
0
Rx packet buffer size with an unmasked write to RXPBS. Bit 31 of RXPBS is
CFG_TS_EN, which enables per-packet Rx timestamping. Writing the register
unconditionally clears this bit on every igb_up() (link down/up, MTU
change, or driver reset).

Like other drivers (igc, i40e, ice), igb intends timestamping settings to
persist across link changes: igb_reset() calls igb_ptp_reset() to re-appl=
y
tstamp_config and set CFG_TS_EN with queues stopped. igb_up() then clears
it immediately afterwards, undoing its own restore.

igb_ptp_hwtstamp_get() returns cached settings and never reads the
register, masking the fallback to software timestamps. On an i210, a link
flap increases PTP path delay from <1us to tens of microseconds.

Fix by masking the buffer size field, as the FQTSS branch already does.

Fixes: 05f9d3e1ae6e ("igb: Add support for CBS offload")
Signed-off-by: Pascal Kneuper <PKneuper@dspace.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
index d4a897a8c82c6..0f3c728a07fb1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1947,7 +1947,12 @@ static void igb_setup_tx_mode(struct igb_adapter *=
adapter)
 			igb_config_tx_modes(adapter, i);
 		}
 	} else {
-		wr32(E1000_RXPBS, I210_RXPBSIZE_DEFAULT);
+		/* Preserve RXPBS.CFG_TS_EN so Rx timestamping settings
+		 * persist across link changes.
+		 */
+		val =3D rd32(E1000_RXPBS) & E1000_RXPBS_CFG_TS_EN;
+		wr32(E1000_RXPBS, val | I210_RXPBSIZE_DEFAULT);
+
 		wr32(E1000_TXPBS, I210_TXPBSIZE_DEFAULT);
 		wr32(E1000_I210_DTXMXPKTSZ, I210_DTXMXPKTSZ_DEFAULT);
=20
--=20
2.47.3

