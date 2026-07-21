Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172B1C44529
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jul 2026 15:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2CC340849;
	Tue, 21 Jul 2026 15:21:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y9tPCiShSGFo; Tue, 21 Jul 2026 15:21:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6EFA4070F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784647287;
	bh=0Rmf+N0EMTdVuCGky14drmy18+nU8XenOdS3gncIz9k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sDeKE+tf9RkopueR1iGb233+TySg2ZQBeEh5PSG+Pree9UFXe16uGniPN3sQFkPtM
	 ii2HPXVNcwyXCEmLL9u+s6qSKTm/6kSo2SgcUlQO2vZvM/oLdK00k2hwTQUH1vlJoR
	 CVXSQvVymsPVuna7kZsneGaGSjoPDxEP6WVUM2KTDS5pa5wuZl8vS4tDOUzD1Qic/R
	 mffTiuAEgtQuXkJ9Bj5zhLwfilQx20u/SJZTnZn2FCqeOJ9uUvKpNS/AT0RrCu6AEx
	 mr/TVYF4Gw+VOyAQ+gfg8zDyKJ2oiNevz2IObo2S1zZv+UEfy4TdUTtvSSbWydNa5V
	 ROtp8n4m98bIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6EFA4070F;
	Tue, 21 Jul 2026 15:21:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FB40EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 15:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6943C4070F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 15:21:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sNGwu09WihA9 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jul 2026 15:21:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BFE5F406E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFE5F406E9
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFE5F406E9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 15:21:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D89A2434B2;
 Tue, 21 Jul 2026 15:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72C21F00A3A;
 Tue, 21 Jul 2026 15:21:24 +0000 (UTC)
Date: Tue, 21 Jul 2026 08:21:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin
 <deliran@verdict.gg>, Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Message-ID: <20260721082124.0f44f8e9@kernel.org>
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-1-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-1-623d5c0d0ab7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784647285;
 bh=0Rmf+N0EMTdVuCGky14drmy18+nU8XenOdS3gncIz9k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bxDS6E/thFmxdUIU38K1fepDyvUlwG5v6zo1cHmc84NV4hPg9pG3ccERxRa2mfTbA
 vvsX3tbh3TkNuXol0mkQvMH/48ozCWlQX0YRrdhvMWVNNibQVv0caGvLjnCBRTaeia
 YKyQuWmmQbwuGi7hwaOZu8KVmzu3jnU44HYEjOvCsV+wNeX8mWnuuVjFkLPObT0Dzm
 zFVsbKD+iv0DDMf4xP6f8bdFBxqSIbt81d0i/TGMlPoYviUenDEW96/p+aBSr1gaq8
 84fBp8eb7+nSREO6ipgIpjVGZX17dOe4eLBd62mJEzqGuEDZCCjk/Y8Am/N7Unh8ka
 +ObJa4D4fLZyg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=bxDS6E/t
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v5 1/8] netlink: specs: add
 XDP RX checksum capability to XDP metadata specs
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

On Wed, 15 Jul 2026 23:39:41 +0200 Lorenzo Bianconi wrote:
> + * In case of success, ``cksum`` contains the checksum value calculated by the
> + * NIC. ``cksum`` is valid only if ``XDP_CHECKSUM_COMPLETE`` is set in
> + * ``ip_summed``. ``cksum_level`` contains the checksum level reported by the
> + * hw. ``cksum_level`` can be considered valid only if
> + * ``XDP_CHECKSUM_UNNECESSARY`` is set in ``ip_summed``.

nit: cksum -> csum like the rest of the networking stack
