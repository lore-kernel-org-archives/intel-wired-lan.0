Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C95CCD4F54
	for <intel-wired-lan@archiver.kernel.org>; Thu, 28 May 2026 17:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B7CA61BBE;
	Thu, 28 May 2026 17:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r332CDnDdhKw; Thu, 28 May 2026 17:14:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B3AE61BBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779988449;
	bh=x3XecCey7V1jOhn3zE1GAiTBEWrdYTpPoYi4jvRTnPE=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KWxQa6fsf5GsQfxqlLKt8fFTnpy0al1QFQPOP6hN6bZOvTcBdV0oWEzvfCQvWvQU8
	 FVsFazjXaupWr9tDCl6PcWsM/QvnWP1RqoVejgLL3QjY0P17zS4WBwAYddoI7gcVsQ
	 D42czenNjK81dnIIq4VOKZjsKO+f/Y/6f7NrYIh0FW4JwspXzifErDqL99rBmuWeuE
	 uU7PVBwRPFyHYdKWyS3CsULsywsBZ5Bh1s3SNFtNE3ZrU1kqzgxHanRdlSI77EZJRn
	 aM5Q6x8tMFL5uBX9wkq1wPPc/8NryJdFwsyMYIqDQ1IUyjGuKIZPhjlrs6oBPs/Vq/
	 WJBxKDGqwykkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B3AE61BBA;
	Thu, 28 May 2026 17:14:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 153312E9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 May 2026 17:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF3CD61BBA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 May 2026 17:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mjEHpk4RXiRy for <intel-wired-lan@lists.osuosl.org>;
 Thu, 28 May 2026 17:14:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 292B961BB9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 292B961BB9
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 292B961BB9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 May 2026 17:14:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51644419C1;
 Thu, 28 May 2026 17:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE5B1F000E9;
 Thu, 28 May 2026 17:14:03 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: zhaojinming@uniontech.com
Cc: 'Simon Horman' <horms@kernel.org>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 28 May 2026 18:12:04 +0100
Message-ID: <20260528171202.2659491-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526021154.2774526-1-zhaojinming@uniontech.com>
References: <20260526021154.2774526-1-zhaojinming@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1779988446;
 bh=x3XecCey7V1jOhn3zE1GAiTBEWrdYTpPoYi4jvRTnPE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cdooFQ0tmujdG4wbgACHhQWY7nU+DQjiOofHK77kakdcPnTvUlOrkTzlgFBK56u8m
 T1mN2I/7L9oV1WmUv/090/d7j0P44pp/Np4HIDfb4xI/UmyGablZQV9/SjbePDwN8r
 C3OQtuUCRDhNirwPdOnV2ODN4m2zgYtw+ZuVCG9opek5uyeuHfCa75gG6Uwu3pFF+s
 i8vde1HivO3Y1DIKfy1BzUQN2B/ibVpjrE5XjMlIAcgyM7ErDHL/unEDDxP9OtlZ9T
 /eo7ebv/frvML8UJQsy/517fldAj8GBsAFIIbQgG8uWVyKBpDnQ5hgtyDgKoINXTa4
 Rb/FebhNCedyw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cdooFQ0t
Subject: Re: [Intel-wired-lan] [PATCH net] ice: dpll: fix memory leak in
 ice_dpll_init_info error paths
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

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: dpll: fix memory leak in ice_dpll_init_info error paths

This commit fixes memory leaks in several error return paths of
ice_dpll_init_info() by routing them to the deinit_info label. This
ensures previously allocated resources are correctly freed.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
[ ... ]
> @@ -4341,12 +4341,16 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
>  
>  	alloc_size = sizeof(*de->input_prio) * d->num_inputs;
>  	de->input_prio = kzalloc(alloc_size, GFP_KERNEL);
> -	if (!de->input_prio)
> -		return -ENOMEM;
> +	if (!de->input_prio) {
> +		ret = -ENOMEM;
> +		goto deinit_info;
> +	}

Simon says: Although this is a pre-existing issue I believe it needs
            to be assessed in the context of this patch.

	    If it is valid then I would suggest a separate patch,
	    preceding this one in a patch-set, to address it.

[Severity: Critical]
This is a pre-existing issue, but does jumping to deinit_info here expose a
double-free risk during driver resets?

When a driver reset occurs, ice_dpll_deinit_info() frees the pointers in
pf->dplls (like d->inputs, d->outputs, de->input_prio, and dp->input_prio)
but does not set them to NULL.

During the subsequent reset recovery, ice_dpll_init_info() is called. If
allocation fails here at de->input_prio, the code jumps to deinit_info
and calls ice_dpll_deinit_info() again.

Because d->outputs and dp->input_prio have not yet been overwritten with
new allocations during this init sequence, they still hold the old dangling
pointers from before the reset. Will calling ice_dpll_deinit_info() again
attempt to kfree() these old pointers, resulting in a double-free?

[ ... ]
