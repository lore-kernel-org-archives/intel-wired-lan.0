Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49B2C5AD4E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 08:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F1E4605D0;
	Mon, 10 Aug 2026 08:34:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KQq3sMwEmE73; Mon, 10 Aug 2026 08:34:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F5236067B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786350861;
	bh=wx/dR5BeT9JtgYuBtWLK4gYFoR3mxTUHjHYo0mlT1ww=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rOCn6OS4DbhdhlxWMTk779i9SZi8bRoopz03ZnVMH7cOFppClW0SgGb2zC4wz45Nm
	 ZotsQjiMFpo3jStLBHJKw3nc2TR7fBbq8K8ogtUAX/Cx9jHdNa1WbWGd58pljFMVkW
	 jMfhMTCS14CF5S1WZzHDa607EQT1YeSIlKDB2sGbDQRCTJHQkIn3LSHaYxhPl+Be2R
	 Tc0dNR+g8Z57Sj+bptZeRpsjSQ4H+g47g7UTMCVuxZAKvoacYDUCYrYpNsk23tTSOh
	 F6qzM314kxIpZn+JlcCuzoF9wqQPr7SU42nz8i5yIjNFgpwlx6gnnYrEOBfBdCnS0P
	 zbYNBd3LeY1HQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F5236067B;
	Mon, 10 Aug 2026 08:34:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E27E5282
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 08:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D44CC6067B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 08:34:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4aknWuqyP5bi for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 08:34:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=pavankumaryalagada@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D106C605D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D106C605D0
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D106C605D0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 08:34:19 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so1222719a12.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 01:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786350859; x=1786955659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wx/dR5BeT9JtgYuBtWLK4gYFoR3mxTUHjHYo0mlT1ww=;
 b=qaj2IagsPjNBnpffCm4DjUicC/9TcocG1L0IOKpDhMtxpLBifjBdbf6Tia++loC+Oi
 jpPtIrpjxkxJumVVQR7+lOGoo3S+zxiLa+ow3FH50+3l+sU9TyH/cSFyOHSwMLrhfBy2
 Jl7TZSpWGkIdVv7KOFlLbBIniMiunOWdeR+FFi/gzc0hP+zsXljfLzc47+fJqQdp9Uzw
 4sHtjYJSyq6uWyeuwlMFSxZekDdkla+28M2+2eVoecUEXEmXngqo6aNa2OrAIFCiyCwz
 Jov9xEGILeUW1K4wqbS6yoe2rGMPlDr72mH18TpUxfVGsmvN1Hkc0TzWxQnZ9oHeGq+T
 ejiA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNP0MUdEvF0NUerdqblukwLK/md07YWXm9B+WVDmfZHn/B6g3rXxUdjBO6YWC5BHBlFfe5yKQ6M0qLuvDFt8w=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzQTgyhHNEE+Paf54HRwEl4GRLR72fZk0Q2++ku/5wVVoLhG3yr
 ogU4MvHw/OX03Wsrr+a64Cf0pbs7Gtu2Q6slkmvrWbnOCywkbfGNgPLw
X-Gm-Gg: AR+sD102hg5X+mXeXgw/rzZqGopn740a+2lnO6NLdKhvsj/aJssXLR6F96ZAr6KCCFP
 DJLZswz2Gq4PN0EoQf/DTA7Xd13y8M/xotscTvLgvKgVcTTIgYmdI3KR4ovi068MyF33Bd4EIuU
 xAyomOtOkrFto12NiVPtbiNX01WJorCto/w1C6PaH88A7DZxv2F+15GU0rSa2XNwx6U1vEE2XRS
 EWleZZKA8ODkEstomAU11MIify3Tj+BccXbyizxybb7wydoqMZhQXpyWsqtNVV8nVj8XFdhwe7v
 3Efa11gytcyyBJYJrZtUTB7ebDA1/Zqm1fWLOFRhpojitLUHp5msNk+EagREbrM0M348MDRkGpA
 gPaSh8ERPy6NyK08/+IvhXFGHFLVqYNApGjGMc+UBtzkrWlY5kfPL+MaLCPwhxt+2d4oUeKa1ZA
 V7qM6R+DzqmrXHaPcynKAWgn7yj69vUibntssUa8uhEeQpCs/NJPJYJMNjACejmyZSOKpa
X-Received: by 2002:a05:6a21:485:b0:3c4:3b16:2979 with SMTP id
 adf61e73a8af0-3cb85f0397fmr51639254637.30.1786350859021; 
 Mon, 10 Aug 2026 01:34:19 -0700 (PDT)
Received: from user.. ([2405:201:c052:b00b:9a9f:f6f8:5800:36c0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bebee8d0sm38776661eec.24.2026.08.10.01.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 01:34:18 -0700 (PDT)
From: pavankumaryalagada@gmail.com
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com,
 Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
Date: Mon, 10 Aug 2026 14:03:55 +0530
Message-ID: <20260810083355.21631-1-pavankumaryalagada@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786350859; x=1786955659; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wx/dR5BeT9JtgYuBtWLK4gYFoR3mxTUHjHYo0mlT1ww=;
 b=su2T1BVsNK6kqZY7PnmhbjiKuVUL+zHjXuKC1lrZkxQXk0HQ5C/NES/tcgjCFaJOMD
 /UxgVVRZMOp61fe0Jq30SNLjMgYl84yMWFPxILvbsMZYMvKyLq5W6f/+L4iS0RIKL8aq
 lw7rJjHgIsbSIWRUsdGJYj4jft0VMUmehIkCpo+vO3wFVboSNBy+vSMsEpTy3F0Vk3l9
 khYFqhgHq0PGGc2hMbGHoDrWMUmaMhl2WhqEIzbudCAzd9bJT6RAS3YSp7c6HHjnpNza
 mzEc+u5JTwbJpM6NweMevpvOD7DuwjKOsGHQ7g1Gl1R5fUfQeHKSX9V+JKbnIWtktsGy
 J+Nw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=su2T1BVs
Subject: [Intel-wired-lan] [PATCH v2] e100: prevent shift-out-of-bounds in
 e100_eeprom_load()
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

From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>

When reading the EEPROM address length, e100_eeprom_read() can return
an invalid length (0 or >= 16). Passing an invalid addr_len to bit-shift
operations causes a shift out-of-bounds, triggering a kernel panic or
UBSAN warning.

Validate addr_len after reading it from EEPROM in both
e100_eeprom_load() and e100_eeprom_save(), and return -EIO if the value
is out of bounds.

Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
---
Tested in QEMU using syzbot c reproducer.

v2:
- Return -EIO instead of -EINVAL for an invalid EEPROM address length.
- Validate addr_len in e100_eeprom_save() as well.
- Drop the unnecessary 1U change in the shift.
- Update the commit message.

v1:
https://lore.kernel.org/all/20260807145626.52692-1-pavankumaryalagada@gmail.com/T/
---
 drivers/net/ethernet/intel/e100.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 1de5cd41ea0c..464dc2d6cdb5 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -775,10 +775,10 @@ static int e100_eeprom_load(struct nic *nic)
 		netif_err(nic, probe, nic->netdev,
 			"Invalid EEPROM address length %u\n",
 			addr_len);
-		return -EINVAL;
+		return -EIO;
 	}
 
-	nic->eeprom_wc = 1U << addr_len;
+	nic->eeprom_wc = 1 << addr_len;
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
 		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
@@ -804,6 +804,14 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16 count)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
+
+	if (!addr_len || addr_len >= 16) {
+		netif_err(nic, probe, nic->netdev,
+			"Invalid EEPROM address length %u\n",
+			addr_len);
+		return -EIO;
+	}
+
 	nic->eeprom_wc = 1 << addr_len;
 
 	if (start + count >= nic->eeprom_wc)
-- 
2.43.0

