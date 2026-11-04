Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C948606D802
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=v+fdIrGI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lfh2EDLR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35D93405E5;
	Wed,  4 Nov 2026 07:51:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zYUiOKriYYp4; Wed,  4 Nov 2026 07:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E382405F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793778667;
	b=NJ762S07yEreDZMXwYOA5cp/CgieWqgVB1aD/jAejgwTfBTffWo/eelmfHS8f+1KJY+/
	 hJJkgo40dtczKBdsoOxbENuABB3fEaX1XXuS8KviN0+JGYQaDnK83TEI/VmPIdfD74SPk
	 qwrYOwnO8hY8JQjudiN4HFopOOtfOYrjNNQtOcuRApQOJsXszwEY/8El+8gplKNNpTQb5
	 y88Bk1rGr0NgHVT8+/3jwQiLrauYihNvNGE4LVYtxChoVC0KCdEKlgI29PKIuU9HZShZz
	 lkF3zZ5f2YHpyI39qXaSOefgsI37ATXQkWdriX1+CZbEqdvxZ/zfX3p9jXkf2PSwZEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793778667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZnBMVlBZ9FA7vi+t9qEZyDr9qGdnO7eBQQiCUp2N+qs=;
	b=nXsYQDMv5Om9/BzPmg+pbIsCdjuuUK0zDIrnuR+fDSaTIcnCvYH/dNyNWR5zzufnjvqc
	 1fC+OneYk5vJ181khgIiNss0DhpbVwnZXxnzz3Tub/l3yLcb27Kjjhl5if3DVzrUhAgvy
	 laeTzr19aueLGqF49xa1+hNqj5YXmGaC0s2vcE26eqGuIphnqnmSlq26vmOLDtQyn+Fo0
	 z+7k41OEzPx/Ugp69CGaw5FzuvtnRlPCml7PxkPXLbaJvNjR96wjjj0J2maNnKQGmNXuO
	 1Ka3wTKUWwUWqW8Xhrq674D5TVW1lTiQdR5xdlzvTdkMX4iW5Bfvr/Ii8jEaC7rszRA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793778667;
	bh=ZnBMVlBZ9FA7vi+t9qEZyDr9qGdnO7eBQQiCUp2N+qs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v+fdIrGIta9ER++1tGXdrmb9eZS2cAlR5KzfYRZRYN42U/tNxAuRuV08iIXg71sTF
	 E/93chMYSRunKSifivkfTf/1QCi2AwClRLITgRZw3G2QBEGydElQetOy1PPsi5Lpb7
	 ZUyawrv37xXCddJTzGkYw4Xgztop99RLkKyJlxFPyB2ZSNB/liiOK5bCho+7bXR6CK
	 Pv5aiIuIQKnJZkCsYWv03zaSA40H6EpmQIAi2KFYWCJGeWOwQuht4CSYIZfFVy/SMX
	 cY5/JP2MDZzseFEpM8/CVhvCR9Uu1Y7mDvfFXg3RDBqGWREiFMH3Frc7Rm7+kiGqSy
	 el/CHp/guYtvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E382405F9;
	Wed,  4 Nov 2026 07:51:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D827937B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 07:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9F1B80DA2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 07:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eQm_hh53b5bO for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 07:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E308280AE8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793778665;
 b=N6KU7bRAWePjF6cvDcnxjKcG9kcHCgAckf7xK++z/u99Ose0kA8rE4dYqb7voVGrC/vV
 Fa/dGQjL+nT42TtB62v/i2dmMuz2NyWRTTqAMYfYzLXq9hUx4d7UlU6oXwTEY99lrvWnT
 FAHR7HmNyGxhyBoyWgQWmqC7nhhUZe/6xc4j0gbMMVnrVGrcZoyf6x/aF9PqdbGzRzBu4
 ucjdDZgoPk5CYWK7MBJPf9tiDP8OHuFCbeMjnx9BK02+re7Rl2y7mGvelg5qe3s5Pg8IQ
 gNPbqC7UetZOCdGBkKvYzWUptCnrRPbyXe/RPNpqQobFraDlph2n6EIRJs2rI2kXcxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793778665;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=ZnBMVlBZ9FA7vi+t9qEZyDr9qGdnO7eBQQiCUp2N+qs=;
 b=d9VGMwXGcV2OO3cWkVaTqaOHg4sWKrgX7ZVMFZJHztiGAIa+zkN3c2aCjLcNKKjpdKM4
 lXrznUt6TRFR9RIfGbd/2EzQwa87byHP9bFxGWEU5ocXiXUyOCBmL2iIaGrjccEr+wk6U
 ABs2UQwY/NsPCfWroDUyes6tdymM4rI0wl1LnDdw8JPxKjSY5J3JY4BiUcq86JS31KrO9
 KxWFGH1vz1HIOsEqDKVKYtQdrxDKW1vmby3MyVxMYAQ2P9US+3JiTiaZF0gCFRkSxt+TT
 mAhu7ts/j3HqAzV5SRFuum2IFF15s8f/5tiOw03yo3r0LPHCgs50l5f8PkzQ2g+3OqA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lfh2EDLR; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lfh2EDLR
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E308280AE8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 07:51:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8278B43D94;
 Wed,  4 Nov 2026 07:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE751F000C1;
 Wed,  4 Nov 2026 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793778663;
 bh=ZnBMVlBZ9FA7vi+t9qEZyDr9qGdnO7eBQQiCUp2N+qs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=lfh2EDLRAKl6CugKHqK4Nev4O1PxVPLC9pM581Xp9avVw13KEnVY7BFw8YQm/qKxD
 zazub/AMBbFr6vMDGXMsZY3e4qhNFpeelWjx7SZOK3AP28Mt0RAeqyEkJuo3ipidQp
 Oz/Yyvq13oCgiU3vmAbSlQfkRFAIz1/Xu+ortNqfrTdd9N4oeUnTipUkUPl4qN0k/t
 NHAMK+AI29+U27RtoJy06mr1eStKrrfeiQj4LQSw9TeNHKEKCR8MTQUyCDGDy2Lfxt
 zbNxg5aagJwgaQh1gtGZ2SbdPR0BKsyyAhVCyeulo6MFnHxvLYxL9DhQLEUWDJo4Ww
 09Bngcb+Ddo9Q==
From: Leon Romanovsky <leon@kernel.org>
To: Mustafa Ismail <mustafa.ismail@intel.com>, 
 Shiraz Saleem <shiraz.saleem@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 David Hu <dhu@x6u.co>
Cc: Jacob Moroni <jmoroni@google.com>, intel-wired-lan@lists.osuosl.org, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Hu <xuehaohu@google.com>
In-Reply-To: <20261030181512.2056056-1-dhu@x6u.co>
References: <20261030181512.2056056-1-dhu@x6u.co>
Subject: Re: [PATCH rdma-next v4 0/6] RDMA/irdma: Add support for ioctl
Message-Id: <179377866057.1745081.14077156608414561671.b4-ty@kernel.org>
Date: Wed, 04 Nov 2026 02:51:00 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 30 Oct 2026 18:15:06 +0000, David Hu wrote:
> From: David Hu <xuehaohu@google.com>
> 
> Hello,
> 
> This patch series introduces support for uverbs ioctl queue creation
> (QP, CQ, and SRQ) in the irdma driver. This series makes progress towards
> modernizing irdma. This enables 1-step queue creation from pinned UMEMs
> and shared dma-buf heaps (system_cc_shared), providing RDMA support for
> Confidential Computing (CoCo) guest environments where memory encryption
> otherwise prevents standard host-VA-based queues from operating.
> 
> [...]

Applied, thanks!

[1/6] RDMA/irdma: Plumb uverbs_attr_bundle for QP, SRQ
      https://git.kernel.org/rdma/rdma/c/18dde0629b58a9
[2/6] RDMA/irdma: Register irdma UVERBS ioctl namespace
      https://git.kernel.org/rdma/rdma/c/7a69fd61897e60
[3/6] RDMA/irdma: Support UMEM attribute for QP creation
      https://git.kernel.org/rdma/rdma/c/3f68d3e1326882
[4/6] RDMA/irdma: Split CQ setup to umode and kmode
      https://git.kernel.org/rdma/rdma/c/d1d5209ec8d49e
[5/6] RDMA/irdma: Support UMEM attribute for CQ creation
      https://git.kernel.org/rdma/rdma/c/b6da1bd879f1e7
[6/6] RDMA/irdma: Support UMEM attribute for SRQ creation
      https://git.kernel.org/rdma/rdma/c/45ac42ec8a486a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

