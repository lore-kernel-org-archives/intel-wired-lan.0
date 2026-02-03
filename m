Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32FAE87846
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Feb 2026 16:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73DF240512;
	Tue,  3 Feb 2026 16:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aoigqc-s1wHS; Tue,  3 Feb 2026 16:11:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB38D40310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770135083;
	bh=AQB8uYt1k0DQ2RqLSdvBp5gJURU1XLNMalqQltuuufQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BlHeb2Oa06Sa0rlFn9wfrHIIPBBUmyar7DOwaThTccuf+8FC1tQ95ctuyfCtAF+yc
	 5TuZ5eYfxgz/45FOvI0Flx0i+x2lp1c0N+8og80SQqB3NbTD6z8K3diCYzXvJKXVKl
	 Xb9SCctezdgWhD3H5wMKAlfpaHhJ2huYweLnUAsqUQJMIUonWtfi/lkHZS02Due/5Q
	 qKPWKvOn0a2Sn19ERRod1YnJUJBASDL0RfwXLg8X6TSfaXm67k1JuJMdFi0ZMrKTJL
	 0gAqjjL1ZWGHV2YkXth8gwAECSJxdPvowphbjhAd8lWjmdG56amMmU8uaK2Bzx71cM
	 45MKU5xIeKv0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB38D40310;
	Tue,  3 Feb 2026 16:11:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C8B3913D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 16:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2B0340310
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 16:11:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xk1Pg4rP1p7R for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Feb 2026 16:11:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D9A33402D9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9A33402D9
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9A33402D9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 16:11:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F37E42DF4;
 Tue,  3 Feb 2026 16:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7489C116D0;
 Tue,  3 Feb 2026 16:11:14 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: ivecera@redhat.com
Date: Tue,  3 Feb 2026 16:11:02 +0000
Message-ID: <20260203161102.1894146-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202171638.17427-8-ivecera@redhat.com>
References: <20260202171638.17427-8-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770135080;
 bh=1tbIX25+8uE6MY6wp88tD9hkDQp221nFtwfC6Jl67ow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jmsb8G4qpkmXi91BggH1JrBWPeFNli0npPW+MBfy9+3crsdSYQ2EtJt5uEvWy+8EF
 p1pfJz0kXtBcroFMeY2v9SjKhWZixreEcjYD8e/PX/AISi6b/VpLq41N4tGWiYk/Yo
 K00vxt3eE1vsNY5n7YlgG1moDVr4rCj2Bko/ksSMwOXwBjMX57ZmBZA0XAmIL6/Q6g
 3wb4g3I2XqnGXLc4mSzDU15k0uqzm6a/nEzS3uGMcfWlXYHBs7oNF0IzX3VCz7M665
 l9zYsUfA2hL7QiBh9l4i6CFPvrI9oEW33iOo8o4FwgUWiP3URE0GjmDEVTEeqh/2Qx
 jwvcaSWrGf/vg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Jmsb8G4q
Subject: Re: [Intel-wired-lan] [net-next, v4,
 7/9] dpll: Add reference count tracking support
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
Cc: edumazet@google.com, anthony.l.nguyen@intel.com, leon@kernel.org,
 andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
 przemyslaw.kitszel@intel.com, arkadiusz.kubalewski@intel.com,
 aleksandr.loktionov@intel.com, intel-wired-lan@lists.osuosl.org,
 kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, richardcochran@gmail.com,
 Prathosh.Satish@microchip.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, mbloch@nvidia.com, linux-kernel@vger.kernel.org,
 tariqt@nvidia.com, aleksander.lobakin@intel.com,
 Simon Horman <horms@kernel.org>, jonathan.lemon@gmail.com, saeedm@nvidia.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
dpll: Add reference count tracking support

This commit adds REF_TRACKER infrastructure support to the DPLL subsystem,
allowing developers to track and debug reference counting leaks for
dpll_device and dpll_pin objects via debugfs.

> diff --git a/include/linux/dpll.h b/include/linux/dpll.h
> --- a/include/linux/dpll.h
> +++ b/include/linux/dpll.h

[ ... ]

> @@ -223,16 +231,17 @@ dpll_netdev_add_pin_handle(struct sk_buff *msg, const struct net_device *dev)
>  }
>
>  static inline struct dpll_pin *
> -fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
> +fwnode_dpll_pin_find(struct fwnode_handle *fwnode, dpll_tracker *tracker);
>  {
>  	return NULL;
>  }

There appears to be a stray semicolon at the end of the function signature
on the line with the tracker parameter. This would cause a compile error
when CONFIG_DPLL is disabled since the function body follows what looks
like a forward declaration.

Should the semicolon be removed so the stub function compiles correctly?
