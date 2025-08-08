Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67757C87FD2
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 Aug 2025 13:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 362FF40ABE;
	Fri,  8 Aug 2025 13:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rD3BWs0rDI9e; Fri,  8 Aug 2025 13:53:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBA6540BDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1754661208;
	bh=WrejizDi7/0x70xAY10jGw+5BxxTRsG30W6FJpT2X5w=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iz6udlrC0kk4qjRelO7MwhQ2vocAmZkl5I0PLbUiouKXNjWj8AMdfIhPCc3Caa60Q
	 wy68vesSdFHqbLWGRhdD12UnGX75Lb+EtWKKxy2Euv9xrGGKdj61GNt45zmUbvueUC
	 10fTL9is/OyWjniwyzBfN5KVgwosJmkVzZZqw8WREVFiBCxLpzxdHRonKkCdPSRtgm
	 dkS32rMfkx9BTVRlx7esQID7s0hM91yvNe1538TbKbdwfZBeazIAQF6RgDBEBCFG3A
	 EpQ9rbxTrXjbiJfDtYaopeO0jYVm6VmdjYBaCmW7tVtnuJMjeYbhVOYS047LfY+Emn
	 D/X8Ls3dtaKXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBA6540BDC;
	Fri,  8 Aug 2025 13:53:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A781D31
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Aug 2025 13:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4DF940BDC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Aug 2025 13:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2GObNT2hhkO for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 Aug 2025 13:53:27 +0000 (UTC)
X-Greylist: delayed 557 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 08 Aug 2025 13:53:27 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2FE2340ABE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FE2340ABE
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FE2340ABE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Aug 2025 13:53:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F75E61429;
 Fri,  8 Aug 2025 13:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01973C4CEED;
 Fri,  8 Aug 2025 13:44:45 +0000 (UTC)
Date: Fri, 8 Aug 2025 14:44:43 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Message-ID: <20250808134443.GD4654@horms.kernel.org>
References: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
 <8ae30b40-04e5-4400-92fb-86101b5c667d@jacekk.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae30b40-04e5-4400-92fb-86101b5c667d@jacekk.info>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1754660687;
 bh=Fjd74z6nl1sIEBfOGJhqPzlxzMvI3qYffQ5FwgvdElo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mvc9tXR57pefvA1PnVW0wnrR3PuOYiTWpjNJAG02qMdbZy7EhHwXzUvQ3fJJiG/Ew
 0D93wGg+Y7K0uZ4W7HzPIBHrLVZJX0LcRjhtGyH+nf5cWi9QTQ8NsaeBtH/0D2ajLY
 TIju01DgC2tolEmwQ7PJTAwqDlp1l0iMIN1YqqP09Hz9PcjzO1u4L3uV3AKcJ3Wtbx
 MZvwT1fCIqFn98eHeKVKcr06x4VcX0aygXXtkgI4XFiOHuW0hsqdHosymeIZPUk0yj
 E1Gfmox2Lc9HpYsrZRjIrVISHfc8j89WN0XX4d42KfiqP1YPf6TlrWB9013TUyle5u
 wHq2OAM1L5vXw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=mvc9tXR5
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 4/5] igc: drop unnecessary
 constant casts to u16
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

On Wed, Jul 23, 2025 at 10:55:20AM +0200, Jacek Kowalski wrote:
> Remove unnecessary casts of constant values to u16.
> C's integer promotion rules make them ints no matter what.
> 
> Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

