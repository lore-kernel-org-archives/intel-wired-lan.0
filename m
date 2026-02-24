Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DEFE9B243
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Feb 2026 09:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 263AF819BC;
	Tue, 24 Feb 2026 09:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L7yvjK_UJ2EF; Tue, 24 Feb 2026 09:40:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96280819D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771926014;
	bh=Naygvq3JDcsoh9FJZcKiSGe7AYZ8AZKBcLvgdvR6bG4=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6YBw5l0lSijK8ZGN0zZpChsBZGXTYuuUwLh6L+eQgYpKD9bsmap2t/fws+7MHQjX0
	 L05K+9Q0ghGqCV4us0/4qcDwzsQZp2JWUUJkcPBXFsZOKgSnXdMjcWONGvlXjNMccr
	 UfvHf4qyAQZqM6aX78+Q4nAhrx6gXcO0f9C05eKEMwhSaq9pfcfPBM06FDRfPIfvze
	 Um/TM61a4ZDk+oZdnHcvmkj6lZekYMPFx6yJmrSGAafvV9l9t36nIGtCzcdGVxdR6T
	 U8USXlXgID+pt1kV1jH+EK+WwSlQpcnOSlqYoh66tJFilfdNsGFOafK6XICTxAruuX
	 G2gHgMPFgGEHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96280819D1;
	Tue, 24 Feb 2026 09:40:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 017CE1B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 09:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F344040656
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 09:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IaKFkj5kCfUW for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Feb 2026 09:40:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4D1FF40654
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D1FF40654
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D1FF40654
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 09:40:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 605C36057A;
 Tue, 24 Feb 2026 09:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E778C116D0;
 Tue, 24 Feb 2026 09:40:08 +0000 (UTC)
Date: Tue, 24 Feb 2026 09:40:07 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <aZ1x9zwU77RJlKti@horms.kernel.org>
References: <20260223125157.819135-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223125157.819135-1-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771926010;
 bh=N+5C2uHwaPX2zVBtOgRhnM8WpLXGYOlGRM6SIgx9wSo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sBIdAcUOm+bfeBzKoSv7NA/F/la9TlpbClXLBOW/ATSmAvlto5kt4A9aoEXACaWXY
 i5nreYarSPqMwpKtIwAe94at5ItkbJxmXTbowPGnyK3D03b/y8pf1b0NbDPbkU9O3w
 Q0fvNr68kLjVaHLVA3gRqgUpcIH+N7Hu0++ISO3dfO0ih2PsUtbDebe4154ZtWdH2U
 UAKaqAff4/yM1QBvMUyXDbDon3ypUp4qlislzDBpFvsmU/bMr/tE3uUf2ejN/RzFXL
 +pQ9WxunOShKf0vj05ArkNQgyGC+OavjriP+snTS3NyovHyCyUaw7yYomqM43fEWnq
 /ez5ayFDJGZow==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=sBIdAcUO
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: set max queues in
 alloc_etherdev_mqs()
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

On Mon, Feb 23, 2026 at 01:51:57PM +0100, Michal Swiatkowski wrote:
> When allocating netdevice using alloc_etherdev_mqs() the maximum
> supported queues number should be passed. The vsi->alloc_txq/rxq is
> storing current number of queues, not the maximum ones.
> 
> Use the same function for getting max Tx and Rx queues which is used
> during ethtool -l call to set maximum number of queues during netdev
> allocation.
> 
> Reproduction steps:
> $ethtool -l $pf # says current 16, max 64
> $ethtool -S $pf # fine
> $ethtool -L $pf combined 40 # crash
> 
> [491187.472594] Call Trace:
> [491187.472829]  <TASK>
> [491187.473067]  netif_set_xps_queue+0x26/0x40
> [491187.473305]  ice_vsi_cfg_txq+0x265/0x3d0 [ice]
> [491187.473619]  ice_vsi_cfg_lan_txqs+0x68/0xa0 [ice]
> [491187.473918]  ice_vsi_cfg_lan+0x2b/0xa0 [ice]
> [491187.474202]  ice_vsi_open+0x71/0x170 [ice]
> [491187.474484]  ice_vsi_recfg_qs+0x17f/0x230 [ice]
> [491187.474759]  ? dev_get_min_mp_channel_count+0xab/0xd0
> [491187.474987]  ice_set_channels+0x185/0x3d0 [ice]
> [491187.475278]  ethnl_set_channels+0x26f/0x340
> 
> Fixes: ee13aa1a2c5a ("ice: use netif_get_num_default_rss_queues()")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

