Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D8DC001B0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Aug 2023 16:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38C0B60C16;
	Tue, 15 Aug 2023 16:55:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38C0B60C16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692118525;
	bh=WN9S8Njc2tiAyYvTsvRD2mLgDtiW0AVJLknxGc99Mek=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Ns0fFYWknzOjK498HjpiEMhNAM/pIBp82roQeuxPygALW1gDD3MNLwroHhtJOvMlN
	 gzylkW5FvOsiqMzHpiEEOj9E93NbkD981lcO+yWUIeO1Eg85dZeN5KASPMHB78UBjw
	 LdcBNVvL9BdeOPoKiYSwLfwtUO4wWgMvHQbPHKwJUNMaVDAaWROVT1TWgzf+QhIeOY
	 uFAUxqH/+UJm9syL59Xe1VYPGiJ9UQPdP87Io1tdc/i8te9fH9ahvwy91hotObmP/j
	 69mpncCKnmf2tIAUSYU7Ey3UZlXSOuKmpoxAA26lS8auCShNPZK06NgLjzfNjrbozn
	 TvoFwAkyER3gQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VtRPuMnszD6X; Tue, 15 Aug 2023 16:55:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 499D260C2B;
	Tue, 15 Aug 2023 16:55:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 499D260C2B
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 635AE1BF379
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 16:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BA0E60C2B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 16:55:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BA0E60C2B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPlDLK5QD5KU for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Aug 2023 16:55:22 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8759C60C16
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 16:55:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8759C60C16
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AD5E261ADA;
 Tue, 15 Aug 2023 16:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51967C433CD;
 Tue, 15 Aug 2023 16:55:20 +0000 (UTC)
Date: Tue, 15 Aug 2023 09:55:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <20230815095519.76d06274@kernel.org>
In-Reply-To: <d5c30de7-df89-18dd-3ad8-a5d99c1e7108@linux.dev>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-5-vadim.fedorenko@linux.dev>
 <20230814202441.349586b4@kernel.org>
 <d5c30de7-df89-18dd-3ad8-a5d99c1e7108@linux.dev>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692118520;
 bh=0NoRpcHZaUX5im0cn9/N12oK9jNQtW6pqx60BrLK0cs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=h/qtXebOTThtIYgLdqHqoNRqfFRfa9y/NntkWbmyTvfgyh9BOctmFKj8k3XAsH1JF
 aoJAGqTrHqidY5JCD+vm0ExK6+BLcxDLSq3p717eHvClBAxkaQSQRbfU1psUYJ74Bd
 kRbPS0rjZmAdOGYHTHVXNwPnKjpnhSFi0B1wAuRKNJLkChNkLAJtDl052iMqhiYfZN
 gLXuKq0MKFOl6PONyTJmxtK4SAvnRX8Q7p9ID1pGkSED5bp6y1rmkY83gbeufmn7as
 b20tSiNqCkYQIn2ljZnydCYVtFoTrK3QNRMZqB4owFbaLyN+qC3eEAVhaUSNzJt1Kk
 YrHv4JWLD1v1g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=h/qtXebO
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

On Tue, 15 Aug 2023 16:18:16 +0100 Vadim Fedorenko wrote:
> On 15/08/2023 04:24, Jakub Kicinski wrote:
> > On Fri, 11 Aug 2023 21:03:35 +0100 Vadim Fedorenko wrote:  
> >> +	xa_for_each(&pin->dpll_refs, i, ref) {
> >> +		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
> >> +		struct dpll_device *dpll = ref->dpll;
> >> +
> >> +		if (!ops->frequency_set)
> >> +			return -EOPNOTSUPP;
> >> +		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
> >> +					 dpll, dpll_priv(dpll), freq, extack);
> >> +		if (ret)
> >> +			return ret;
> >> +		__dpll_pin_change_ntf(pin);
> >> +	}  
> > 
> > only one freq is reported in get, AFAICT, so why send a notification
> > after each ref is updated?  
> 
> The pin can be technically connected to several DPLLs and app may watch
> for the specific DPLL messages only. We would like to inform all users 
> on any DPLL which has this pin connected to.

How does this end up looking in the notifications?
__dpll_pin_change_ntf() only takes the pin object, from a quick read 
it seems like it will generate the same notification multiple times.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
