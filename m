Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC2606A32D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=IbMbIjbh;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QoN2Ojl0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E50160784;
	Wed, 11 Nov 2026 23:46:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SxITfL43zJGf; Wed, 11 Nov 2026 23:46:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 75E766085F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794440814;
	b=YJDUA0SnmPElmIfxysXp5f1KIQkYlwWiGsW8+7CZYKd5/dgiAXqrXPBO4CwaHZbdr6F4
	 E1SR+Zb2LSIkbF37gUt8YczMeWPOxijNlC7O+NP8xR7wDTav/5emqOqDBzoksQZJRF3rg
	 p6rRZzqLgDv+vkggaxCwrZeT3UPIjlFWVSwuMNRMwBwQJqYo/Sx0J5euGWcIOlbHj3vV2
	 upRCyhlzBBSUkolvAIkR5jVgwq7dcv3OewOcVXH+TxG/uhCNUA+Pv0mEeAX/PIEVoAwNY
	 LwwyeTrYCTQSXgOhIwjhz/5I00YhIAOk4jU4kg3hIu61fKu2uY8ZM7dwHmic8v7STkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794440814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
	b=nnzrlImnyof1Gbv/ry3DvrHwXHXW9TxNxgIlcmtQBASsXZRBMq7djHzcvpbBNQmIRWb+
	 57TqQM3VPsWCvh++HT078D2VTe8KpY39EHEUEEVDPSEzPgGicjIm8o2uLmOSkN2O87b6D
	 fERLG/t9Lu7EOwD4oGqXQAdlJU5gDdLHZ0Fyc6kj899weD+Ww6c40+I1Vo9UWEIMAVzw0
	 7QhwMhMaYoUc8TF2kHnOZJoEJoFuUQTo9AMvQXzsopY2BmKOqUurmJWdqLqNru4kAOYBJ
	 LiT7NGru54XtaWeeHMPt19vszapBDss8gaC+SwpcxKLlTTpJfTE9L/IijLQT7R8gapg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QoN2Ojl0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794440814;
	bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IbMbIjbhmiuZGn0yry5B0YX/W4tWOBgOeLpxiRBnTgIme9ednenNkFY9H6lF8uaa/
	 tw6zG9TYooSh474GKy6MtCG1fZFNup50rcjAGJuhEc588gHtlZeA33RrOD6wj+b+K4
	 ylij13lyceAKk1y9r5+yJtNAzkn4h/mEw1R8a/n6y+9XwKkiL/7QSrzhbFqQWyss2J
	 5BvqtZ/SGRDpGMvp6JVQUc421q56nAmuYLa22Q6Emvmg7yLtb07MQJv52ndRO/HrTE
	 cZG7kmLlj/PjTcNn4Qh2GvXHezg8YJtYwPaQlzCjH0fc0uJw2uuA5N6iAY63RcOtd2
	 IXbX0pjRFuzyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75E766085F;
	Wed, 11 Nov 2026 23:46:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DC45E09
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 23:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3332860887
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 23:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MB7V-2ATn-aB for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 23:46:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CEE6B60784
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=QoN2Ojl0
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CEE6B60784
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 23:46:51 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4a76f63b243so296982fac.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 15:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794440810; x=1795045610;
 darn=lists.osuosl.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
 b=QoN2Ojl01PEAm8/mCt3KEQK/VCnp3nsiXxAeYnXS8rNv5cYSlRGDL86wzhpIMNKVQ8
 2HDYVlz8iI2u49Cbv7uF7oYZfX7UcnMUYZ3mKM4MSs7xuttcXkZp+tpUusOV/eWMaYhx
 ODF7ULFVuAs2QmQql9hD6vSlb7I5mTc9q2xDyo6ZpJoG1jl7R1Feq3Eo8swzOoEnnUMo
 ipjWLTPpKuhi9BxLP6MiLHUWeavyJMlKp+qxGYWkbbgrEjNdHu7lzPSL6tz4r4XXw2gp
 BSQYI48XOTMJaFluyj44HtNCZ2HIy099zdcJlG+wSURap1+WQs26n1zKvALbiQuWYgJe
 URKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794440810; x=1795045610;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
 b=LFSWaHx3EcpfkUNTp3pDUpJ2eJHWRonFhb4Wu4qg3B4blHcdGeHOW1Q7NpGAQRkOAc
 6Ln/Mr5OugKqKX3rLBkdLh2TUEOwa/RFFmQMCsDgWdSpW2K5FWufqiFOJjEUikykCUUy
 ahaXb0VJs5Bu74iXHnzkk3McHk7OXj1R2qe6Zd4zEO3wGbYG7vCioY4g20wCr2x6aQcP
 0BHAy+6z4/Mt9IOkCvps9vf+KjmBlRkMTuFUvo4YvfbvVCtaULJYQEhY8MEwk/E11wGU
 31ZKJvijB2uSNDhVPZcOdxDzLqcefwVisGbt/2yZSCwYFfCvIR0D8Cl4+Ng/DEywsRJp
 BCvA==
X-Forwarded-Encrypted: i=1;
 AL+hErEp13z5RTZzyj1nwa8nU4ibcsFN+GsyC/xdVZ1p3937tZDplO3AWkj68KsRzjQ7N2DNtlsLDliv6VmeY9gt1LA=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+oA8/S86UIbUqaVC7e6Msdd1M92nn5/vXvrhvIX6s+djBrz8h4
 FwJlq/Dvl16VQjLLIhoaFhAd2wn/gqjMywoG1Wyp5N8GiNhdFgLiwDCbbOt7AEUJcLnVN+bH0Uo
 QHivcB5/68VwikEMYlHJ6FGatDjcInzSq7y3gBtlTsw==
X-Gm-Gg: AYBFou2ATZalMk0c212+EdOSQhfpzKlmqhORQprSy3VFYmEvEDL2G2XvCUEzDZlGtZ3
 iW5SEcYsWYXIGOTfMuBTlxWB9vRCAwDgwvXXZAxJiArHICE1Az1EU1D7Ihi8NNuvenzAOV83CUb
 cZ2mZl7IbGBW6j7rGffLR7ibNF4VNMldEUW4sgLOwg809JteFxHb+i0IfVOtEHL0fhB+a/y0Wyu
 VlDovGnmHBVeA+qL0ix9K7B55QWni8tHaBzXACG9j9gORhjRpJ/hzMcgi1//uiJE5ykxMxtiA6a
 MDm/QLz1QYW8m54irzI5qMy5Nqy0z0yXwChJCE/0cYH/0f2MAvRprGGYsgYTkrnPuoHnMZVSdZF
 sv/MoSReVMqCQTiuU2zj1M13ZSCgGAr1ZQoajFgpvqn4TXSNgCMDJtXg1QLHcOHioboEgyvODPv
 27Nxk8JVArpg==
X-Received: by 2002:a05:6820:f004:b0:719:1627:6c16 with SMTP id
 006d021491bc7-7196b62ab2dmr743911eaf.12.1794440810117; Wed, 11 Nov 2026
 15:46:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
 <avTqb--WfUNBcEyN@devvm16445.scu0.facebook.com>
In-Reply-To: <avTqb--WfUNBcEyN@devvm16445.scu0.facebook.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Wed, 11 Nov 2026 23:46:39 +0000
X-Gm-Features: AclHuK98I8l2CyqIug_hRhhYiDHFe7Xrim7_SwhM5rRiI9ms5coKAG0rV8Jl2JY
Message-ID: <CAG4wq-dw8VqiVTbi-fSJTnwj+amkfE_56ndKCYk4v31z2ppcTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir Vdovin <deliran@verdict.gg>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 llvm@lists.linux.dev, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stanislav,

On 11/11, Stanislav Fomichev wrote:
> My main concern is that we are adding a lot of code and one more
> special way to plumb the metadata (and another metadata area), another
> set of kfuncs

The RX metadata can be stale on XDP_PASS and lost on XDP_REDIRECT.
There are already separate attempts to fix it:

- the RX hash and the VLAN tag [1],
- a checksum assertion [2],
- the checksum invalidation that you suggested [3].

For me, the question is not whether to plumb the metadata, but how.
It is not great to have fragmented mechanisms. The skb core extension
area aims to unify them.

That is my view. What do you think is the best way to solve these
problems?

> and slowly creeping more features into xdp making it
> more and more like skb.

I will leave this to Jesper.

> For containers in general, and for fast af_/xdp, we seem to have been
> moving into netkit with queue leasing. Maybe that's something that
> can help with your veth performance?

Thank you for the suggestion. Unfortunately, it does not fit our case.
Our XDP program decides where each packet goes, from the inner
headers after decap or even partial decryption [4]. Hardware queue
steering cannot do this.

This series also covers cases without containers: XDP_PASS on the NIC
and cpumap load balancing.

[1] https://lore.kernel.org/all/175146824674.1421237.18351246421763677468.stgit@firesoul/
[2] https://lore.kernel.org/all/20260630191510.81402-1-deliran@verdict.gg/
[3] https://lore.kernel.org/all/amEojEGsIGkUjIWn@devvm7509.cco0.facebook.com/
[4] https://lore.kernel.org/all/ca38f2ed-999f-4ce1-8035-8ee9247f27f2@kernel.org/

Cheers,
Tianyi
