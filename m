Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D3DC44501
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 12:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89FB1408DB;
	Thu, 16 Jul 2026 12:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f68puZwmjH9P; Thu, 16 Jul 2026 12:30:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD37D408C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784205040;
	bh=mmvRkk+7hLp/TwLQ/myCqZjT/o4rdVb5i1bmgc1547s=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RDygGKpKe8fLkg+3fotkk60jJZlv2uCqR8XclKqCn6TkFQOXhe2J/aiY5sE4Jf3F+
	 1VhyZIi+plpLR73VUSeT4Dylwm1ESI+Em7R647EOtLfNpPDeMT064kTQW9ZgN0KZG+
	 HIqWYkgbJ/pH9bv8q53UmA8H2Y5wxXo3USroKSGS+LbvGM3UIWeTQt7tN0NKk+DvBf
	 JWF2ecafg50vW5J9elBiCDXp9/wgq0T4CJ5M1cS2EUjhjyTbclUl4dHTBB8GED8Fsb
	 nQrwW26sdQwn3TuYyCdVn9WpWsMsTSvz2spfV760JyHP0GZBRoKwlkO0ZuxmDnu2qx
	 vz9tcIIoPXsjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD37D408C0;
	Thu, 16 Jul 2026 12:30:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 234431F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 12:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1485980E88
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 12:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j9mkiuY1eRHv for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 12:30:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::1;
 helo=mail-pz2-x01.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9536A80E86
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9536A80E86
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9536A80E86
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 12:30:38 +0000 (UTC)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca8758e7e94so268646a12.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 05:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205038; x=1784809838;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mmvRkk+7hLp/TwLQ/myCqZjT/o4rdVb5i1bmgc1547s=;
 b=EdP+YfOaKL8m8a7fW+nnkMCcTnFhKKHwfkbX59x04zpJOaoFeMM4agIF3URGNQnafW
 JeiWyVBpyCSE4m/2gl8T1dkRqjlZ94XwzJsjWcV3T+3Ov1va74N++FhIa73XZKrFetLr
 bJ0Ma6ZqFNhPbqYY5zt2Pqjcqx27xI/YUEYv3Bm+N9GMOnzPaw2uuLa8dmP2WRxref6G
 wIe+lVBDmQOfq+g7f3Oi/GTcJ8m6XuDaud6p8BIP34M9SquBIsTSAkAczCgXTshOJ5hY
 SkWME764hiKJsHGP4rBTNDYe9a21CTJKBC9yrTmRnheiatam5X81c0qvo2Zo6iXMPaUz
 Ja0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJJUy44DYKejCLqYHMf+9oX+z4wOTCxix9WF11s/DFwuYNWIHUfb/nUnGK8PeDsI6qMXLCpzXOniiQu6ucVmo=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxqzNJzPY5L3Bo8LkjVNYBZuwADnSip4GuXZeuOP1kuSuzD0ch+
 1CBJmqxfUVnKZg5vvQ1Wuqa8uFWegtobsbA1LmVyQRl94WsT1XyQhzWn
X-Gm-Gg: AfdE7cnzt9FGyDn0uEt7y791vEMyf0xlr8LweXTU6GXf4S4o4/EVMhOxhKzFXzhc+pc
 PoTeZ5j8cga0EjiCVg9WFrbrPQ2l6qZPbBMv97ESWZdVazgSSapbVU6z9Lz+922DgbvS5FbiYu6
 xkA0T+pU0a/9Wb1hOia9cM/kRtxQ0FSJNGINv6j2I+56w1C8qQiNn53JnEgCFBdYJSolnaGP0rF
 PBG3aVoG8iIHUOWfVjUIBhh9CTnHY3pys2Hb1gZNbnMvZLLKXQ9FjFLWR5AZV0BbATzp8e2E3Mv
 cxgM5CtPj5Wczdy780xdNrouhFx74Jn8CCg2JCewK7Ww+SXBIr34WpjWPSxu9b3Y2fN1Ma0ztuJ
 iwm5NizTe3uKlwZf7/Y0Pu/1RjUSRuk+QVpUaDcdexzWk0rHKYc6CMpZECkhpf9URf4QtrIG0d9
 spMuNtQw==
X-Received: by 2002:a05:6a00:a0a:b0:829:b08f:7353 with SMTP id
 d2e1a72fcca58-84beb0767c5mr2200864b3a.7.1784205037593; 
 Thu, 16 Jul 2026 05:30:37 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f81a5absm4902337b3a.54.2026.07.16.05.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:30:37 -0700 (PDT)
Date: Thu, 16 Jul 2026 05:30:31 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin <deliran@verdict.gg>, 
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-ID: <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784205038; x=1784809838; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mmvRkk+7hLp/TwLQ/myCqZjT/o4rdVb5i1bmgc1547s=;
 b=XlYG+UCaouBMSrJGqp43GoECEIvl7smkFxec/KmY5v7QHb0Bc4HtYq+Omsi5ZQEURn
 jyMLBCll5ez0eXPZ0LBHZiSxScA/iLtRRvbzBoSszQ1hWhm3oESA8lZc5vlgh/jUOaZu
 eArqxjko+0JG+q3+5SoLCTkxo77H3hsh0m1ytTB1tyZtNIm4GIDvgukoetKRnkG5LQvp
 FY5mq3S/DwBZ2jQpbelsGJaO3WtGgmA/Pf1KH2rCR1BMVEU1Xl5RmydyxidIZ3OlmTOb
 KG3T1llsrSHdsgJ9q/PWH4MEQdnY5BWw6e82dPeh6WOUlhgO9I5/LxY60+lBUcKpU8vl
 XT1w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XlYG+UCa
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v5 8/8] selftests: net: add
 test for XDP_PASS skb checksum invalidation
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 07/15, Lorenzo Bianconi wrote:
> Add a test that verifies skb->ip_summed is set to CHECKSUM_NONE
> when a device running in XDP mode creates an skb from a xdp_buff
> if the attached ebpf program returns an XDP_PASS.
> The test attaches an XDP program returning XDP_PASS, and a TC
> ingress program that runs the bpf_skb_rx_checksum() kfunc to
> inspect the resulting skb. After XDP_PASS the driver must invalidate
> any previously computed hardware RX checksum since XDP may have
> modified the packet data.
> The BPF program counts packets per checksum type in a map, and the
> test runner verifies that after sending traffic the CHECKSUM_NONE
> counter is non-zero while CHECKSUM_UNNECESSARY and CHECKSUM_COMPLETE
> counters are zero.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/networking/xdp-rx-metadata.rst       |  5 ++
>  .../selftests/drivers/net/hw/xdp_metadata.py       | 55 +++++++++++++++-
>  .../selftests/net/lib/skb_metadata_csum.bpf.c      | 73 ++++++++++++++++++++++
>  3 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> index 93918b3769a3..7434ac98242a 100644
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst
> @@ -90,6 +90,11 @@ conversion, and the XDP metadata is not used by the kernel when building
>  ``skbs``. However, TC-BPF programs can access the XDP metadata area using
>  the ``data_meta`` pointer.

[..]

> +If a driver is running in XDP mode, any existing hardware RX checksum
> +(``CHECKSUM_UNNECESSARY`` or ``CHECKSUM_COMPLETE``) must be invalidated
> +by setting ``skb->ip_summed`` to ``CHECKSUM_NONE`` before passing the
> +skb to the kernel, since XDP may have modified the packet data.
> +
>  In the future, we'd like to support a case where an XDP program
>  can override some of the metadata used for building ``skbs``.

Sorry for keeping nitpicking on this, but I'm still not convinced that
it is what we currently do. From my previous reply:

> > Looking at a few drivers:
> > - bnxt (bnxt_rx_pkt) does UNNECESSARY - ok
> > - mlx5 (mlx5e_handle_csum) does UNNECESSARY and skips COMPLETE if there is
> >   bpf prog attached
> > - fbnic (fbnic_rx_csum) - can do COMPLETE even with xdp attached?
> > - gve (gve_rx) - can do COMPLETE even with xdp attached?

(although for gve I might be wrong, there is also gve_rx_skb_csum that only
does UNNECESSARY).

I'd wait for Jakub to chime in, but it feels like we should just document
what we currently do as a recommended approach: for the drivers
that support COMPLETE, do not report it when the bpf program is attached.
Both NONE and UNNECESSARY are ok.

Also, did you run this test on real HW? NIPA now has HW tests, maybe it
makes sense to route this series via net-next to get the real coverage?
