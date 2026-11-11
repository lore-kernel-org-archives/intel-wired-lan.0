Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A239606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6rus3InP;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=up9Ve5je
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4406A40ABD;
	Wed, 11 Nov 2026 22:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Jk73s5cvcTa; Wed, 11 Nov 2026 22:25:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7480D40ABE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794435919;
	b=YdHtMYxA+EbklioGcqJMsiCxkW4Ka6cqJ6hnqEQO7Kpcu9kmEoySfP8IRjYkeATloc4k
	 L+eNObI0BoOb/GK8HIsuqWJhzEejbfZEp8Q3LFweep+Codus4bwNUSG+ck6ZP53VuR6oy
	 u3tuqrW7XUiIuylp/HGMEBs12zAwwxyZkk83FKRwVMLG85DFBXgC1KaOFDmDWQf0UGKTp
	 z6aXHPYKuASnlLHcK4d6/4o6arsya+cZb0aTlklf8vPBQo97MvVc95NXL88hSYUTe8cR+
	 qfBZ+n2QmksCL26QQ48JsP4rpDbBXBM8huKt+kOsy2D9W7zvl2kI0ihQo+ElEP1vj6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794435919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LcIgSNREManU20T5ds32E1qosC1xbF0e9vbPmoZw/SM=;
	b=EZfox22xns7P33bHja9ZQJHjpqQs0sLb119kMXLkPO4we2ZKjv6qRInVqcxB4day5w4D
	 dOCdyoXEkYaEiec6IRdM5dIi9yFimbitN/rHa9JX2aaTG0WYTjGdZaZDPZiueoT5omYCR
	 z0kEuLSD18Aj5TdOfA8HOecsi3K2BewT7lNXJosMXKTHUGKWzcD93boLFzcTPNAubvgzh
	 n+1jbrJ3+QHiUSqKUFgQy+SpcGICzDIKsWWo6r1wGEFq5CwFCATeHe2vL1Y9jfBK/A7a6
	 99nFngiIp9EOedeO7g7r6zoqEuuJIh02Xn2LhujGu8yL3iVj8E578qV+Vr7pD6BhH4g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=up9Ve5je;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794435919;
	bh=LcIgSNREManU20T5ds32E1qosC1xbF0e9vbPmoZw/SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6rus3InP0tpkKLtKVe9ri0QPLtBkTZxNGm2Flj4pZqYKUuucJ8jXjk+Tzc5UwTG86
	 wdMIZ2rO5qQYI6zFt8iwx//Rm2R+2RB/L5UE9wdEZ8eQaf/XTkXKnC7izhA5yKlPIK
	 skDF962qY7NEj+xgEsxbfPlslrdqWLRnY0beRZkUwST9AkAsZibvRzRVMFAuayW4A1
	 vJ1XaJZxLRrRhVcOVmA0hntap3NjxxeVmmMuFkemXG5JSnzkmguGpHFb75bQApuOii
	 dT3LAGiqIw1Om1SDh/a5uM2m7cJwjQJZ4dZCSzvSXi1CUV5/94whVxHJfgRJyqbHXD
	 ieRXSjY9tHA4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7480D40ABE;
	Wed, 11 Nov 2026 22:25:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73E80335
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 22:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51C9A40ABE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 22:25:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fL3wLw-AB4nv for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 22:25:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 75A8540ABD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:38::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:38::7;
 helo=mail-dl2-x07.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=up9Ve5je
Received: from mail-dl2-x07.google.com (mail-dl2-x07.google.com
 [IPv6:2607:f8b0:4864:38::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75A8540ABD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 22:25:16 +0000 (UTC)
Received: by mail-dl2-x07.google.com with SMTP id
 a92af1059eb24-13985f8229aso3309020c88.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 14:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794435916; x=1795040716; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LcIgSNREManU20T5ds32E1qosC1xbF0e9vbPmoZw/SM=;
 b=up9Ve5jevLvoMvWgmE4YvtmZQnbyi/HST3Mkh58mpXfgU1CiNXOY3itTJyX87FQjVm
 nz3/CghaGikpNXPhmzKWEY71ndJSqkTNQjh1SqcRSVB/GfNOvXv8f+r5seyz11p+E9mc
 ATm7V7W46o3YSoMFocBy8G3kcIxwa8/iEbr/mxBT/FOA5R3w/tm81n6TaY2odLPHkBw/
 NaqYvnHRCaFLzGIlWj3gv3QvoygAxzAT2nz5SjEVO7FdTA0OwMAi5N/QROvB5maKzbfA
 6RL7ghPEnshAtBrXgNUQequgsfPjsaLqGbpNTseX15XLOxMsTGgFR1p6CeLGMt6+k7KY
 N+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794435916; x=1795040716;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LcIgSNREManU20T5ds32E1qosC1xbF0e9vbPmoZw/SM=;
 b=PCokqhw5RNmJ6TVrO8Q02fasLbMohceJdvJYBEbIr4nfb+GA5OuEaPiK7qvRdcH20u
 Bfi3LDleDQL4BFePnEYWYzbpucxhgWcnuE2rRYnQ8/pqCZZI/sMJZQEOk2cp1Ybu1JRn
 7nbRVR9X26fkry4CPjBhKkq0ueZN7z8yzmxjextdonhKFY4Zg8YXPY6oYyst8ddBgD6J
 yczjpS/+nyANO2yAnGCYO60VXJhAgO115FpLrJn7y2mYr/6PHtW87/KdH+/l/lE/op9C
 LSVPpSC7vaQuZcxTvwFWMeFVtJXZQrkzCAQdhGaPuCtTn8FevMHuCrxA/AHsKngFHJmj
 yhVw==
X-Forwarded-Encrypted: i=1;
 AL+hErGoX7ViCpVKe1J2scVhMOEXkDn6wwUDiNM1hUEm3YoXklmFNH7Lr70oqWJlxf/2rvR2xy0NW8xDnSrS7N53t/E=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/mfVha7Y9uMQQtOMEPvZ+36yrJv2hIBy1nScJwDms7eIlLrrpJ
 6V+4csLExRxYUHuhYsu93MhtMxtHK6Q8VmlTfkm9faj+dL/rr0V1GouK
X-Gm-Gg: AYBFou0BNQ6kZuUpKg3cKlDx2qjprfyX70DFTFcfSIe+tcIFIVN56+XIF9tL56A9G4B
 I65uulimrRDTU3U3d0ssPZwY+KQARXlsAdMuD6uW9uhuooH3TRl6ToMGlBbdwif+Ls9S1/ovpnc
 NUOgH144Pm7yue5zZhxtKgbbQhKTl1y2eVgdp3VghZSDQj+P6lO/2BDN9SL3YAaBuUmI3IM7A/H
 c5YJHYroG+bySW7AaPG37YYOyGTA5t9ARjtc9kNEYDOY4mOVhL7NbBfw5mO2JfdI5SyXn7gdsSp
 o5Mj46dJCS9gtkKglJ6K1PkCMm1btkYy+iOofiR+S2fATHKrweBY//950vyH7iEAJyOpRAxdad3
 0ZAo0fmhj98IaFLKYTOPJ7k/ReLyXUCPWKf1NGW6aHKBKvKN8KzKcwphYhdgb80eTO/II31K2xE
 9EeiPAlWCohyOvXjsRZ0NKtG7lRO/1s2NDrBcAP2tV1ojMw7VZpSOokYMf2LunZdbQoC3ipLnFd
 rB/EbCUwDctO26g2iVzFVwGGEH5PQQFJa6p+bWHbydP6+CevYEpI9OfggM0GsLnXhYHT/WsRHHl
 vT+IksYy5+gFWSaN029J9wQ=
X-Received: by 2002:a05:7022:286:10b0:1b3:a23a:d1f3 with SMTP id
 a92af1059eb24-1b3c03037a9mr3351998c88.18.1794435915687; 
 Wed, 11 Nov 2026 14:25:15 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:43::])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5890584sm20682923c88.3.2026.11.11.14.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 14:25:15 -0800 (PST)
Date: Wed, 11 Nov 2026 14:25:09 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>
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
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>,
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
 linux-kselftest@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, llvm@lists.linux.dev,
 kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
Message-ID: <avTqb--WfUNBcEyN@devvm16445.scu0.facebook.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11, Tianyi Gao wrote:
> Hi Stanislav,
> 
> On 11/10, Stanislav Fomichev wrote:
> > Awhile ago we discussed the alternative of adding setters for xdp
> > metadata. Then the veth (or whoever turns xdp frame into an skb) can
> > apply whatever metadata it needs (and there is some magic behind the
> > scenes that takes it into account when creating an skb). That keeps
> > the layout and most of the code outside of kernel. Have we considered
> > that here?
> 
> Thanks for the reminder. Yes, we considered [1] and [2], and took
> parts of them.
> 
> The alternative setter model in [1] requires a program on veth or
> cpumap to call the setters for the RX metadata. We want to avoid that:
> 
> - On veth, an XDP program removes software GSO from the peer, limits
>   its MTU, and can copy skbs from the peer.
> - On cpumap, each entry would need a program only for this.
> 
> This series achieves the same with only the XDP program on the NIC,
> which stores the values with kfuncs in the skb core extension area
> after the xdp_frame. cpumap and veth take this area into account when
> they create the skb, which is the "magic behind the scenes".
> 
> [1] https://lore.kernel.org/all/20250616145523.63bd2577@kernel.org/
> [2] https://lore.kernel.org/all/aGvcb53APFXR8eJb@mini-arch/

My main concern is that we are adding a lot of code and one more special
way to plumb the metadata (and another metadata area), another set
of kfuncs and slowly creeping more features into xdp making it more
and more like skb.

For containers in general, and for fast af_/xdp, we seem to have been
moving into netkit with queue leasing. Maybe that's something that
can help with your veth performance?
