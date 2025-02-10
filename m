Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B520C0219D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Feb 2025 09:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFAA2413EC;
	Mon, 10 Feb 2025 09:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xeld06MG91XZ; Mon, 10 Feb 2025 09:13:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1917413FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1739178817;
	bh=pAf4xxjMd3bido3OYSPc5jm1TyPEocE6gMB8ihRh6EI=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a6Wq1DZS29B2LH1FqrMs5vdobrCaiZMancs2HV2hHbnS5B8cKkXLTFYc71hs0JE+f
	 A7C3Jnvl5lLZJjS7id4i53vPShlg5gINUL2p101ZyW7h0LnNGQYNkHyRjf8w/s4syp
	 pwNllip7ksYsMq2gqIH6jSzfdq6lZ8ZWKqqwbcsrBnLIk6ThZUweEAGIfaIytWibHn
	 AJDpsy0SNJLwoMnSlxSwv/MMYnFQ2uxi7Eo+MwaS2PPD/pl6o6n2ygc5kQI5HZv0Py
	 YaerGOtaNze4MZTC9HkJ7BZdrqhnnA8cwqyakhPIZucQ3fOVaxdx4ChNtigZekMpj9
	 VZZXjoWulOOYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1917413FB;
	Mon, 10 Feb 2025 09:13:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A7F1C2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Feb 2025 09:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7935340439
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Feb 2025 09:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KCzHlj2VjLAj for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Feb 2025 09:13:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::b3; helo=out-179.mta0.migadu.com;
 envelope-from=vadim.fedorenko@linux.dev; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3359840F73
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3359840F73
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3359840F73
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Feb 2025 09:13:34 +0000 (UTC)
Message-ID: <bfa55bd5-a5a1-4ef5-bb89-cb38eaec2cc0@linux.dev>
Date: Mon, 10 Feb 2025 09:13:24 +0000
MIME-Version: 1.0
To: Piotr Wejman <wejmanpm@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250208154350.75316-1-wejmanpm@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250208154350.75316-1-wejmanpm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1739178806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pAf4xxjMd3bido3OYSPc5jm1TyPEocE6gMB8ihRh6EI=;
 b=CceZQDOIpIJ8DujjXQhLHKVWH2biBmI5Huqn7vs2vKD0wInknLcSiw0ug8ybSVw31/wGSA
 pAg4L7EctJLJwQ+rbnRuARQfnE90KGoW3tgf12xeCsT5UvsVWtAqdVpo0wdgK4brGzauFv
 1Yn1hubC91lNdczFV9oeCK6v96EmPYA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=CceZQDOI
Subject: Re: [Intel-wired-lan] [PATCH v2] net: e1000e: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
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

On 08/02/2025 15:43, Piotr Wejman wrote:
> Update the driver to use the new hardware timestamping API added in commit
> 66f7223039c0 ("net: add NDOs for configuring hardware timestamping").
> Use Netlink extack for error reporting in e1000e_hwtstamp_set.
> Align the indentation of net_device_ops.
> 
> Signed-off-by: Piotr Wejman <wejmanpm@gmail.com>
> ---
> Changes in v2:
>    - amend commit message
>    - use extack for error reporting
>    - rename e1000_mii_ioctl to e1000_ioctl
>    - Link to v1: https://lore.kernel.org/netdev/20250202170839.47375-1-piotrwejman90@gmail.com/
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

