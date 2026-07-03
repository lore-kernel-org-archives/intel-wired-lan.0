Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4FFC43458
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Jul 2026 15:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F882812E5;
	Mon,  6 Jul 2026 15:23:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t41s2h5Glh22; Mon,  6 Jul 2026 15:23:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD751812B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783351413;
	bh=ZXaOhXKFNzha/+UZgRF1nlZyqJvtz4uRe3j6zG6TsZY=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=70lXagm2ygxKwX4FW2M5xogBdm3Qp9lE5kIT6v0Md5/S+4zi8HqQpggLKsWaF3IFz
	 cuTFMTLEa6Tr2qiFtrYP4NYJ6CIHp2ZEqVEHhxK0FdcJeF4Az9iy1LRAMun5Wqo+X4
	 skT38TXlUlfN/s00J5cm8kXWSIa5hNyNLNaqbQydhijd1MnY7x1NCOCjnHuwjFKudr
	 D2d/bp2K/G/0bXA05U5CMxUWhY/fsK6ph8l+xXMVD0qAhmYG18ZrzqjnxjGfBjL8n1
	 LRLTSW583KSwW5sq4ZM5PO77P/upgmP+cQV06CUJBBTdqL2VOeWRNZS1+hTfoZhHYG
	 fnHi+yuvmvrUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD751812B2;
	Mon,  6 Jul 2026 15:23:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D402316
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Jul 2026 05:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01512843C6
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Jul 2026 05:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C2NBCyQM0FlH for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Jul 2026 05:01:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com;
 envelope-from=dbgh9129@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2686D83DB7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2686D83DB7
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2686D83DB7
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Jul 2026 05:00:59 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-8ee88fce476so1196656d6.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 02 Jul 2026 22:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783054859; x=1783659659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXaOhXKFNzha/+UZgRF1nlZyqJvtz4uRe3j6zG6TsZY=;
 b=aHbLKloAVEY7QoerfcnVPsGaOm/bJYWroKXIo6sjs+7/Hf31oKoOgg+KYVemNa2dwi
 LHot+ObtfX9pQdfori5oMxIcoELmrQZJBe1SYMnUoo6IrKnkuqtRadbmkjEH4yqVjPAD
 /mh9A8EPjSEDNu2/aA4K3pFgxGTweKxI8YLQByXqr7o6yfMT9J19b8f3TflOGxkuGpgK
 VLXKWiDQq/xDpyiJwsTawZzYk9pkIPj1Na/g8I+AhXqrYaDLkZsZBZs/XBHWeeqiGGbX
 PCdklOVwNAXGP+YpGuEYAjon6TTYialsE/eGrZNzWnXKmNttWCNCTfpDsBdS8gwgytrx
 tpdQ==
X-Gm-Message-State: AOJu0YyZw60EypOryoBe6YPYkaX7C8pn62jRw5H3EhiKqEbmH8RcODnY
 l4rJDVYcp8Vcszg0dYAJZm3UeBfdTV8U6P5oDF3rNNO3p2yLYL7W2+zm
X-Gm-Gg: AfdE7cmDYs4P9eEt4hd/LHr/LhpQz4qzLptbKSEHtiNqIf61G5nmuw7ud1RyKwiiv1d
 S7s05pO6yd+q30tteABoRdXo9cHiE100D/y36BJBwhwz9bGVmxopDKFst9Gy80uL2Or/WDaBvps
 ieu61sGWl1ty4GsXLSEU58PRR2A4qmHr2JjtcYLbueG2VFQ9Tvztwscue6eEkYajgG/BWZzMqLo
 +nekoK+n7D3OWrbEL9nKfBD9G8QZNr9BIv7qoW0+g5sWLov9jkzj3xw2YCLYObeqwAR5bewJmGM
 Hf7J655Xem2QG4hTozZsWYGHP84inIMLVxMcozyDNuBpi2rWQrQIrHhNWn59EL9zKm8beA0eyqS
 NezNafDS1i142OSxB9V8512LmfpHwU14AQIg1pRmJP8yyjlAGlVgXq+wUpHZu4T1kaEG375gnP6
 t6YIRI+1YNJmJsMQge9E+Q9fAw8hXfsSp+aKHF/RPtEegCjTq0W+iDesEFQ1+rLBkW2329SmVyu
 gB3siqCWKVVCn7GV0JSbx+otA==
X-Received: by 2002:a05:6214:588f:b0:8e9:f5de:d636 with SMTP id
 6a1803df08f44-8f3c9cb3057mr119943406d6.55.1783054858547; 
 Thu, 02 Jul 2026 22:00:58 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46e27d54asm46420096d6.3.2026.07.02.22.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 22:00:57 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuho Choi <dbgh9129@gmail.com>
Date: Fri,  3 Jul 2026 01:00:53 -0400
Message-ID: <20260703050053.120851-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Jul 2026 15:23:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783054859; x=1783659659; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXaOhXKFNzha/+UZgRF1nlZyqJvtz4uRe3j6zG6TsZY=;
 b=QT6YGMV3ahHB2w1bz59lcSGQLMdk8NY2tT849Ad7j200XDtudzGe7HrtQt7CfjUSKM
 BeoBd9YmW3WVDodVr/w/tdXNl7Z0FUrW6RAQwHpjeDUHBpNsFTofP5E+qMSAwZcgpiyw
 sg+qi0OCOhAVTFjGYlIl9vDF9T6s7zGRoLPQhGBMSxxIQB63Joayfi8j+VEB2Gh4ruqX
 BGpIP+75b20EYCJiBBmu3gTTUao8OrvTLGFyZgI3NOtIrGMs6tgYb6+qZk5nIgBp2a2V
 ZX/dJ/h6QWADuDrvnxCyqzJ19dSVAFyTFFSOW3q0y1UydAByqJH/3naWaTR7jCQV2nHF
 gIIA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QT6YGMV3
Subject: [Intel-wired-lan] [PATCH v1] idpf: Fix mailbox IRQ name leak on
 request failure
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

idpf_mb_intr_req_irq() allocates the mailbox IRQ name before calling
request_irq(). On success, the name is released later through
kfree(free_irq()), but request_irq() failure returns without freeing it.

Free the allocated name on the request_irq() failure path.

Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..bb81e620c5c8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -139,7 +139,7 @@ static int idpf_mb_intr_req_irq(struct idpf_adapter *adapter)
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"IRQ request for mailbox failed, error: %d\n", err);
-
+		kfree(name);
 		return err;
 	}
 
-- 
2.43.0

