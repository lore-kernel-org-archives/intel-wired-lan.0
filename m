Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78B0C531D4
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 14:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 783BD40786;
	Thu, 23 Jul 2026 14:00:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jqhdljltodJv; Thu, 23 Jul 2026 14:00:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 850A240939
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784815200;
	bh=iRwMS1yYg6x6c1ic3bqTI4TGm9UD5nBCdmyRzQBTNus=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=7nlIU7WECDb3Zj1rTcfYrIYtMIGnkxjCs9BIk7CSUc4N58hHEM2UnKJw5+hOcoliK
	 Hyf8Mo4I6D6ipTWVxDXjev9v8M2wFZKvm2RYXfIGJxoQuYG9Y5GBX7rWK8ATux/v8A
	 syqfxcUt2BvG9QYJKOGBhpmXLxq/c/Uvg3dIhUQfzy/vBv+WdhhKlCLPkAzebaVuuC
	 /WPeBIKfKHzcVlubRo6ybCySmn2VpqfmXSNiUNTJNSL/1Vm1XfGfi+0bcDj5zJqYIK
	 EvFaG8GVaqzFUGgQj/zeVfNWzatYuEjSddBkwbrMFVSp5c+7Cnc4CxeXiGvppGnNnG
	 qCj0/IZcDr9Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 850A240939;
	Thu, 23 Jul 2026 14:00:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4564839E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B78B400D3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:05:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NmDfoYqV2jS0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 07:05:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::a;
 helo=mail-pj2-x0a.google.com; envelope-from=dennylin0707@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8BFFB40026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BFFB40026
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BFFB40026
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:05:10 +0000 (UTC)
Received: by mail-pj2-x0a.google.com with SMTP id
 98e67ed59e1d1-38dc4f9462cso100834a91.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 00:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790310; x=1785395110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iRwMS1yYg6x6c1ic3bqTI4TGm9UD5nBCdmyRzQBTNus=;
 b=jfhqrBXElN4zhPZLQ/SsfVPLnZk9w8uxMt+9TwcCuUnI/6FKPYyayvr5jcJEo3ZJ9+
 eoAXJtxPV90FLn4GCX6wR19FfUsRyLA2UXnSIdUULx9I4MYApHcTBWnrBD2PEKKH+8tu
 JntDqoGZwvuP3CtI6uuwwRVWyHM2JbOcnqkxejfstKshfcJIzpMsFojlzJlx4m0wX3rJ
 bbmkAsgfLtO3RHPt7vGuqMSinqREsop0jvTT3pZh0VxJZuCbECq24oA4Xy80XB1/Wqrd
 pHc/16oODSMgFOoxM5zOMY1zdBzhTW9TUsgmIa+UOyn033GqnOAu1SEJANi9tLmvExGV
 mXvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpx9hpg5pkC7z/WS3/3MsdlkCqMZPFQabKo1iTwfnXNrMo5N0r5nUHj9NJ4r9TXDqh+fT54xS/9ozYlaB7kkDY=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwWGs9Q0GH8jXNSaRfwaQPn4jOx5AHCdzje77YVPzcq8YHGNcVI
 clAYzj0Lb0bFHv+UArz7XsbBLnp4zsfeqKfeePE2c/PWajUgIGwoJvMB
X-Gm-Gg: AR+sD13Zo4iEftI1bXgCm3RYrsXIoJaceMfp+LGhrYFLGD1aMtfltt2150QgW4h18zF
 puO/k7BsoqnNcMmIQf8j0nmyuUvFUuvN6T6Png5tsQ/bp4hvrlWUvBibKfyXGY8zkqXIWPbfN7F
 BkivSLo/Mk6XabsNCkQTjIPLsZhQmUtaZU3bQ6XyWM4CulSci2PeoATCSYlcYm2ekZCU9InA9XJ
 K3VtF50LhELPOBBs7o4/8++sVIA7S6BlkjIujVMou8fkl3ucXeCFv+elAfftU8wC+PXYH7CrWs+
 +KNhXfg6wTPlWr6TBtMHr0wqCzRYluNK+2uOb569siXAFdFc/Y9y39T3idi6jYx5ePi6jAOum1y
 MRijBZdM6jyN4RYzH962X8HLCxXODvXrLqYht687bcH+pUwuV4FT3YM1Ss/3IyncUgMwGG0PZAZ
 xvsrU5fsXPGZhBSU1DlYhTnsWPltz3DGfCmg==
X-Received: by 2002:a05:6a20:b786:b0:3bf:6856:d8fb with SMTP id
 adf61e73a8af0-3c44b052073mr1929910637.29.1784790309632; 
 Thu, 23 Jul 2026 00:05:09 -0700 (PDT)
Received: from localhost.localdomain ([76.86.179.124])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3149198adabsm6247910eec.8.2026.07.23.00.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:05:09 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 23 Jul 2026 07:04:51 +0000
Message-ID: <20260723070451.6545-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:59:59 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784790310; x=1785395110; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iRwMS1yYg6x6c1ic3bqTI4TGm9UD5nBCdmyRzQBTNus=;
 b=dGokSFKlSGq7iamhqx/NO/LPLSPrftW+cud3/qQspur+ZcEoKU7aXysULJ++GmXiOL
 rlOcruiNVZ+mKSBDM9775+EnEm3ipNqp42v+Z/DA6XmqwneVfxU7F2/ya2rLFlt5LsJS
 tXMlyXVJlLsNVRCdp8G+0AHFni03AuaWZtx0mnPMHJcC9QMmAnJryUWpwbk92T8pxYN3
 obTAstBlAQ6CpYpBiuoekQIk9FSJldWxKGQELNH7bDp0df8uiyxd3DmNhefk62wjNdUJ
 9Jl6LI7LWV9wQesAOp8klF6Q8DMESMUwyrS2NjBkDHWMafPgg4BbAGlF8E7cueXOqfBz
 EJaA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dGokSFKl
Subject: [Intel-wired-lan] [PATCH] igc: Remove unreachable break after return
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

The break statement immediately following the return statement is
unreachable and can never be executed.

Remove the redundant break statement.

No functional change intended.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..6252d4b68f88 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2528,7 +2528,6 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
 		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
 			goto out_failure;
 		return IGC_XDP_REDIRECT;
-		break;
 	default:
 		bpf_warn_invalid_xdp_action(adapter->netdev, prog, act);
 		fallthrough;
-- 
2.43.0

