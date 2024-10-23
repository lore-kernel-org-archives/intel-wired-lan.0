Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE10CDDE6E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Oct 2024 12:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD85F80BD8;
	Wed, 23 Oct 2024 12:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIBdOvlYZptM; Wed, 23 Oct 2024 12:02:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6FAE80CD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729684965;
	bh=fcxBLDWi9hyrNB3QD7TMm3WxQbNsaGb+JKkXY0ttJTs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XODDTEGb1KViWyw06uq983P9uKOk+3El9Z14zD5WhVQxRDHR+AROKGRRXON9rz15y
	 n5zlFnkNa1ce9LMG0HgDCWEZwcOYXEVWLVhUTNWtdacN0QzvWspnXY4GmclpsDvX05
	 dh1yjFWRA3N93UyRCCmfju8OB1m9cpV7JJFfaCr+i4qqoUXmS49aGQT1wkrx8s5oGr
	 TTHIqSvstvVFexztv1methzYyah3JEx2bRwV/yHr6lnEiIl2B6fkikfl9FFLEzt+ek
	 FeaXMYM8f9quh9inYd19NibfwjXtzoUw/3ZgapKT8ZizPReUzegHEQ9C1X6kvi26GZ
	 OfLJBrdyK3YTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6FAE80CD6;
	Wed, 23 Oct 2024 12:02:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DA1BB4C2A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 12:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7439403CC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 12:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id khewYLtXSTpM for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Oct 2024 12:02:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 20A8E4034D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20A8E4034D
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20A8E4034D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 12:02:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 629395C5115;
 Wed, 23 Oct 2024 12:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AF6C4CEC6;
 Wed, 23 Oct 2024 12:02:39 +0000 (UTC)
Date: Wed, 23 Oct 2024 13:02:37 +0100
From: Simon Horman <horms@kernel.org>
To: Johnny Park <pjohnny0508@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <20241023120237.GP402847@kernel.org>
References: <ZxhruNNXvQI-xUwE@Fantasy-Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxhruNNXvQI-xUwE@Fantasy-Ubuntu>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1729684961;
 bh=JXY75s2u6rRPudxtXz5fP+1Bnsjq+f7s0nxJfypNBvs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VLmmHE30MNdMidUIAvLPu6/pyXAM2u588vAzss1L0k5zJJhCgcQcvznT8of5FXDrg
 m9OOQ9oF3qZwMdI3W2RAnyBt0UJ6mL4A0mzMB4pj91TlwzZAO3yb594fCOJK598+8a
 75vmcYOgTAYrJhBoI0PDbcfgUjpubbZHvRrN8OE+zUsQgiVdG9xWcN15snJGPScdhm
 Y3ZxdjsFEawR15u2J2rErqr2BqCj/YwuKjX5ZVX/tGcAYBRvlRX/h6PbCv+5aCyQxQ
 B/gXYcwlKeXgEoCulSLAs7YpPP3HgaM4kw6UH6nu1LL30aaEKXT7ncw9NSY4sh7wrS
 b0o/hFQ/P43GA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VLmmHE30
Subject: Re: [Intel-wired-lan] [PATCH v2 1/1] [net-next] igb: Fix spelling
 in igb_main.c
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

On Tue, Oct 22, 2024 at 09:21:28PM -0600, Johnny Park wrote:
> Simple patch that fix spelling mistakes in igb_main.c
> 
> Signed-off-by: Johnny Park <pjohnny0508@gmail.com>
> ---
> Changes in v2:
>   - Fix spelling mor -> more

Thanks for the update.
I checked and this addresses all false-positives flagged by codespell in
this file.

Reviewed-by: Simon Horman <horms@kernel.org>
