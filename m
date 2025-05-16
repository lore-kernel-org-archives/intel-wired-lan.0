Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC06C3DA6D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 May 2025 12:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D745761254;
	Fri, 16 May 2025 12:26:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hl_j4PWHYPOg; Fri, 16 May 2025 12:26:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7E8E60A69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1747398406;
	bh=CUN0+3O7VdkWkD2xyW1kcMCV7ozLJSQpUNIy4rInAto=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nnc9KkY178xyVKnBRHLKv4jGWOES7S5TZymu4RpYMth1jXnQFWGVJZuXNd0MspmLf
	 TK8dw2ovviqE5hKzmLXG/7nIrcuKyTBWDnoMDBlO38Ztb5UkJfxDadfxwGln4NVHx9
	 8OcOFK6H7c0LKks2PYdvgKLromfbEALJKm55fhCWo55nTzi4Z4KlfNCvXChsEMaenC
	 sSXIcG0s+ot80qlP21+P1S15/lBu5I7mC7BNe44z+8WpflfrCi5XvbembN9N0R6GsU
	 6PYZEG6i4fo6tWLZdlM7zvDqwyrXZ/2bfYkBJPCXdL1FCxju3ZhH8dk94MNc4aVsXE
	 GLsFER5soNlhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7E8E60A69;
	Fri, 16 May 2025 12:26:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 711FF185
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 12:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58BE760A69
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 12:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FR3kv0id35qY for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 May 2025 12:26:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D07E1606B1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D07E1606B1
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D07E1606B1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 12:26:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EF539629F9;
 Fri, 16 May 2025 12:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA202C4CEE4;
 Fri, 16 May 2025 12:26:41 +0000 (UTC)
Date: Fri, 16 May 2025 13:26:39 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Richard Cochran <richardcochran@gmail.com>
Message-ID: <20250516122639.GC3339421@horms.kernel.org>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-5-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513101132.328235-5-vladimir.oltean@nxp.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1747398403;
 bh=l3A+0C0ZlMZcEXmwmZb2VDN+BImDhjEvJVBJ/1QFA8s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OPdmoIISRpPa7rjmhyGgokdv72e1rC9/hs+9SDt8j1usSTqFs/EpuokpwCavVv/SK
 6OqkcKIMnnUOTkkF7nP1MmVU1C4+ojVNmoFGnSiNUtXnK5zKnLfJVhuNdUlqX6XA32
 Z2iuB4V/y3JEup+5kZRtw3x6TmI7b1KYasPtT7fdsS1OT/vvsltisErDYmBjPZ0Zhl
 4hrz5tcK7msEF2qlWGOrZ68gjGk5eLH2R95vUNFerghOXa1EtyzLixi1qFk29tNHt8
 LhR78xsoyUnu42vhT/jMjmV3MkuzuE1NWnfO174KTh0p/3A15ZtxND7J/f5cd5Q+z6
 D11yJQubqzn9A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=OPdmoIIS
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 4/5] ixgbe: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
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

On Tue, May 13, 2025 at 01:11:31PM +0300, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6.
> 
> It is time to convert the Intel ixgbe driver to the new API, so that
> timestamping configuration can be removed from the ndo_eth_ioctl() path
> completely.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>

