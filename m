Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E62EF99D3
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Feb 2026 20:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B39741E17;
	Fri, 13 Feb 2026 20:34:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rOkXYB-XIC59; Fri, 13 Feb 2026 20:34:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 703A641E14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771014893;
	bh=byJ7P9wBxKwBGxzkiFFWkFLzr5TIuDdg2vakTlQnC1w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YlfOY4PEbUFDp8asKeS4kcJgn7bkm52maZcxAa5HWzV7+IhL3TT8m282rKCtYiZ1C
	 OOAi0ZSSbFQAKFZN+W2Z7d+y+rJ97v6jrAC9vWHuuxSujpugxn+IaVrL1rDgmWkqju
	 yl1Yga+3/SWc+VdmVzQ3Q/QJv73W7e5zKXGAIQoUaeg4MVFoC3bDGCPN1pewQBP3yY
	 J+BsO64AQcTpcUFYVSeHDKTpgttP94HqJvMBNSN5e5FREZ8mq6GjodRszFz10V1aFj
	 hbYCZLWCAe720B2+uipRS8NUivmyC2Z1THPKu44QhpWf91PaOy7qLjWDSMZdrjY5Nd
	 26wF/7LayQ0Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 703A641E14;
	Fri, 13 Feb 2026 20:34:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4767569
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 20:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28C308130D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 20:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 73ctHupYJvW6 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Feb 2026 20:34:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 956CD812D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 956CD812D4
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 956CD812D4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 20:34:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 44C6F6091C;
 Fri, 13 Feb 2026 20:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13816C116C6;
 Fri, 13 Feb 2026 20:34:45 +0000 (UTC)
Date: Fri, 13 Feb 2026 12:34:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, "Bastien Curutchet (eBPF Foundation)"
 <bastien.curutchet@bootlin.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>, "Ricardo
 B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>, Eelco Chaudron
 <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Toke
 Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Message-ID: <20260213123444.12fd433e@kernel.org>
In-Reply-To: <20260212183328.1883148-3-larysa.zaremba@intel.com>
References: <20260212183328.1883148-2-larysa.zaremba@intel.com>
 <20260212183328.1883148-3-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771014887;
 bh=XxUt9o01tkl2YeDC894gfSKrSV9JalAY+MmXygvGPhk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hDp60Yyho4yXiHjPDWqvFUJnMKAiJv7mwRpUKs0th2GCzeNB+Froz1yzy6qvMW7MR
 Fau2WLI+fY9sPaBEFU577fpBUmaZt3TjJWBWKloUV9JpEkQCxPt+RgCRzP/0X8byCs
 lzxfCwb6bpODUIUEXWbcP3isLC9l9yuvBc6EbJWmqOkEwf4Bqvp5lbEuHNCj4VxcXU
 QUNKJeQTF2nRqwHbO2777R+lSnwQsn4FBRGdnE7kVFQOAFKzfg4/l+FyQbHOYu/d9E
 /YdFBaoWReY6379kNQ03msQ3Hhdrw6hwdAu2GYoFe00CPDhnxuOEweL6qsXDXBt9QF
 9vuP2MXDPvBUw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hDp60Yyh
Subject: Re: [Intel-wired-lan] [PATCH bpf v2 1/9] xdp: use modulo operation
 to calculate XDP frag tailroom
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

On Thu, 12 Feb 2026 19:33:16 +0100 Larysa Zaremba wrote:
> -	tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
> +	tailroom = rxq->frag_size - skb_frag_size(frag) -
> +		   skb_frag_off(frag) % rxq->frag_size;
>  	if (unlikely(offset > tailroom))

Acked-by: Jakub Kicinski <kuba@kernel.org>
