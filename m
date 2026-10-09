Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9596ACA9EBB
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63AD8814C4;
	Fri,  9 Oct 2026 21:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MekKgYU7bCB0; Fri,  9 Oct 2026 21:04:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9C9D1814B1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791579849;
	b=jaDG6GtsDulYdeB7rtjGZ21lEhi1UV2YakjRXXho24hybvR3tBqA6mT7O50PyTuABzlT
	 N1yol+U2TaUH57BQeUqYtSzPtv7mkvF+NRPfx64warKAjmTEON4ZROnFQUnvh5N0wvfFr
	 HRJIqK2EKjz0dheLg0ocrZ4ovzpzsrXciemWQx68NLsMi4zS7lhvbJsD5oztwIq4e+TzW
	 2s8sGWAbbSgvrM07Licd6DCy+jcBX/yOpbOnDKtuRFD3VX7kujF7S6dCCWibxeDoHZ6KA
	 CYfKlhKHBNz+EAOIZJ6A/eY5S0ZectEQITE6I8d1N8OkPA98C6fzO1jCb5qb5r7RB1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791579849;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=nNfHVcHc5n6vc5zxJ+6omi3qh0ntDFtBFywZxYpSVkU=;
	b=ARB+3/Gk1ELDCENuqzrYTCb+uNFd3H1Vw8Kw2vw+6JAOtW3GFyUwifJCN3CqrEeFVzPU
	 0qQLpRDTP1G8RNOUM5d4DODwqCXdEiYz1aTJIWAY+vDA0GGDZ2sRH6pQPhrExP6TF292Y
	 2+6PiyVP2eevIUs57ZjP0tJVwSAqJNeqkLy79JKVwOsNyYYyI6VwbtidKjBrp+2tE7ABg
	 9QXaRZrcup+J/0TmCl2bxTDJMyovQsuaN6aEQ4Rz7wKt0cLSZvzSm/cTHUdv89Lrdw7Ru
	 frrspD6XiUeHEMkUobSjEheXoq6SutsqbLLBkrzS6JMopHvjORvBD6lXvBSIZMoqKiQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791579849;
	bh=nNfHVcHc5n6vc5zxJ+6omi3qh0ntDFtBFywZxYpSVkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=eR5PmaGgMWMZ9i2pVYRsi0abC6Rassui1FeJtyMhV/v2mZc08he8zkgjOJumasYki
	 uqazmiuIsSUyNE3CGcK28lwnRDvoT9N5G1Bhd+yeVnCpn5F1XDiNX5jeQGAYxVpF2k
	 i/sWm1rEZwrpVX9oDrGeblKIn1dyKJ1yCF52heQmDsihJWWk/MnOublkHg1QHa9zU3
	 O4IFkW7poXN46p3/oWRRhs/4/DCNFIcwD9WGqZNRxJuFbHdwMprYAqzCRQi9a3qwtv
	 6CfKzqYKRIqYG3FYpYv4fenlqggrYBoxkdWcZY1Aa+05cpr+CPEpv1xT9zvZzN6bgF
	 HaZq0L1HtB1hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C9D1814B1;
	Fri,  9 Oct 2026 21:04:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E6C4A75
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E17AC40080
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x5Cog5fR50ZC for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1E9F14018C
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791579846;
 b=cW34iA+a1cP8060CD4y89NAukjsjx10iIJxq/b8Qba+VNSGp3itOy6/cDZNlSqO5vTG0
 +yrWzSHyAeTWP4px93pkfEgSDysDGsp9UWOrbRFZpI0rSFzuD1qUQqXg5paJOd/1HRXLb
 Tq+nRtlkPVDm9E+s1SZARGR9ikmxvj3O4XTT7CAocW8qxu8ZXLnVpt1S14GsjbjlJV/4i
 Oz7i+gYzMJaN1YWfvqjdpNPQFNIak2dL7AHMorv0aw5fApRU6YPdLuk2k7gQpZohahapc
 967pXa2DkS1u4NWXU5B7NjCbjOOvaA6UwOnohu/dQ+TkzYtkmYHT1hXvEUjH4Lo1b6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791579846;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=nNfHVcHc5n6vc5zxJ+6omi3qh0ntDFtBFywZxYpSVkU=;
 b=snTz7s6hSreZojuIZA2hoCvkH4T1k8XUFchOvK1xkGLaUUfqgDEkeFab+50tUZaNXbC1
 Kg6YqVTERs40QK6HU0EmAM95C/bJVwrqP1fJWFzDNBHKJxa63Nl7abq5GaINNMx2te3Fh
 7Id8nQsj/7zdA/WHxSJaRLxoUZPJXy4GyEfHLhsGO6H/sRMTlhZhDG4Qgfzwum4ApQXsf
 cj5+rzRdI13CzRhgNxLdUtHO3OsYn1i4iQJzUdHcQ8HBDIS103mm/gmJZwQfpFmY2GWeb
 VPlQa7h8aVmyabIp48zwLPOVWI91IidNFYs9JGo4G8Grwxw5qEhHHJRfUbfWsa+FjQQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ydlc3KCl; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Ydlc3KCl
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E9F14018C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF90160202;
 Fri,  9 Oct 2026 21:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D581F000FF;
 Fri,  9 Oct 2026 21:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791579844;
 bh=nNfHVcHc5n6vc5zxJ+6omi3qh0ntDFtBFywZxYpSVkU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ydlc3KClHFXLSa+r3/BB0h1ng6/wm8OP1Jq4Vx6kY98nobTZ1HHRzC7Qx253oD4dR
 yv4+TvlhKG/UPnEBN2dNjWccDwaycpqabyC9dSbGg+ib6kmxe3G1lpq9mHbWhp0oa1
 knm7FnGJfIl+xHADeQJvlHRBg1JKkXPWA7jyFu025iQwW0EHYDkj1afLuGgP2qPexJ
 Fdil6amZn6ur76ltuk31Jic0QnJ4RBN1I3kdup9IjQ168WGFyVkixZrcGeR/86etdU
 xf4JAzGvLSVvYyZlYf5O0hiAfFTL64AA0lIDEFxNheUJYCb8bVMbVAvqjD7s5erCXo
 nFMudEoA+BCPg==
Message-ID: <sashiko-outbox-166076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 09/10] qlcnic: use pskb_may_pull() to pull
 excess TX frags into the head
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-9-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-9-8f2bd9bee138@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:04:03 +0000
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

> qlcnic_xmit_frame() pulls the frags that don't fit in a TX descriptor
> into the head with __pskb_pull_tail().  It already checks the result.
> Switch to pskb_may_pull(), which takes the length the head should end up
> with and checks it against the skb, so this driver no longer calls
> __pskb_pull_tail() directly.
>=20
> __pskb_pull_tail() also releases empty frags, even when there's nothing
> to pull, so if the frags being pulled are all empty it still gets the
> frag count under the limit.  pskb_may_pull() returns early in that case,
> so follow it with skb_drop_empty_frags().
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-pskb-pu=
ll-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com?part=3D9

