Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6560A5BCA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8OVgpJVw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tzc9Zs/y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B9FB608D4;
	Tue, 10 Nov 2026 14:20:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rVmCTEu6loI2; Tue, 10 Nov 2026 14:20:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7689B608DB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794320441;
	b=CCx3bqb8jok2SmQYBSI2IqYQ7MYzDWcqeIBRsRbLz+1Dk3iYZi3rNB+/HgDwtpeMhFHs
	 R1S5xuZbd45rOe09cCHtewGhJVwFUELxY2gTge3qiWwBJ0ko+KM8aOILS9KsvIMpwmuHt
	 l3OQbPMRSQGBnx0/rHejgpH2bmJX5eOeA1J3khUeu1AA+chSZ6/5D5pBZT08DWnCUxTUQ
	 q87l8u1Dc5LVr2lA0jr7UtFW4ojttJXSMGTGAa4OUDcJWyZt1SDn3nWEv2c09b1XsHfpB
	 /NhRLdkn0uaFwFidiPQMLcHpnwpq0V9hr9AsfcP3A8OjYDgx00lKXa6BrcyNKTUBBVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794320441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yxghYJJACMUSH3L8Z8k3tre7BBZpihYhe07SHtfZRzU=;
	b=R2G8oqWLiFDvJO4h9HbHRa5GJNhyfgJEFQOVzeEviwV8bX35IcH5wOXBs81WeJFW0777
	 b5wHwAatx3NZYXLJmlX6axP+ZK/kxb1r8wk7ziqQacVqcAS26ama0QtzX+vKTYnt8Tg2Q
	 cykchYefO3D+b/fS0q3W3986dO7b/xzFfuL4lv0rnPXj7wnpfSjzrvcMlDBrUOBbq5t5j
	 0gKH8oIOR16NPKxKJaos31Mj2Tat/4yhsYPXCky5HOyJodsoSaEeuQ3EiGbZOXvm4xWbv
	 5KCy6uqtcnnF2HfXVPPreC4y4ik46UeAheQ8Ij54nMzecp4LGeai4Tf9FYZPNHVPgyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794320441;
	bh=yxghYJJACMUSH3L8Z8k3tre7BBZpihYhe07SHtfZRzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8OVgpJVwCs/feGbjYcw1aPHQenQsi7WSGRUi0ev3vBKb/6VJvUiee3CJS8/if4vPd
	 cmPl8vFLJXdjX8jmsxQER1w/aphiiMLERRkz9ujOum8xh3up5fvvYqJotvnbgm8AeN
	 fga5JbnmYXBwtjd3E6hSbfX3ByQNFpSwzXChXnie1O1RnG7YiPA1uYQK5qBZINJ5gi
	 EtrlkXK/CuCFqCiWXRCnYxsz0MX2sNU6Nadm3DD16BAAv17Gl9HzrVp5fTMew281Xp
	 HHnr0MvUjGuZ106krVkBzYmD0jZAQH2N038KS8DE6cT9Uoc7LtO7BaxL6uN7SJwQ4m
	 AN0YmtlXcDseg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7689B608DB;
	Tue, 10 Nov 2026 14:20:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C8641388
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 14:20:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE9AB4034A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 14:20:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1hEYWNqyOyU for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 14:20:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C88F54008E
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=hawk@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Tzc9Zs/y
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C88F54008E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 14:20:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DC0F639BB;
 Tue, 10 Nov 2026 14:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657561F008A2;
 Tue, 10 Nov 2026 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794320437;
 bh=yxghYJJACMUSH3L8Z8k3tre7BBZpihYhe07SHtfZRzU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Tzc9Zs/ycPeXxJ8aNptWRv5lXPygStV7Lf+YUKUAuneDLgJyMyaAf+p0f7TpXUTOM
 WsEH1DhI/2Ts1lJdYM9/+VhYtt2IatVPaJZc0W6ph2hxS4vqjd6dVRdWho4YcGNpVx
 Hv0Z9WLWCfc5ozGerNpjq0O/HYYCk5BHBJvv1eQanba4kd3aYFLPjoELh2Qv5lMmlB
 1hIXqcR/hJlH5YIT+YK893I/s8nTPsglgehw4Q9MQkJgPaG/n1SQ3WuQXVj+Ttqyaz
 pJ5qwLkDiWJGQ4yFAALapy77jvIDGMyiEsY2GX3clx+yVz4PFTBft10FfYxT4vAwvV
 Z6oqX/5AyJ1SA==
Message-ID: <197d5a54-26e1-4985-8001-5819fc702fd4@kernel.org>
Date: Tue, 10 Nov 2026 15:20:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 04/15] xdp: add a kfunc to delete skb core
 extension entries
To: Tianyi Gao <tianyi@cloudflare.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vladimir Vdovin <deliran@verdict.gg>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Chris J Arges <carges@cloudflare.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 llvm@lists.linux.dev, kernel-team@cloudflare.com
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <2892d19e606e3809c268de0610a4ccc8bf68625a.1794281983.git.tianyi@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <2892d19e606e3809c268de0610a4ccc8bf68625a.1794281983.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/26 04:57, Tianyi Gao wrote:
> bpf_xdp_skb_ext_del() deletes the stored entry for an id. A program on
> cpumap or veth can use it to drop RX metadata that an earlier program
> stored.
> 
> Without the XDP_FLAGS_HAS_SKB_EXT flag, the kfunc does nothing, because
> the header bytes may then belong to the packet.
> 
> The kfunc only clears XDP_SKB_EXT_ENTRY_ACTIVE, so a later store of the
> same id reuses its offset. The flag and the size of the area stay the
> same, also after the last delete. To give the bytes back, the kfunc
> would have to move the entries after the deleted one. The cost is
> headroom that bpf_xdp_adjust_head() and bpf_xdp_adjust_meta() cannot
> use.
> 
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
> __skb_ext_del() frees struct skb_ext after the last delete, because it
> comes from a slab cache. The skb core extension area uses existing
> headroom, so it is not freed.
> ---
>   include/net/xdp.h |  8 ++++++++
>   net/core/xdp.c    | 26 ++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)

I think this approach of simply disabling the entry is okay.
This is trading off performance vs small area memory usage.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

--Jesper
