Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD64ECAAD8
	for <intel-wired-lan@archiver.kernel.org>; Sun, 18 Sep 2022 22:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EF2164025F;
	Sun, 18 Sep 2022 22:18:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF2164025F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1663539491;
	bh=izkxP0x2OJXvSc+XAR4u1UtTz07siLkHy7xoWrj0DtA=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=4/9B77ZoDNPtzc/GSgoZMSrOHuL594//A8UoOFvm06OmYkJlBXQDhkjg768akE5JG
	 RA7iIM2egl85U1+/6dvAX7mrD7O+LY1ygu0vI4RIqw1ojx/pdFJv5svmvXYlthiX0O
	 RM9uXqdXWW6U+yz+Wa7tMlolFNPoithZr09F5w18JKdG/IjXBGwQa+ZgVKlD4Rclds
	 hfOmHDZis72f1KpbWlq2E4HV9L3EMbxUDdHGWCndCVQg6DUQTeJxjveQ8A1V8Q8uP4
	 lqofriK+s/+7YChcSrsfZc+UiQdfk1z2tVOT5c7hxzXqBv9+JLfHbywlI+juP8Ni+Z
	 U163mLDK0o9MA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V-DnnFqxeeow; Sun, 18 Sep 2022 22:18:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0291D40A38;
	Sun, 18 Sep 2022 22:18:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0291D40A38
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 5F52A1BF41C
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Sep 2022 22:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39AF983E37
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Sep 2022 22:18:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39AF983E37
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3y0uYjk7d7DT for <intel-wired-lan@lists.osuosl.org>;
 Sun, 18 Sep 2022 22:18:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1580F83E36
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1580F83E36
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Sep 2022 22:18:07 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id e5so26358406pfl.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 18 Sep 2022 15:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=sdMjgVjjAnbiiUNEW0iYZefKbrfHrYNSoqWXWFLophY=;
 b=4rUbBuQNBiU0BvuOdHWRNIb+pyNPa9O7pi6fXrFpONayOqAiOLy+UqtAtM25t3KwLg
 4QuphKHe5lu/+/VURmqeuStCkcOFGQcdggW6hP+N6KEs6yWu7YHQqUkx/3wwmpX9/w1N
 vr4zt+Wny8CbJXRxf4F4aQYOGJLi1zwD9jRw0PGN4JOBBOZ2R+f4rMAceApXWclRCnnO
 wHtQus7rYWKu86L4TbNkU8tuIY+EhctaALbyJOBK2JADM6Z09mbpCSezpzG9FH7mRUPV
 7CkmLX0FfNNBYIUC7Lm6xxSuS2G1h72fP5gOyAWzN4TH2RsD4wLU7hhODM71HUkVIDvQ
 qQmw==
X-Gm-Message-State: ACrzQf3t+1hhXa27cnxJK9UYeShaW59Lz+l3rG39tp+O2zCIf8isy5Cq
 m7iXJQ391Y7Dt3xFfW37+mg=
X-Google-Smtp-Source: AMsMyM6xUUZ+BaqIhTuUMDzaPNBCTSsTR/5KEfYxUIdSQpR+aVEyBC0U6jRLqZP5qXYS8o+zm3sbJg==
X-Received: by 2002:a65:6c11:0:b0:439:ebfb:f8cb with SMTP id
 y17-20020a656c11000000b00439ebfbf8cbmr5595306pgu.6.1663539486383; 
 Sun, 18 Sep 2022 15:18:06 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu.
 [2607:f720:1300:3033::1:4dd]) by smtp.googlemail.com with ESMTPSA id
 rm2-20020a17090b3ec200b001fde655225fsm17286524pjb.2.2022.09.18.15.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Sep 2022 15:18:05 -0700 (PDT)
From: Li Zhong <floridsleeves@gmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Date: Sun, 18 Sep 2022 15:17:50 -0700
Message-Id: <20220918221750.1065134-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=sdMjgVjjAnbiiUNEW0iYZefKbrfHrYNSoqWXWFLophY=;
 b=E1NybUn6BAtU07WgYjFs7GXDT6zfdF1lkijuQVgKAU8v9oRgKGf0lllhOBhyPJ0MiZ
 kHJhyfEa+JmOuBr3VnV5mtM6HLiHP5o4D27PhkwBNfcG76j5uFyCqw132b41CbZMcyty
 cMnzDyxj+r8BeC3B9J/Ovl4B8QJdjgMkvGxRPLncLQnD281IZZUT1mI8/TL/V7jjPzax
 oAyP8J8teVU/Tt9inaZm5IyEEhLIOf4U5WOAxUJkGOH+k5dqSao6Ffj2yRDugJWyw2Ro
 D+MGfPQtUsPiT4B6b8Rmze5AfLonp0rjnfOGXMC6jUg2LN09PxbIIZs6Z7z+uxxzKl5u
 NT3A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=E1NybUn6
Subject: [Intel-wired-lan] [PATCH v1] drivers/net/ethernet/intel/e100: Check
 the return value of e100_exec_cmd()
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: edumazet@google.com, Li Zhong <floridsleeves@gmail.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Check the return value of e100_exec_cmd(), which could be error when the
command execution fail.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/net/ethernet/intel/e100.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 11a884aa5082..f785dd73d537 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -1903,6 +1903,8 @@ static int e100_alloc_cbs(struct nic *nic)
 
 static inline void e100_start_receiver(struct nic *nic, struct rx *rx)
 {
+	int err;
+
 	if (!nic->rxs) return;
 	if (RU_SUSPENDED != nic->ru_running) return;
 
@@ -1911,7 +1913,10 @@ static inline void e100_start_receiver(struct nic *nic, struct rx *rx)
 
 	/* (Re)start RU if suspended or idle and RFA is non-NULL */
 	if (rx->skb) {
-		e100_exec_cmd(nic, ruc_start, rx->dma_addr);
+		err = e100_exec_cmd(nic, ruc_start, rx->dma_addr);
+		if (err)
+			return;
+
 		nic->ru_running = RU_RUNNING;
 	}
 }
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
