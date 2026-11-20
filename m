Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB6B606A334
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=EgFGIJkX;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TH6LUu/W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF71660E96;
	Fri, 20 Nov 2026 16:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iOld5ym7mmt7; Fri, 20 Nov 2026 16:33:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3747260E85
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795192389;
	b=YHuNFUKHmCaVXD/cHryoFxJCYIv3rj0lTA1RIONpGvsHH7aouE9U+ndf/qvn2rK83Rdh
	 C0ChZpHrXkcBoTaVywk7Yx6GpZtZIFCPAkiAJ01MAfZtmV/+iXP7EcsNEu8Nvz+G0GOqM
	 mYOqzTj1HpzrMzzFurl2bnO4EzgX9uhHVIGwb8KeR8dYl51oBC1IGGu7IaY7WNuXaKmoh
	 n0Si7XJ5YOg9xWkyFqs1SdsZ9nN/uxFo1v6EnaoP4dXXofpCKAsvgpSjYpgI+X83+Rovi
	 hgsbFrAaRZZatPCl8FLcIZp0an5ykxyz8LhzQ7hdQL4NIuPNjFuoJXc4BHHOhyY3XwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795192389;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9Q+A2Pm/lTzn6/74RcxfPC60rEW9xoC4OYcN2wFWBNQ=;
	b=PrlGE1Br9HRCKbyNkcRyJhfFF+qd8OnI8wKWrIwMZEwKByNrsu3UWWunpGEO3mmJZFwK
	 yM3UwjDZAS/UW/2g+cBVYRo2GxAwLTjqdxoqhKWz2ZTROtx+vJNf7Z3803CaG3R14Erq6
	 h39DX8198Zw7tbVwb95xP2xlxnxocRla4CYK8Byz+Dd00bdGhciiE/rC5omTYNmFGXMaL
	 lDJyUVZpt8609bkHTKS/J/TXcbbUzicoAEB9JZwDyH6YmdSAspiftUDfo/7vb+eeAEw5q
	 XJ8bLIQOrJb5q7FaPvPkcYJoSRDENthbz3WFS5DWLwP9hdIU/kPs/0HciXdfEFgitWQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795192389;
	bh=9Q+A2Pm/lTzn6/74RcxfPC60rEW9xoC4OYcN2wFWBNQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EgFGIJkX5YyRydE/9NxM3Yya1aA7+HQG78yQS+S+Md6wmhukRWgn46CYXZ41nfihU
	 LEHX71d5Xg1aJK7zdWS6INPa4rmuMJ+x01csmqRTVfj71+8gmS2GnSi/p84URQ+oa5
	 +6GgmuIZWsnBtUQdANHEhjwK9ELSiRJg2IALko67CVfbuNnaaQoz53PRyUoGUT9qcR
	 RnHCNRTKtfv+L+TUSyLryuA+Om8boNOMDuxG5D2Q82CLOWCoksmVOzHpvDWZBReOS5
	 WUDShl4nfRMblwxH9qLvpxZ73tMAjDzx82s0BK5uNRDq2xXafI98sYhZA5Yt5iMJ3y
	 8w9dO4olU3MLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3747260E85;
	Fri, 20 Nov 2026 16:33:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 462E415D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37B0E40098
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HG866JlXZT8o for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 15:06:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5FBD640050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com;
 envelope-from=shital.gandhi45@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=TH6LUu/W
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FBD640050
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:06:26 +0000 (UTC)
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1b3ada81853so1131990c88.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 07:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795187186; x=1795791986; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Q+A2Pm/lTzn6/74RcxfPC60rEW9xoC4OYcN2wFWBNQ=;
 b=TH6LUu/WkpCu5EzTBUkD1lZMMM1CYn1EYKnNzlQG4VSjNHQxmuKqCOTg9VpZ7XJxn2
 7YztNwfN6bXyFkFbMwCgfLHr27OEgvbZIc/kc2KRUnmxp8d9OhdV5ZUhNB4DyNHfF7vJ
 WrWeuaXQbNX23q4oPZ0109jR65dJ4e+g7Zb/J4Q4Tss9C9/R9qOc88+R+4HKOFKjE792
 dYoZ9JUePUEDLGgebqzgwOp8ypRFrfnqyL0SmIvoTCeNE0BtxowVcwUImDDY1DZ5Vtfq
 O6k2ISrY88dVGGnJnuzhPsvwwZWilyoc4ckqM266RFjqv7XGNyh00zxp+Gfi92z8NefI
 eYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795187186; x=1795791986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Q+A2Pm/lTzn6/74RcxfPC60rEW9xoC4OYcN2wFWBNQ=;
 b=wz1Fy27V5SkLW9oK5lBSOJvx5XVpH4aVd3BE6UbPPK/k8PBWrI+G0c6e1lBdwoLsI7
 rz45GOpAk9fD5/ZOIZAZ0leKhZFvSN2xycNO98fq76y76t7nNEqNhLXJhctESzJi5lwh
 9K1N7BSadW+rrrnJBVmhopyhCQxvEGYbdlIX18VhIrC+InoVlIQ6nIBrqp7N8oYsdvMR
 bvNjdE6r2eQW8SpDLkaFC+OBieS9yN5EsNDi3v1Ue5hL51FmEUKCALreqIHqc1FPyBF7
 OnOnozFewba7QGhTKABvBdRy9D+zrEr0nSixJXfZE5eeB8QD9o/Jd5uJPliQfOAmZs53
 IuNQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE1AFbJB5TCTa9N+qvd3lB36+sAJOBHb8lQFDz2Ykdlrkii2Uj7BDvQhJVyA1JsM2GHOiYqXaJMw7O7BawCFlo=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8ec+mgOusmqXLVdcLLLwTKdvzG8xLLT+sUgeVL1a5NamSUL3kp
 eyFeUrG2rYqUZdgqPQLcdGdldxTp6xNgl5u5gHybZs5kzeHJDOkqurll
X-Gm-Gg: AYBFou1R2tNI7hOv8oQRGbCMYdruk0GWbC8fTozr6jO3zUdG7vkjy0fPMwgo1ObU2rz
 4Msuf8pGc5RMU3/GBKI+Ri3z1X5C6/9bQjUPKilF/sW2ia2nmlzTsoaDMpdZ0eWFIPQ+ld3cy/W
 CLxypiyozj8EocDk6R9DsSbwHSmNSfxVk5qjWcQCzPpfY3OtsIuEVYOjsEevWxefxywKqaW4X4P
 eqlHkau9FlCiX/kqjVLExSMGTu/jKl0jJf/wgHNrQ38FRRFZJjk/cQTUhF59HKb+qr2h1obrf68
 egarLWbXZE5a+QL4PeIu8Q7QaLmMorURZhCFp66vZyU/o1VNz2Jo4F5ig96vjfFhwXirXjmRokx
 3h8Qa3AxoNd+Cg9T/el6DUOZ30ZBIYlspa7ncNXsBGqcVs90af1ygfk2VesqDkyQHJoR7rYWBhN
 Df42+rA6n0zQFcwlAtn9p2R4K92yGm2sh2kwWdC5IG29VvOML4bMzCi9ly+hEYoSOvQykLNkD39
 d34hPqIFwUt2GwLwyNFztcSim71tMYFw3bdgAzp+IvXvNjrgHr8WkVPwmc7oi5rndHpnhlnbBmU
 iG7jBrPHMRk5M9IDOcFm7Ji+8/LPXncnNrZ5Bo/SUShR0tkDckKgvTK4Vi219Do=
X-Received: by 2002:a05:7022:3f0d:b0:16c:3408:760b with SMTP id
 a92af1059eb24-1b5568dabf1mr3023904c88.32.1795187185858; 
 Fri, 20 Nov 2026 07:06:25 -0800 (PST)
Received: from IN01-9QQVVV3.CAMNWK.COM ([171.76.82.79])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556840494sm7844902c88.12.2026.11.20.07.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:06:25 -0800 (PST)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Subject: [PATCH iwl-next 0/2] i40e,
 ice: one RCU grace period per XDP ring teardown
Date: Fri, 20 Nov 2026 15:05:25 +0000
Message-ID: <20261120150527.14649-1-shital.gandhi45@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:33:05 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Both i40e and ice wait for an RCU grace period once per XDP Tx ring
when tearing the rings down, so the time spent scales with the number
of queues (i40e) or CPUs (ice). The wait only has to cover in-progress
ndo_xdp_xmit and ndo_xsk_wakeup calls, and one grace period taken
before the loop does that for all rings.

Compile-tested with W=1 (allmodconfig, x86_64); not run on hardware.

Shitalkumar Gandhi (2):
  i40e: wait for one RCU grace period in i40e_down(), not one per queue
  ice: wait for one RCU grace period when destroying XDP rings

 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c   | 10 +++++++---
 2 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.53.0

