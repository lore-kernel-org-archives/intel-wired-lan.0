Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F3FC3DA5D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 22 Jul 2024 14:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C721810FB;
	Mon, 22 Jul 2024 14:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PvOlydfeeUPJ; Mon, 22 Jul 2024 14:53:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B55F0810F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1721660028;
	bh=9eeoFkP8RVNfmx1d7pYcUQd9wx7CZEw0Ipg0pQeXN9M=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ubPRkP30ixu/sRxAFYO5r8MZwfxobzHGTGfG1cBPsKhfIMlIiBmNjNeZuyIBBCsNj
	 kXChgtv19xMkjiSrXu+n0kGk+8Bko/KYvDvyg1761GC7HhPqvIf3q56DkZYN3UetHs
	 4th4+kji4HyuaJPzjnP2GgDosYuUCDveQs/f20Me4EyBc2RSqUdcnQWmZ9Kk9U49ew
	 w2vv3JMl6R07hWMtfhFqtikxIXE/4rJdaM4hZ4sfmbp0P1AQpOD5n/TF7RZXGkrnDM
	 kPNTyBoKkZpYgdUwZORtpfYAdWJPqMcUppmcVo4rmlRoEEbmFvUnjNFC/pgQpl3HTm
	 D+kzwt+Uq4+5g==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id B55F0810F6;
	Mon, 22 Jul 2024 14:53:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 5CF511BF286
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 14:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5620940448
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 14:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NNhC0hlZHeTS for <intel-wired-lan@lists.osuosl.org>;
 Mon, 22 Jul 2024 14:53:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7AB0E402E7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7AB0E402E7
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7AB0E402E7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 14:53:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D10BCCE09AA;
 Mon, 22 Jul 2024 14:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55E9C4AF0B;
 Mon, 22 Jul 2024 14:53:41 +0000 (UTC)
Date: Mon, 22 Jul 2024 15:53:39 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20240722145339.GG715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-4-ahmed.zaki@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-4-ahmed.zaki@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1721660023;
 bh=DBrfqFXsCePi5RkuOb5Ae8jJax5RVndoMZBKRM8bsAY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pnNS2fvyZzKMBRw5Itw8QkII/Y4+fzFRB2Do5jGgdx7PFCUOoYJtlkr8GlMHGmTsn
 uRtnccKm/ZlKwoYQNTsfvjey4AvPxCZ4QeL3qIBkVrKw84oN3j+3+hPC4VQTw2BG/y
 IR2o+iW/GQpK4C2n05gH+QY/mhKw0oMtDTQSFlgDmqgLjpg/SS1t0vk57ofiaq9rbf
 Zt1697dcgIx5Ak41pYgLUk4YSN9DtRlnx3yt6Ef0/L2epqr6/j+WptJgNGy78cTUlL
 7xFEZDTK367yK7p9DeaC4mzMkUBVHYl7GdIwR7iPmkXkWlHowLRKTPQZDQWmoQccVD
 RA5pSRk9FqDeg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pnNS2fvy
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 03/13] ice: add debugging
 functions for the parser sections
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, Junfeng Guo <junfeng.guo@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jul 10, 2024 at 02:40:05PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Add debug for all parser sections.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Hi Jungfeng, Ahmed, all.

I am wondering if a mechanism other than writing to the system log
was considered for this debugging information, e.g. debugfs.

