Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1CBC982D6
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 16:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AC8180653;
	Thu, 17 Sep 2026 16:07:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtroLSMJcP3p; Thu, 17 Sep 2026 16:07:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D97981097
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789661230;
	b=Zu7FKKQaVBAwhj5GB66tGimrnRrULpEfwOodMFZySoV8CTwuMzOCXLryHyg3UdxZaJnp
	 dG8SP83sZEv3mCEk8ny1k2Xe+PcXcjB3lKUyG0AWKtqA1bXsQpDRUgMkKAuzl3Zfoc2Iq
	 Ot+0rhn6QyjaWo/skJp6d0PNhU4q7wJ5q5511fJQBl5q3kmEo3fxIaQNdPE0DXYXDESW8
	 1M2XpTkVr4sRfEYc28FNub6ND+yo3CbmVk0UfoBEIhSb3NSFnYducPKZl5Ssb1Phli+/e
	 Xa5Gmrkt6bhyOZdF6zgdoltIAIkw4qJXCe7CgBJHjfMNWMqyKappYyAC0piUnMmvARw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789661230;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E8d3Fh9qdYf4kz33kMFEhvPXsHkGC1s2BDYeW1CWXTw=;
	b=YAlecJhp31cD8fM4yZD3hrUxZ2MpDv/kH9NqCthvTF7bXdchIsRAj1CM9qtZ1IIc9kcm
	 HHXJ0FnLxSEWhhwKi3ppT4G99JZo7mUeLUnsyEGi7AHxuYdhq5IAKCEoAbVAB9HodqGRr
	 fJ1sG17M0f0ive6e3vRNyG2fztF/XIFqWnqYB5dDUKojB3CbImW2LJ2PZf3e8Oai0pVO7
	 kFZhEefjDIoLmYsjq+6kzJ/hANlntM7h2NOsWa/21fc+pLZAowBEIBe+WtyPnN4l6v/Gs
	 O5HQiTFwH4KXfXnGwoqK4NROPvQdQx5R0lVh7m159RwWXI/lct8yV0PWOk5zazMfPew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789661230;
	bh=E8d3Fh9qdYf4kz33kMFEhvPXsHkGC1s2BDYeW1CWXTw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2kYatbCvr0ZNoXG2NNIcpGhupH6ICYU57C7CAK5kTIuFO90/YhkxVVuekjP34XG/M
	 LK4snNz2mXDF1gTwmnHu9b5bw33ipI6pjfqbHuy2AEFy7teZzke9mjivya7TRoLavy
	 jgFI0wGLH2+PxXzz4/2Dmy2tD7QLPWQ7y3lzrSkldwqN5yg0aqT2XGj1DOXfThs2jC
	 oN6T/tOxPoBN/ta8U1HFdEcjlApiulMcvfYmY2oORTJ7mhzel2PPF/FlffLZQ3tpJw
	 A0cfVC4ct2555Mm+SVYajPZ4ptHyoMW+HGpicFtkdaoY5mXqSzXeuVG4mFZ69iAJ29
	 LWusihfWyKRcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D97981097;
	Thu, 17 Sep 2026 16:07:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4154424D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27D6E4024D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66DIkXuRdhZM for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 10:52:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6F64340050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789642333;
 b=dGQw6p0nAVlFCSCJ1JqhHNfrOfGTKzPb6rJoZ7CDKXubV7Pu5wtOpE6dwzfihi9LSpH3
 ob26d83a3QC5o/nbbLUpgB1bsTtgHkemlIsj0G/A+uCcmfODXGrbhH7GmuDesHMQbQWXC
 l1MDu2HGQyxVE+I6/0IA2NrR/5F4zlfYDd+bAtnwluB3YBSFiMY9y/52KZfRfd7xJ3EsZ
 rtEtV63OQI0AAzaXqrETV5Lc/SE578QPMQzLKk/8SW1zqsP8Pvu+ZlUFmujxJ75TLi01V
 Ds2LU9rNaOB5zq8zlU9ocOAu108Cj814OOwGmOP03TE+PCZwo1ZWodhw80Q6w6obaew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789642333;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=E8d3Fh9qdYf4kz33kMFEhvPXsHkGC1s2BDYeW1CWXTw=;
 b=nEWHLDrU0c0/+sP29OOFebWl31oEjUJ2WLxPnlJ8I/7RZ8XjwniQDQVHlKhWeCy9KaDE
 qcHXDbwQ63kcOAFVIpR1VaQJ9biBHRVkNnrSF25/3TIs9sMftR30DDAMeDoxGo+ch9TSq
 dIP7K7/+f6gEAKGRh3x8Skk3P6sjMO8NXoDJNtQFw7A/7EOQYX9L1Fc2wP8J0sbo612Z+
 fn8g2guBkp48PEh2Xm1HReF0To1DcwacX4eWQdchIjmcpcRFaMBejlAPW3szu0wTrdQLP
 Hikc1YMkspfI8uYKenI2d5Vn7wPPQ3psBHY4uBq2GLwgAWl58WjD4X8/Rm7VFoh6CQw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XTY4fFh0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::f;
 helo=mail-pj2-x0f.google.com; envelope-from=luckilystar08@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XTY4fFh0
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com
 [IPv6:2607:f8b0:4864:39::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F64340050
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:12 +0000 (UTC)
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396cccbba92so562349a91.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789642332; x=1790247132; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E8d3Fh9qdYf4kz33kMFEhvPXsHkGC1s2BDYeW1CWXTw=;
 b=XTY4fFh0i3Y8BpuG6yDNC991252P5uzF7Xp9yl0Mp++DI7h+5NCmzzyuIlk5bR+Rit
 y+x5vx8ZihOS+fostBpUV6dIMewrRLdBA/HNJYqA/C9UXl9dEtV5SglCl9aqz9XLmvFf
 4x9f2lKLL9pjIkANcx60yHeKCue0eNe8QdpoQ/EcT8HRwK5cJe+ZXRxQCYwtbs67QJkn
 6uJp0UeWLMWz+PoZZGQCDe0Pa4NT6dGpai1qanqloX3iZxqP/Lktexx8ZkbA3Lg6XFix
 ePJuEwy/433r5hWVNZdBrvZu1xoNtbF3+i5uawrpZtIHkRbNebJuSaKuQNRyEH4twqow
 H5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789642332; x=1790247132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E8d3Fh9qdYf4kz33kMFEhvPXsHkGC1s2BDYeW1CWXTw=;
 b=pClWAV3UjR1A6sAFxZgU9M3nKC4H0xzYGy42qf3xr99YOprW+3WVF0hlpaI7Y3TCd6
 0zbRUgK9is19bAiIxxiD5Bdvt3b038LJLlro7CctQ3jzw/bVyYinfoDha/vZtKmdMqtc
 m7H2jY68qoR+UK7p4q2rJ4S5hyOgU/0wEi+cAOxDl/UEVy7IzbH3HQZMIKMIHkA0Af5b
 eUD7gwnI3N0HfbAlECoMK7EbmiMvDIBnTCsG9otu7cCRJJ0WYTkFLA75r0yqoT8rPly3
 SWa0ODC78F9giX7pLkTALLN1OXDTMET3CM3zjCaL3ZipjSfHkDoldlygXNQ9NJ1LfqR1
 FqRw==
X-Gm-Message-State: AFuF++kFv39bC4C/Lwb0Jc1wBlVA0hoMFx1URLB7dxt/y2wFKZE14zQd
 6H8kGDktc7/92RahNLl2vE1pRVcl/TkX1qewW2tj1xKFP0FU2DuS80aZsCrPq9PAFGw=
X-Gm-Gg: AYBFou1BKwkD3R6c7IneR1ny05rjjeJZnfRjc6nC9oABLNYm5cWBNedp5zlCG/hT7Cq
 koni0I90HPZ93izy+RP83Jr4cjZnEfyvDHsb5y2I8FhGZCzhudd5fSt83zTSE/HykjPyOjVIwEC
 4TConmZ1D6Ky5WwkEVAVKvmfmsQJ5jNz7wFO743U/A+ztNNE8SpkVjUtMOeRWaBFnGVAAvijJE7
 eIpSGgaU2/2s0tpSqhjWc5O+8yLHBCJ1DuKH6MP3h9aQzduyN2SsPGQm3l1F5/wcTRXiIFDWtPv
 WZnAjR4JC28HIV0kqVxeDNUCLKfOqnWgk1ly6XzDUyqIZitA++W882yHppT/A9fayOAfYkmnjSc
 lvkAKUpQQLwUTeSTQgYc6kZxNWyGm4EHUy+FfBmC8WXXSyBBbmuXWXVB49ptjw/7kLdwOu5mHGP
 CQoY23SQa2JiTrokiNtredw90pHmTlgGDjcBiRBscI+2Si0eNjYcahV7klImNoB/joiDHopSBzn
 QmG1wyr/GQq1ir5FSs0ItDvF7TyurckOVcriSRGk4U+uLW3Ao5oU4XrRTWJ4R76XfwrabcZnAXa
 qe8=
X-Received: by 2002:a17:90b:4a51:b0:39d:ecb6:8d40 with SMTP id
 98e67ed59e1d1-39e1e277458mr13370263a91.4.1789642331967; 
 Thu, 17 Sep 2026 03:52:11 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e361b8e1asm4486019a91.12.2026.09.17.03.52.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Sep 2026 03:52:11 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 emil.s.tantilov@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net 0/2] idpf: stop stray device writes after a warm reboot
Date: Thu, 17 Sep 2026 18:52:03 +0800
Message-ID: <20260917105205.37561-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 16:07:09 +0000
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

From: Tian Xun Ng <tianxun.ng@bytedance.com>

After a warm reboot with idpf loaded, the device writes SW_MARKER TX
completions to DMA addresses that belong to the previous kernel, about
20 seconds into the next boot. With the IOMMU translating, this shows up
as a burst of F_TRANSLATION faults from the idpf PCI functions on every
such boot. In IOMMU pass-through mode the writes corrupt memory the new
kernel has already reused, and nodes crash in unrelated code (page table
freeing, slab allocation).

The cause is in idpf_shutdown(). Since commit 4c9106f4906a ("idpf: fix
adapter NULL pointer dereference on reboot") it no longer goes through
idpf_remove(), so idpf_vc_core_deinit() shuts the virtchnl transaction
manager down before the vports are torn down. The disable and destroy
messages then fail and the device keeps its queues enabled.

Patch 1 keeps the mailbox up for that teardown unless a hard reset is in
progress or has been detected. Patch 2 restores the function reset that
idpf_remove() performs on exit.

Testing:
- The same two changes, backported to a 6.17 kernel, were run on arm64
  (64K pages) servers with two idpf functions: no stray device writes in
  151 warm reboots (130 in IOMMU pass-through mode with page_poison=1,
  21 with the IOMMU translating), against stray writes after 20 of 20
  warm reboots on an unpatched control node.
- Not covered: restarts after a kernel crash, and a device that cannot
  answer at shutdown; the writes still occur in those cases.
- This series is those changes ported to the dev-queue branch of
  tnguy/net-queue. On this tree it is build-tested only: W=1 builds of
  drivers/net/ethernet/intel/idpf with arm64 defconfig (plus IDPF),
  allmodconfig and allyesconfig, with no warnings. It has not been run
  on hardware on this tree.

An LLM coding assistant helped analyse the crash dumps and fault logs,
locate the shutdown ordering problem, and draft both changes and their
changelogs. Both patches carry an Assisted-by tag.

Tian Xun Ng (2):
  idpf: keep the mailbox up while tearing down vports on shutdown
  idpf: reset the function on shutdown

 drivers/net/ethernet/intel/idpf/idpf_main.c    |  3 +++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c    | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)


base-commit: a98bd9f12dc5ed64029d00a8192a28685a54a587
-- 
2.50.1 (Apple Git-155)

