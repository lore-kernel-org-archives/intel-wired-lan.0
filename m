Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C3606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=lA/+J99Q;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OeBOHIcG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11DDC40A15;
	Wed, 11 Nov 2026 00:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RKSw_vZqUkc4; Wed, 11 Nov 2026 00:01:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 711C140A1B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794355260;
	b=XrvF9hRIsueAth4yAS06rcSrdClpplqVOSXHYm9Kfl2Nr0/n+b1/J3zbm+D57fc7fsXz
	 qk1kHAYQP5W6g86DSDYq9pVpyUdWJmuLQfhDAECGSxydAXIKe9+E8aqSQskhDMLQJpxHE
	 K4/YSONznQUJTj3wkla2r6SPp4j9sl0wlImcetfj/6PK+qsvQ4dDx/o7wxhBbB/Yo1H58
	 ZDGfgEr4RldzUCiAvnOUiW9lXeHORdB/Qbfe4dNULvQjG2HTBzQxy+wcNWrjWnisaiJd4
	 O1w5DylmgqaGv85QNQAr43f9DaoxBLPjMT3wgxHwLnRl72c5wn7+raLFOa2tjDpbwGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794355260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bYaErAxQk82jgbOAPhvOLDjqMW7sA/6+9+NevIx4alw=;
	b=aqIzybyb/R5G/hEU8pOAshApWzT2FtkcJe/PCT0ujWvN/urNPXcqDBOMGspoprikpUzW
	 /lHKZL+a/xpeZAN1KXKVlP7bhCsEHT1NrrVe3ahH3c9hXaMk0iGkgj5WTxk+h/F/01WkS
	 UyrxKAThQKWIiJenqyOGOw7eNI4XbG0KAnWgZhDm4HZNNrDi+GsBRRRPxRpZmU5iwiRVQ
	 6vABYm/rlBd3If1YLMBJMbZK4Shbybz8jvgW0UakF0YURpz2AfFqCTG1IAL7paKJk303x
	 uBMwBj+GKzHVKz+X1a+0A5/WrHVF1pHJ/7PmUuGA/3ya0SlylnzfRqV071RTuKttbdg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OeBOHIcG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794355260;
	bh=bYaErAxQk82jgbOAPhvOLDjqMW7sA/6+9+NevIx4alw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lA/+J99QDRrnadENkxVTZgfmSqoAqKn+HJTWXzQ9g7CCkqLEQFJY+ifns1MriK4Eo
	 5DYyEwfbeAC5HPChRo2jla0lJxQ75v3hP8/zu6oLaEGq+B1knKNdSspRszBMeFQtVL
	 LRSBzdUcSggOSwM4RnSge7at5hKNNpbgHUPJWT2I9QeIx7jGZ7qOlK06IZkzj5G0EN
	 S9Q1EBgvWelooXeESRAx027KSnf00nMfv91mN0zwccUfcr9VJ2bOE4I3YO5na4SIzx
	 vnc762k8J/6kNBqnDKDNYdydT9JC4wC+vKcVOrvL2VjHQJtANbgN+2IdLsHaHhVb+I
	 d3FhAwvXWvUiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 711C140A1B;
	Wed, 11 Nov 2026 00:01:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B314731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 00:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CC4740A1B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 00:00:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7UCTWxwkl1CQ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 00:00:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9DA1B40A15
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:36::1"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:36::1;
 helo=mail-dy2-x01.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=OeBOHIcG
Received: from mail-dy2-x01.google.com (mail-dy2-x01.google.com
 [IPv6:2607:f8b0:4864:36::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DA1B40A15
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 00:00:58 +0000 (UTC)
Received: by mail-dy2-x01.google.com with SMTP id
 5a478bee46e88-36f758312e0so1267574eec.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 16:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794355257; x=1794960057; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bYaErAxQk82jgbOAPhvOLDjqMW7sA/6+9+NevIx4alw=;
 b=OeBOHIcGSEVHemfAu7/ljgok4ewzXyOejjFCL9WtKQWAY3ezHT72lTRyLtaxmkrDqQ
 xxm7cqST8erjaqCTsuYYPSt1Bu9Krc5OCzG8r8CEEH0Uktcalq8Kg/TJRIQWllv0QnnK
 L/mPsLUAXI1EAUO6SDyRJa/IAExA0kl3CGmvCG3I39z6n5pZGKtfbg0SgtMiGJ/MUKiz
 0xuKoDt5r3vGqD5Ui5DlnQZdoLE3XmI2yXoHK1Ms8YIhKqqyhOuvl+gchG8HBd/4B9nF
 EgtWAaDqXf32LcQoFzdo/6/x70ktdafs9Gud0HLvcAipki9w8QpEMe/vSoZJXfPqHGUP
 P3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794355257; x=1794960057;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bYaErAxQk82jgbOAPhvOLDjqMW7sA/6+9+NevIx4alw=;
 b=gxkSEoR8m29lbLwX60QFXBvsbH6U2//wccNn0PrbCeZGH+tc4ULz80Ti2wK3HLb9c4
 Eb+aU2Rj4Og788pY2iALV7oFbWq/NY2gBapNS6TDj9D4TZ368PDwaa5CLlM0sIxB7lnW
 TehjD/ofSNtsuOwGKAvd47OZDiLwwhG9bHBeF8iZJLRb252VnxgmUnogutnEJqXNsEzS
 8+yE9Pes7vjhX9H0g0fQA6vadV/LKmHJFflRiwah35JUOnGnEC+smO4mxCfJrupzEX+q
 QgCUSfIH/RtVttdpp6JfzpddSL+Q5G+NukCJdI1GMDT70R0kWB9PW5vA/kNa+ZoKY5Lp
 Cu5A==
X-Forwarded-Encrypted: i=1;
 AL+hErGJjoNGxoGKWmu97vZOBpOeGFV8C+Dp0Ruo5rkICxtjum8vrSPVWVd3j2u77wL2+xluCU2Ar5Y5kZkuG4pg02A=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9X3F3+B88tZJb9ZotMRro0aEuSlNEb0bmtmqUDEtPVxuAiDS9J
 S3VnK7sJmodlZE4bU2RLoe+yweBILq8PpFMBpQphV5JCp9o1HPBxUeEs
X-Gm-Gg: AYBFou1fwXd5eSiSomF8YDtytFzffm2JmWFpGB7kDSPdwWGWJg8aXtXLLOPM2nMdRGf
 MJ6yf6laAsgzUZ+8OylVWFG1Jf5C9wP0XzW3lvLKqiZUbRYFD3PyWqen80BoEDXuZNouTZ6MuZD
 JI2G1V6+K6etS6FsFffoyweUVyyOWcktByWy46OgTcnc6lyRLV0ozplP450SUFOCfpyQPsm+FwO
 CoO1Gulzq7uF7vfKRYK9133de88KJPT6APNF8qSWIVjkTGbC37WZpe4Wuzh4UDwAtJEStQ3S/4H
 5e0AYgOfR/TAoBUF5GIBBIPpEOHScCZxMszbWDTYgPx7e606oU9vQtXlP1uZlL9LmV/W8Y6YJKK
 t4+lcYwu7RMSPSUBWheDSMr7phtR2OHeYT0tkJbvO3YzoGW9Pv8NDDxXS3+Pu9egFJhICZvdgup
 7/m6zMbSj5dJtXdhAV0OWYwykE8/UessOLFTzF4XgEA0ZaZTszK17CP9nf6+jwKwchXHbc81sEQ
 GmXpu5IuPOXwp1+dqzQwyPwVL1DqjCIGhHaavl0k4/LXRLvf/AOSrEKp1o/KNkDop2XQO/wudnp
 d3dS794Vx+UvmuUgc1EVTlQc
X-Received: by 2002:a05:7301:90b:b0:375:4366:a90c with SMTP id
 5a478bee46e88-3768730e517mr1138142eec.41.1794355256884; 
 Tue, 10 Nov 2026 16:00:56 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:71::])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375218c7c50sm19090263eec.29.2026.11.10.16.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:00:55 -0800 (PST)
Date: Tue, 10 Nov 2026 16:00:51 -0800
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
Message-ID: <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10, Tianyi Gao wrote:
> An skb gets its RX hash, VLAN tag and checksum status from the RX
> descriptor, which describes the packet before the XDP program ran.
> 
> Without this series:
> 
> - On XDP_PASS, the values are stale. After the program strips a UDP
>   tunnel header, the stack applies the outer CHECKSUM_UNNECESSARY to the
>   inner packet [1]. If the outer UDP checksum is 0, a packet with a bad
>   inner checksum reaches the socket.
> - On XDP_REDIRECT, the values are lost. The skb that cpumap or veth
>   builds from the xdp_frame has no RX hash and no VLAN tag, and its
>   checksum status is CHECKSUM_NONE.
> 
> In one use case, an XDP program redirects packets into a veth device.
> The checksum status is lost, so GRO verifies every checksum in software.
> With one TCP flow, this costs 34% of the receiving CPU.
> 
> Another use case [2] is load balancing IPsec tunnel traffic with cpumap.
> Without the RX hash, GRO on cpumap puts all flows into the same bucket.
> In a cpumap test with 16 TCP flows and no IPsec, the throughput is
> 17.6 Gbit/s instead of 23.4.
> 
> This series introduces SKB core extensions for XDP. It reserves an skb
> core extension area in the headroom, right after the space for struct
> xdp_frame. An XDP program stores RX metadata in the area with kfuncs,
> and the kernel sets the skb fields from it. This design was initially
> proposed in [3].

Awhile ago we discussed the alternative of adding setters for xdp metadata.
Then the veth (or whoever turns xdp frame into an skb) can apply whatever
metadata it needs (and there is some magic behind the scenes that takes
it into account when creating an skb). That keeps the layout and most
of the code outside of kernel. Have we considered that here?
