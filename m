Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424E9CA600C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB16D40340;
	Thu,  8 Oct 2026 15:27:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nzMr0TZQT73m; Thu,  8 Oct 2026 15:27:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DEA3E40343
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473244;
	b=ihTEn1NAU0odq9G2nfjdAU/Y/6p5t6ygnuv/WknzJQghcBGDkZdNfojLP7l3hIK8q6Rq
	 b0hs17o0PElbr7/rC8LwcfbIikpZRem43xNWrPRsXlddIaxgJFb6tSeB/P36D2xMfrxYH
	 feItWVdQZJV5/hMLN9USSolIAgBMqf9nFhW8lkxlCVM345qXPljmRjdTmmdAuloYksdG+
	 DGyRyx77fvj9mRlveibk7gt2qoPS0LBhtZxJ+abx+lRKCYBVuPEmJbTmz7MHigcdCBYX1
	 IaAQTW0Fl0dDT3XVL8Kzw3Y2Z3UIj2XJe4KUYUP2TTbTK/eOYEkdKH65wPxQBGDGB4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473244;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+d7uJDJhZJvHZwnUFL8rPNX4HlSixikJ7Pt8tEZOBOA=;
	b=oNFFFqPih0JXTtVyRvrCJ90KXmLHzFe9e++xn3MKxJyTedgFBK6uBVnnKPeWjlw/cbxm
	 zmY3exAf7TiUAR7PxRCk2GSzxh2a14F6WdqaDPOScrihmrLhQNynio4oIUUXM2BhL2VUh
	 8MXYjgH/4kuzjF3x1KMVDnYpd53GNj04QSat4X45PtctC1j/6JP1uo6OswmkKW0CQCy1O
	 f0r6+IiYYcmh4bFdlQ6eZEQD52jiwH4bZi1kE7ZEx2BW9yOZHLrlLISEs9nxPEl067kQQ
	 crhupVCFioJgPqwkEIODHbEOhmggbQDuwgLgUqNBJgFtQ5VHGBnu9ScwzlpxNkCPs/g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EMGEv+rb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473243;
	bh=+d7uJDJhZJvHZwnUFL8rPNX4HlSixikJ7Pt8tEZOBOA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CFaRw9pKplqUBroyruTg4FVJQFSDNWGJUBegNlTKx8QrlGuZ6X0Hy2wawSZ23c7qF
	 4EqxgUTwB2pbtE8Pif8y2QRsPYbkMK0TBTv6L4IljUbxeE3Kg0PMqBs6yv1ETtjVKg
	 bL/HrLsGXon+I+rdNWUb2NFMrekiK4fPN/jJIdtQpjmXJYnK0nVGU7V9YXQMXfQWfh
	 eZIOq1hZ/tTDjbDNmlXPR6b9vwQ7o17K6FKuYGXrtZT4rqgHLx+MzUEr0gSvgCore7
	 470UnpNfbmqzdqyWfjTEmbiqdGJLIgPcmeIKiFdxMUY5ZwhNB4C2oL4Cf8fJqR1Qtx
	 SQHmgFJ7/c/Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEA3E40343;
	Thu,  8 Oct 2026 15:27:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BF3632F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6884C40721
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Vl2GOAOnp2R for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 18:16:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 18EA040512
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791396995;
 b=lT2qnTG4UyLaNkhwL7jROObfi1cELkPn3ppzyt8Jx07fhLb23fzC3f5bADAOSuC6EEaG
 6/HJL4jW1CQQ0QVMdz1BUiSoOA8kBswdL0Lkq4gmFKL1bpEg99JMABotoZAIlXinQe9ST
 nFgceRG891tI7fzoSEFNhjC8EN98UeNH9/0edYFHBOqTWpAcP/5t207GTuKN+KIf0iV/C
 Kf5/FxawZs9Da2DZJWLggOI4kkZ2xlhIcn9Mg7xg9bcCs5TQTsCVtHRlbJ57HsYdpo7Wg
 mCFmtvihuQjdDjgE3GO2l3TorLsr8ZInKiisvXZUxuP4Z2nW3Ip/212DbN7guA/o0IQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791396995;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=+d7uJDJhZJvHZwnUFL8rPNX4HlSixikJ7Pt8tEZOBOA=;
 b=N+FRwfaC+4RVkjcGZJXabWl2osNV/LTNhTsg12mMA7zlrTCNpiYUasBEumjid5Z9E/m9
 QrdUlSc82CSF+wcMBd0iI7q5hlCwwCJzYNsO0KNbAMlPx89flt0DhZZZAc5dvF7SYDICf
 m5J/CDuxl26pHFsZzjEAm8e/ZcVq0sFNsSZhy4Ir4YnQE9iVs/xjJUiyVuEwoIm4nhrIb
 NsxkE/XKz5QKkvr+zdjbGd09wGzhTMuXAfQ/FN1p6l+jiRzJUGML1Jo2LU/qyFCWvcLGR
 0v1JeCfTDYQvruNugKs71BpRykyOr7Ma/mnm5FrzO3JTgk8LiHSaqzXGS6klmi4DGfg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=toxicpanda.com; 
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=EMGEv+rb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=EMGEv+rb
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18EA040512
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:32 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-5350cc60b51so35408531cf.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Oct 2026 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791396991; x=1792001791; darn=lists.osuosl.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+d7uJDJhZJvHZwnUFL8rPNX4HlSixikJ7Pt8tEZOBOA=;
 b=EMGEv+rb36nJdXOU1M7beTWEkXeB3d+6wfoXtyQ5/6hSzVZRQmAzNNTBTzSTG9zI4D
 cQ9aLg5ijx02n+s9cQiuUdb0ta/vVT1WwF3s+e/egq53Da4/q8Us9E81rsvrkByc182t
 eZTSVmCZRVKPVrG4C5YijQTm/sRU5SEVKBb4l9v6CYxnr/CRJ4gAPsNqE91TzBOifSk9
 qH53F/n50ayIz5eg0ObSTkhP7rFsqTM9mKwxV866RF1JlBhSMNJKeFcd08AQNY2mNmDF
 Mv45VrnaqgWYFDYC4zUxcIA/54JUW8y1I2Hvy09jaTgZDmz5uDjsOSkpDH0yTFkM1Byf
 BEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791396991; x=1792001791;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+d7uJDJhZJvHZwnUFL8rPNX4HlSixikJ7Pt8tEZOBOA=;
 b=wb2Ef8WHFhFmq9F3YuJ0gGW1N+T8PS87MS6LgOuPJ+1CZilC7caTjknQk4r0fPxvCV
 JBZbgYEXf7bC3nY7jMT/dJD5ExNgpEHibJZT0G32im7h8Vb5WUgwqyQypkgIjqkFSjYo
 9AUPwTaGmT3aevkKlDT+dd/viUROZiOSMielw5goOzSm//buDkROYi1oxngycM34x66a
 xJsPFsQNhUQqyp8J38m1U/9KqdgQW+aP48a8pGLDvGFG6vriV7fHfddZQ0BHLmVIsLFL
 681xfQVtHC606jYF2tD2phBGHkBeJ15tVhrsWCX36ox806wfL9a/LWn9nO7vAwf8bOlP
 CXsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzva6Y6uDIiqolve4V55lmIkIup3kJkioZFR0zB7Gk3dERwg7DS4nd6R9O09YEMR0c67yEwY5zLcyPPXvt4PXw=@lists.osuosl.org
X-Gm-Message-State: AFuF++lEKHO/HDbD1FWTPaY0Cs0PWHGJmfSYsPgRuIkeZ0DeBWcRO+W2
 s7n61IqOv0bFsDyW0ByxQCzfEUAZnKOyNUV3xqFtaaNwut3tOUy6edIQBc6OjDVuXuU=
X-Gm-Gg: AYBFou34feuqPDmNYQ/Me2FaRN4F978kuWzK0yBNR7EXTzUqKbcd8liL9Dy8DGd7bja
 tt3pxYByuKLFbziomukKdJk3Ye0+gLQJP55jj2TYhL6nV+nVG3oJCQuU5Jd7aZteUIe5i3etR4a
 xOxi2RSdqO3UABH45l/OpThDzX79BGY0G8nmrkdxQD6Ofvy5knNct7KKhKd6a7zo9OB1zO8CAoC
 JheKdcAiNobq8thk1bVwiL6fSYAICNd9CzqhhY1agiqBR5ZgxXbSJLQONUsihfF1FpyWeLquNFo
 sCnyDKjBEB1V4HO48axBEoYjc8RqUH9GHegHL1HlYJgZ7HLbDhY1kSYabVJbi70IvOKV5fP54PI
 pjHPsEzLRuq+Upnh8PpIBzUsMQYljBDueOUfMDihMYkbV+cP/KxC4uSkC/0IJ04suo/S1Ix8BUY
 F2TRPJ8cZc3jKAjoX4M5/isbATJHnKmW15YsEMgOaUoGNcqh49KJ0/aUIP/IIfAecU0n9/za9VY
 xxK92xrvOtnf24=
X-Received: by 2002:a05:622a:98b:b0:535:15a9:2516 with SMTP id
 d75a77b69052e-5357560fcb8mr47504081cf.53.1791396991271; 
 Wed, 07 Oct 2026 11:16:31 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5357209ff04sm25811551cf.7.2026.10.07.11.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:16:30 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH net-next 0/9] net: stop calling __pskb_pull_tail() from drivers
Date: Wed, 07 Oct 2026 18:16:13 +0000
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG+MxmoC/22NywqDMBBFf0Vm3cEHQWh/pXSRiZM6bUhDJoog/
 nvVbru8r3NXUM7CCrdqhcyzqHziLtpLBW608ckow66ha7q+bZoeyWDSN2GaQsBiJeCQZeas6L3
 x1F17w62FfZ8ye1lO9h0iF4y8FHj8Ep3oxa4c6KNLVhkp2+jGwwqpJlOf5v8z2LYvyPZACbsAA
 AA=
X-Change-ID: 20261006-b4-pskb-pull-tail-drivers-ff4fb2964e1a
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=4206;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=vn8FTVHGMrT37pYQ+kom/lZJg3xw5yD+Z8WzSqCiJUE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNQafSGevfmZO2PVgBdAMDrT/Q8BcDOZO7ALSZDi6LHzWalQ1RcI/ykJ522k74cd/ODbB0drvUX
 1QhkjFs1aWQY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA
X-Mailman-Approved-At: Thu, 08 Oct 2026 15:27:22 +0000
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

__pskb_pull_tail() is the slow path behind pskb_may_pull() and
__skb_linearize(), and drivers shouldn't be calling it directly.  It
takes the number of bytes to pull relative to the current head and does
no bounds checking on it.  Ask for more than the skb holds and it BUG()s
in skb_copy_bits().  Ask for a negative amount, which is what a caller
computing "len - skb_headlen(skb)" gets once the head is already long
enough, and skb_copy_bits() is handed a length of nearly 4GB to copy
into the head.  Under KASAN that shows up as an out-of-bounds read of
size 4294967288, after which __pskb_pull_tail() returns success with the
skb's head and paged lengths no longer matching its frags.

It also returns NULL on failure with nothing making the caller look at
it.  Eight network drivers call it directly and four of them don't
check.  All four are RX paths where a failed pull is followed by
eth_type_trans() or skb_pull(), which BUG() in __skb_pull() once the
head is shorter than what they pull.  As far as I can tell none of the
four can fail today, since the skb is fresh, isn't shared and has room
in the head, but that only holds because of how each driver happens to
allocate.

pskb_may_pull() and __skb_linearize() take the length the head should
end up with, check it against skb->len and fail cleanly, which is what
every one of these callers wants.  Convert all eight drivers to them,
check the result, and drop the packet on failure.

The last patch makes skb_condense() check its pull as well.  It can't
fail there today, but it would undercount truesize if it ever did.

The callers left in aoe and xen-netfront are fixed separately, through
the block and net trees:

  https://lore.kernel.org/r/20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com
  https://lore.kernel.org/r/20261007-b4-xen-netfront-short-head-v1-1-12d7113a7e4e@toxicpanda.com

Once those are in I'd like to stop exporting __pskb_pull_tail() so new
drivers can't pick it up.

Testing: every touched file builds with W=1 on x86_64 allmodconfig
(ftmac100 on i386, it's 32-bit only).  e1000e under QEMU, which hits
the converted TSO workaround on every TSO packet, passes TCP traffic
between two emulated 82574Ls, and with failslab failing 5% of atomic
allocations the failed pulls drop the packet and nothing falls over.
The same setup with jumbo frames and copybreak off makes
skb_condense() pull frag data into the head tens of thousands of times
a run.  xen-netfront ran as a Xen HVM guest under QEMU's KVM Xen
emulation, with the backend changed to spread frames over 18 and 19 RX
slots, which takes the converted pull in xennet_fill_frags() and its
overflow path.  The other drivers are compile tested only.

Thanks,
Josef

---
Josef Bacik (9):
      net: ftmac100: check for failure when pulling in the RX header
      net/mlx5e: check for failure when pulling the Ethernet header after XDP
      net: niu: check for failure when pulling in the RX header
      xen/netfront: check for failure when pulling in xennet_fill_frags()
      e1000: use pskb_may_pull() in the 82544 TSO workaround
      e1000e: use pskb_may_pull() in the 82571/2/3 TSO workaround
      netxen: use pskb_may_pull() to pull excess TX frags into the head
      qlcnic: use pskb_may_pull() to pull excess TX frags into the head
      net: skbuff: don't reset truesize in skb_condense() if the pull fails

 drivers/net/ethernet/faraday/ftmac100.c            | 10 ++++++++--
 drivers/net/ethernet/intel/e1000/e1000_main.c      |  5 ++---
 drivers/net/ethernet/intel/e1000e/netdev.c         |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  9 ++++++---
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |  2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |  2 +-
 drivers/net/ethernet/sun/niu.c                     |  6 +++++-
 drivers/net/xen-netfront.c                         | 22 ++++++++++------------
 net/core/skbuff.c                                  |  3 ++-
 9 files changed, 37 insertions(+), 26 deletions(-)
---
base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
change-id: 20261006-b4-pskb-pull-tail-drivers-ff4fb2964e1a

