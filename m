Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC36606A7C8
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Miq3CxpJ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBT3jv+7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EC3481365;
	Tue, 10 Nov 2026 13:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UnAxb-5ThN47; Tue, 10 Nov 2026 13:10:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BCF0081360
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794316225;
	b=eSh9Tu2VydU334d3VzZ8y6uY656dx6QC/M7gHjgq2QQsnV6JMimJfAntn+S1qPTGt/IE
	 mcdF9akbBdeDazpmQ5lUN94BlARZlCOK/NaFtTEldVLuIbq+3a/4OTYF06FsEttNwCNCq
	 jCV4drdYO2DZ/KT9NlGBh8Y5TY4s+kF3CRXwD5ng3+Tcq7vrgYTiSL/TAn4QSa4NQCOFM
	 O7yb3fl6YaDIFmTcklUyHQk9cvUYXf7m4WosUnQ93BqDz/j1jRboA6eu32SbECjXeXcWM
	 aDtvUNTOwllpy+5pMmDoSOfiMe1/ISpEdSVjpTp4Pu3yBZDl03KyjrRd8/C0oPLK52w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316225;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6syMrSNRwGS6gjty+GgbOX5gHZbIzGMr07iLqxjqTOM=;
	b=qtU0E3WSXzPki7WmBdzvkGb3vsRzMEBvQfQpHiiuxGl4U00E/LYDbe77JQ4nx+S2B1TI
	 uTDVaqotOUC7OfkNjB+uHu+CyAIWEEI/9DH/VTMcpfENaSMMIJjoENT6OCzI2tWO+s5Kt
	 cU6YwmsLPPNuLDAdBDOdbx2KXFMmDCTPviN1j71Z/8JR9xhvhJsVywkyB2q77dH0MuSyL
	 Ex4rGH1eYsqqC5Z8U9vlnmgTP4YoG/Gz0j2ub2FcTuoR23olFjandhrLCtd870JJi7gPt
	 0N/adBLY2ga2yIHfCAvKlt7BOfkevtl+uSijxrBccCmtgssYynS16a1P4WBgrK8gGSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794316225;
	bh=6syMrSNRwGS6gjty+GgbOX5gHZbIzGMr07iLqxjqTOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Miq3CxpJw9jDSHafWeoMr+YGlHr5xTeg55/CQSSvdSPsi9GNa1xi0b8lAcRA+IHOt
	 kbEG39Fu7kRw+uLc/EAir0O8YQW24kK2x/Fh6GmS68H1ZDewsyrjL3ydw3MUIOE7eB
	 L0Xdd2LmRnz0VXHmNFqje1y2D4PMewSfEuB69W3A4H5rpigdA2V+sBMZxAmDk4oGPI
	 RmGfmi+0PxSc2E0DoBIvnaNbEG2YWehTL49UkZewwqvU//QHOcsdYIpuOlahIdTpc3
	 zDuX3Sf6mnTnIjagS1EHQVG83V7N1P5S3GPS8M1UenVZKT8HfoZIw17b6WHzBp+E10
	 TO1ZVfoT04iHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCF0081360;
	Tue, 10 Nov 2026 13:10:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 628971A6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 13:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5791360861
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 13:10:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OSubr48ly5MD for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 13:10:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67F1E605E0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=hawk@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oBT3jv+7
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67F1E605E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 13:10:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DA8A471BB;
 Tue, 10 Nov 2026 13:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF0C1F0089F;
 Tue, 10 Nov 2026 13:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794316223;
 bh=6syMrSNRwGS6gjty+GgbOX5gHZbIzGMr07iLqxjqTOM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oBT3jv+7Uh8iNm1FkZPAz5lvI4+ePpC8H2PhjSKqdjsT2nXrnihcgVY5/fNRN/qkP
 PdQe2p3NY1cjTf29GoUX5f7gXFwiXll+SNZDvqELr1jmfdnX9EgZsxiU79wdVAP/Nw
 3jsIJyYX4kr20uaqGlla6FYKC7LjFoyvU8yp3KTayEwQ/iknj4SpxJ9iibIkz9ZyGt
 24p2Kw4EZdFVhp4PGWqi25qvMUPoqlC6bNVjtS/MDaimyf7Al3GLinl8D2cYDKkrI/
 i12mODcI/Nlo4fa7mHti/iQ3zd0OZv8KCdMu0JiFvJYTsRGST2GQEGUseIznQD5kJk
 3vpkAAMH/xgPg==
Message-ID: <cec4e2cc-9544-4146-9c49-92e5cff7d670@kernel.org>
Date: Tue, 10 Nov 2026 14:10:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 01/15] xdp: reserve an skb core extension area
 after the xdp_frame
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
 <115997f55d63b507ce54fbe9e22900b59016f3c3.1794281983.git.tianyi@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <115997f55d63b507ce54fbe9e22900b59016f3c3.1794281983.git.tianyi@cloudflare.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/26 04:56, Tianyi Gao wrote:
> Reserve the skb core extension area in the headroom, right after the
> xdp_frame. An XDP program stores RX metadata there for the skb that is
> built later.
> 
> The area begins with a header, struct xdp_skb_ext. It records the offset
> of each entry and the end of the last entry, in 4-byte units.
> bpf_xdp_adjust_head(), bpf_xdp_adjust_meta() and bpf_xdp_pull_data() use
> xdp_skb_ext_end() as their lower bound, so packet data and metadata
> cannot overwrite the entries.
> 
> The XDP_FLAGS_HAS_SKB_EXT flag indicates that the header is valid. Most
> drivers reuse the xdp_buff between packets, so xdp_prepare_buff() clears
> it. With BPF_F_TEST_XDP_LIVE_FRAMES, reset_ctx() restores the flags
> before each run, and ctx_was_changed() compares them.
> 
> Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Link: https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@kernel.org/
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
>   include/net/xdp.h  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   net/bpf/test_run.c |  4 +++-
>   net/core/filter.c  |  8 +++-----
>   3 files changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 07231adfb5f8..c888353425d4 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -81,6 +81,9 @@ enum xdp_buff_flags {
>   	 * XDP program is not attached.
>   	 */
>   	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
> +	XDP_FLAGS_HAS_SKB_EXT		= BIT(3), /* skb core extension header
> +						   * is valid
> +						   */

This can be on 1-line (80 chars) of you change the comment to be:
  /* skb core ext hdr valid */

>   };
The rest looks good to me.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
