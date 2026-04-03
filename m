Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DB9E7E350
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 09:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A25D440BDF;
	Fri,  3 Apr 2026 09:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4tmP8t3OLCeF; Fri,  3 Apr 2026 09:06:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5088E40AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775207165;
	bh=MP4C9sOsOcaOqKGDl0GdhqZahjXBwKV5bVXDeuALXPA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4Zg+RkHz5CzznK5qxsIAaOkUrm9BGFnqm2J6KC2oQfErZ+soTMywGbQiQ5bqLm6gy
	 K2/JYoNSCDTBGfaPZlPBJheae3RSrzczbqwCBUlrTNQ0p3pHJwaFOH1hYZlVXW3mgw
	 tRsFWgwRbCm3tUUQ1RiOwJZ1rMBlihnhfijuVimJQXJYsSX8B6gTmXjh5kdZfPClHo
	 7YuUNwrxYPrA99AioCqxpiWH62UBW7T4YQtN2g+eO0Y2CEPHcrS59KYg5lGck7Xlr7
	 zA3ehrhhT4aHEs6H1zy3zySLU6rvajJjCYmVfbTuVNxiIMLE/ur52HZ7kybULxJ1xd
	 FnBexxtR34ncg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5088E40AE8;
	Fri,  3 Apr 2026 09:06:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78B822CC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 09:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67F1040055
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 09:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6TmPtxNpE-4m for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 09:06:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C236B40028
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C236B40028
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C236B40028
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 09:06:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 12A4460008;
 Fri,  3 Apr 2026 09:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A37C4CEF7;
 Fri,  3 Apr 2026 09:06:00 +0000 (UTC)
Date: Fri, 3 Apr 2026 10:05:58 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>
Message-ID: <20260403090558.GE11973@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-3-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-3-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775207161;
 bh=H37DUjLxE6C6eoONgTSfZeAyzqq6kkHrKPV6bhnkF2c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rSFZ6RioqUNtlia0e/Of/j7QUkUyb4O/qRfeWhV8ykGNImr48SrcahC4ZeJqlAr57
 9FKryywykEALF89c1k3PiREEZwHTQryaxCdlUN+zW68RfQd2QG2g4mR6VnsmjlsnEx
 139E6IePR/LyF2cz7Id89COM/rfF0DyN3EJ0/tpKVsGcnqbTYINLwEFiddNhu13XLV
 lyYUBJO7sztziRtVbrxIm4rpVD7w154UJhSAf2NaDUgu0vdn+qMXesDGVYhX4vSDZF
 c94IdMpofJIAcJbE9k0/fJLcHlfm9C/0vWQnqFB0btfVZ3Zgzxd3qwDQ9qRXx++ciZ
 H7AskzF5Nk1iA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=rSFZ6Rio
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix PTP Call Trace during
 PTP release
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

On Fri, Mar 27, 2026 at 08:23:26AM +0100, Aleksandr Loktionov wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> If a PF reset occurs when the PTP state is ICE_PTP_UNINIT, then
> ice_ptp_rebuild() will update the state to ICE_PTP_ERROR. This will
> result in the following PTP release call trace during driver unload:
> 
>     kernel BUG at lib/list_debug.c:52!
>     ice_ptp_release+0x332/0x3c0 [ice]
>     ice_deinit_features.part.0+0x10e/0x120 [ice]
>     ice_remove+0x100/0x220 [ice]
> 
> This was observed when passing PF1 through to a VM. ice_ptp_init()
> fails because ctrl_pf is NULL and sets the state to ICE_PTP_UNINIT.
> 
> Fix by detecting the ICE_PTP_UNINIT state in ice_ptp_rebuild() and
> returning without error, preventing the invalid state transition to
> ICE_PTP_ERROR. The only valid path to ICE_PTP_ERROR is from
> ICE_PTP_RESETTING after a failed rebuild.
> 
> Fixes: 8293e4cb2ff5 ("ice: introduce PTP state machine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

