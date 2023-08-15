Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F62C001B0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Aug 2023 03:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF0E74020B;
	Tue, 15 Aug 2023 03:23:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF0E74020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692069789;
	bh=0gnRJS+OofetIDE8bVH3h5eCusMYiZcuD6FZnu5qSNc=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=TTHCmJOkIgHZ+BO67O/Xe5CFEuLRWj17y/ccQjTfB1ED9tmehz+3sodjUTeO8/JbV
	 CAwOhRL04x96CZ9XcMfWm6mqBdkNXffj8NTELeMlJy+6SUAfqLAwUZ6GxmytnS/U61
	 hcQ5GgnSa2F0kaHV/JCstnvNF2JOr1rG1N5GY2SraFRWNfrSGlbzSgdSVFuZFJPl2m
	 wpqtB/oJ0lOAjgBoWL8AjT6qf5PP3vnZDX5EJ09tVWVqAS8jHopDTqXRAkdVSXubZK
	 2IV9nHB31KCQQAa/ACLhwXSvP0cUb8gf2ihUBEn7FSgOlKxEPDnheNNpS1MA8EuLeH
	 VVs5hhMuayzwg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x2Ao5IGURNkB; Tue, 15 Aug 2023 03:23:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 985CC4091C;
	Tue, 15 Aug 2023 03:23:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 985CC4091C
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 9DF961BF380
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 03:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7534481CA0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 03:23:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7534481CA0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WvX54vNj2RoV for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Aug 2023 03:23:05 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 764DE81B14
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 03:23:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 764DE81B14
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2436C601FE;
 Tue, 15 Aug 2023 03:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18B7C433C8;
 Tue, 15 Aug 2023 03:23:02 +0000 (UTC)
Date: Mon, 14 Aug 2023 20:23:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <20230814202301.13768f0d@kernel.org>
In-Reply-To: <20230811200340.577359-5-vadim.fedorenko@linux.dev>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-5-vadim.fedorenko@linux.dev>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692069783;
 bh=3+FTO5tYbyi0mvftVJwDIuqYnqD2lynJbuJhWEOFv1I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DDjT8cCx82/67tu2egRePi9MaFGJvhbGmQdECqvo3CMYdryzy5u1IkjR1YOVlL9c3
 YyBOTPAFUmedSEl0lngnxJeQjXUg0N3pu9DdN/2PL1jRsrY4X7rmiLOAKJ6SEWhovx
 wh5zpVLlWqMTw7ydONqAUZVo/Rt24gXumrstNuqDv/w6mycYXkjKSDgTrN70shfk8L
 G4wqRmevtZvHMTdTSXhKPmpvGYlR6kAsG7GXGEczOIT/Rlzfk5L/kFVzOj9Rev7iCm
 o5N5AfLFEYsmCJm9KK/OywOrhC+6eiL08ImPk0dTLXJ38Haicc4dMoCf93o0lRx5Hs
 MRRNk9E5qw7Eg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=DDjT8cCx
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
> +static int
> +dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
> +		  struct netlink_ext_ack *extack)
> +{
> +	u64 freq = nla_get_u64(a);
> +	struct dpll_pin_ref *ref;
> +	unsigned long i;
> +	int ret;
> +
> +	if (!dpll_pin_is_freq_supported(pin, freq)) {
> +		NL_SET_ERR_MSG_FMT(extack, "not supported freq:%llu", freq);
> +		return -EINVAL;
> +	}

NL_SET_ERR_MSG_ATTR(extack, a, "frequency not supported by the device")
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
