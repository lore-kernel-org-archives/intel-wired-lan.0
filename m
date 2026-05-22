Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EE3CD5BB3
	for <intel-wired-lan@archiver.kernel.org>; Fri, 22 May 2026 15:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB70461CF0;
	Fri, 22 May 2026 15:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2pM3njuaSoL6; Fri, 22 May 2026 15:55:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 337FD6EA49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779465327;
	bh=vBx+xEmgiWqiT4uPnzeTJ1AxTohv1dp7pULOGoYMnlI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c/FQvhkqeBsBvAF0Quw6x3oZjs9ITs0hV2rhTd1Nv6lsEM4B413bJp2CSh6FQi/7B
	 e7Vpk9BeaqCfEzzbXH7/5JJzyUnmBI6XY7Db9Rvnrmo4QIaMBL4z8JjzR/wpe5eBoU
	 bSyRxMpO/dU6bfaeOA+7lertbWFEWaNBGrBtsQ3ceU2Un8yo6TdXZdB9qUh8RNryTz
	 1kwWEawB/HrSIoYj0LB0HmxQS49Q86v4M7GmRcXfyootFE4T/dYzC0YmZyDrk24PkN
	 Vmuz3wPONW5lyeguM0EV33XifUnX2ekiRV3iJe3jE1f/kJx6J6RGRvQf9gyHfkGP3N
	 Q9xMnTMBR7wVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 337FD6EA49;
	Fri, 22 May 2026 15:55:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4789A282
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 May 2026 15:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D9C561CF0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 May 2026 15:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WXHoUXb3eWZS for <intel-wired-lan@lists.osuosl.org>;
 Fri, 22 May 2026 15:55:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5E4FF61CD5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E4FF61CD5
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E4FF61CD5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 May 2026 15:55:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 857CA43CF5;
 Fri, 22 May 2026 15:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EB61F000E9;
 Fri, 22 May 2026 15:55:24 +0000 (UTC)
Date: Fri, 22 May 2026 08:55:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Cc: "anthonylnguyen" <anthony.l.nguyen@intel.com>,
 "anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>, "andrewnetdev"
 <andrew+netdev@lunn.ch>, "davem" <davem@davemloft.net>, "edumazet"
 <edumazet@google.com>, "pabeni" <pabeni@redhat.com>, "intel-wired-lan"
 <intel-wired-lan@lists.osuosl.org>, "netdev" <netdev@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <20260522085523.0432a2d5@kernel.org>
In-Reply-To: <19e4e74ff40.601fab765713.9212104302286035517@zohomail.in>
References: <19e4e74ff40.601fab765713.9212104302286035517@zohomail.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1779465324;
 bh=vBx+xEmgiWqiT4uPnzeTJ1AxTohv1dp7pULOGoYMnlI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QnB6gVsjkVmFDeXnIkJg2AoGPGEvdLko479fzlLgSkENzK/cO1lIg8kip6JWm28bN
 7JJIlsYkefYbqwPmlyKZMVfyXPxdmwSyhxgipsbUhjOlU3efIcOB2bEFHpHyDav7mZ
 1QGOhgUD5It+R5xqlPe1j5zesmfqKh/irR178zTqlTneeAovfTXjtXpVtGqiAFDgmq
 fgrYYr7a7rSjr+szbPKFg6unWwYWB+ILWOxn0663jQAcIyUbpk1XSHYcQHp5ifI1Pe
 Q3Y1G5o8eLXDTWhozb0ndNK7Y3xqeA+A9ferSi+Mgbv3jJzNMtK72ILYM537C2kcpU
 2e0d8fb794D9w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QnB6gVsj
Subject: Re: [Intel-wired-lan] [PATCH net-next] net: e100: remove redundant
 static variable initializations
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

On Fri, 22 May 2026 12:22:30 +0530 Ashwin Gundarapu wrote:
> Remove '= 0' from static variables eeprom_bad_csum_allow and use_io.
> Static variables are zero-initialized by default.
> 
> Found by checkpatch.pl

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
