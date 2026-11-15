Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C51606A33E
	for <intel-wired-lan@archiver.kernel.org>; Sun, 15 Nov 2026 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=bCMUe83y;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVa3kJOZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 017AF40663;
	Sun, 15 Nov 2026 19:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H_DKq8Y0EIcB; Sun, 15 Nov 2026 19:39:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E98E40669
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794771549;
	b=P5voyBpZMQ7vKw/ON9RAfHPO9of27Z/62zgS/OqWVK3xkjGiQKAQiBUhWPHeRZLuSmw2
	 EuW5RlE6WZJu+Qrqm70T1SBWhC3Q+Aw2S3vFchzmSzMndEp01EBvxvbZxetYpsJDem17a
	 P3uNoUXQ11Eb8479iowdwTbENffHmx7XdVZblaNgVBBxhgyqfvIBxFDo1Jomcy7nk5f0E
	 lfmIzlfFigXpavZddXHmt1WZmW7Q5qHKMw/aD9biTgnMv/BB59vxz9YgtqycV+AlqkEJ6
	 ILv5sFN+tsVEciFUSbT4VhxcANgUsZvPMwbkxe03nijU+TrYnYg/isEKyn4J+AxqGCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794771549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nhfeoYtF7WorX7zGjUIuskRdAMeUM/Fthys1xBCjJm0=;
	b=lS8sTmBZOa5NjcD7vkm8Mv+ENP7DHqgfNe93unYxzh/aZKQWi5JHSf8+lIVqzQzPST2Y
	 /KH+Lq+o+l0TRh61PRBKpM2ColIUNxRzbK4J8ITj1dUr7O178g0rDoCTXHc8DZEojjRMC
	 yupaAEjdZQfG2Fp0dM+vXdJ9qCNpb1UEWL/up3fRB1X7RBmPYD19c8Co9MLdUTYCMzVUc
	 JbD4LMSr9gL4VnVLO7rkHT6r0QqYxz+o0kkPuu3/Z2QQPDM+OGo22UAuKF7HEVYE4I6si
	 ad/CXc+LM6U3gZ5K6AJ6OSKiOTBUMVX8mLbXo66lQWA2SpJJ5L2Mn8No0Or4/HdrT+g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794771549;
	bh=nhfeoYtF7WorX7zGjUIuskRdAMeUM/Fthys1xBCjJm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bCMUe83y/yGPWJEi7ij0Ww3hmbIw+OhhQsSKYZZ/2hcDAHe4QuUWhiHxNXRBMfh+e
	 XK1lCO6pyQBghpJa44jTP6bEyXpPLn+tE6mieIot8lDChyqZM72PeGuiqkvaEY4x/y
	 OQMJwb+HQ+5UtoM/TrWxrQ+AlVrbWDt/W8mZWK+lhZ3ZH37THR9tJKt25DzQSpw0PF
	 wQJORkIm4w0VevZjjHtqj4+yzSuf5r1Eu1fofQgogrCHUG+oIsD1LzshSEKqQuytIb
	 ZhCTBspEuF4VYmCYnGs3yo3kh0bBAuJd2r4LngoM3WBCXCl2wVam+k0V/jcOdDoX8o
	 CfTvQnhGanUwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E98E40669;
	Sun, 15 Nov 2026 19:39:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CAB54D7
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 19:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B000880C5C
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 19:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zlKELm-Jgsxi for <intel-wired-lan@lists.osuosl.org>;
 Sun, 15 Nov 2026 19:39:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E400B80C0F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dVa3kJOZ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E400B80C0F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 19:39:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D4A660F40;
 Sun, 15 Nov 2026 19:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8141F000C4;
 Sun, 15 Nov 2026 19:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794771544;
 bh=nhfeoYtF7WorX7zGjUIuskRdAMeUM/Fthys1xBCjJm0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=dVa3kJOZBz7IO1OByxjM4DlK62AKKz9Ka3JoFzukyf8Mtt0WvAaVeywOTe2Oxg/b8
 pJyd/Hcb01G5boe98nFycm5mUUClT8X7Ntu/1hFxdikFhRyhtf5j8ITJmO/TeBJjtn
 MllBZTZzBOIQzHQks6G53m4E5EztR9RrlaTTKls1hOvK+K0NTFkTZ0W9xoU+OfWydr
 ehuUkkZB4od/5R7m6mbCjNblOJ3ivYl6FVgGGrPUx9aJuPBpos7I+xoq6QBgkYsa+6
 gWd3jR4JLD89gS/0b1XfIfCvKSoESH/3bKWJJBKhwwBrXXZ7j6EIEV0axeTCYXQoLi
 8Uf7b4PEUNkjQ==
Date: Sun, 15 Nov 2026 11:39:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir
 Vdovin <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Donald
 Hunter <donald.hunter@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Chris J Arges
 <carges@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, llvm@lists.linux.dev,
 kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
Message-ID: <20261115113902.4834dda6@kernel.org>
In-Reply-To: <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 01:07:46 +0000 Tianyi Gao wrote:
> - On veth, an XDP program removes software GSO from the peer, limits
>   its MTU, and can copy skbs from the peer.

Could you remind us why you XDP_REDIRECT xdp_frames to the veth
if you end up allocating the skb on the veth, anyway?

I thought that was to let veth run its own prog before skb is allocated
but you're saying that you want to avoid veth having a prog, so clearly
it's not that.
