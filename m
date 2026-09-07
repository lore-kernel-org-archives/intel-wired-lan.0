Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD71FC79FAF
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71FFA80BCF;
	Tue,  8 Sep 2026 15:14:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gU_x31Wq6slT; Tue,  8 Sep 2026 15:14:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9D1F880C04
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788880440;
	b=NiuJoZvZ1cFwVyZDA6G6Ix/Mu78Lxywu12QTj0Fx5fqd4c4cc4fQKChQH130foL6soJV
	 WjGlxlhD+l6/CHS715MP8AuPulqugEpet4gksaiRXMU0uJ3B4kzzOROt6TYZSRrDSGuu/
	 kIJv4RzFCZEc9UDSwBHeXsrCFV8Q2pWOvwB1z5BOb8KuTGK+p3RpZJ2QenM969D4WeyTZ
	 hPsf5q/a+obfjmN9GrXyf44hWDkmB7n+NFUEVph+goDFYEHPClSap0Gxx0M9VuGTAQ1BM
	 SW/1sC7OdipoV4LD3ISe5D7fnSTN6w6kqyubHPK/9wAyp4XAWICVuwBFdrZZz8ZCXJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788880440;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CAjCGFj9uN24CROal9WgOpj03Aiwe9JIURKGhaUN4Iw=;
	b=ro4KtgufbS+fSXLRYyEVdRKUKRdjL0Y3prSvT5LzQLUPtmXKZVnMc5orNmTKC/MgOuEc
	 NMcdJPEwXnKSMEmtR59t4R9ENwosXzrOKbDAmJwUClXBS/BRpFOvHcc2RCZWTmzooAQqK
	 XpBqijp8nApV55K+uexKecmHPaN3siCWqAlmHGMR/uICgFi0psFmikPRef498pJzrcGiY
	 PdAuGV2Aml0S6d1g5H9Fuegmbw8LU/PE/FFQaLpR3UheLtoin59hiy5It4TTb3pXKOFwK
	 8O+SeYIKMOQYaiJb1gEN7LtbZlHJIkIumwmVulCuKE+4ALsk+CTWWB0Axz7PhO1WqKQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788880440;
	bh=CAjCGFj9uN24CROal9WgOpj03Aiwe9JIURKGhaUN4Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QHnAXgKik+QHp3lm0DvkCatTZavnM16W0W3j1pSDSwroxIX/XYGSOEiQICtj/lPLE
	 9dJD3Ma8bitonO/pbHXWb1I1Nc60WZrhtlBWLpxShh7ZY7P/4SK4TvRDp+gQGQNu0k
	 A9aBWEEejxVdqq5IDXIEVbbh4X5qK6kOFi8F4LGZUzhptdsJuyDtYp+l6V2k4/c9qn
	 1BTKydmL+ud1uTmMMaoNMibuZIy7W3b8K2FbZJMudzE2vRZc9BDNPoYdpPZvx2nNEn
	 bBP/VuSnsBCEY3cQtLr/gXv5phd+3yUTv/cHbKiu+aNpQ6ukhQbOpdOb7XAUTzk8wR
	 iq+8eFqvyLArQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D1F880C04;
	Tue,  8 Sep 2026 15:14:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F85F49D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85AE9400F5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:55:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSERLewFCVwq for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 09:54:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A6D00400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788774899;
 b=DbEDNM0YqlsYplE558MgHw9fprt9gGYhywv8YllhruIrm7HPO7drvVc7my7CvTUgDeCX
 48SjJMwV6u6cVL9Ma1hpG+PHFl4J7a396cyI6eCkmE3KGI5oYcJm0SBeqlPT+TiCue9/L
 x6EPkNkBtPaABfA6GMa9xTQO2slEC2Y8XRLD9oWHES6IXVzwmPb8o/CDa3K0DrwODvyUN
 l3tta6ac/ZwDo4A9twG/9Gf8+v6zfLiHI5I4iNm8Jl1XE7bS9+/8wCEYOuQyWiup4Wc6D
 HUMQ7mqY9vntaxi3n9VaU44A095n1VX8I6/HZw3ue8NK7wb3ubC7ls3pHE5B5W1mo0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788774899;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=CAjCGFj9uN24CROal9WgOpj03Aiwe9JIURKGhaUN4Iw=;
 b=fksMAyzrHwlPmNXnDSDf0ibQWjQLS+XQDaOIsHYcUtnGQ9XPpxKikVGFiQpzPetJW7FP
 FScYGIJEdJrFJo4ozzZyEAQmM1mZJ1Q62ruNjy7xQy/SUENRciIBVolpIuvK64JqrYQgq
 3m3qR1KVeQO9s/BDKiERFMOP314X5iMqiPiKOkPaUT5VBzi+9EN1BNCpghqL42bCm2D8t
 7wi7aZNv3Q0l5/rQpt8xomP/3EQ3uoYE/HoSdhMRFR2hc5+WS+4j803m6my/LDypCpJxd
 Z4GDdHi2a3myTScEJQxu1BX69lwgfGVnsmXdWGfvrlsnNYoBGTDc3AhqOccnMGJLiug==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=h9l2kfLh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=hemanth.selam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=h9l2kfLh
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6D00400D5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:54:59 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so2675843a91.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788774898; x=1789379698; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CAjCGFj9uN24CROal9WgOpj03Aiwe9JIURKGhaUN4Iw=;
 b=h9l2kfLh+fAV/1IFbPv2kQVLwoNA9AjjrtTLrvscX9l1XJbUGm/PF9LAxqlo38PM8A
 oGzoPI7ySJpOrOqQ9mnix9NPhVqTqRn4fVUS4pryP+XjhuE/ksDhoZMljm3t37dXNWmC
 Q1P0bpHo1uKr5eemzhTQ+5qiFjV8vSW6iyQZFYjLanJXpBoK9wjucGatPgs6wV8Dh/KI
 QVcG5kkV6Iz2Q6ZAlpZfv4j1q/35MqFkwoHNaaSZev8U7HivgkfMCwLeFfairUzqBR3f
 ogo0brPDvhVUnNTB7Qa6YTCa/MUNdRKTrIPkmgBmsHMZjVJehQ5kFetyY/9R/SF07xf2
 e7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788774898; x=1789379698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CAjCGFj9uN24CROal9WgOpj03Aiwe9JIURKGhaUN4Iw=;
 b=IB1ouu+mdPmErpP1rzGdqVouqD6LoVEwxWQlC6Bh4uyCCy9xxcuyIC9dz7J26Zilme
 7XOnQEubO3FuzF6iuBeLGdxLMPS4PPxajVmwuOE8rdQ92prtXN2PmZ+isEfCkJDZilSQ
 0cyq4jiSAf6KPlZYvz023JA+ylWWr4/0IsEWz8uxuxvz+1qXTfJGdP+DOoaCirylDcFR
 Yj1uOTxtUwvGkvz4hYvh/0lKbG7HqiHEAGEcnWcQHhdpeJY3W1yzxKiM6FW9FCTuyGbn
 E6fDBuPMqQKMUl0F9o8fe2qxI3BUs7456hf5JzgpC7DUQO99ESVkEoqH466+h8fcpZ9x
 OReQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3rzBhrQEnc3Htfh/bdZuU7sF8kFDxYXmQGITumnVQl5keJyNISEaAgyD6CzWDup7gTLIeXiLxc2irWTGG1XI=@lists.osuosl.org
X-Gm-Message-State: AFuF++kRIJbNZyAIMOIwfa8e2KxfRg7XTsik+wmp+Fh6A5wKC9Az1y+w
 GNrNLtCOoFLnC9G/Xml9JiVr8sde3aBGOwIuGvEWqS6EUB4Ywi9mstCTSXXMbVGs9E4=
X-Gm-Gg: AYBFou2JT/aqq3oZey/1cCEHAvulLaJsbiaRW4jbeeg7s1rI6DZFyZoBijY1NKTHAtc
 vnKnjZIStysh7kc7cAEEETcFwvDz9W6E79Wn6tcqa7MPiusBnpmMD1KJGGYdpU5qBKrNr5jaq5u
 m3ZSHiPpRxGFg1QpeiF1s7XKN6ZitM+hl97Jam19VZmJizHe3s2QRjUuda6P51vDHFM5CwMWmO5
 RdIDeBWXbtN5LpyH1hgoqY8b3UoWiDPU9L1UvRY9pJ3s14TIIu/XesN9oNCbmYdlrQbxCFAmr/X
 zwToDP6YdMb/mKb90Rc/ZaHgx/TLWO/sKjuXg6Hhg73qig2XJH6ucNOScdFjnZWj8bBF+fBgi8S
 Ov9QPopjFvEhHwEVIxBEsW7Bii51QerXa0y4TgX1zFm7JDTeLIaQ7tSPcjQwz3zaH5wGrb0rVB+
 ffSG0f6+MOynrlxGdOinWR09ISH6jWTf0U8RGnYTKFymBUdURzVHalJlu9b/MuDkITaJOIxPwbu
 vMkdKskZLHcVg==
X-Received: by 2002:a17:90b:510c:b0:398:9be6:f999 with SMTP id
 98e67ed59e1d1-39b262e27a9mr36356477a91.24.1788774898462; 
 Mon, 07 Sep 2026 02:54:58 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432424d27asm34831030c88.2.2026.09.07.02.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 02:54:57 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: [PATCH iwl-next v2 1/4] i40e: fix typos in comments
Date: Mon,  7 Sep 2026 15:24:43 +0530
Message-ID: <20260907095446.27290-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 15:13:56 +0000
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

Fix typos in comments, found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt. Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    v2: designate the patch to iwl-next and use a subject prefix naming the
    component, as maintainer-netdev.rst asks; v1 went out with a bare
    [PATCH] and a "net:" prefix. Rebased onto iwl-next, diff unchanged.
    
    v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/

 drivers/net/ethernet/intel/i40e/i40e_common.c  | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 8dadfef2c09f..026b35e5a000 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -676,7 +676,7 @@ int i40e_pf_reset(struct i40e_hw *hw)
 	grst_del = FIELD_GET(I40E_GLGEN_RSTCTL_GRSTDEL_MASK,
 			     rd32(hw, I40E_GLGEN_RSTCTL));
 
-	/* It can take upto 15 secs for GRST steady state.
+	/* It can take up to 15 secs for GRST steady state.
 	 * Bump it to 16 secs max to be safe.
 	 */
 	grst_del = grst_del * 20;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 3da9ec49cc74..ef9d1e78c16a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2614,7 +2614,7 @@ static u64 i40e_eeprom_test(struct net_device *netdev, u64 *data)
 	netif_info(pf, hw, netdev, "eeprom test\n");
 	*data = i40e_diag_eeprom_test(&pf->hw);
 
-	/* forcebly clear the NVM Update state machine */
+	/* forcibly clear the NVM Update state machine */
 	pf->hw.nvmupd_state = I40E_NVMUPD_STATE_INIT;
 
 	return *data;
