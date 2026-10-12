Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548B1CA9EDE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 08:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 056B960618;
	Mon, 12 Oct 2026 08:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RH7XUvJfe2Vj; Mon, 12 Oct 2026 08:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5CB4360619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791794189;
	b=ir0pD7Llxxb5Xt6tuLABolY9efNuzyFyanY55r5miMzc7TrYLlwzHP5s23+t/khd2meh
	 5dNOglWpYhiavgsAk2ZNxuE8P5hZ/1Z0vytl1bdt/NL3q5/BHCWLs8cdXsyIHVpx7GLJz
	 VSr90ThQXrqJQlFBpwHC34RdIS4MukIW2WOBrT6fgI9AgOo4+ttqlkDTstfjY3GUCORtl
	 1uPeO5Ly9oswPqEF1T+Pvqz/HDG9hJFBNeayNVKMpxID4i6TtnrmEpJXwPeh06/6MEROs
	 kO76DieM0pE+X1tzMSIx4pMdx4IPl3oFLgi1xEAGcUi8iN8rHaYC0ieUfhKrQR7Hbxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791794189;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DTiVtIUtGBfVxQ7yYFuD3meimlqQg85rziaxJktMdLg=;
	b=nKfdthdmpjlxqz8X32q5Yu2hJnQlGdDgIhFo7/4Kl1BMjSwaHB+L6wo4m2SOC7uWbgby
	 cJoj2eMKIRHtJ0Gvl699WXJqFMefJqgUJgOzFET5nLjOvPstvPxPE6FRUSAGmfM7Ywypp
	 fK5BYLfSz0h9SN3eNmK85E3xeCiQ5Qn4032aK0zVzkouRI+t55lK1Av+V2DAcVCdMA7Ny
	 g65dbu1Sv+si082e1/fb+y5r8aUJhbSNP43qvUGtSKVV8mdbv54kKZZyScZGFAEx031rZ
	 TmTi5KKMe4Tcapixq5VzeWjpJXTP4ptoceE6vmb6kWABxD51hMF4FbUKVlEKhWlkGPg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791794189;
	bh=DTiVtIUtGBfVxQ7yYFuD3meimlqQg85rziaxJktMdLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sgz1E8aCI7JWRnUKMdnB+sFUI0mmft1wI97KzvnbvnLpEXpO7SviqEyNwsck1j4hH
	 dptGoRI8SB/2vBSzLx+BoVcp0WBOBDbpon2WlUKh8mXVsMaclHGaivljhbnQjvqKOZ
	 5lsVEEPVy0tiqVynlbcODWEykBXCUdjgB91zfmWp0dwtMHxs2SqXSWRg1feo1yw2UW
	 laI1Fh2n9ws9t0THPYGDk00K5ELKY2FnUCIvtD0s6xMFrfh8lKY8y0A5qYOl9wtRzA
	 3anMqiM51EMYGHlp0xVF1CKUEEZZU/M8z0kJ5bMLeqIPAURweFUSi5yWgRdD4QH4KS
	 2vjp3VbJEp1wA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CB4360619;
	Mon, 12 Oct 2026 08:36:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B16871DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 970AA40589
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:36:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N4VcQap_zG4a for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 08:36:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E0DA540583
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=220.197.31.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791794185;
 b=SKUpwsgORG+YY+MSlPEAOTjogVt3gfD0ZfwZN881h+ggykn9HTz3whsTOnuMYwH7Gi3J
 Ihh0556e2c0JDMMBttWYaIgEhZe/yk/M4D0NhZGzbWJH/I+a4SOxzfUf6+F7gNPAoauuM
 r327v3n7M2zf0bygFfFbERQ+tW0Qm/oM9N+6PmUcsPg+S1JyjCceEnDsW55OBAz/ZEeub
 8NwS/ohXN2LR4YW/UshmktmqwW+U8qoHGtkFoChHKJ/JpNkc+ks71k9Pcv1GWRriDX9B2
 QAgt4RgY1ezpse8NGn9AVEx/kkezPDHabx/oIeDL4NFX59ERlwXkbd99JqtgV9qxP5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791794185;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=DTiVtIUtGBfVxQ7yYFuD3meimlqQg85rziaxJktMdLg=;
 b=AOlulQeoeyps12z4bZoQrKl9kYGrwrKaz6wVm8a3B+m8wSGsGrtXbo6hke42uB5OFyir
 Bg2KrYz3GdMu7iqDQcTRaUMnNui+EJXL6bzsLzPAZGaoMNiXLWVwTvKZi+s4D7LH0hLWh
 AozS0uQSZEeA2nwDSb7xc2whzJ6umSfo+WxwE+JmwfEPA9cbYKjiddFFLLLuCYu7B+9W7
 QlnC/HPAEmb3bKeUy9GRDiZ+XVyXPg21WUxfKsqrpZf9TxXJ6ivOm3lO1IrORrKRvdt60
 DyufGDbnPjPg5ANH9oFMYpDluJZrB1rDdhJ4pTxyH83t/2x4oUWcIgTAu0pUx+CdNrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=ox4BZMjX; 
 arc=none smtp.remote-ip=220.197.31.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.8;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=ox4BZMjX
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0DA540583
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=DTiVtIUtGBfVxQ7yYFuD3meimlqQg85rziaxJktMdLg=;
 b=ox4BZMjXQtHLUPDLkHI9PDvHUgU6oFifuDhySazVrBf4tOXsuPoVyCwSyx3cyR
 +liUJliBZfuK2Yz4ndZ4EhQC/ana+v4ri7GeXkLMHDtDwR7z5nyWEV7/zYyX4ta7
 /MBQiBfgejVrieKA5E00Pa/9oZU4DoDCTHzSK3g/hpbCY=
Message-ID: <f605d9f6-3ff5-463e-8eea-10be6d4b25f4@126.com>
Date: Mon, 12 Oct 2026 16:35:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: wait for in-flight Rx polls before freeing a
 representor
To: netdev-bot+sinfo@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20261012072959.254206-1-xiaolinkui@126.com>
 <179179045626.2527009.2374745016618209052@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179179045626.2527009.2374745016618209052@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wD3Pxzem8xqpaKIBA--.62278S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XrWrZrWDJF43Cr13tr1rXrb_yoW8Jr1rpF
 W5Ars3t3Z8JryIkry8tw42va4Fvan3KF1DWr15Kr1Yvw15GF1YqrW3Kr15CFyDGr97Z34F
 v3yqq3y8AryqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZXocUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqB-rwmrMm99t1AAA3F
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


On 2026/10/12 15:34, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi,

Thanks for the reminder. This change was not tested on real hardware. It was
found by code inspection of the representor teardown path; I did not 
reproduce
the UAF at runtime and no stack trace was observed. The fix is based on the
RCU/NAPI lifetime analysis described in the commit message.

If a future revision is needed for other reasons, I will make sure to 
include
this information in the commit message.

Thanks,
Linkui

