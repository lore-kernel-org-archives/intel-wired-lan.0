Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54976C61DD6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 15:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBA5E80C71;
	Wed,  2 Sep 2026 15:10:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PYob7ks6Y4fX; Wed,  2 Sep 2026 15:10:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788361839;
	bh=oncz24DQCI7h/SAy0ZeJzGJH6zM3Y5+xwZoSuFu7ZrM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ziHMeArLMztrHd+ajlujNdQLcmBeVEnyVFArB8LHTC0N6diWIC0rXFL1zlTs6uH3V
	 emV56GglRaRw+pmSK2QsQaJww1gJMeai0FSg3oFnJE6d+iF7Gffhq1IUMbJDdpR6Ek
	 S12DsBsKj3VKvbXNSvoIC6h74J1UKVeJYt9LqDCbu3zptt8jJgNG320cj0SXt+gbb2
	 Lv5Wp1QVDzMuTMdH7hufFbo+h/OrQ7iI02p3y7zY87ZpSvUwqA5aEm1yH9Xoqdgv52
	 pvTSoGGjUda+E8RnyUfhBtRNVOvCpRa5RtslODva3cA1jFoxttimRmabXWNma6ILJ6
	 kKsVLr9NnG/Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 227EA80C9D;
	Wed,  2 Sep 2026 15:10:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 015122FE
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 09:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA3CD40A2B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 09:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ilrcdv0tUaQI for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 09:35:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=keshav74123@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kryugaIn
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5339940A28
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 09:35:03 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d9201076b3so9841705ad.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 02 Sep 2026 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788341702; x=1788946502; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oncz24DQCI7h/SAy0ZeJzGJH6zM3Y5+xwZoSuFu7ZrM=;
 b=kryugaInd3jxJr9L3pgaDXp7hdQG3GdyIVspmwt01Bc3WW9wkk+W1IFJpDr+HRtIzf
 1vUQ89Sw0kGG9BiXQ6leS/Zxc+60zS/jvi9kWZsYrnzbgQqXLZ/rTHPMuaywMLIDUJ1G
 5e1/b9XGclkEUH1Sz/VsvNKu7946LGYgOqZ/31yHk6HvA9wEvs8R02lpncTdNcLAHqu+
 TE64FfUg7LL8/2iw9JvOo4NcEL0bS9MPnBDAXPqfX0HFH6nFic34IcDkqmYfVm2MGVds
 lKzkpZyRvPl1CgPLwmvB4/cc+TFjllEKU5JPfG7EPpgtl1iDIfhykZfmQpwZ2jCWsDeU
 wC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788341702; x=1788946502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oncz24DQCI7h/SAy0ZeJzGJH6zM3Y5+xwZoSuFu7ZrM=;
 b=Bq7Ko05NIh+kHmVeWPMVUqio6gcuqG+eh6WzMR+sZ8CtDwvu7NS9pNakPcWe9vBrvN
 Jpk/Bs+KrCv5E35MMfomTIYXw5Kor+QhvZkzAnf53iVL6LnxWAb0JgcSvRr9GKITn0K+
 GbOFZnmgP5WkpWqq42J8lJ9NIodDmop+91i6zxbQPC2jCgsdIS0ZcKCRFI8jdkhqr8Zl
 ys/M6ei36sum+NyoobE+suEeuJrI+0uU1ziSTp+mgGTNzRt9RQAQAmdLJK1E+a38sHlj
 QZoxKi7H1E5JXlIS9RumjCyDe3JmNAxDb6ada+aJIkLcbYmGFrvBcP4qBcZFNgDkU7BG
 6HXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmiTHrga5UwMIMTd1p3MY+RGGKQdBXl0SBm9xuz2CUtJ3ITfDZo6kS/v+MLynulnT9mu+hGmYnJxwFKly+eR8=@lists.osuosl.org
X-Gm-Message-State: AFuF++k0Qq2eA5kK4uNm/q1Kw744LK6j5WXxC8Fc/Vxwa/dBoL1I+HWj
 ImNYVLqulZjeXtSNRo3QB5iclrA/wb4SvxHs1U/qv4p08DW6cwlBtFiR
X-Gm-Gg: AR+sD12btHVeTtWtaEKOO12VgX/H8N0wRpQimOO4DpfqcUn03V8woEpk5uzJczgR3Hl
 2qf2QEO65wyvR4QbDSaAydh6QPRah0SzWL6Mc/k83+LhdHG+hDLXVe3mMSTpjpI79vOym+YY1v1
 KMoDD+FDVasvMQGWOwWHO51Wv+kDKFvth6cLmA2gdOw3kqGa299OAhNCjkxibvL0k36P3pmxxoi
 RtCgIMKL2zhXqI01nJ+W0xCezVeOvf5lj+7ypomzchaZLnMiZeT7vGZoR24UUyzjIM1NlgchcrE
 Oltju9FlamwN+3/nWVikOgz2XKqe/+5xFEiIa3WfrczoOjHKDCge49JK0sL6amJgByqcK8BaQ/e
 yPKGfanoIES94fbMPKEd20zp5/sB4eYDz7thVb9L3DPFsM8u33oDc5tRqv29m4m9afBGxhrD5VB
 NAH1dWKAZLPGVgujH6WnumpOy4JJcQTHI9nb//5hGUY3F8tk6zbiyFGjrSqEcEkmGxghyPrpReq
 z8Mhhgq7V5fX8zA4r7hyX7T68yljiNFW5I=
X-Received: by 2002:a17:903:1aab:b0:2da:f1b1:56c4 with SMTP id
 d9443c01a7336-2daf1b16445mr22990685ad.3.1788341702379; 
 Wed, 02 Sep 2026 02:35:02 -0700 (PDT)
Received: from archlinux.domain.name ([103.97.242.49])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07b7a175sm5257507eec.17.2026.09.02.02.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 02:35:01 -0700 (PDT)
From: Keshav Goyal <keshav74123@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Keshav Goyal <keshav74123@gmail.com>
Subject: [PATCH net-next] igc: remove unreachable break after return in XDP
 path
Date: Wed,  2 Sep 2026 15:04:43 +0530
Message-ID: <20260902093443.93466-1-keshav74123@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 02 Sep 2026 15:10:37 +0000
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

The break statement after "return IGC_XDP_REDIRECT" in the XDP
switch case is dead code since the return exits the function
unconditionally. All other return statements in this switch are
not followed by a break.

This was flagged by checkpatch.pl:
WARNING: break is not useful after a return

Signed-off-by: Keshav Goyal <keshav74123@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1fb5f3cbe93c..3b7dd104d8d9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2525,7 +2525,6 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
 		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
 			goto out_failure;
 		return IGC_XDP_REDIRECT;
-		break;
 	default:
 		bpf_warn_invalid_xdp_action(adapter->netdev, prog, act);
 		fallthrough;
-- 
2.55.0

