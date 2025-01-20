Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95980C02181
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jan 2025 16:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FBE76110F;
	Mon, 20 Jan 2025 16:38:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FDvlVZxRzNMT; Mon, 20 Jan 2025 16:38:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B19C06110A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1737391134;
	bh=ruhT4TwrMjlVnM9ny9ee2UTNjaQg5mw6+gLvyj2TWy4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=zBm8pWlJ5F6IvF4W5jCc/+9s+dRz8OyhoDp5wYpP4vbiNlMNCgfpNwuOBPvbMEm48
	 XSXLzVY0iJFrqM6UOrk4FRNimnWSBGEhMLRZcvdVkYHi/OZJyk1ra0O+M1ValbqqPb
	 tTB7mkSooyuSUxOxpyyyYNE3MnWB1KoO4G2f7musiwA2CBzb9j/PWv+86Bbw/2fPZ7
	 HKVf/79GJ1LTuLExAvM/eH5Sp1AkAKRTCHQT7RO3fe0W3thAY4+u9+kwlEt3U8OhHS
	 Ql8b88670lgGyh8xGJ8Js6dasDCrKjywf6SgsQqe/oIXjCJtg7qGwp4hwsN0i/jPvL
	 3kMSHUSput4LQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B19C06110A;
	Mon, 20 Jan 2025 16:38:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 248B6959
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jan 2025 16:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 136458264A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jan 2025 16:38:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xiqnSsj4V1Fa for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jan 2025 16:38:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7012382117
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7012382117
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7012382117
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jan 2025 16:38:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B2E23A4058D;
 Mon, 20 Jan 2025 16:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A9AC4CEDD;
 Mon, 20 Jan 2025 16:38:48 +0000 (UTC)
Date: Mon, 20 Jan 2025 16:38:46 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Message-ID: <20250120163846.GB6206@kernel.org>
References: <20250120155016.556735-1-maciej.fijalkowski@intel.com>
 <20250120155016.556735-2-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120155016.556735-2-maciej.fijalkowski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1737391131;
 bh=c0xlwRDQNm8uVGKxRC9PeZrdMybvdgoujTDDGoxlHM0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PuocawU+BoxAJiHkULhiJo2gO//KfciOKMPcChpM2z6rabZQZkuC4UH5Ey9lqIXu7
 gRCuOpbp2KSCISCl6BNs4Md3xmmnygvy1mlA/5d6ymBJ9spuhIQTzvKvxRc0Mn2fdF
 oqVnQxykyq+jT2v30ps1WxI3r6KCqLRLCtZySz9gmZLLez0A2mO87DZhZFvYPtooBP
 bwg6ul8nNm7JuJrA/eNgIolBmop9BMR68NQzOqCYDzRSF2xRtqosToHP2X8xP2nd51
 6BC2Qyv4vdtv7BevHw9YcR34UTKbuJvdaKEpDG12bXXiW0Z/qW7pRdaDdZFGc+LlOM
 mL7PKSA1ZdJWQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=PuocawU+
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-net 1/3] ice: put Rx buffers
 after being done with current frame
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
Cc: netdev@vger.kernel.org, xudu@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 intel-wired-lan@lists.osuosl.org, jmaxwell@redhat.com,
 magnus.karlsson@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jan 20, 2025 at 04:50:14PM +0100, Maciej Fijalkowski wrote:
> Introduce a new helper ice_put_rx_mbuf() that will go through gathered
> frags from current frame and will call ice_put_rx_buf() on them. Current
> logic that was supposed to simplify and optimize the driver where we go
> through a batch of all buffers processed in current NAPI instance turned
> out to be broken for jumbo frames and very heavy load that was coming
> from both multi-thread iperf and nginx/wrk pair between server and
> client. The delay introduced by approach that we are dropping is simply
> too big and we need to take the decision regarding page
> recycling/releasing as quick as we can.
> 
> While at it, address an error path of ice_add_xdp_frag() - we were
> missing buffer putting from day 1 there.
> 
> As a nice side effect we get rid of annoying and repetetive three-liner:

nit: repetitive

...
