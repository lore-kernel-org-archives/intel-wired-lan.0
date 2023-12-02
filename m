Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1611C4167B
	for <intel-wired-lan@archiver.kernel.org>; Sat,  2 Dec 2023 02:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35A9D42425;
	Sat,  2 Dec 2023 02:37:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35A9D42425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701484634;
	bh=n40Gk6FqRCZuvWZjkqlzqVe0KsgsUW2HU9XiPA2XN3o=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=pfe8EvGdq35KlRObG+hNxSoP7TJP5rHOmji8rPBKvF4QucuaUPTUTdwDNJwzGTfhF
	 7k3c/TrmgXRR8/Qx6irQ/ta6AFny+oGJvTcsiE4C7MdpaxOOC940odlpqk6cR01TI2
	 2RB9s2IiWlu9jiffXC9NC68sUVxygsB8xlAl8lKXH4ed+wnZhsn4PnkpWn6iMtiQTJ
	 GRIwheIcimJRkfZpEX5ZbZLWXVS+dXR4KoZ3xb17TS7wADtsJnBYkINiaefVk7kjDG
	 P+/vgdA3+sCPUhjDVzYGwDn4Dzl8k0djxMXZ7PLei5Lafrwvo8biX+d6ofn9qBTxnb
	 CfVky8fukCPMg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4E68BEgoAzEt; Sat,  2 Dec 2023 02:37:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 272A042440;
	Sat,  2 Dec 2023 02:37:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 272A042440
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 2840A1BF2CD
 for <intel-wired-lan@osuosl.org>; Sat,  2 Dec 2023 02:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBE4A848F7
 for <intel-wired-lan@osuosl.org>; Sat,  2 Dec 2023 02:37:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBE4A848F7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lTI5p5dEP8fu for <intel-wired-lan@osuosl.org>;
 Sat,  2 Dec 2023 02:37:11 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 149D3848B5
 for <intel-wired-lan@osuosl.org>; Sat,  2 Dec 2023 02:37:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 149D3848B5
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 45B2ECE259D;
 Sat,  2 Dec 2023 02:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5262DC433C7;
 Sat,  2 Dec 2023 02:37:05 +0000 (UTC)
Date: Fri, 1 Dec 2023 18:37:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pawel Kaminski <pawel.kaminski@intel.com>
Message-ID: <20231201183704.382f5964@kernel.org>
In-Reply-To: <20231201235949.62728-1-pawel.kaminski@intel.com>
References: <20231201235949.62728-1-pawel.kaminski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1701484625;
 bh=7TxLpYvEmtlsow83j0jT5kvwsPw4rjLxRzvb9Zl7cMs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=thKnZh+XhU645J7FTtcZmdC443aYOo2RGAG6K1/bOr0BKyEsUmxTh5rh7CCcBIsCz
 R8gebA+nTEq4l81+42rWf0X7cWxS7AwryjdVSwylUVcRKdBoac9swHmVdTIK1J1tMi
 8WH7/N/TMoyu4Ul13X7V+VB6MTNFpI9jJ8rHZTPE4TSYgw1Vb1xKgCv3IKJS2h5Tib
 Mq27Eh+tsaS+HyR+pguHBSkwfQ+Hr1XRvIDI813QV7EFQnC8/TtLQGHwaHzkWNx/jr
 PwF36e3WMG0ifmEzJSeFYmiSgjBg+0/fiHG7XPQfE0fKqoKojCr7oq0+ypUs2Rqh+0
 2WSEW54eNG4Lw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=thKnZh+X
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: Add support for
 devlink loopback param.
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, intel-wired-lan@osuosl.org,
 Michal Wilczynski <michal.wilczynski@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri,  1 Dec 2023 15:59:49 -0800 Pawel Kaminski wrote:
> Add support for devlink loopback param. Supported values are "enabled",
> "disabled" and "prioritized". Default configuration is set to "enabled.
> 
> By default loopback traffic BW is locked to PF configured BW.

First off - hairpin-bandwidth or some such would be a much better name.
Second - you must explain every devlink param in Documentation/

Also admission ctrl vs prioritizing sounds like different knobs.

> HW is
> capable of higher speeds on loopback traffic. Loopback param set to
> "prioritized" enables HW BW prioritization for VF to VF traffic,
> effectively increasing BW between VFs. Applicable to 8x10G and 4x25G
> cards.

Not very clear what this means...
So the VFs are Tx bandwidth limited to link speed.
How does the device know it can admit extra traffic?
Presumably this doesn't affect rates set by devlink rate?

> To achieve max loopback BW one could:
>  - Make, as much as possible, fair distribution of loopback usages
>    between groups to gain maximal loopback BW.

Can't parse what this means.

>  - Try to dedicate ports for loopback only traffic, with minimal network
>    traffic.

Or this.

> Changing loopback configuration will trigger CORER reset in order to take
> effect.

Changing config of a permanent param shouldn't trigger anything.
Please see the documentation for expected behavior..
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
