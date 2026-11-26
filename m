Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B98606A329
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Pt9CWrUk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJOsD03i
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA9036066C;
	Thu, 26 Nov 2026 14:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rRfbdwxS0cpH; Thu, 26 Nov 2026 14:09:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6389F608E6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795702140;
	b=MgxHzglXH8MliXlZKm1/XeihXwtXntko9pc4h6zQ7/dx42qJNYoJPqHVAErS7Oo6ZVTs
	 mlwbwprhRlseVASwYo2uFCPVrW/pV2YBdoGKUIKhcDQMzyiJL/2A5mqbZtQzQ4UtJE9Pb
	 eBrUbdT4XwcdV2+DmVgvMqGifqXd0gnFBDmQp8IA/dDU1CD/dj2vakPBSgqlOwi8YAl8V
	 G4WbiVg9MhyA3kVUy2dhPUbUDRuaNIoEwd8txaWFFhcsnyhqLVYUClcS0j2jpg17jHGOb
	 zrQgG5DGIKZvWzLIUwyOwjZQE8eEku0Yr5dxz1IvpK/wOVOfBYr7vb9k9rhyNvTzDfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795702140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ycz4zN8OJGHkVYq0dR22YPKKxsW4H2gix6T/uO2MvZc=;
	b=gtmOjSBVDzaeo2c5ryp7BUvnToXC/tqE8D/PdT/UsU+TmQXINQGrREO+TL6n+nZCB+V6
	 USKPBQShdfT8tDc0pXU/iymdpSldA1XwzFnyte9lLew84NXjTefsj3TP3kvZS1RaKZId9
	 RksgsohSwn2gKlqjikSxAy8aFfq24LYMAFLNJdAlHz6OpfVl6MDAfbSsyiWBWWHmycT3r
	 jndqLQoXvmblcvj5MGrzW/b+Rqk3kAf4tAJhmaOOsvRFb4OgynekASuBHg64hNJ5aTwv0
	 Uqw2tpzYqfcEDhcwOFWdEB4I5LGWC7oqQ7r1RrBf5E9ZcAXMJBMoxeRW0+Orv8/lpHA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795702140;
	bh=ycz4zN8OJGHkVYq0dR22YPKKxsW4H2gix6T/uO2MvZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pt9CWrUkReXkAkyxr5Jwvese+GNX+r5iopNiLd1RNdCZCOEc7WUOT5/mfUkat0mNt
	 cLc72szBCFw73AzMe81eZPSLrlA+NRKGSq4F39DkXVJRcsY6YSMrFuHrIR7l59FyLp
	 Lu/FLdhDL5d2CJlEzzYWwALUDk/mFS0xAQRi8ohykSlBBAj9d+4rdQc7ygzovdkyHP
	 CAM4W5p3guQxRlEnK2XrciUaNQC+EnE5Pvn1MbHSUbFE3lbR6N1Ykrd8Zf4URXGqOv
	 S7Jk3D9Gre5LE9iuuiweklEKcP3QheKEc7WIVx+pcWXHKR0mr7HkEBAxVM7zW+JWlV
	 vH96y1fQFrofg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6389F608E6;
	Thu, 26 Nov 2026 14:09:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EFF1311
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 14:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60F25404A4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 14:08:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TvAw0zUvzeHi for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 14:08:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C860840111
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=SJOsD03i
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C860840111
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 14:08:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA57246429;
 Thu, 26 Nov 2026 14:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352F91F000C0;
 Thu, 26 Nov 2026 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795702137;
 bh=ycz4zN8OJGHkVYq0dR22YPKKxsW4H2gix6T/uO2MvZc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SJOsD03iiSTrVhmnyD961u/NuqqW5Devu9pnbYz5JxC7dUJP1I0Bqcipy6wgRXLLu
 EvESMbVecbwkkgAmq2uFk5XFlkofzP/HkwUNRrxxED4BhoiOyemaaaiaum5WfIGB7L
 CHBkT5dv+GKkLRgKBkO95lxLVXkKN7c+RJqrVQ0uRl+QDeMbpEdgr7mYVNSG9s63x3
 t96VMLSPOLUtkLhho7Su00TPCx/1yWJKxS0hlyFN5gysJLkJxJOKazDUuQI6iICGtb
 jwo970nEJ+jERI24GXm49GO3GCozCvRh6PDX2PRcavUdp2HbuJPdqPzpvoqyMGYqzw
 9cio0Kn4Ff3oQ==
Date: Thu, 26 Nov 2026 14:08:52 +0000
From: Simon Horman <horms@kernel.org>
To: Yuqiang Sun <izaiahsun@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 m.wilczynski@samsung.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: Do not free a preallocated node in
 ice_sched_add_node()
Message-ID: <20261126140852.GA31322@horms.kernel.org>
References: <20261119055731.55798-1-izaiahsun@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119055731.55798-1-izaiahsun@gmail.com>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 01:57:31PM +0800, Yuqiang Sun wrote:
> ice_devlink_rate_node_new() allocates a scheduler node and stores it in
> the devlink rate as priv. When the parent is set, ice_devlink_set_parent()
> passes it to ice_sched_add_node() as prealloc_node. If allocating
> node->children fails, ice_sched_add_node() frees the node with
> devm_kfree(), but priv still points to it, and later rate operations
> (setting tx_max or tx_share, or setting the parent again) use the freed
> node.
> 
> Only free the node when ice_sched_add_node() allocated it.
> 
> Fixes: bdf96d965a20 ("ice: Add an option to pre-allocate memory for ice_sched_node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
> ---
> 
> Notes:
>     Bug was found by kbound, an internal static analysis prototype.
>     The fix was written with the help of Claude Opus 5.5.
>     
>     Compile-tested only (x86_64 and arm64 allmodconfig, W=1, sparse): I do
>     not have E800 hardware.

Reviewed-by: Simon Horman <horms@kernel.org>

