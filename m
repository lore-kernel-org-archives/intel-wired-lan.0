Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37DCC52D7C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Aug 2024 18:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 490A840686;
	Tue, 13 Aug 2024 18:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0AXkR_G3h7-a; Tue, 13 Aug 2024 18:28:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67C72403BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1723573680;
	bh=Xx3vUn4Ffi9+cFtQJZC9o9842wkaz5PPRNr6UKhxqa4=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=80IuuYjDklm12ZZh/lWXj7rSpeJpWkP6HDG4vtdszei6u3xXBSEV1E+b2b05NecfY
	 tttdxmPXy6yhyjNTJRTXEF4VHnwq3vK2BtzPPVPgNYFBbA1QmVzUQ69eOykHNe5sJp
	 dPqT1gUguH+09NOScpqdpiFkQvxks2KiX91U+AfGJuE/HWGdo6ZFlKrqi3jDah5YLJ
	 gZnMukdPIWH9TSdBGW31IXuqx43nPDeMrgE+CWi2DWdYhXsZNHYSEbbHjpsSzRxHIc
	 yAb5AnK1nHLljwRKiOTXkB7M1LsVgKe1wE/FJ63Yc+Bkp34oNFPCUHksKcN09aC3RV
	 e1awoho3FPX2A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67C72403BE;
	Tue, 13 Aug 2024 18:28:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id A50D21BF343
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Aug 2024 18:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C54A80EDE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Aug 2024 18:27:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id om9PQvgBKO31 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Aug 2024 18:27:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com;
 envelope-from=3q6w7zgokdyik8lmhtgqfwemmejc.amkglrcj-ugpcb-j8ljgqrq.mqsmqj.mpe@flex--manojvishy.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D430380ED8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D430380ED8
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D430380ED8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Aug 2024 18:27:56 +0000 (UTC)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-665a6dd38c8so123971107b3.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Aug 2024 11:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723573675; x=1724178475;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xx3vUn4Ffi9+cFtQJZC9o9842wkaz5PPRNr6UKhxqa4=;
 b=bXIutexYw49QgfTl55Jkmjm3dOZi3kfVYlmv1AruMQJ8/MK5B7ZpOi/m29IYkG2z7x
 lsPlqtrf3DNjI47kRg+FZ9SuMz5sFLCGfXULdqRupRsF9VZl8MEfaaBcyMQdpAoh4jsO
 FkXFG42p12dhvxjrD4wuXevCHGb11t1ToSKL5UNweDqBT5Fg55y3uNf9CbxVzPujHoWk
 YLbnwaIbSR26t6j86Aff9aXtimp+lfL9h2+piOYt2g64c+bXk6TkKtFAlZnjUprFzPqB
 1R6eCOdOATIouKNe6Nnx8uerchxyDfansk4hlpgG94LBcspu4TVkZ5Z03hehv5ox8GMy
 k00Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPwNRMqWYIC+tHboL6Lb6IWVVBuw0SpMIUDQrqt8r0X3rguTF5OvU5ZYPlvR7TGRk0mqAF7wrdTaOIAMY6swM966o20w3NDFDWHoeTJ7kHsw==
X-Gm-Message-State: AOJu0Ywns5/zEmV3vKuozxGWSE74ekN7umBw1Sl7jLtBm8uVEEwGhls+
 6XWkgK9vvbh/jeKq2lx2Y/Ri6QN/ZkLyH5x+H3GqyUbIE7wplZNkvSPnIgJgVJKL0NEGv45PECy
 4OTbMmhv3gRVxcCBTdg==
X-Google-Smtp-Source: AGHT+IEx3+U3ZkvA7CMIoEjRZ4BxjgN2Bf0euNJuMc/TelI5R1HUUjVY1E3oCM0wKQAMuhyiSiaKXwm0TBtkioIO
X-Received: from manojvishy.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a05:690c:3183:b0:6aa:4e07:ad70 with
 SMTP id 00721157ae682-6ac9736421emr4847b3.2.1723573675642; Tue, 13 Aug 2024
 11:27:55 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:27:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813182747.1770032-1-manojvishy@google.com>
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723573675; x=1724178475; darn=lists.osuosl.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Xx3vUn4Ffi9+cFtQJZC9o9842wkaz5PPRNr6UKhxqa4=;
 b=3IA0x+jksKxwxxcgxZjPT4AGkbE6dO1I/smmeeWWn5C18yfLBEpmNJ4Nufqhp5vWYG
 uiTJepuA3Y7Kd0cDQKpUENxsglTnz7xr84YSn/5oq3l8u42JAjPm8ctyPOlhanibdxA3
 i3pvZBqahjVBJW2/RITYzxSeRR3Lyb60cac1VN0Bvj+6WaQhlN6Wq3nwqNSU/ETmE4fb
 8A294bp2JugXGszlxEePqJLsYMKQm/jpoQi7ZZ76isgd5BPzUYeKFS8Kn9BQa9/SGLiP
 YFLcAR2lgJKBMEBZFacJf6KymzeB9BcFO3hHgcACLDNnYdqd5pDkpGZ/TlDW2Bno0LNN
 EniA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20230601 header.b=3IA0x+jk
Subject: [Intel-wired-lan] [PATCH v1 0/5] IDPF Virtchnl fixes
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
Cc: netdev@vger.kernel.org, Manoj Vishwanathan <manojvishy@google.com>,
 linux-kernel@vger.kernel.org, google-lan-reviews@googlegroups.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This patch series is to enhance IDPF virtchnl error reporting and some
minor fixes to the locking sequence in virtchnl message handling
we encountered while testing.
Also includes a minor clean up with regards to warning we encountered
in controlq section of IDPF.

The issue we had here was a virtchnl processing delay leading to the
"xn->salt" mismatch, transaction timeout and connection not recovering.
This was due to default CPU bounded kworker workqueue for virtchnl message
processing being starved by aggressive userspace load causing the
virtchnl processing to be delayed and causing a transaction timeout.
The reason the virtchnl process kworker was stalled as it
was bound to CPU0 by default and there was immense IRQ traffic to CPU0.
All of the above with an aggressive user space process on the same core
lead to the change from Marco Leogrande to convert the idpf workqueues
to unbound.


Manoj Vishwanathan (3):
  idpf: address an rtnl lock splat in tx timeout recovery path
  idpf: Acquire the lock before accessing the xn->salt
  idpf: more info during virtchnl transaction time out

Marco Leogrande (1):
  idpf: convert workqueues to unbound

Willem de Bruijn (1):
  idpf: warn on possible ctlq overflow

 drivers/net/ethernet/intel/idpf/idpf_main.c   | 15 ++++++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 14 ++++++++++++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 21 ++++++++++++++-----
 3 files changed, 39 insertions(+), 11 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog

