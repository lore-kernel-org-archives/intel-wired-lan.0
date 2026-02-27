Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D165FEFB51
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Feb 2026 20:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCAB3835E0;
	Fri, 27 Feb 2026 20:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCjyxjmEf0Pn; Fri, 27 Feb 2026 20:35:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0B61831DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772224534;
	bh=nRaIjBVYslTopVZnWl1PKdjxejATawghymOdcPvjdcM=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=zVPYJa1081NEOa7lUsoGMJU5CtAAOzxR1PNxgpukYs/Idv/lh8Ql1UwxWYEsWwCn+
	 DjBu4Vxpe598bDZzIXyXP88T+LRtgfLUcKU2ewkwTyWj34Kn9Uf40EdARc0lvXbJTA
	 DKOLHacPhcoUzysAVpNBeeod8xNUUtwXzvzHc9opUsCNgjKXm17l3LPJ1oJuieLGdw
	 LAFJaDVrI/tHljLQlipnLZuQN6l8RurjwOz4IwBbinSzP8wGA8lCrbiygHoE2l0v60
	 35yljpEuUKsDQyMvRqu3mxEa3Y8I1o0FSbNiX5kS3s8JeHpxUd04a4abUaB9chSOFj
	 RBx4uyYJWIwdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0B61831DA;
	Fri, 27 Feb 2026 20:35:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B9331F3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 20:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 219A060D53
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 20:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6U5InePO69UR for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Feb 2026 20:35:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::124a; helo=mail-dl1-x124a.google.com;
 envelope-from=3eqciaqskaowgfihvsftcfruccuzs.qca@flex--srutherford.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 64DCE60D50
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64DCE60D50
Received: from mail-dl1-x124a.google.com (mail-dl1-x124a.google.com
 [IPv6:2607:f8b0:4864:20::124a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64DCE60D50
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 20:35:32 +0000 (UTC)
Received: by mail-dl1-x124a.google.com with SMTP id
 a92af1059eb24-12711967e0eso3312459c88.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 12:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224531; x=1772829331;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nRaIjBVYslTopVZnWl1PKdjxejATawghymOdcPvjdcM=;
 b=g0mB4ntHz8qjtG2oH5tg9Z10dWMpmuzZRJVfiiZUoly8JJb/zj4nPQRbGVedHP82s4
 RpgxIS3zdyIMFMg6FAIf4WQYvRHtT+XUrrE+xeLxygGF7u8mbLrY+LMQxJX/+maoDvlg
 hAES5DUGBcqQl+9drdgpPGY1mfNDBo/QQvMLCoNquEL83I6aZpZtiLSy3EcLIS/V4JQb
 BkbJBziSeYH0R6ZXT/qxaq+QSJMuQt8Xc5oC1uHdLROVhzk6cYQHLyRX1beRyzfmwrMq
 DyHdXqzpSxfgKU87kOYXF/SS8faYodN8CFWvTyOk5P0UOiJsh+izbE6RJlqyxhJa5PqG
 l1Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGJ4/BGhFNGtvVUeCj0D4MRbk9s5jxLMlGibDU2u87U0Lika71nkeIaeCodu5RY+0nL60riU1anpmpdYvvsdw=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yw50Ia8hUI+PIjzOtIT9nDWdxSH/MUydEdQ4HuNZNW2Rp0Ngn2J
 WTDQoIo7wEzAhzg9jspUoAeS1Uh9eNyicEpRMbKs/iAERaoqT4+7ZwQI/9MKtEGFPHSTsx6z+H4
 HXiTYoizCD6kAuVy1+B/CFh+NrQ==
X-Received: from dlj37.prod.google.com ([2002:a05:7022:525:b0:127:16fc:ca92])
 (user=srutherford job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:43aa:b0:119:e56c:18be with SMTP id
 a92af1059eb24-1278fc8a31cmr1426907c88.38.1772224529468; 
 Fri, 27 Feb 2026 12:35:29 -0800 (PST)
Date: Fri, 27 Feb 2026 20:34:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227203457.558196-1-srutherford@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, aleksander.lobakin@intel.com, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Brian Vazquez <brianvv@google.com>, 
 Li Li <boolli@google.com>, emil.s.tantilov@intel.com, 
 Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772224531; x=1772829331; darn=lists.osuosl.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nRaIjBVYslTopVZnWl1PKdjxejATawghymOdcPvjdcM=;
 b=hakCQ44qxMT8E6HwiFTMMEXFH8X1wwcuBAprk7woArXdfK0KlWTF72+fbCS5GlnuNN
 L5dskEZHbLJsAibceqwSch5/VkFoQG/qRaZqQJQozdpjrZ1P7IjmFofCpvXskJ+ygXiz
 DfCwcEDrobxOsf9DcWIBhRQDso5cXgFFyE/zTVNJarp1YbeTKRYRxFFIR/cdqR6iakaf
 dOpl5+RBpMDZL+cln+Xe3EnoMZonCst7V9x1c2d7czKQ6+uOw/gxsRuKR6gej8n/9Po/
 Binc9c3jSL2NjH5yHSEboz61JbzEytvkqKXkOrIyufebbojUzFHQlcspRiuRhNkVPSVK
 Utgg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20230601 header.b=hakCQ44q
Subject: [Intel-wired-lan] [RFC PATCHv2 0/1] idpf: IDPF + SWIOTLB Bug
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
From: Steve Rutherford via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Steve Rutherford <srutherford@google.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Found an issue with the IDPF driver when SWIOTLB is enabled. The issue
results in empty headers for packets that hit the split queue workaround
path. It's caused by a spurious sync in that path. The header is synced
from the SWIOTLB even when the header was shoved into the payload.

I cooked up a sample patch, but I'm not an expert in this driver, so I have
no idea if it's the right solution. It did allow my QEMU VM to boot with a
superficially functional passed-through IDPF NIC and SWIOTLB=force.

The patch was written against COS's 6.12, so I assume that it will not
apply cleanly elsewhere, but I figured a wrong sample patch was better than
a long paragraph describing the same thing. My read of more recent kernels
is that this problem is still present, but could be mistaken.

v2 - Updated title and tags based on feedback.

Steve Rutherford (1):
  idpf: Fix header clobber in IDPF with SWIOTLB enabled

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog

