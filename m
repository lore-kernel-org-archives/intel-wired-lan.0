Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5848CC77B77
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Apr 2023 04:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB0D64093E;
	Mon, 17 Apr 2023 04:57:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB0D64093E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681707462;
	bh=nx4Yz8iaQszacrfXyhkxIYm5yl/aqmRcz4ZY+a1PJlU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=F3i5vAxdjaSl3k4nmHif98iMTBCnAws7yB7+qgM6d1vcVaJicEWAf8wpJn5cRXxAN
	 lcB1isutFQ8H3bbjA/ha8zv/T1kAgRS/B+SqHuINHzciwA1xT1Eo/fVanR7CbIVxf7
	 kLc9G67fESzMuFxA0ejAQl21j6zDfkOyFbY7KqFamwGJOmrxZ+KUzXOHgGkmh9SU2r
	 mV0PWjn67es+x+rT/YGRpnInfPrebwL8T9Lk7yvTpGFu8UmP+0gRAmCBMt/pP+kPDT
	 +VLkQ/nPOhVe3FDOT5Q870l5tBR/X/FmzcWTTn9bg2qLiD+aj2ZpHoF4UjXRj28jFd
	 iWrkllNXbwdDw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D7SDtfp-sZoy; Mon, 17 Apr 2023 04:57:41 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8D214095E;
	Mon, 17 Apr 2023 04:57:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8D214095E
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id DC2121C40DF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Apr 2023 04:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6DAF606ED
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Apr 2023 04:57:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6DAF606ED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9NWsMzobQqKR for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Apr 2023 04:57:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D180060035
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D180060035
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Apr 2023 04:57:38 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1a524c999d9so12984805ad.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Apr 2023 21:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681707458; x=1684299458;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQ2gshH4/aCZhlG2BB2SngtL8XpumcJLw5HG0dcuZLQ=;
 b=jB+x4SWQXGS6eidlOeZjLp8K6+5NjZujHB9o+4vRgalXZeln8WZlVJNDUqhUai8kIH
 CcVr1aaQdZ7qGRlK8utW3uRDqKgXmVTf1EopgYNLx9DjhsDcTFx87KTUuoaXC2Pdwgwe
 5ShkVP6NECLUSy4kXohJxy4fJf3nRWXNv3ZTrQBPgTO57AD/JiqmFDUPQqrFjlxC/L/E
 YnkpzyjfHplG3ZLJQuweQkJTYIt3WS9x9QoNwdMfRTkxE8j1kr7sWhniu3UQbbEqoxCe
 FdIWD8M/EXr+Gec1sOAG6YAQZ+mAOCKKGAwS8DupZEKJk3tbIw11135NDpC94Po33iF4
 u/Mg==
X-Gm-Message-State: AAQBX9eVH7Ra1uMdYwn+hwr3GxvtdPFp8w6SMDF/XDnuPU7VrtfZilVv
 5dPPX0usiWHycM4MKfbp0E8Jq1Wmrm2KNqdbK6kGghOjhBWoKcRNgjY16cWkUJRGBgZNW9uehTw
 v0lLimOTymQlti8b5pB1Mx/RM3UllYiI6tw1bAO4p7WODnvkzS7TdttsvI6jkoXk+We7UxMNZoO
 YCo2sYJpyh2Qc=
X-Google-Smtp-Source: AKy350ZYHpIepWRtN3k9kQ19yynNJyiqDe2ySdGp7mo8KQCzt3ajVQh7ziUtJngm+4Iz0OPEnkaGAQ==
X-Received: by 2002:a05:6a00:1a16:b0:63b:646d:9165 with SMTP id
 g22-20020a056a001a1600b0063b646d9165mr12728795pfv.26.1681707457694; 
 Sun, 16 Apr 2023 21:57:37 -0700 (PDT)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a62e811000000b0063b8f17768dsm1209102pfi.129.2023.04.16.21.57.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Apr 2023 21:57:37 -0700 (PDT)
Date: Sun, 16 Apr 2023 21:57:34 -0700
From: Joe Damato <jdamato@fastly.com>
To: intel-wired-lan@lists.osuosl.org
Message-ID: <20230417045734.GA43796@fastly.com>
References: <20230416191223.394805-1-jdamato@fastly.com>
 <20230416191223.394805-2-jdamato@fastly.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230416191223.394805-2-jdamato@fastly.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fastly.com; s=google; t=1681707458; x=1684299458;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQ2gshH4/aCZhlG2BB2SngtL8XpumcJLw5HG0dcuZLQ=;
 b=GE4kR3sifv7Fu3ED9vPiLYwCMFJ06zXf4GpRQbArlZef+q30cUwy7GR9K1tMhMFIbV
 0Ou1IQUI8GcJ1Q6VlFmTSGh7zMbsWcL8eGY8mm6BmvR6o+TfKOISgbBR5C2cRjSULg4A
 XhAI2uBwH5SEgKzYoRZRyRNkrug57bfD98MrA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com
 header.a=rsa-sha256 header.s=google header.b=GE4kR3si
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] ixgbe: Allow flow hash to
 be set via ethtool
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 jesse.brandeburg@intel.com, kuba@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, Apr 16, 2023 at 07:12:22PM +0000, Joe Damato wrote:
> ixgbe currently returns `EINVAL` whenever the flowhash it set by ethtool
> because the ethtool code in the kernel passes a non-zero value for hfunc
> that ixgbe should allow.
> 
> When ethtool is called with `ETHTOOL_SRXFHINDIR`,
> `ethtool_set_rxfh_indir` will call ixgbe's set_rxfh function
> with `ETH_RSS_HASH_NO_CHANGE`. This value should be accepted.
> 
> When ethtool is called with `ETHTOOL_SRSSH`, `ethtool_set_rxfh` will
> call ixgbe's set_rxfh function with `rxfh.hfunc`, which appears to be
> hardcoded in ixgbe to always be `ETH_RSS_HASH_TOP`. This value should
> also be accepted.
> 
> Before this patch:
> 
> $ sudo ethtool -L eth1 combined 10
> $ sudo ethtool -X eth1 default
> Cannot set RX flow hash configuration: Invalid argument
> 
> After this patch:
> 
> $ sudo ethtool -L eth1 combined 10
> $ sudo ethtool -X eth1 default
> $ sudo ethtool -x eth1
> RX flow hash indirection table for eth1 with 10 RX ring(s):
>     0:      0     1     2     3     4     5     6     7
>     8:      8     9     0     1     2     3     4     5
>    16:      6     7     8     9     0     1     2     3
>    24:      4     5     6     7     8     9     0     1
>    ...
> 

Sorry for the noise, forgot the fixes tag.

Fixes: 1c7cf0784e4d ("ixgbe: support for ethtool set_rxfh")

> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 6cfc9dc16537..821dfd323fa9 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -3131,8 +3131,8 @@ static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
>  	int i;
>  	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
>  
> -	if (hfunc)
> -		return -EINVAL;
> +	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
> +		return -EOPNOTSUPP;
>  
>  	/* Fill out the redirection table */
>  	if (indir) {
> -- 
> 2.25.1
> 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
