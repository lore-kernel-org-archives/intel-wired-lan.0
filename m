Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1103FC9831E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 00:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A607340580;
	Fri, 25 Sep 2026 00:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CWkRNkVZR7QZ; Fri, 25 Sep 2026 00:34:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F229440581
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790296489;
	b=bN9rTsGiD5l4usMn98/UcZj5lqT3iuG1XlauHCoX5j8d4Tx51J16En8SfyZEHlzkGExI
	 WWG10u6YoXnPQCOFFNwEDQmOm64X7XY2ej9iCERivvn5fEbHmwLcjxig/U8YM0fBKxE3H
	 6psVw620XP4oK7+eMhcuAtLeT428S4G6fvbGE7UM5uV2rGBXmze/oLMaOPh2PKPvJwE4+
	 MBRko3ruTKAr04N9b70XFD51RFsd25op37Sh61HVvzOp6zX7kQoA4BeMUzv0O7MkxFI6H
	 coD0KfvGQj7A33j66SMwFBXAFoLh3rNWTGo8m3bGs3RVNRzG66JDh/y1VKVeoMwXD0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790296489;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N0BCZSjIX+UY6/4hcfUjcg/hMZ34STcp2U1v/I0YunY=;
	b=qgdNipQwUi503C6yeiwHhKKy1BnHesrns/JYnCK6FuyKzJ4Hsb8RTeP7Bkqy11cK+dJW
	 2PN6ksDXPGGvvhIzjSu8/HTwjCj6Z+oCloVqu5KSrrIkBQM5NNXsaRfDpFeFVjVLGVgfP
	 sOX9fLKRQt7KhaDzU1S2E72soAInYGWstsc+2hIJWbS0ZTf2e5dcKeIMbGhY5rqZIrQ9D
	 DskpX6ZEMD7yA8i6WlHw2pQ2QwVYeCrVEHDAex+n9mMPX1y21ZoobPGM/AKdzTUuYYOi1
	 BAzwPjqnB9fMS+gIs1+4qkRMQ0X8Q+gNkHAqRjn0q0tkpTtG7ziC97K+kXD98o5QZDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790296489;
	bh=N0BCZSjIX+UY6/4hcfUjcg/hMZ34STcp2U1v/I0YunY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pO2qu72uXT0UCXVS94+h4zzwzEu4OxDQrEjU7canKSnxc2KSalvpHSYkE4rZBNiA4
	 nksrAVISRjw9+w0IslAF7X/eTPLNax2iaA7m2/DRJa3aRfFiTipvM9EtQ/LLOphBjB
	 IjURNr0VgMSNq/rvg6+04FrsXMPunzKmFOvgU+2QodrZPRlyg+ujFxbALgLcus0qif
	 qTfFM7hiSlV18B/eXYdndGbgaBKBCtucG9Ay8MioaTEVMd5cLiUaZoDc3hEtw7hvfl
	 ZpKixYChd7iQGHT3tNWR2zBwX8TTw67i0V93C13Swwau2+ld4/kmKIbOnHynmWw5Re
	 g7Z7tWOTusvIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F229440581;
	Fri, 25 Sep 2026 00:34:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C3911329
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 23:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B557881118
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 23:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dQlIezGGmf7V for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 23:23:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1851E81114
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790292238;
 b=r9Hs5WPWtWdyJQ2Mh3n3pbq3TjBpBadaPrSOR8HVzTiQSfZzjTz7CZrlutAcTWAtdPnB
 eNgFKPOf5PAhH6bAWVqokdaOvD9OCk0alsta6pPX4cAAbF83HRM+Y1Lr2sXnt/G2BlNpv
 T9KjeEVaH32rr7c+0EavSpo8MKzafJlD+U0JE+gVRx3Y5EboyovbGSfllWOTTLcoOYu6Y
 nZGiU9p/g1OCdlg7LsPaEyM+saz+gAr9ILMBUNuj46KiRbQhwmMudA5Tw3jNUOH5cjzIg
 CLWcv+dcompKcPnSfZtV5cJojOJt/CjzfjgbrU5KycyjCbKmFIu8EbWafwjkDN5fRWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790292238;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=N0BCZSjIX+UY6/4hcfUjcg/hMZ34STcp2U1v/I0YunY=;
 b=ZVTz6ypX1kAuifDcBlGo09zByVV5r9EHozPbsbDPagJJjx4V8h6aHtXkbDc3P68CLa5t
 y9sY/c1FEMFNopgPXZ9Aa8cqGpt7CdsFCzCK6RnbaQcwvFb6VKqDp3l2puRP0hr0XPv3s
 OUtlVkGBBcFqVEeZaZ3nwicUY9wGvozGR1z79B2rzjW0fzlLta90alIQQH/YwhquGTgjm
 h0xUHFMBbBOLNbEIlz4TgbYaOVc77bfB9g1fH7UOI3ptr8+B9nZZ54tfVJ1phVrSZxIBf
 mQJJOaEl7WRcVmae2ejmQRffAu3cg7/nLQJvjmCp9VK5WefKoGThcn7Vx9b/I1QDZeg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=k6yWWxA7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com;
 envelope-from=ayush37735@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=k6yWWxA7
Received: from mail-dy2-x10.google.com (mail-dy2-x10.google.com
 [IPv6:2607:f8b0:4864:36::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1851E81114
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 23:23:56 +0000 (UTC)
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664e061cso269983eec.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790292236; x=1790897036; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N0BCZSjIX+UY6/4hcfUjcg/hMZ34STcp2U1v/I0YunY=;
 b=k6yWWxA77/+4UKHbcNB9h1knfxtkq/7fFcsDjckirCGKZmMeS9AP1FH2qFIa5h6quS
 XhPaoxkvbCyTK0vPJrJimC78hXAuou6J5xASFy10j/ZrBj/YgSK5peNxDMHOocscwu/u
 oAHDt81NyMafiyBtv5oiQJIAJdJ+9KydVS9hrHM8XFmPHrHOXTNVf7we+E8RDP98D1L/
 CtqIqUVPoJMp24I8oRjCwDVkNtRYrcQB/gAQlveyUBuF0pnDOTuaype916daINS6ZLXE
 FYb6gtxLMZS/Z9SL4B3QlQap17vAb4iuo/t03PYeHE7gMieHnBQbRMi2vXV7kdk2XhXa
 NdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790292236; x=1790897036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N0BCZSjIX+UY6/4hcfUjcg/hMZ34STcp2U1v/I0YunY=;
 b=brOtIrSnXCfHyqQdn5tmB2h6jKKWkEZp/1Zwjl+BFiouNz0OfgUaKIplw017A62vAL
 mh1F84/LXjlFwqvB9VlPVV6FYD0PfeBvH2QJx9VdOUTbfIyziy29b8Mp1r8V3aChU2JM
 LHkyjPN7IdovUbCEKqBb6grCtppD4YvNNDaF+K1cwetYQTvMca5cRBA6Jk8AwmD1lpLZ
 Lq6/Q+MpSjKkqeZgWSRdxE7ufZPJgSWqvwcBYzaZ7LoUAzxGfHdk0BeNzrZOLSNUb2LD
 3R4CYmCtwXcvFBZQw/bXG9aqHzBl7fkN8oAbtVxZzF9wZ4bZEtHkphrQK+01iZaWLi7G
 FSDQ==
X-Gm-Message-State: AFuF++nqjPWNMFMSq4qcp/0JJKj714ZjbrLbre6vzs1YzXy/8hXKsxJ9
 ZEeiCActhi+PIJWL2q7T4B7tsmRXJVRlLlxs7cVjkqf4dTN0dTnlLcPP
X-Gm-Gg: AYBFou3lS177ieACdBvB4PcckRPDzumMnkUgtz8fAzmafHqHUqxmcc2JwSx5srsMTCE
 eLK1HxdOmeF3IG6tMZWcstTgSzQG4XmPpTyMQWcWDeR59p/Txq9g4H/zJAn0aN1VhfJDDH1EP2p
 Epg70dmk1aHAMrKyBM4eLnrpvJkfl2KhZYifh/VjTxXijOleSLwjzH0cr1gZnYO20ABP6ZAVyVV
 BnJiCIt+PMgFtE2Ct4pDpkyr/f4q2iyHJjDBBfxwFuIiOV24MLXeUtiVunW6erG9Akl9F/Q0IyZ
 lYqBnHS02Dx+uQif8d9xWCJacn8OVvHRQKB2BQ6+Z4y/ZluimSp18U+AxqCQErG1Q2bjcvACJXN
 Xud0JjuB3QthvtQ2CbCrcoAEGGYBLzBpU+3tt5bD4LQqImXnh8UJ2l82GeKvZSrnFQ4fDX3liJP
 QZ1v9CtXA7bX8tHQKq4Crl9aR3E5BGg+7qsd+BvZo7VoreFgg89hebMJsaIiM=
X-Received: by 2002:a05:693c:87d5:20b0:33b:bfb7:31cc with SMTP id
 5a478bee46e88-34001f1961emr3645480eec.16.1790292235455; 
 Thu, 24 Sep 2026 16:23:55 -0700 (PDT)
Received: from evangelion-g ([2a09:bac5:40e1:11cd::1c6:c])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144757263sm1516795eec.12.2026.09.24.16.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 16:23:54 -0700 (PDT)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Brigham Campbell <me@brighamcampbell.com>,
 linux-kernel-mentees@lists.linux.dev,
 Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH] ice: dpll: fix kernel-doc parameter descriptions
Date: Fri, 25 Sep 2026 04:51:38 +0530
Message-ID: <20260924232138.69492-1-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 00:34:48 +0000
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

Remove stale @count and @cgu parameter descriptions from
ice_dpll_init_fwnode_pins() and ice_dpll_init_pins_e825().

Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 85a74cd6ea1f..d00a2fb683d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3919,7 +3919,6 @@ ice_dpll_init_fwnode_pin(struct ice_dpll_pin *pin, const char *name)
  * @pf: board private structure
  * @pins: pointer to pins array
  * @start_idx: starting index for pins
- * @count: number of pins to initialize
  *
  * Initialize input pins for E825 RCLK support. The parent pins (rclk0, rclk1)
  * are expected to be defined by the system firmware (ACPI). This function
@@ -4025,7 +4024,6 @@ static int ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
 /**
  * ice_dpll_init_pins_e825 - init pins and register pins with a dplls
  * @pf: board private structure
- * @cgu: if cgu is present and controlled by this NIC
  *
  * Initialize directly connected pf's pins within pf's dplls in a Linux dpll
  * subsystem.
-- 
2.53.0

