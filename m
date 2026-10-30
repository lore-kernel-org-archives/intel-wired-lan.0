Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A9606A32F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ct/OjhAl;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNgiXmC1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98C5981118;
	Fri, 30 Oct 2026 13:37:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 164oN1bYB4Ry; Fri, 30 Oct 2026 13:37:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2364A8110C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793367441;
	b=eDVwblVWanmix8RamWLrS3/u6RKuCWoAKoB1naPKXABy5+NnJQydDWraz70CR/WEdFFM
	 Qoy6MsHwszzRE4jqp9cOpiMiIp20hyzqkpa7FNBIHK+G+8Qe5FkJI4582uVbihszbJW2w
	 Ka6cQGG56qqKAIXQHQA3f8QRao7IMPPLJDd4EoemDHxmBk9M2ydpl75E7oVNHX4e53Uzi
	 dX2EnkAjbAjSVi+B+FaEqQefqTxILlehSrffBUklJTAifyRFiZ1VLX1eHQT+2TDKiF6lD
	 EWxcB3KP7MnXNbxYTpcLps8+jJpAJJF1q1CXNY7bKMjsnhBSoEHngClVwe4RrUZ/kmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793367441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8tJ3mHvsCbcK0uC2z5FiKSUzFDveTQLdd2jjhlDidfw=;
	b=P4F9UgAR6zCUXEdUHF6es3EGM9ZgID1kkLQ8BkMd71jp2QE5SjHokNqA82X7/t/wEi2m
	 5ZnMqjq+HGOEsIgtdKslZBoPFGCJE9XJHcz6HhYVKrmd8Hx07MvrK8fs5riaFjGUf662I
	 h43uwvW2ANmIyXQ9jjRk3YgdqzqlE/aGU9YHPHIYBRue53eEMxsGE5U8dqb2DYirCh/wn
	 /dPG5HFGvTv73zKUGNunHfbrwnKr0pB0omfkQEvRkZTQE97Cigr/RhdBO3xf7QobqoS5G
	 0bJ/ipBzfi07R6W/AWaYxI9t1f7H3nNH+oRMKHgLxqQy6e2zCqq469z23GagdnWysMg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793367441;
	bh=8tJ3mHvsCbcK0uC2z5FiKSUzFDveTQLdd2jjhlDidfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ct/OjhAlqhf7Zu5aPWfwuA7gwMDlsh+JBfCasF6bJhpFQ4D1I2Jz63MFN4k1bS6Cp
	 CnjoPSqoDIhP2xI98/68TKbDUyzzJhfIdJ93nExJ4G47Czc7PFBHjjWsLfHIZPzt49
	 Wph8IKkdP/Ac8sTpX2g4SXzkIWJ6NuxWhIHt7e9uCZjXMWdNmV+rT7WzZEYKYPZ3Lw
	 LUII/FnwbxwKkU+kzBs/4GYQ5u2SYTMJaNHwWj7IkVitbAG8hnOTOEMhCyq7q2JASe
	 ksmaU7JpEeYPqO9csDjbawZmyJXW7E7eqR+WOmW6pVAgMVzMl68mzPsmI8G8aoTnBf
	 so5jNTrSll4zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2364A8110C;
	Fri, 30 Oct 2026 13:37:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB764D38
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 13:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD17240243
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 13:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VyaHyzwlrpXB for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 13:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EBF1E400D5
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793367439;
 b=lu9ghxmKJIlc60A2zErbaMelGK7jvrNEFEoEogxFvfmem33XeR1t/VcjMXi+4kS4BO8g
 WeJNcRU26GD83q3pOGF9UPJorE5xfL+9SvPph+lnMuj8ts64LZeuk3MhHXAU1DK9otdmk
 4vsqgBwpoz3AghIxQEyoDNs9iSQKRI6GyAequk9qNNI09UOLKcs5/YkNVHEqGQOEOeydL
 6/U0b5zXl2191RPSGFi0RWW2+RU3nNGm3sfszIy3c8DfSoGEafJJHFDLxXmVoN9K9Tgjn
 I+V1ZHaUHtVSpJPpoYbV1OpV/Fl3djrAu6WLRRrTAYbbN5m/KU7nCwp3MLhcYjiD7Jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793367439;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=8tJ3mHvsCbcK0uC2z5FiKSUzFDveTQLdd2jjhlDidfw=;
 b=S0s4qk8/kwlAElUCC/d6frWKR+7fu4PH7R3zXnKePbCYqgOxW7QgTEITCdn7Mnbi7gmv
 M1yixJ0rY/fTgZ6lK9aeQL8Znu3/h0ECXFaLW7W18vzmr7yqZVtenlLxz2vgXwPRVL+0H
 2IMz1pfyCLOdzKAKn9OmZQ1P9E2vXKRw6Yof3R1wNQ181TmOqgenyTKGPohfcvla/Zork
 kub09jSP6GIFHSlAfdCLybrRtenipB2ttBBC1Ar3ADyIa285cvgUtqTLKNc2ipcXs4CQy
 897/BFA68lbU97BZpnfDAasePZPhAO7GPLcoUAwAfnw7Z+dCOMSp8PDYpBMv8TFWH/A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gNgiXmC1; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gNgiXmC1
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBF1E400D5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 13:37:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 941E6435F9;
 Fri, 30 Oct 2026 13:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED6A1F00A02;
 Fri, 30 Oct 2026 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793367435;
 bh=8tJ3mHvsCbcK0uC2z5FiKSUzFDveTQLdd2jjhlDidfw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=gNgiXmC1hJbmntbn8phJg0ee50nGdaXjCJiFZtfcwCb84nlmG2+I+G+swfz1cbYwA
 mY70cuTfDvF9VNaKUyVrakM6NBJiqWEIGKYaMwvHjmZ8tmc8Ysz/j4uBRznu8hRT/I
 yN+BnVieh5JO7BlbF2r/8BXu/3H84N0fyGavQlBlcQ0RGHLqG0nWL03rxTQ/AU2rZU
 QQDVFy4ogb/lpeX7tmDxNJCLMsHGEdkqw1oYI/6W66inTlQnbxY1OE5C9U9OPbyk8I
 TCxIi/nnjTP0BRsxVDY274yuz+Jp43YGCHVJkJ1h4+j+kXRmcE+IB2cjxwVFvPnSVV
 3UlzcFxZ75wPA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 jtollet@cisco.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Marcin Knap
 <marcin.knap@vecima.com>, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Sunil Goutham
 <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring
 is full
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
Date: Fri, 30 Oct 2026 14:37:11 +0100
Message-ID: <87jymz48e0.fsf@all.your.base.are.belong.to.us>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>
writes:

> From: Marcin Knap <marcin.knap@vecima.com>
>
> When an XDP program redirects a zero-copy buffer to an XSK and the
> socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
> -ENOBUFS to xdp_do_redirect().
>
> A failed xdp_do_redirect() leaves the buffer owned by the caller, and
> most drivers rely on that: mlx5e treats the failure as XDP_DROP and
> releases the buffer when the Rx WQE is refilled, while i40e, ice,
> ixgbe, igb, igc, stmmac, idpf and others free it themselves. The
> buffer is therefore freed twice. It gets reused for another Rx
> descriptor, the second free puts an in-use buffer back on the pool
> free list, and the same UMEM frame is later handed to user space
> twice. ixgbe and igb keep the buffer in the ring on their need_wakeup
> -ENOBUFS (XDP_EXIT) path and run it through XDP again on the next poll,
> after the core has freed it.
>
> Leave the buffer with the caller on both the single-buffer and the
> multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
> do. A few drivers relied on the core freeing the buffer, so make them
> free it:
>
> - i40e and ice consume the descriptor on XDP_EXIT without freeing it.
> - gve DQO counts the redirect error without freeing the buffer.
> - octeontx2 returns false on a failed redirect, so the caller goes on
>   to build an skb from the already freed buffer. Free the buffer and
>   report it as consumed instead.
>
> Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
> zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
> with the Rx ring. With this change no duplicate frames were seen with
> striding RQ on or off.
>
> Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
> Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
> ---
> Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
> The i40e and ice changes and the multi-buffer path are build-tested
> only, as I don't have that hardware available.
> ---
> Changes in v2:
> - Also free the buffer on zero-copy redirect failure in gve DQO and
>   octeontx2, which relied on the core freeing it (AI review).
> - Audited the remaining zero-copy drivers against Bj=C3=B6rn's table.
>   ixgbe and igb no longer run XDP on a freed buffer after
>   XDP_EXIT; making them drop and consume the descriptor (R2) is
>   left for a follow-up unless you prefer it in this patch.
> - Rebased on current bpf.
> - Link to v1: https://patch.msgid.link/20261019-xsk-zc-rx-double-free-v1-=
1-2aa19f6628fb@vecima.com

Thank you for catching, and cleaning up the drivers.

I can follow-up with the documentation [1], or if you respin, feel free
to add it yourself.

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>


[1] https://gist.github.com/fb-bjorn/d6835c49650bc3433b427a9c9708fbe2

