Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5E0CD4F5E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 May 2026 11:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C0A26159F;
	Thu, 21 May 2026 11:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eC7CttkmQlLF; Thu, 21 May 2026 11:43:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A652A61599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779363821;
	bh=gNwhZlZNvRf30NjRud00r64+zMtRvb84BXByEUe94wE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c+qUXy+z88kADCW4/96nr/USfBHBz/zlI/ZiPwqwafFWwBUwnzztH1pzvv748POXT
	 67Icdo3FLX0OQng6Krg7JSEcMYWKgsBsZTtPene5gQOGY4UdNX2S3J1Z5zhS3QFqMM
	 rGSc51QnQtDX8SX60CICTB+bXNwZRA3iaaOit98Gg+z3i19+3ugzWKHYucWY7Xw9pv
	 WP6cGCsPzVeht8SNSbA6+JAVfc8ELScqSM0uxMoKBgUJ2fExGnJ7q+bOX2nd7vvwCf
	 Gn55wrfCRFCRxh9EzWxkLI9t74pjopcTCQ6LLWC9fzpPe0CFAu5r4vBEgFS/1Gm+E3
	 ZptqM8bNUdR0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A652A61599;
	Thu, 21 May 2026 11:43:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AE74265
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 11:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C39661599
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 11:43:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5e5DjH1X_o4N for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 May 2026 11:43:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F098461564
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F098461564
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F098461564
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 11:43:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 117DB429D6;
 Thu, 21 May 2026 11:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1384C1F000E9;
 Thu, 21 May 2026 11:43:34 +0000 (UTC)
Date: Thu, 21 May 2026 12:43:32 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260521114332.GC1506108@horms.kernel.org>
References: <20260518111506.65284-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518111506.65284-1-larysa.zaremba@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1779363818;
 bh=gNwhZlZNvRf30NjRud00r64+zMtRvb84BXByEUe94wE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KVWGSSQkk7z2naqeJYJq6xHDJDJnA4c1yP3WGTzwMTrL5NehmGY25IXM4PaHiJoCq
 YE0sw3ITwkOvRbHQZWO83SC6dGNMEj2Iy1VHSmkGYDKstDCs35IYnLwRhAzHnLJ3dR
 S4yKQ0MPhoL6xXVBQ/9tGpNPgPsCIMtwHgl7pjkaxic9P1I5ZVsNNGVPkV/qcT/dec
 vTeUU5zXzfe6PEbTRV1jMgdWwu1K/vogJsjUrjACNhBQNNdg/YdWhHDFXXjKCGBuYN
 Ao2f1ASEDBeCTTaMBqIMc09I0BinuzmIroz9wyaBVfGwoa8+SAZitgo3kMfCP3qo52
 XEC7f9RVp5Sjw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=KVWGSSQk
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ixgbe: do not configure xps
 for XDP queues
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

On Mon, May 18, 2026 at 01:15:04PM +0200, Larysa Zaremba wrote:
> netif_set_xps_queue() should not be called for an XDP Tx queue, since such
> queues are not netdev-exposed. On systems with number of CPUs >=64, on E610
> adapter, netdev is configured with maximum number queue pairs being 63
> (due to MSI-X assignment), but configuring XDP results in 64 XDP queues.
> 
> So, during XDP program load, when netif_set_xps_queue() is called for the
> last XDP queue, we get a WARNING with a call trace and KASAN report
> afterwards (if enabled).
> 
> [ 2012.699800] WARNING: net/core/dev.c:2854 at __netif_set_xps_queue+0x116a/0x1e40, CPU#36: xdpsock/103668

...

> 
> Skip XPS configuration for XDP Tx queues.
> 
> Fixes: 33fdc82f0883 ("ixgbe: add support for XDP_TX action")
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

