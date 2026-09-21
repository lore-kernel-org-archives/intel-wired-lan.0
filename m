Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D737C982E6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 15:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA7AE407AD;
	Mon, 21 Sep 2026 15:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lp1EVojm7thF; Mon, 21 Sep 2026 15:33:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5BBE740782
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790004795;
	b=LGP0If9TGfB0dbAQmWU8uz7l/KnNxPsp07KU7rEqdIsbIqZ/L8XdcFLOKrezBFqTU5lN
	 Fh3odYDcGvnFdyEDri4CMeh14M9UXWMVNkbOIFpYhkGN9nm7BEM2bMod1iIHXieVk6AAh
	 E8gztl1vAA2giUPc27Q46tYrMpYc+i9ruI8oOoY9xGLscabpGMlMnllGncFkVt/6cp2C6
	 NubPqdDF9Mu1Nc0J27sjW2mkf4lDZcpAALzIwnqk4zd+B9e7JQHTdyqPIzW+yJyu7qsxS
	 ZTff+hejrQ0bWvqcUNAWUPicOp55WiGUpTwVloxStKzHcjO+hpI95Cekv18XUJ4Rr/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790004795;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gRV8TcWW5ZwNyFZnqA6Ki45Wf1bqD9wRv3NLNzR2dP0=;
	b=hoSehZ6tOqNDNBj8FfZjaESC8K8w6S4llOJg4aTUvjJI8PoV3voCaesXSNBS6DaSTmOb
	 Vmoth4rlfM12INsf8Qn/3qdSHVSONheVgBA1QxJ9jyNziN2KeCWU8qFZ/5mysVe3E5+sI
	 d80CfF58TIDHJoB0QRFxwcXEdRe796fzD9NJGojZMooz2Y6Ksi46KG4VTcCgwjvp91o54
	 L3CiZSUQMtTTzQXbnb5ck8h6DruE+voQVAj0X36U85wvWQjIZ77O0Neg24WPeknMRDx/l
	 pwO+Gr5xybTZxQpdt1hzTloL5pEawz+loct7Rv+5kLVxuX/lOYtjgmp5buKQ/v1um5Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oevVx0sg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790004795;
	bh=gRV8TcWW5ZwNyFZnqA6Ki45Wf1bqD9wRv3NLNzR2dP0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Pxyn4IGf5bbikaX7ttDhhW0hLKAZa31xxzDDKk+NO/vd4ffPxr+IogARaaZkhRJL/
	 RiP72cMlBY/DtKeyB+D2edJDuqvvN2sJoDNItJFCMlq/AL/RZgQ+gd1xOGXO3qv/Yh
	 Oyvc4ayz/SbND8CIU8+Ym9d1yeHNpB5wVdbTnqilKLqtz80DiLqr0CJBmDCTsmincr
	 G+NVm2L1om+yrtV1LnwEkwBdeXfII4PHgl+AwS5kQziKFpez+L3WTgVHbSBwbxcKcZ
	 HjkxwkauelBjyv8LxKqFZ8X9/MCi34lcxtzGd97FyTCil8JuF9Fyuc4HNq69mGi7ZO
	 ZumsmbxLOyTXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BBE740782;
	Mon, 21 Sep 2026 15:33:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE0862EB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 13:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B485940818
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 13:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xtbTKvM9oytw for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 13:00:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DA08E40814
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789995606;
 b=LPSzqSmjROdMBd1Ck+eYTVROopNMgPU9zWfE49KlXT097IDrQWr4R6j8N2Yf61XxIwlG
 UczCQYzPnJ+G9bEs3jX33irmcmnyB6t9XhXe4quXd2AEBv+8i/vLS+J2n3/uitnnNXQ4l
 Gl9nUBEQGNnl/fAwqWBkVRf8ydRZJLT78qKuWIhCAsM6CaJTry+ukGzn8vnlEeqRZkf64
 nuwTWgpyLfvYMPh5wjqXdWFMg+EHrSaWjYQKX5UHDHesru4qgS5VdJi2nht5qu6BxHtRo
 lcxw6Vp9J6m3AZcNZQNy7vGlBA+oY+1gDMGmiI4h9WyAPrqM8mrgIxS9QWYaYEUH/bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789995606;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=gRV8TcWW5ZwNyFZnqA6Ki45Wf1bqD9wRv3NLNzR2dP0=;
 b=OqDOsZZqKiCRMwA7SsgYPiV+5gwqvTJtnQu4Iw1pBVWqAgyBtMfExSGOkbJ+RUPblPSz
 Jgba0M3QjIerqWJHpoy6AD76N/f6todHBeC+EpC1T+340dq/x37QE53ijGDICQ941PKyt
 dDdjQRfJHWeiI7jiPGn7TVjwhpSlt3AoYFAEAEMMt7FLAqL0tdWe222tMZzIlGapQ4xxK
 M/sGyloaTH06QrZGh46LADp/v/ueVojVMLEOKBfCoVz/oQgD2iqI+cCOddMrw3EnrHEqe
 3s0vSXLe1M8M/UUKJMSuvwW3froyyPYjXuYdQKCdm8JlGR6hWXxBFs6bP9dr2PsBDOg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oevVx0sg; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=nsvatoslav515@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=oevVx0sg
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA08E40814
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 13:00:05 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a64c7cdb46so4413384a12.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789995603; x=1790600403; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gRV8TcWW5ZwNyFZnqA6Ki45Wf1bqD9wRv3NLNzR2dP0=;
 b=oevVx0sggEr+O6xW/P+0CEr81HIORQVMY1sB2qn8XUUF8QdLMjc0BC4VpCclFsoRnB
 wsM+onsW7Yd5D//xo9q8kT9M3wOC2gGvLYzkbTykh+KnNKJ5qpnog5VgYtXCliTFG1Xz
 BTNkU/gGjElz/2RXOgMqSzaaM9OMXCM2JR+qR5mGw5UUcrJTTGmXMLh0n8IPElTwuix2
 HW98/dH198Z5du7qgkDs4UWAiPPlQpQxadrYpAYRVACKGm319HRhSlvokwefQL791koc
 oP7vumtsZtg+TVzZrsJ63ApOw/h7V9wO9KZQ0RvHSuv5iMrG0hUt1lVZF9f5G1kXa3EF
 Cyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789995603; x=1790600403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gRV8TcWW5ZwNyFZnqA6Ki45Wf1bqD9wRv3NLNzR2dP0=;
 b=YCNy9GvP6Dy1vPl9F+OKFZrbgK+eV51n2ti8OEfoYtLNsAtOr9bgbRNvAibcXCFqnR
 r58y5XlD0g7bOUIFdJRBCAusDUYjvjPRNEvQzXGRXul6X7eNz3jC/qYitoMIq69koMuz
 yg32DXUzMNNZ2rtSEZGfdIO6kTfmtsEdTh4XQxjxu2nixkOyExtNNrJC0HcRw8FzNL/V
 ClvLGuRTfUp6WmbFNND8GCnNB4i4bU59ukI9zFxVWhLeL0Uj+hyTM1kl77Sbj154J1LF
 Y+bHZ4p7V66G6a8cAdZ7nObKSAE3YZ2D/6zSD61LqbcV3dPsmyRWa0qCPZec4Rca0U1p
 tg9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBygMw7NAIogW98tFzzXQ6LekROgG7NRfdEhninHeP3bTM1rMMKv5GlonNtWl/xQsaWMTdTYwoUo0o1WIUBaqJk=@lists.osuosl.org
X-Gm-Message-State: AFuF++ld5E302wbkRh4C2sUZ86a+HSf4LiWwS5wUCUC46gTvLR+paSKT
 Lm0JbwUHz7xFLZCUylZxusPC61pOcdTVXy3X05v9xFoSsBmaUcIE63mM
X-Gm-Gg: AYBFou2c2zIWcduMQhh1olE17BT0ux3rvphgCG224yCcdkYkdfTa5eyd2jQOCPYInBa
 Bkig/hz0YsDu6sR6uxMNUXVn7AvWdJ2pfhiovzdWxnADUbQtHkE3LeRdpBgLNsXY9V9CdsR2rOk
 +DarJ7U9M4Tgiz2wlsfiF8FojHp4yNgy+WFw9wE+C9/m/aJuBoDAUiAaB+2OJgY2lgga3SzkmbV
 faJXQVID4a1Z9B6pprdFf343nPrdsWtkGaHb66zuir1fJeeB53EP/55n7h25XZKrfXqYqfFWhy6
 ugdKzid0x2mS5YsSPd8YpGuu1Ach2CuTZ1y0HtoUfgnnlr5A1p+8vdCn1faZ6ku+rlbJAfC0iMQ
 N4eR3noC7PesgxvRv/V65z/cumPwfS0qgZ0mfCtu5WgfmowPP5wo5CyQ9KVaqhl3R+Hnk9HkXTW
 UmP5K6GDZDKkmSwW4bfAWIuKawtj2HNoZO8avqKnjhTSQPPgmY4rXXta6ICaqI8LuwDWoBgktzI
 /CVSsG5qQfpgodOEQ==
X-Received: by 2002:a17:906:9fcc:b0:c26:1648:a070 with SMTP id
 a640c23a62f3a-c2a15ead5ccmr900804566b.43.1789995603107; 
 Mon, 21 Sep 2026 06:00:03 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a355eb33bsm321193766b.15.2026.09.21.06.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:00:02 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Subject: [PATCH] net: e1000: fix warning in iounmap on probe failure
Date: Mon, 21 Sep 2026 15:59:32 +0300
Message-ID: <20260921125932.7943-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 15:33:14 +0000
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

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
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

