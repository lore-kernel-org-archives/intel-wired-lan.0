Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93520C47258
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Jan 2024 11:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 13F814051B;
	Thu, 25 Jan 2024 11:53:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13F814051B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706183609;
	bh=yZieuJ5Tk20zO1kZN+QaX8JNlnXKZYsB+7yzAz3rpp8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8JVMxCSlMGEZbd+E0HAOfKEunm3wG/Ifafm2Jm0oIEGQzf//sdS0kahae++lKCpRZ
	 BKlBI3DcZKg0B1QJ2Elw+V5shkKFHFFwIxQADq7a2OIyBgZUY+6UZPFlvtFXmYtEC+
	 cZG3hUszO4K3nudUj3w/VfYFZLKP7UHc/8cg9JywlSKxxkHIkw4UF1B6hyxaqkYcUs
	 rI+N6cg+IRm6e7T+mkP/2XjQ1zDheU0KO+lufx7UOxe+KcjL8BHFDjG4C37O9sg20E
	 riOYQlY6k+iGgbRORGpRP4Flh9T+EvzIrcxVVT3mo9YGZ1/ubzSNN5wzoIGVxPpgyv
	 12mymBh9OnL6A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RUwZh6_m0NzS; Thu, 25 Jan 2024 11:53:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id E8ADE405CF;
	Thu, 25 Jan 2024 11:53:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8ADE405CF
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id CD7451BF39A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A51C060AC4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:53:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A51C060AC4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DuZBO5ub1yqH for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Jan 2024 11:53:25 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D187260AC1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:53:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D187260AC1
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8F0E5611C6;
 Thu, 25 Jan 2024 11:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813B1C433F1;
 Thu, 25 Jan 2024 11:53:21 +0000 (UTC)
Date: Thu, 25 Jan 2024 11:53:18 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Message-ID: <20240125115318.GI217708@kernel.org>
References: <20240124082408.49138-1-kurt@linutronix.de>
 <20240124210855.GC217708@kernel.org>
 <87h6j1ev5j.fsf@kurt.kurt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6j1ev5j.fsf@kurt.kurt.home>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706183604;
 bh=h9mu/SRtva+3sHA+94qVBfMLNZBqZZ5vSWU3hU8vWQA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WC1vINH1bPG/0VkODv4Qx6BCl4vyaABchLnpyZoPEfAbbadwzZCeJv0R9wJlzfxrr
 G7AS20fAqh7l2RO6KjehNwNuyRNo4mlxwZcl8/UigMlT9lIG+pxbW3KxUmNJaF2TR6
 p/5l67kTbt/0YzvBNxXTiiY8NODH7R47y5kdjjeI812pOY1+I+GDfOvoufDKslxCsQ
 r9E44R2b++GzsOnL3AONqoO9sufnobiqxbJw+Zu3E8Y/oNMkM3d1uGAKp9elGLRzGB
 Br9UbStPiKPfLKFiX61xPEqqlXdgGC4uC+9HF7f6TjIWaEXiaGDTgP9oSwyetKXKpw
 4IXvXi2N+eIsw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=WC1vINH1
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-next] igc: Add support for LEDs
 on i225/i226
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
Cc: Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <carpenter@linaro.org>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

+ Dan Carpenter <carpenter@linaro.org>

On Thu, Jan 25, 2024 at 08:20:40AM +0100, Kurt Kanzenbach wrote:
> On Wed Jan 24 2024, Simon Horman wrote:
> > On Wed, Jan 24, 2024 at 09:24:08AM +0100, Kurt Kanzenbach wrote:
> >
> > ...
> >
> >> +static int igc_led_hw_control_set(struct led_classdev *led_cdev,
> >> +				  unsigned long flags)
> >> +{
> >> +	struct igc_led_classdev *ldev = lcdev_to_igc_ldev(led_cdev);
> >> +	struct igc_adapter *adapter = netdev_priv(ldev->netdev);
> >> +	bool blink = false;
> >> +	u32 mode;
> >> +
> >> +	if (flags & BIT(TRIGGER_NETDEV_LINK_10))
> >> +		mode = IGC_LEDCTL_MODE_LINK_10;
> >> +	if (flags & BIT(TRIGGER_NETDEV_LINK_100))
> >> +		mode = IGC_LEDCTL_MODE_LINK_100;
> >> +	if (flags & BIT(TRIGGER_NETDEV_LINK_1000))
> >> +		mode = IGC_LEDCTL_MODE_LINK_1000;
> >> +	if (flags & BIT(TRIGGER_NETDEV_LINK_2500))
> >> +		mode = IGC_LEDCTL_MODE_LINK_2500;
> >> +	if ((flags & BIT(TRIGGER_NETDEV_TX)) ||
> >> +	    (flags & BIT(TRIGGER_NETDEV_RX)))
> >> +		mode = IGC_LEDCTL_MODE_ACTIVITY;
> >
> > Hi Kurt,
> >
> > I guess this can't happen in practice,
> > but if none of the conditions above are met,
> > then mode is used uninitialised below.
> 
> Yes, it shouldn't happen, because the supported modes are
> checked. However, mode can be initialized to off to avoid the warning.

Thanks.

> > Flagged by Smatch.
> 
> Out of curiosity how did you get the warning? I usually run `make W=1 C=1
> M=...` before sending patches.

Probably there is a better way, but I run Smatch like this:

 .../smatch/smatch_scripts/kchecker a.c

Smatch can be found here:

  https://github.com/error27/smatch



