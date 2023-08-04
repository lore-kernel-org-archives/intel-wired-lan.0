Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EE0C001DB
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Aug 2023 08:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3E5641C55;
	Fri,  4 Aug 2023 08:30:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3E5641C55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691137840;
	bh=N48PWJVsM9dcNnoj3PAftAsCwyoPalk63B5JHTZ78H4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Az04lTFgPKyoWcu3Q5pCDycUvx6tfDgwMMjtiEb2mzgOvv06/41XiqjY2dwVnJTOP
	 Bixt+ZQ5NLE8j3daQMSd/++PfLZfFdJ0pUVx+SwGT+9jIwU957L44P5l2rVanFmHsw
	 tiPNm54U7hSTwJdGl3MMA3+JqoJDgKigQo5NuJP841klHLYCtTrQcMyz1IpvJW9sTe
	 j7xgzL+4mqBztKHUF218klRQBVMoEUNYWI41gnKgrZzP8ojan2k5GSjMY7JCRJyCF0
	 DJ4G29x4I1RnvlGteJzMRRMFOsQ+chv4M3n+37JHiWtusob2UaWIxGyS9RjDzF98c5
	 /Ttp7u9PzSTbw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j7hc1Nlo6ycL; Fri,  4 Aug 2023 08:30:39 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABB3141D7C;
	Fri,  4 Aug 2023 08:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABB3141D7C
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 31D621BF341
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Aug 2023 08:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 967DB821C5
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Aug 2023 08:30:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 967DB821C5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C1aeuaKyqQi7 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Aug 2023 08:30:11 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DA6B82F06
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Aug 2023 08:30:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4DA6B82F06
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bca857accbso1590114a34.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 04 Aug 2023 01:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691137810; x=1691742610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTW4GcsIoC0wedeu0cP1p/SdzNq7SXqwMejU+XlRg/A=;
 b=axvT2mblT2PAnp1etzf3GxTg7MMxUb+hgmtEt82Oi75tt5+7fij07XwlDhoFOLNQ/2
 6B0AFzfuPP/ouLNVvoP7/GdtAJs9U3zhrHz2WS0zFdkTDrjSbokyucu+Wv/duORttmaa
 X6wTL+xl6bfSxD8O7bguZV737aVGlTUAmDcLCjCa0s3kFTW59ApA7QpQMnTMSRFkKYY1
 wMJW/Fcwvl5bOHC52ySis0FC41oV2tYX27wpUH9Mlxg5LNggBo9L/u+fro3QJXTMSwzJ
 mEPjZOhfGlOOF6C+QnO9WgEDRNJ8mbuNxnLar0sDx/EHTDOO3PcDv2M8wWL9rq8ciZG/
 DGOA==
X-Gm-Message-State: AOJu0Yxod4e1WvJRPcxm7X4e0APTmhBoKBQzf5aVhw9ws2iifqvv9Ii/
 jDi/UvN+zBksa4M3umZyMFictQ==
X-Google-Smtp-Source: AGHT+IHh6wCyuLACZdpvHgsdR8UkOmQsmagdun+zvBpnhfZpwlQcNCElW7X7S0H00eHM1MYxpZV3NA==
X-Received: by 2002:a9d:67d6:0:b0:6b9:68fb:5a28 with SMTP id
 c22-20020a9d67d6000000b006b968fb5a28mr931396otn.27.1691137810270; 
 Fri, 04 Aug 2023 01:30:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 o14-20020a17090a4b4e00b00268b439a0cbsm1057998pjl.23.2023.08.04.01.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 01:30:09 -0700 (PDT)
Date: Fri, 4 Aug 2023 01:30:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <202308040130.E48094967E@keescook>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-4-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230728155207.10042-4-aleksander.lobakin@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691137810; x=1691742610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sTW4GcsIoC0wedeu0cP1p/SdzNq7SXqwMejU+XlRg/A=;
 b=GzQT2IqnS0O9DsPcor7DwEmC2sqiMDOSQPI4yqQEhlltfGaGer/VaRPL79vkoGC3nq
 OI2mf4uB95BiiebH88szvpfhhb4hvT2F+ko6eNeOK9/E9F2QgOGqU3hBbUOJg+LFzTmB
 vd+4ynvEAgfFtLVfaLBUybVzDa6hZBiOuW8u0=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=GzQT2Iqn
Subject: Re: [Intel-wired-lan] [PATCH net-next 3/3] virtchnl: fix fake
 1-elem arrays for structures allocated as `nents`
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 linux-hardening@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Jul 28, 2023 at 05:52:07PM +0200, Alexander Lobakin wrote:
> Finally, fix 3 structures which are allocated technically correctly,
> i.e. the calculated size equals to the one that struct_size() would
> return, except for sizeof(). For &virtchnl_vlan_filter_list_v2, use
> the same approach when there are no enough space as taken previously
> for &virtchnl_vlan_filter_list, i.e. let the maximum size be calculated
> automatically instead of trying to guestimate it using maths.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
