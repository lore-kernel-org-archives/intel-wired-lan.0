Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9A6E6B244
	for <intel-wired-lan@archiver.kernel.org>; Fri,  1 Nov 2024 10:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42F0780EB0;
	Fri,  1 Nov 2024 10:30:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3mf0SFBMN2Kd; Fri,  1 Nov 2024 10:30:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA76C8203A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1730457045;
	bh=wYdMMdRGXFwpokW8pyhVwKstf1EscA60BosA31i2T6Q=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZXVlSZ32LoXmLZkmpgmBD6GZPrGA++mrtENzjZbo+0dxuuBJtMKLhCOCHVnni1wbG
	 gqu74FPvJnB6OynA6UH3NV25mvrZuNEO15v8cQGh4l/Z1AHJBnVHcUbXPPKNPxfJ56
	 3JX9wX47sc8+dS55ED06pdVSjT1xGg1BQIS41/Sbg+UDdLjAjzNxYo+jdhHV94yVHv
	 8t/JYxdXV4mJo/tDYCinAH232zDSRtkA0J9QCxgij4a4ADUC+5PfxafPUicpvilg8+
	 26vqVcVUH6h3hwXTaLRF6xxl3HXTDqSJXhLifvz58jk5YPGRnXDzCTQ4Suezn4bUem
	 lIDbJxTXdm9pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA76C8203A;
	Fri,  1 Nov 2024 10:30:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF34460
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Nov 2024 10:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBE74402E5
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Nov 2024 10:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kJSJG2sBvBNv for <intel-wired-lan@lists.osuosl.org>;
 Fri,  1 Nov 2024 10:30:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0CA1A402CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CA1A402CE
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CA1A402CE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Nov 2024 10:30:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7060CA43319;
 Fri,  1 Nov 2024 10:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2C5C4CECD;
 Fri,  1 Nov 2024 10:30:40 +0000 (UTC)
Date: Fri, 1 Nov 2024 10:30:38 +0000
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20241101103038.GF1838431@kernel.org>
References: <20241001102605.4526-1-mateusz.polchlopek@intel.com>
 <20241001102605.4526-3-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001102605.4526-3-mateusz.polchlopek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1730457041;
 bh=fK1mvPxKuCzyRD8eeizEsobaBIxDnSVChFaJ3zbXAxY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fy51toMChfwdqf8TKX3Y4LinfdMxBYxkO5iWPC95XooxpHWmOOP2jWlBgrC8EFi1P
 I9RI7NQBDwAQvDMXGzibRpWMg90Cmurb5DYj2yhW2q9SWZeTaM8XWkBgbSORi6q7KR
 nd1aZOjsnXKwMDwisv/LNHTAtIVlkXATy8DqOHtnYYMr7cR+F7LUNi146pW8of28uh
 9Xlm4QH0wgYWmImx9NG9RbHjfjSYKpZwztFkpHGBCVkgGhHBWmE4o29Bo+5uBf1xh8
 7cBu7xncG+LWz/Z6g6K3oNvZJsNyvaMchTTwSJFPFVFlWFhgmb8aGpwon4TwO8EYNP
 VwrmTBwZBIOew==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=fy51toMC
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/2] ice: extend dump serdes
 equalizer values feature
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

On Tue, Oct 01, 2024 at 06:26:05AM -0400, Mateusz Polchlopek wrote:
> Extend the work done in commit 70838938e89c ("ice: Implement driver
> functionality to dump serdes equalizer values") by adding the new set of
> Rx registers that can be read using command:
>   $ ethtool -d interface_name
> 
> Rx equalization parameters are E810 PHY registers used by end user to
> gather information about configuration and status to debug link and
> connection issues in the field.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

