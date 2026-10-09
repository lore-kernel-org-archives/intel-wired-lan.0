Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AADCA9EBB
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22A1881471;
	Fri,  9 Oct 2026 21:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GpaEZ_1fjZ1J; Fri,  9 Oct 2026 21:04:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C8F981299
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791579842;
	b=tH2v0qGqlfMg8MrfvQJaNcOFRehKxvlJusU0T2Ax3hkgNtDr99RtitbL56DSJb5EEXJs
	 q6A5bubvHnkfh2ktI1fTSJZ2ok/ZLn6sq6lpOt1Z5SlZfmhJgDLk0c2lnhv6tryJ80kmR
	 lpBQ4CE4mYJSXx/kELCqtcRl7o2r0KVXvGeErUtvfmPrc2ELmSFFUkivlN8OMzsODuwEi
	 J8X/7Qa2Y0k0zBQU+31NHgp9WDMlcJJPPNiQijUWmROR3H7nirmSqvPu/9Ir/mZyjid7S
	 5L0qfFKs6JJFJQFXPNgSqGcEZBEt3I3mYMrdTPvuQUEk1IEJ4iw6zwiQXL41GJzUAmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791579842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Mo4nF0ATan/SOiBlE4oHVy3vMEhRIw2ESPRseHUQrlo=;
	b=W+sMaLnjKBSm+g13DUPBsF89qgQwf7vhtMEmAfCXLKWG4SbBSu/lBdx4Vxk8z4xkY/xo
	 RQdjgyKFibVg23VlokifR5Fjucp//1cgEtmjQX/6KDNi+623lw0bvc3xHrRyvlV9Wehij
	 a9a6hc9ERJ/zi6oCx18Ewg1zNdeO0bCnu2+fmYzabZkIqimbEYDKiav/yYWYpc3pyYJ9g
	 Bv8ybsAavYJKJMkamYTGoceE/zbNN3C2P2pYtblIsua/V9hvpR9jP6AbBG0tPWJzmnl6B
	 iP6mcLEjn0ZRIZeGilUuUPPas7M2ze3Pp9K+One5CakKw05Wf5xMKnoLNyH7RtWHEGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NeqHZQZs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791579842;
	bh=Mo4nF0ATan/SOiBlE4oHVy3vMEhRIw2ESPRseHUQrlo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=XlFnuOz2vbGk3xFi7ueitCNhtomJV7r1UUrj5bG3YyUQ4IXdmMMd4bCWXlZLq31bO
	 FHKbQDtD7EPUlxs1fQm/baUwo8VGkAx1BHuGlw/Ndh4N0UPRB6QquW6vI+rc98I/SE
	 ZHokt4ydYRH1y31gwPjEh4G2EUWUjXNmqjKCKh5fJmirpvL6436Cz0qssiUD0H6Wto
	 fXwTlVMo81q78wncbhIlQ3fuH4oke2lt2VAZSQ8Rie8xXl6Fl/maiEwYnZFG4o7t9e
	 UeCRHvvz6hIWzwzS07BP+kd1iVvJvGU/g21DgYOWsAKJNY9GxewOFu0bQ02zJV6iCX
	 d9s1GREtwlzgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C8F981299;
	Fri,  9 Oct 2026 21:04:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4429C1DE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3610281299
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWHszFwYleGt for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:03:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5ED8A81255
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791579839;
 b=kwy5qu3upsC3QX81UcAtuwhKouTZycmSr8k5vi7xZjucHfO3pzzguUKke2xFQg/S72os
 l/xoTE1Whk6SFie8uu0iiEiS7zAp9Na3q53QIQuzo/ionBxJzg+smZ4e30reEwhUXXYi/
 Vbz0gSesZ1u2THQEhxdAOhirvvMpqV2rKoHAYT1HGeJQU0mOos+5WDsIe8CbuPkbNkB0X
 VBn3S4km2uF9oRH8vsSfhtVExRpW2zVxxG59Xc+i+HY3/3oV5Pes2WgYHCTQnTUP3vAMy
 1LjZqtcwt2OC+dKEXk3c6xuzX5FkbjX+OhNjsD4KNsDESImwOTBzwOXjoQLPXCsWcVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791579839;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=Mo4nF0ATan/SOiBlE4oHVy3vMEhRIw2ESPRseHUQrlo=;
 b=YhMvMFbHvlylFAkBGkHh4AoGF70dhXvOCX5KHp9Z1IbyiC0cgmWEWbLViRwWTWBP0B/4
 oxV7WazSHduJjfaAYcwbbyviCi5K+wR1SsPnCaJS3wjQnpfo1jow5QlRf2WLlHdnnSkYG
 mWVPp/iddMFf7v+7Lwmk7bRYRxc913T5OmeIdTKnG7EgC2RAH5tMrV0rSdNXBSFYY37AI
 wuK/7eqHISJ7Y2boyZOOmptSAoeFZB6FG7MG0yIiaU4NU0F487bxhd2heAni6+71bqw/C
 0FOmyqGPGixgDboE9Zhx88NKZwwgwKTY+5/7Ox+fqpxDJvE4E0J8SuupELz+r4xYbqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NeqHZQZs; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=NeqHZQZs
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5ED8A81255
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:03:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D67F86021E;
 Fri,  9 Oct 2026 21:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5519E1F000FF;
 Fri,  9 Oct 2026 21:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791579836;
 bh=Mo4nF0ATan/SOiBlE4oHVy3vMEhRIw2ESPRseHUQrlo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NeqHZQZstlJVx8gIsKnSfmrsbZsZSe7z1iMpB2pxhwHh3U3qtchDolt54C8a7StNV
 bo8hYTwrh2uBO2GiGT14R9j161Q266v96aoZcyvj6E6Xe0SgpNEQXaVN5AAKzB0bt+
 x9WT7uLiQS5Fgwyvrn9nloYpyDRaZBCSpzCdNCOK7z546E8mxQ/p1adJYCpNMNVctm
 YRrgrbVSpKnwjnmGHWNTGzvylrTx0wThjo9zrE6FwJRLHhMp9k/n+jObi50102L+ee
 RjH7tbp007T1YxwLLK0+oajERXLU37D3ExfBw58ZV13ZQKmlMbdrSUE2/cY4QtBjZc
 CywMvRPa7I5tQ==
Message-ID: <sashiko-outbox-166068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 03/10] net/mlx5e: check for failure when
 pulling the Ethernet header after XDP
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-3-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-3-8f2bd9bee138@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:03:55 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

> When an XDP program leaves less than ETH_HLEN in the linear part of a
> multi-buffer packet, mlx5e_skb_from_cqe_mpwrq_nonlinear() pulls the rest
> of the Ethernet header in from the frags with __pskb_pull_tail() and
> ignores the return value.  If that pull fails, eth_type_trans() later
> finds less than ETH_HLEN in the head and BUG()s in __skb_pull().
>=20
> Use pskb_may_pull() instead and drop the packet if it fails.  Pulling
> min(ETH_HLEN, skb->len) keeps today's behaviour for a frame shorter
> than an Ethernet header.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-pskb-pu=
ll-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com?part=3D3

