Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7475CC56205
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 17:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21E0640856;
	Thu,  6 Aug 2026 17:28:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVpfQnlmvIPF; Thu,  6 Aug 2026 17:28:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0036340859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786037301;
	bh=g5bdrOH9EQYp8+Y2KB755YBGfk5WlLVToWPGvUG6bgI=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BQtFdFMN0cfJNSytNPqFvyVfZKDlrnzhmPoSBp2I5NZmgNTdSCbnGXCI1tSm0xGpr
	 gUmL/792uGIsqwuI3S9k1eoCAC9aJ6BO9Wc0kGgR7RqnY8WJ6/igY2uc7TnLRxeknP
	 AxrhTzNl3yF70CFTEc3bow+YEv8ag5DZoLjf2ZVAMLKxm3fGn0KJ844sxDTXfF/omC
	 MpSUs4Qitw6Z8VuXgSwev8gAA6pVEtY9GmYm4zIsTu8WrqLzlwOwzBEMtnqf4BSRCi
	 FErB7Kir5BcBy1PcJshAmta7ucM+2YKenTZn6Ae0Bg0gKc908mEBVKsR9r6/mNGSRR
	 iewoZ9iXuywCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0036340859;
	Thu,  6 Aug 2026 17:28:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DF5B2B6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 17:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FB9D40857
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 17:25:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AYWBSjhu5oaj for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 17:25:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=skunkolee@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CED8F40856
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CED8F40856
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CED8F40856
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 17:25:38 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2020799a91.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 10:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037138; x=1786641938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g5bdrOH9EQYp8+Y2KB755YBGfk5WlLVToWPGvUG6bgI=;
 b=Y6gcrtwisjsoi4b3TAWl2mST55wyKeqT1inUld0xluRMgHQfbCucW9tZAZVwrjUo8G
 idAvfNxkpnXJlR+pdGwCii26V+fQ126YCVo1/CEIF8NznYqb6/1QOk588DYk/1ZUOYRB
 0i+YBnBQ9t4sBeFzlPbQD4IVIBs7lCy8IRQP4brdOX8PJZ6vniXf4Mu7V03nQ8ri50aD
 gtgU8IYcT1YChVpWQLhfHMROvmuKDtZfeLnS6Si16m+6L9xZZbthsrpgRJObJ9uHt5HV
 +7v8RnxqnKkt6SO+filWMRX6XEsfHhPvkCAlHik+WdRVfcL/T+YyVklJyyh4M2ImFlYZ
 0S3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrI+tLiYz0OBEOTHt2ijy2XAT2kIpBIgrRh9JI/CLnqee+lR0oIibpUUpf77tuWm1kOnmguVs26luPqDnz/jDs=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxE3Yl5NObEGl/g5MgI4AtzXqgKs1DZBy8aMRlAJChXd4vvK7hD
 kMKfldPXQe6HijRTqOQoavUVOFk5q9///7GVEH4t0t7/E0bahJJVxxaU
X-Gm-Gg: AR+sD11t74hmarSN5OIYPuhbYdjQQ8ZWxCACwAjZZGmEkM0mShE590KE1wuzM1ptEmF
 LzTVUMBDKvtOzuUd1t6w6Xo20VG0DvQvzO18Mce3kY/U21hXJFlP9WowtFBmYWQbJEuPuQxzCHg
 6G2Hgjeb8tFw4vjgarn82uDWI8rNCpcT5jWjUq1myezvm4mCh3Np8i6d9HiSji8D4JfXMOcZCsg
 bqqvInSlCTqwxxaPwe9YUUq+t9kaNIUNOjZdODCc8MQas9Qb7awHzAOIaX07LoMo5VydA0DgUDy
 UITQHDigwi0xOB69XhyLNG/tCChnitUoUOac0WMtorpY4WXkgWGoyQHPQlJ3IKtAuaGckC/b0CN
 LK4eZU/cZ5VPvcQ6MGvyKQN2M+P0O5Et8OicVDJAuOTHQIWREseKy318EZKVHuaRXRr+cge2ttW
 Ej6GdZtz4Z6jr5BZV4o43wgSRvHna2yOVf3jJ46LO3kVr5Gi/mHdItxhdt8SU0XmlPaknePXYed
 ZdjN+NDqsxkiFJJgYh6/i2IUuBAj6w63xWM1deH6FdIxKcMXolVYB+Xsc0t
X-Received: by 2002:a17:90b:524c:b0:38e:5ac1:9517 with SMTP id
 98e67ed59e1d1-3903c54b386mr15896123a91.3.1786037137831; 
 Thu, 06 Aug 2026 10:25:37 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::6868])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1389e3csm57948a91.2.2026.08.06.10.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:25:36 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ivy Lopez <skunkolee@gmail.com>
Date: Thu,  6 Aug 2026 11:24:52 -0600
Message-ID: <20260806172452.32139-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 17:28:20 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786037138; x=1786641938; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g5bdrOH9EQYp8+Y2KB755YBGfk5WlLVToWPGvUG6bgI=;
 b=sBaqsInBdUaBIjRmG0cd/W17N1qkD3xa4U5ppd94QdQjhsbtmDCIGQGrImltK02avZ
 cUBSsjS2UWFTjohJbLEwTlvi7574Pn/RFc/OKhd+pk25c4zCQUxFladXyr/9QqKhJCru
 jjhKZZPnQp6NPalal1LD/Qa0i8s1C2n+8Wxhmov4/Vbu8nRTMeaRkZOfX79jnQ+S4DBq
 MmL0G1RqGmx7fK7g7jfvcn3qQBVmYeE6SUeDPmsYt9ZQV3oqjj8916jDFDJPvC2emQs9
 9T1WvBTRFqRp1TxJJQ/hSNW7zG1LrBROWaiS0m4fcCEWH59BUnciS+ibJA83ZmlnxCCt
 t/RA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=sBaqsInB
Subject: [Intel-wired-lan] [PATCH] e1000e: fix incorrect modified flag check
 in e1000_read_nvm_spt()
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

e1000_read_nvm_spt() reads two adjacent 16-bit NVM words as one
32-bit dword for efficiency. When deciding whether to use the
shadow RAM value for the high word (data[i + 1]), it incorrectly
checks the "modified" flag of the low word (shadow_ram[offset + i])
instead of the high word's own flag (shadow_ram[offset + i + 1]).

This can cause silent NVM shadow RAM corruption:
 - if only the high word is marked modified, its pending write is
   lost and the stale flash value is returned instead
 - if only the low word is marked modified, the high word is
   incorrectly overwritten with the low word's shadow value

This function is used on all PCH chips from SPT onward (SPT, CNP,
TGP, ADP, MTP, etc). The bug has been present since the dword-read
optimization was introduced for these chips.

Note: this was found via code review while investigating a separate
reproducible packet loss issue on I219-LM (SPT+ PCH). Testing showed
this fix does not resolve that particular symptom, but the flag
check is still a genuine logic bug that can corrupt shadow RAM
contents and should be fixed regardless.

Fixes: 79849ebc0e06 ("e1000e: initial support for i219")
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index aa90e0ce8aca..87cd1cdc6f10 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -3473,7 +3473,7 @@ static s32 e1000_read_nvm_spt(struct e1000_hw *hw, u16 offset, u16 words,
 				    dev_spec->shadow_ram[offset + i].value;
 			else
 				data[i] = (u16)(dword & 0xFFFF);
-			if (dev_spec->shadow_ram[offset + i].modified)
+			if (dev_spec->shadow_ram[offset + i + 1].modified)
 				data[i + 1] =
 				    dev_spec->shadow_ram[offset + i + 1].value;
 			else
-- 
2.55.0

