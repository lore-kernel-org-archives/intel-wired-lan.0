Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9A6C47DD3
	for <intel-wired-lan@archiver.kernel.org>; Fri, 19 Jan 2024 14:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C18D8463A;
	Fri, 19 Jan 2024 14:56:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C18D8463A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1705676199;
	bh=0FJ3u8FQXRoqT7BwVNIx98aq+VUBYB6SO4lY5IMX48M=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=zP8mXn5lI/S7H5nIKZsLo6Oab/Ewl/u9NRXMT+RaJp+zb0Oez9/MHJ2PnUAo5MJFa
	 YG4CNbwNOpamBuBDiuVmun+hiUf0vnAuZcmleQNIL7dyW0hej8j56rxq+KqRtsgpL7
	 GYF9v4UNhGegdXTYsUdwvf3ZpqqNi8rZiTWUdVHMFnIaGq5GlZQk5oO5pS+54cW2aO
	 ejrABNFhe8e606SM283GUPoo4orsfGLA0+viWS8gTaFHmMksQxJrsGOu28QroOdb5K
	 jrIp1qjH2ibosfl+EgoTpvsmtOG8x37rbaxCvzkArDCzvffBBMOU1TFJ5Nn+vfHwiq
	 XiXmgppz14J/g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jrpruhvK5kM9; Fri, 19 Jan 2024 14:56:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C40E8463E;
	Fri, 19 Jan 2024 14:56:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C40E8463E
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1E2781BF35A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 14:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 012774393D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 14:56:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 012774393D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8vXJoiB4PrFb for <intel-wired-lan@lists.osuosl.org>;
 Fri, 19 Jan 2024 14:56:21 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2BA8A400D6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 14:56:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BA8A400D6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 625C8618F6;
 Fri, 19 Jan 2024 14:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FC9C433F1;
 Fri, 19 Jan 2024 14:56:17 +0000 (UTC)
Date: Fri, 19 Jan 2024 14:56:14 +0000
From: Simon Horman <horms@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Message-ID: <20240119145614.GB89683@kernel.org>
References: <20240115082825.28343-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115082825.28343-1-chentao@kylinos.cn>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1705676180;
 bh=qHs04bjtpQIRD5zTdGPu5IZXoDqL4hhRu+sEHgltQV0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=saWR+B9B9L6yDQk5YP+UwF5lhmfamU39f5eLZpY4n/aGzCzJoW/G8P2Fw5jVe5+g0
 nap8LyzoALjJzxEj93SZWbo3LY0K+/LAvi6bNICEO8qmOHzARNK+3PXIe8rMRa8Lri
 wekHJ1hP1AooS+spxD4UZXQiZdrYkgp/d5MoTvL5otdLzCT2H7DhpSgyfySb+wSNL7
 FcZq/a2zhkoZ+dujiddJpkvWUdVF0wTRSOVtpJc15aToPSerSjDpbeUiv99XpPmIsc
 AAdH4j/FftzPN30bzPfwuG8VJCsvTWf+S9L8707gM6uiA4dEZR3kH7gMgh91CEHe04
 ZCbQSLwkJscqQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=saWR+B9B
Subject: Re: [Intel-wired-lan] [PATCH v3] igb: Fix string truncation
 warnings in igb_set_fw_version
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Kunwu Chan <kunwu.chan@hotmail.com>, przemyslaw.kitszel@intel.com,
 jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jan 15, 2024 at 04:28:25PM +0800, Kunwu Chan wrote:
> Commit 1978d3ead82c ("intel: fix string truncation warnings")
> fixes '-Wformat-truncation=' warnings in igb_main.c by using kasprintf.
> 
> drivers/net/ethernet/intel/igb/igb_main.c:3092:53: warning：‘%d’ directive output may be truncated writing between 1 and 5 bytes into a region of size between 1 and 13 [-Wformat-truncation=]
>  3092 |                                  "%d.%d, 0x%08x, %d.%d.%d",
>       |                                                     ^~
> drivers/net/ethernet/intel/igb/igb_main.c:3092:34: note：directive argument in the range [0, 65535]
>  3092 |                                  "%d.%d, 0x%08x, %d.%d.%d",
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/igb/igb_main.c:3092:34: note：directive argument in the range [0, 65535]
> drivers/net/ethernet/intel/igb/igb_main.c:3090:25: note：‘snprintf’ output between 23 and 43 bytes into a destination of size 32
> 
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fix this warning by using a larger space for adapter->fw_version,
> and then fall back and continue to use snprintf.
> 
> Fixes: 1978d3ead82c ("intel: fix string truncation warnings")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>
