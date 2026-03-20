Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53BA10987B3
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 16:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FDED848FC;
	Fri, 20 Mar 2026 16:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MD4foJWpztTG; Fri, 20 Mar 2026 16:45:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8979A848F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774025101;
	bh=zsDRMGfUsRSQc8C7Ylsy+4Aq4teRZIPEjCj3MnzHEHY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A0OCgrNBeZQhgfD7qLmdDd8J6K3+qmbp6/THKSqMIgU4AsuNFFfoJxYtgHEMkOcSq
	 02yrdzeggZIdW5hXHBAh5OZSsKg4xMgJp5nLngsZ2To9FWncVYKAbKmR1RmpX/7Ud8
	 xLVYnux+IH0oWRP1k1u4QcWP8Mzf/jk3LTqAYilsXPhT+qQXmOlYQ1qt3uaIW4wV7U
	 Nlm6nXWt45I7ybczeSVfcQjwv9CHmRnhUDMUridA2MECtEZDNZ51cyGx9KGiWG0+H8
	 eoAnexBSdS+cidMPudgtJLGdsIjRS1QxjjsfmgMAGCb1NNoESLDpZsOLvZbHgmR5MV
	 fsbxXm35EMPUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8979A848F9;
	Fri, 20 Mar 2026 16:45:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EC7D25C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 16:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2469040177
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 16:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJ89zK12fP4p for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 16:44:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6F6A640139
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F6A640139
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F6A640139
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 16:44:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 04E74432D7;
 Fri, 20 Mar 2026 16:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA532C4CEF7;
 Fri, 20 Mar 2026 16:44:57 +0000 (UTC)
Date: Fri, 20 Mar 2026 16:44:54 +0000
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Message-ID: <20260320164454.GB74886@horms.kernel.org>
References: <20260319111659.551039-1-przemyslaw.korba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319111659.551039-1-przemyslaw.korba@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774025098;
 bh=XvtyeRdyTe4yJx38Xxj/5vma5vmFAWY0GDfAooXKx4Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R4WdYjnc+0tljIDD4t50zjsaVKOrzd4XoUrF8CblSR2EWpROoj37yMu05o8x0RTOq
 PmRlptITKk9rU7AY0QHKFnMrsivf+WeI0OKEsX0V5j2zlewfFzmTbsrTTOYMRDH+I9
 /OA6gdbno1/+uvX5v5ABx8aDH1pgWazTth/k9TXFeAPxHEbY6go4JgziPRQQb8KGDr
 lb4QS5Iv+R6CAf+3EuFhhW98U1nWzvSvWr8QTvmmYbXHUYioH+r+Ju0S2OrVMgd4az
 hc9RbqXhfJ4GgkpSapyISIrJRSeY3xPXMnqET49chgXFnpvpfYPsmZruU809nVMK0h
 HCGKaEJ9NR9bw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=R4WdYjnc
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix posted write
 support for sideband queue operations
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

On Thu, Mar 19, 2026 at 12:13:27PM +0100, Przemyslaw Korba wrote:
> On E830, PTP time adjustment commands sent via
> SBQ don't generate completion responses, causing the driver to
> timeout waiting and return -EIO, when trying:
> 
> phc_ctl eth8 get adj 2 get
> dmesg: ice 0000:1a:00.0: PTP failed to adjust time, err -5
> 
> Add support for posted mode not to wait for completion response.
> 
> Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v2:
> - change "postpone" to "posted"
> - init struct with {} instead of {0}
> v1:
> https://lore.kernel.org/intel-wired-lan/20260310110700.345904-1-przemyslaw.korba@intel.com/

Reviewed-by: Simon Horman <horms@kernel.org>
