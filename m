Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190D3C001B0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Aug 2023 03:24:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ACFB24020B;
	Tue, 15 Aug 2023 03:24:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACFB24020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692069888;
	bh=rllcEF7xmyqbpmU3x5YICxxg0R5C1wyVu3ZtYFnOQeA=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kyxwZKcA7qbSO9XtL+O3w7Yl5zMwkU2AOpNat8VbGQnL404rZxlhgQn7E0vu7XRZH
	 xZlmRfMmZYIL5hmP0D1rRSK8f7ptOAEnjZm9Pc74IXHp+LfIp9P33KfUYJovlz9slt
	 TU3uXAwc3vC+/lFSbFQP7mDu6Bvx3sB1PCGBx6X71zOw2YbXrKhn+Dsb/S98gjY62K
	 L2Z5eDasyNWzjKknT/ATInMKW/s9bVcq+/5O+HRIsoJqgQbMkMFvpfb9CuJ922Exjp
	 jr1eTJRXYH14K2fhJmfDKssiYN89o84SIjxWhiOTuiiLrObLLyWscGhhQSGp7/2V8X
	 iEy95zyAe2k/A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BY13ZV0FVh-f; Tue, 15 Aug 2023 03:24:47 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 51B254091C;
	Tue, 15 Aug 2023 03:24:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51B254091C
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id DB9511BF380
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 03:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B070E4168E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 03:24:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B070E4168E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Z0Muwcopasm for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Aug 2023 03:24:44 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F1034161B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 03:24:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F1034161B
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CB37760ABC;
 Tue, 15 Aug 2023 03:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D622C433C7;
 Tue, 15 Aug 2023 03:24:42 +0000 (UTC)
Date: Mon, 14 Aug 2023 20:24:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <20230814202441.349586b4@kernel.org>
In-Reply-To: <20230811200340.577359-5-vadim.fedorenko@linux.dev>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-5-vadim.fedorenko@linux.dev>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692069883;
 bh=3FRPby38WxMTq6IfBU0Tvs25oJJdKuU9MSll+th2OsE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CohmaaG5iOklaCdHt91LUExlKpLVTVneSHhbdnXV20JXzqFrpqlDFmV2mcXlqi/zy
 0xrSDKaT+EGvXM4vwCw771XsxmZn7pRw7Tl1WTmb/KVsTBM5W7zXZr8NOVy5pNT5gQ
 eVv2srZ6/3YDU9VH1CZVh2LL3xn/ve/cl7yXOZCacsolZsnXnZFy9XJKky1jK4E6b3
 WdaqHv/eX0lL/oxtfLyFb32sCE8v4p0riDP8+UWgwM9BTWCJ5JmcvQs7pUDITYXA0F
 +0QkZKoC6sEPWH073OgEtVWZKzpkEV/meZf8ei7i9M+TaAyYJ4wqtycQWrEd4nCHZc
 j9Bw7B/xcRTYw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CohmaaG5
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 4/9] dpll: netlink: Add
 DPLL framework base functions
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
Cc: Jiri Pirko <jiri@resnulli.us>, Bart Van Assche <bvanassche@acm.org>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-arm-kernel@lists.infradead.org, Jiri Pirko <jiri@nvidia.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, 11 Aug 2023 21:03:35 +0100 Vadim Fedorenko wrote:
> +	xa_for_each(&pin->dpll_refs, i, ref) {
> +		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
> +		struct dpll_device *dpll = ref->dpll;
> +
> +		if (!ops->frequency_set)
> +			return -EOPNOTSUPP;
> +		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
> +					 dpll, dpll_priv(dpll), freq, extack);
> +		if (ret)
> +			return ret;
> +		__dpll_pin_change_ntf(pin);
> +	}

only one freq is reported in get, AFAICT, so why send a notification
after each ref is updated?
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
