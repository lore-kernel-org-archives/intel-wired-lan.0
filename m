Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8125DC98311
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 09:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27BB76067F;
	Thu, 24 Sep 2026 09:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6k17BfZlFpRs; Thu, 24 Sep 2026 09:52:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 36EA960699
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790243557;
	b=a7Xvhj9DgiTgXMe3ivTCgQcKVw9dE+0uukI1ZCMIZjmzPdYYGI3/6ynicSQJAr8kCccF
	 KPUhT9seqPYDo0tNtHb0SJzw1E9RkdBFIn8ZhMolj6NF2a/zexJuGlP1ibzHyD3TFw0xh
	 Agyfg9pfgMzI4sFSNaMBGGroUY2OJR3HdtRetPj6logYa1bJ45Y37iOCqdY/a3iHU6fy4
	 ow+11Ut5Zdi1me6OEJWTC492iREL/tROSXe8dufMp2rCkeD1MYCIlLYCEf7f0/jQ/hSZO
	 KNDylTbytWo9Q6W+RKdv5chyTMC6lHSZ6nZataeqfQZkiMjRw3tXSPuWzjQXm2x2MXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790243557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=r0he6qsbBj/Yqg6MIys9ZBccNQWdxa3bYyKVfyOnXUw=;
	b=Jl9J5Be7k5+5dCbvPICb+eLUPj6YqK1BmeDfJVFxpl9KpTMHtlMdB/KX9UXB4Li0QFDj
	 lQik8vrQhmQw9SCvQVaumXjw0FjDZdFN7uB4viRxKUEVjdtA7Sq90ri5iDGvJfmOzXqSk
	 0qz8wrjmL60g6wK2fwHCg4/D3VxIAkVWF7OV+qzjzr1hWg7XvaXWWXyYBE00hu1Q71X5m
	 d+PiCszkt+aLuL7y5ZB+I8fP9vrPNfQ1QtkGWUKAPsePHevbJYmpXU5BiEavc3rze58+N
	 KO64/G/fCMZje3DyQY+zA/kLbjrYj3DCZkkOHmELdlT/8R33iDC+OjkrOJ9Wbw7xL+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790243557;
	bh=r0he6qsbBj/Yqg6MIys9ZBccNQWdxa3bYyKVfyOnXUw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aqq+PDVkvUEqLKCHoVvwwlTcFj7bi+KsrdITZ1g3U+YjcdbFWAcRw/2lLKqh2LOgg
	 +lFFEkpCHjCJ5+yhX0cHy8ElJYRrVYdrCxOp4ch8v/O0UVtYdSryPjnAPfhjLJnLaJ
	 yP8igDrCYwN8G5n5iITp7u5P6S8lfu/YKazHpbPBAOPPFiy4XCuZKi7G0kJfhyircn
	 uMb9gJAmEOZmw1269PnXhhSKtCbsePx/IAZMdZLtqZwWoZln/CJL7eFGG3N7DS2y/u
	 ayIegAownbgc7viE95l5NX6he6Sa7Q+c69luduA+kn7R+AL+SwL82t2g+QRJGwhfxr
	 Xv0tBHGIl7JyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36EA960699;
	Thu, 24 Sep 2026 09:52:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BECFE392
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 09:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3A0A40C9E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 09:52:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j33SIE8Or_AI for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 09:52:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6F04740C99
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790243554;
 b=IJFg1Oz2TDWI4mT/gxsUoV2rksyeVtco0o3j/rySsFrcRRK8HnWt9xVOQupcPX+gyBCn
 sDzepC654ac3qRm3X53mzBx0cezHVZy85GpkKyG3qLT4PSLxzFZs7WhnZ7e2FzQI0zFwG
 zATJH3CPNsV5Iv/SYobsBJEPxjCDZm1zWaGgaPTqDs6gJv+wJF65MsHe0vr5DdplpL35l
 GAsZwpaIEgdAA3m8fvXcJU0dAFgt+9AJMcnL9+XYttrIbiQrJPTundC4ufAJ27rioReJI
 iukp4NxZqjO2AbFdCQabCMJ1idL9KmhvwBZ+n3jwyhQQnVBc+O5Xl1Sk6y8Ungte3Hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790243554;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=r0he6qsbBj/Yqg6MIys9ZBccNQWdxa3bYyKVfyOnXUw=;
 b=UNJIFbmtJG0i/ow+zLFmXKUR48aTAnrT9bP7GGE0tvepi+cIqiwfGN42SQP79u4ighcG
 RB86cyDv3cUBky0feP25VnUfB5+wN5CQTaWBv7KHMkW5qB5Jhqghv/MOt4t/HFN9jI3hs
 SookB6Y3z3sjBboB9dIpoXg7IBqAryG+c9mlL3NlO/sY2GgxYl8cNE+TTjvaByS+ofBMP
 +CEhjHYbgmJNieD6zHKqyJFWYdPBc1XLk7xCe5ewygV40mS+X+ilsaocbD1+o4+Os1svG
 uXpMg96M599FchswpAN9vnI6vYaN9fGzAPNCtElnzfVa2sq1N4bRNWdKzjUE3CTgkYQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eqdX+gXn; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=nsvatoslav515@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eqdX+gXn
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F04740C99
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 09:52:33 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aa06e51bc3so3095315a12.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790243552; x=1790848352; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r0he6qsbBj/Yqg6MIys9ZBccNQWdxa3bYyKVfyOnXUw=;
 b=eqdX+gXnB5xbFLr3gwOjBfzSsMNZTq19PjdiWkQ6WtgcL+8RQf8nWjrtKwptzryu42
 Jx65PH1OGocireWQLfaB7yqw1Nk8wxsvxxaFOU3PdeAFXHrQuTVlstNgUhc/XqULKNEG
 TQDloHn2h0jFtwosaaLFYVJDfpZFbW8gu5dx7Uq4bfDiMv4wY6U+m1OHScVkNuojBGbr
 IKnDGuXhSYxCxPEtuKeOEApmHqb+2keXMrVov0cD1IAUCyQHZCMnqna0XFVLLBB3PE5x
 Jd+6Ud4dd1JRh1hDQiGZ16vXpMtAhFcakI3OyWv/uPpBMHATIrEaHius5sUEM23JLftb
 /9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790243552; x=1790848352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r0he6qsbBj/Yqg6MIys9ZBccNQWdxa3bYyKVfyOnXUw=;
 b=pnyuKELKYUZfmmXilyXkAj4Pli+2XjaSOXuBg0NNzClpG3lp5VRegmAntgbOOLixxi
 yDoZoLJLi9tTNMZFAkGseWbs900c8EYDq+XfVxBp1hjfCQzEMRxz05sGGbbEHuJFQEea
 C2juBhW9TLpArDq+GKuCZKRFLT2Jqbjb+3MczoSBKxESrqTH8X1Jlao0WrIe78yYnKSy
 MOyVqDGwPt3T/vPf/SQtmQxMBdZ9qYKMPnjNRhhm9HVUiRZeCJATesyPReZ1b2TNCY/G
 ASb58PB5bSJht7DmrTaD7SFlLamz1MoehT+jinIhaonJO5F9V2eJ0BQD9GecTBRBcA3Y
 1Olg==
X-Gm-Message-State: AFuF++mgk6Z0gLpndC/zWRP4CWs4XoR0pTDzSRlZiLhTcw/3CtxhOjIk
 VoGu+7TQMLgxIT6elxv6MjtyQkEMsBrZbMZpVF3oe0NNmiDVf/6ADkpk
X-Gm-Gg: AYBFou1vA/9yGwDMvj76KmXDwD2PsSxnDWIMcwmjV8m9/6Uq5hBbm8xcvrpQrvoMD34
 ONQL8950SwuCidQZugmPy9Vlq8YjvoUlQY9s9u4241MDxe9EcfoqJu4teCbg1GD8BkErJu3QjBE
 LJfmjuNSBCCR/GvARaEGxNdWfCDh51W1R/e/pW0C0BRk9XcTlA2Yb67sxWPi/ZF/gNGlkG7/qmq
 gLpvOhK1++mZK2i9UGEpxpviFqkws9oj5Kp6Zeov7gEEBJLsq6+g1pwz8O/OSzTu4X1Gm5fO/ZA
 1aP45RWAZgh3+J5tWhVv7IsG3UFcbbeH432+DGL6Ty9YgQDVpoApC64fSa61jh+RVqJ/GBFEzfO
 8Vb+7zkogJzC7cod/QRbJl80HZDVt1cl+eeD0q5jimIwaqVcBEk/fLItdb94d2dkT5JBBUc6qdx
 jYbnR5RDsMSqE8JB2vwRmBC8QuE4xEAro0NznhuJzIRwrOHQ2v5132bYUjwdvnFB5NM+NtMvq06
 3Y2X0FgGC3IcC1v
X-Received: by 2002:a05:6402:4502:b0:6aa:1c28:81b6 with SMTP id
 4fb4d7f45d1cf-6aac8f546fdmr1573268a12.17.1790243551492; 
 Thu, 24 Sep 2026 02:52:31 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab386e5b9sm3506813a12.8.2026.09.24.02.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 02:52:30 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, stable@vger.kernel.org
Subject: [PATCH net v3] net: e1000: fix warning in iounmap on probe failure
Date: Thu, 24 Sep 2026 12:51:52 +0300
Message-ID: <20260924095152.3069-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
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

When e1000_probe() fails, the shared error handling ladder attempts to
iounmap() the hw->ce4100_gbe_mdio_base_virt pointer. If the hardware is
not a CE4100, this pointer remains uninitialized (NULL). On architectures
like x86, passing a NULL pointer to iounmap() triggers a WARN_ON_ONCE,
which is fatal under panic_on_warn.

Fix this by conditionally unmapping the CE4100 MDIO base only if the
mac_type is e1000_ce4100, matching the exact logic used in e1000_remove().
The hw->hw_addr iounmap() remains unconditional since it is guaranteed to
be valid for all error paths reaching the err_sw_init label.

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b
Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY registers")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
v3:
  - Switched from pointer null-checks to checking hw->mac_type == e1000_ce4100
  - Removed redundant check for hw->hw_addr since it cannot be NULL here
  - Added missing Cc: stable tag and Closes tag
v2: 
  - Expanded commit message to answer reviewer questions (reproduction details)
  - Added appropriate Fixes tags
  - Added Reviewed-by tag from Aleksandr Loktionov

 drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..156903089fa6 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
-	iounmap(hw->hw_addr);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->hw_addr)
+		iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
 	free_netdev(netdev);
-- 
2.47.3

