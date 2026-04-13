Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282DFE93804
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Apr 2026 00:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4AF542469;
	Mon, 13 Apr 2026 00:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VTd3TsHhU05x; Mon, 13 Apr 2026 00:04:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A701142468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776038640;
	bh=bLZ2hGvxy/AXXUxBlYW4a7XQvCB2LmyGHSGavvwLlRA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q0eElVWnGM4J3GnRY4qeDgU//QFQjqVR7KiXGTxKeWTmBuU/qtRaH6JvF2zmx5xx0
	 BtYgXLanlzn25F/i74yGkcnpH8/AdqLr1vwLysh4iWYcuI+46hNQbjp9B6W7GMQ1sg
	 C4F6cP6zfpTI5p84UH1ohtEUi2NSf4foSJHHf8QWlgBnNSoNaxQmpMrdYQKRmIvi0Z
	 MR+ds8G0cpIVhqkGYue1k26582qpV8tuz1CVFwMRBK0AN//1eBnGSH1nFhhaomZzIz
	 FySVeY0yii6QeV/nBESL7AHrvhwPyKNmc00MgF6pfN50Zqhcq9G9EkQb7AqBBznPLr
	 CoCJFZMgERNqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A701142468;
	Mon, 13 Apr 2026 00:04:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D558F237
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 00:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C6F90407A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 00:03:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FfbeK-UdGky9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Apr 2026 00:03:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 28CD0407A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28CD0407A1
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28CD0407A1
 for <intel-wired-lan@osuosl.org>; Mon, 13 Apr 2026 00:03:57 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2d868d014a5so536211eec.1
 for <intel-wired-lan@osuosl.org>; Sun, 12 Apr 2026 17:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776038637; x=1776643437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLZ2hGvxy/AXXUxBlYW4a7XQvCB2LmyGHSGavvwLlRA=;
 b=OFdimfm4O/W9vJrZqOMjnuJWFeVTp5958IJOZ3o8sCLumGnV6+7p0aRdqkEKJDTTuD
 BxENPUStqpYMPDDtJZl2vAH6EEj3FtCloNDSh41KE4a9TAo6sySSwubg/xqf7ekh5j4B
 2Ck229j9lnUnnU6r64iQ84EkVMy+UqZTKNmt48rVfccj0w3Q8r6skk2DquwZjY3pUsTI
 k6IhrFLPVpsEkLnxAP+tLJ1by5lTX5ybBBVSaKufI88n7umxC1kHT52gyI1hV2+73E1g
 3C2OJtugn/3znwviqeHNadC/Q888npWId2bzjgQwza5CkKIf+KTRoe5vVaPQQbqk+3O2
 Dxjg==
X-Gm-Message-State: AOJu0YzYc97whEREKRlhuL7hUoNZ18NvO8PlpRd/JipIpC10k4eTTnSm
 fWl5muUEqkCIaj5SeBaOG259UX5Ve2Tonwea5XSudJCrUE4P/aBHBiA01mbjWZLyYPg=
X-Gm-Gg: AeBDietp2jjH20qwUCV7z5ZTSoseghHba0s1mTUgpprvsalZeWNslQw6prArWiXhDnr
 pA/zeTlc6iBq+Wzsshvj97XcsQ8/g/6C4um7+sSM8zUI5s2FkcPPzPld3ulRYqIuuVPev1dGUFB
 NuX0RFSxK5N8K27XG1s/T3F+E76voaiOhv9861Hqzw9Uq6ZQUKvq+Sdsl2QXv7ZMG8C97VOsWZR
 NK1D63pMzBPKJ2HJevb9IyYFN1byteTCQ9s41SbYzG2xe1mt2UKK5xWehNUnZxA6PZeomO2WPOP
 3FK0TFUOsksou3Xc6yn008aPH/6rnEpHuHY9w9I/mQkKd2d55E6JhsJI/nWToCml4Pn3SkNUux+
 4bjjob/b6Zf5Y3njdon/d8v68zT12EXGSOACOY7XzC4qAg//WtVgvo4KFaR7aeo5JvKZaCA23F1
 GJEWo=
X-Received: by 2002:a05:7300:dc8b:b0:2d9:f0b3:1d98 with SMTP id
 5a478bee46e88-2d9f0b33952mr27219eec.7.1776038636511; 
 Sun, 12 Apr 2026 17:03:56 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:ba4::23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d561cd2a4esm18067085eec.16.2026.04.12.17.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 17:03:56 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@osuosl.org
Cc: Matt Vollrath <tactii@gmail.com>, stable@vger.kernel.org,
 Avigail Dahan <avigailx.dahan@intel.com>
Date: Sun, 12 Apr 2026 20:03:25 -0400
Message-ID: <20260413000325.33379-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776038637; x=1776643437; darn=osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bLZ2hGvxy/AXXUxBlYW4a7XQvCB2LmyGHSGavvwLlRA=;
 b=W/Pq9fcLEwQR5nVig2Ym0dv8nHZNt4reHMdi8YExfmiZiO4nQBeRSLwdllHwhas1e1
 JhsqB11+psJouU0s9BHBpE00FqRr6WGLsxai7k/7x+f4ZTiqz7r4r1KiNFkooR1qLTeD
 mVmScWw38ez8wZIGDBVkzLG5bnZmZqtPCQEHS6l5751shRb/XCN7nbGKRddBJ6xGb20t
 tkaoNYjZpl2f9qz4la4BDo+fHzOr7BwZ9EP1NyIcml/d1PpQzX5/15dkqqriPJ7DiuuO
 OT6hyI3vrHB67CQApK4o+XREf4SjJf7FIFzVxDCQEA/R7v+mTeb30PgNDwo31oSbQVaa
 h5jA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=W/Pq9fcL
Subject: [Intel-wired-lan] [PATCH iwl-net v2] e1000e: Unroll PTP in probe
 error handling
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

If probe fails after registering the PTP clock and its delayed work,
these resources must be released.

This was not an issue until a 2016 fix moved the e1000e_ptp_init() call
before the jump to err_register.

Fixes: aa524b66c5ef ("e1000e: don't modify SYSTIM registers during SIOCSHWTSTAMP ioctl")
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9befdacd6730..7ce0cc8ab8f4 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7706,6 +7706,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_register:
 	if (!(adapter->flags & FLAG_HAS_AMT))
 		e1000e_release_hw_control(adapter);
+	e1000e_ptp_remove(adapter);
 err_eeprom:
 	if (hw->phy.ops.check_reset_block && !hw->phy.ops.check_reset_block(hw))
 		e1000_phy_hw_reset(&adapter->hw);
-- 
2.43.0

Changes:
v2:
* Apply the correct Fixes tag
* Target iwl-net
* Cc stable

