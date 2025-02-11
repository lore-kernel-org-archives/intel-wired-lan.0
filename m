Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9FDC02198
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Feb 2025 00:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E77940D5F;
	Tue, 11 Feb 2025 00:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H1V18_vuhRo0; Tue, 11 Feb 2025 00:13:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BDC040DA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1739232801;
	bh=9eLzGS9WkUVVxny9iJ2E6LoVaKTZPcRd8gURudEbrgs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ynIB4f5rDr71DCTsqQLMdwsueE9cbZGk0Zvpzi4YyloLh0SyM74qtSIU+L1aZmqVx
	 0Q6vmuczVCkhpgB3HIkObKBfRwlcQa1qBbNPVdWCfybS2MhN+Bl6MNwjxtYlp5ye8z
	 8QIrAkY4IzMleq5Qx7wYjxqwcVHKHTBLPIU8HDVtESbqdnn/8ObQ6mP25NDp7JZWHB
	 G/HLhux1GwY8sNEnCat+5eP4iNIaQv0b8EObq2NdVaG4ePweVCkAYVDTJ4j/OFtiZR
	 oiATlVf7MDaQomRDGtkyrXl95wIJQKexLq+17pLku9RkL3rHFU6q071Nz5OwSN2RKv
	 ccRu1dDhF3pEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BDC040DA3;
	Tue, 11 Feb 2025 00:13:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D20806C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Feb 2025 00:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B486D40545
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Feb 2025 00:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Frt0I7aT0yTo for <intel-wired-lan@lists.osuosl.org>;
 Tue, 11 Feb 2025 00:13:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C9E8740B0E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9E8740B0E
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C9E8740B0E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Feb 2025 00:13:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B7627A40181;
 Tue, 11 Feb 2025 00:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A937C4CED1;
 Tue, 11 Feb 2025 00:13:16 +0000 (UTC)
Date: Mon, 10 Feb 2025 16:13:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>, <horms@kernel.org>,
 <pabeni@redhat.com>, <davem@davemloft.net>, <michael.chan@broadcom.com>,
 <tariqt@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <jdamato@fastly.com>, <shayd@nvidia.com>,
 <akpm@linux-foundation.org>, <shayagr@amazon.com>,
 <kalesh-anakkur.purayil@broadcom.com>, David Arinzon <darinzon@amazon.com>
Message-ID: <20250210161315.51d9b2a9@kernel.org>
In-Reply-To: <760e3977-9f83-431b-b29b-f8ad1609b462@intel.com>
References: <20250204220622.156061-1-ahmed.zaki@intel.com>
 <20250204220622.156061-2-ahmed.zaki@intel.com>
 <20250206182941.12705a4d@kernel.org>
 <760e3977-9f83-431b-b29b-f8ad1609b462@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1739232797;
 bh=VUO/5kVNTPNLBmnlmfRqFC8g1zAK6+hLkMupNZ7qiuY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=j4Lq91EKd4pYiC64vknEZj/BjtF8VqMW2iJSV3+m3hKLKsPRe+MXNzQ5Ql/7+M/Om
 pxwrzK8V3EL5laIABA1Q6EoaF7UiQee2u+oUJ4AMDln2GTJGYadEAvTscxj24fgs3z
 InOCatdk3APiamkecFvcwxTKp8jlCO1N1ss4fB3g/4gVW06kDHMt8DGBUhkBTXglkh
 Lf0LTuFttmc6sDj7nPmzs625qGOFcSdY6WCbUS8qqqliXMYFM/vtxvcb3ok+YGzTj3
 xoS6oOzvkjXrw4cCm2wMZbG/Sz3uRCIm/J1fp1LaWCSTW4qnAcifD1BMX5YAIOUpiq
 1A29aQCqmMbFg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=j4Lq91EK
Subject: Re: [Intel-wired-lan] [PATCH net-next v7 1/5] net: move ARFS rmap
 management to core
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

On Mon, 10 Feb 2025 08:04:43 -0700 Ahmed Zaki wrote:
> On 2025-02-06 7:29 p.m., Jakub Kicinski wrote:
> 
> > Speaking of which, why do the auto-removal in napi_disable()
> > rather than netif_napi_del() ? We don't reinstall on napi_enable()
> > and doing a disable() + enable() is fairly common during driver
> > reconfig.
> >   
> 
> The patch does not re-install the notifiers in napi_add either, they are 
> installed in set_irq() :
> 
> napi_add_config()  -> napi_set_irq()  -> napi_enable()
> 
> so napi_disable or napi_del seemed both OK to me.
> 
> However, I moved notifier auto-removal to npi_del() and did some testing 
> on ice but it seems the driver does not delete napi on "ip link down" 
> and that generates warnings on free_irq(). It only disables the napis.
> 
> So is this a bug? Do we need to ask drivers to disable __and__ delete 
> napis before freeing the IRQs?
> 
> If not, then we have to keep notifier aut-removal in napi_diasable().

If the driver releases the IRQ but keeps the NAPI instance I would have
expected it to call:

	napi_set_irq(napi, -1);

before freeing the IRQ. Otherwise the NAPI instance will "point" to 
a freed IRQ.
