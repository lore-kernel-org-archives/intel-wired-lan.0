Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7096C02193
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jan 2025 10:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 712CF41440;
	Fri, 31 Jan 2025 10:05:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jaW15mZoG7Kc; Fri, 31 Jan 2025 10:05:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AFF9412C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1738317954;
	bh=YUCkWLuraLeMQBvY6DzjO8l/cXFVGvcco/yxcce5m9M=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1LcC5JZ3/WymMIZntGPmLaFmuLon1YnD6HpImA3zdeZXWNs1rxX/sbnE3g0fNLmil
	 Qhz4pgPRAypfo6oYJrFTPEhloY3FsdRDtPIdvaZyo/9coAkWw/gSfK6tH/B3+JjfmC
	 jpuKLkvsGC7M/hjurVOrhxGcGJppvfudAqPj72NSVWv6zKzlpMxg8LtnzfP/X/oqCl
	 bQpZP7BhFC8yKrwRjAcMSYfi814LYEuFiTiT64QUQABuXyQovbSdQHw8FtUMw/1h0g
	 cs9GBmsazhABC2E91TFss0OetLWe+uvoU01APoWFSVEH3v1SJMJMNpes/2WkdJFmxy
	 ezdx5WLI/NIJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AFF9412C9;
	Fri, 31 Jan 2025 10:05:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C860B16C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jan 2025 10:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3A62412D0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jan 2025 10:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rn6PDvCyiA8l for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jan 2025 10:05:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D3E704124A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3E704124A
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3E704124A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jan 2025 10:05:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8BBFD5C59F7;
 Fri, 31 Jan 2025 10:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ACCC4CED1;
 Fri, 31 Jan 2025 10:05:47 +0000 (UTC)
Date: Fri, 31 Jan 2025 10:05:45 +0000
From: Simon Horman <horms@kernel.org>
To: Zdenek Bouska <zdenek.bouska@siemens.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Song Yoong Siang <yoong.siang.song@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <20250131100545.GF24105@kernel.org>
References: <20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-v1-1-b765d3e972de@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-v1-1-b765d3e972de@siemens.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1738317951;
 bh=fOGvzt4VXpEvCOY+kXMq0uNd0SgvKFlchoIyv6XU0bk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QE4WKA7gY0xGktkyO5t3ED+S8CDsKoqhNJAwhoWmL9ESKRCS+SdHy30ikMQPjjlJY
 tSSdYtw94CkCLaMsRPNv6SAedBrxJ+E7C1BFvuuCUB9IfKVXWxDgbRqV6Y91qg9Qjy
 o0AAEs5Jx/XCYFnEHscsyLfHl5sshAPcXXfPJ/3iW5YfA7xSO1/p6zlXILM3jfbGRx
 tHvjQ+8De9sgFh2h4koz8akuFuhun4rrwYqRZlNVtSnFW4tCk5h1DNzDBwllZcUyFG
 prqRa/S8ACSaJsCnq4aMsnmhESAXlqBMt9BZSSllChd+zb3TFSaut1ZNfMjG9Ro5Uj
 kCe0B+zt5Yquw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QE4WKA7g
Subject: Re: [Intel-wired-lan] [PATCH] igc: Fix HW RX timestamp when passed
 by ZC XDP
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

On Tue, Jan 28, 2025 at 01:26:48PM +0100, Zdenek Bouska wrote:
> Fixes HW RX timestamp in the following scenario:
> - AF_PACKET socket with enabled HW RX timestamps is created
> - AF_XDP socket with enabled zero copy is created
> - frame is forwarded to the BPF program, where the timestamp should
>   still be readable (extracted by igc_xdp_rx_timestamp(), kfunc
>   behind bpf_xdp_metadata_rx_timestamp())
> - the frame got XDP_PASS from BPF program, redirecting to the stack
> - AF_PACKET socket receives the frame with HW RX timestamp
> 
> Moves the skb timestamp setting from igc_dispatch_skb_zc() to
> igc_construct_skb_zc() so that igc_construct_skb_zc() is similar to
> igc_construct_skb().
> 
> This issue can also be reproduced by running:
>  # tools/testing/selftests/bpf/xdp_hw_metadata enp1s0
> When a frame with the wrong port 9092 (instead of 9091) is used:
>  # echo -n xdp | nc -u -q1 192.168.10.9 9092
> then the RX timestamp is missing and xdp_hw_metadata prints:
>  skb hwtstamp is not found!
> 
> With this fix or when copy mode is used:
>  # tools/testing/selftests/bpf/xdp_hw_metadata -c enp1s0
> then RX timestamp is found and xdp_hw_metadata prints:
>  found skb hwtstamp = 1736509937.852786132
> 
> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>

Reviewed-by: Simon Horman <horms@kernel.org>

