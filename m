Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82670EBFD3A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Apr 2026 10:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3793E6071F;
	Mon, 13 Apr 2026 10:54:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v-7S_HiFWEU6; Mon, 13 Apr 2026 10:54:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0749D605EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776077696;
	bh=QPZjPqBTgIApsUsjb4wfwFztDHzZclAwfWv3FFH5YTw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8uoJIUXQ8CY2RG1om/Y2rR9+BqkYAHP4Z4671Wl0RuX3WzrjBliO+BNRsOxN/Z4OY
	 Aq0I1ietjSLnWHR+KsUIWKAmcymR+dPkvZvjdcnTUiOxoeCRISePYi2CC397PST89j
	 BBHA9YFXpSYsS7D5NHMcBlSc6CeGohfCO5567PjEE2qjYUtKKGsp6okEYdTWmR8/WV
	 xDrotdq+66qeL0k3fahoTCG0pZ42hDZDJ6q5mUCls2UJTR2d/XCz5MiTAkVAqqEhy7
	 IZBlYl+vlg0gD+BiISakIumBsSJJNYQO3iXXYTqYOLRQsQ5ypYiBTWNpKez4W4C7/e
	 XHB9U7hGcYF2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0749D605EF;
	Mon, 13 Apr 2026 10:54:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 343CC283
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 10:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A70380701
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 10:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LUzaJomf_2Wu for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Apr 2026 10:54:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2D5E3806ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D5E3806ED
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D5E3806ED
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 10:54:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A41E141661;
 Mon, 13 Apr 2026 10:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638EFC116C6;
 Mon, 13 Apr 2026 10:54:52 +0000 (UTC)
Date: Mon, 13 Apr 2026 11:54:50 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@linux.intel.com>
Message-ID: <20260413105450.GN469338@kernel.org>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
 <20260408131154.2661818-5-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408131154.2661818-5-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776077693;
 bh=nz5hxxicKyK9BXmV2TEjGdfMjMpJw2jsLLzARmCjv5I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y/30kM3r2N63GzzLiQlAttghWO10O6LvFF5HbwPtLczvbXdm/JViuh2Ap481ew5ra
 8liF+004dJPeIJ2Q3kKL6nhXxD/n7KSfFeefsJOV1qXbYFBa/4djNB2TaX3GE3XgY1
 z4yDt8Sh0RYEu/0i8C5X07PVb2ggRSCVxk+HI1EOnzddbi+LYaiMS/V5gaezCWjdZl
 cJD1ep3rO1IjOaqX4jrmRHoFQADEml09InnL4Le9p274txJGljZBVJgs5CVE7RnlLx
 e1mjozks+dVQFe1LE3L1f3aXiQvpD+gol5hZUcamwAlu9cDcyyo4HN8QdcRJp5tthd
 3wV15Xf/GmwdA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Y/30kM3r
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 4/6] ixgbe: fix cls_u32
 nexthdr path returning success when no entry installed
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

On Wed, Apr 08, 2026 at 03:11:52PM +0200, Aleksandr Loktionov wrote:
> ixgbe_configure_clsu32() returns 0 (success) after the nexthdr loop
> even when ixgbe_clsu32_build_input() fails for every candidate entry
> and no jump-table slot is actually programmed.  Callers that test the
> return value would then falsely believe the filter was installed.
> 
> The variable 'err' already tracks the last ixgbe_clsu32_build_input()
> return value; if the loop completes with a successful break, err is 0.
> If all attempts failed, err holds the last failure code.  Change the
> unconditional 'return 0' to 'return err' so errors are propagated
> correctly.
> 
> Fixes: 1cdaaf5405ba ("ixgbe: Match on multiple headers for cls_u32 offloads")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v1 -> v2:
>  - Add Fixes: tag; reroute from iwl-next to iwl-net (false-success
>    return is a user-visible correctness bug, not a cleanup).

Reviewed-by: Simon Horman <horms@kernel.org>

