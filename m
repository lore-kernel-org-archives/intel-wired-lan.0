Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8D1C3DA49
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jul 2024 10:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E5D18121E;
	Tue, 30 Jul 2024 10:28:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F1YWQ5c_Tnhi; Tue, 30 Jul 2024 10:28:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6CA581155
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1722335338;
	bh=RVCC2r2VtkP6hMOglo1gbmjRZl1jeT5/KiemZakIbUM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=hNph4SV05Y0vZDiY49rL5bcidVImG+MXWlLaURlY00uyc9RhiwVBh7KKbldvDGhVE
	 3MUebAuyuT8OvncVm8ZFlTWfmL17rpf++9kL0mhS3G48NAH9qo2yxsC27g0orVu0LK
	 2HqO+i4a/zQKhnHMT/eZdcfdV2q2MjfxI/xCCQjlRVZOPp9IUyg7oDOlE5RvSPIJTJ
	 z5b2+2sZR+7GBUE/J49i4BzwMlePU006OvkT6X7EbNH6YNWA6EhVf/zKSos3BlG129
	 poP2NcWaOpkC6JSujf39/lxpbbciMZWRea7Ob0eHcyJCxirBtiu1Q0VnCZTXI9HuiX
	 DPqDOVv3Wv/Ew==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6CA581155;
	Tue, 30 Jul 2024 10:28:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id B9B771BF5DA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 10:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B478C608B9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 10:28:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dl_C9QT373FC for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jul 2024 10:28:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C4F4B6059D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4F4B6059D
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4F4B6059D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 10:28:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 66CA0CE0ED3;
 Tue, 30 Jul 2024 10:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26D0C32782;
 Tue, 30 Jul 2024 10:28:51 +0000 (UTC)
Date: Tue, 30 Jul 2024 11:28:49 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20240730102849.GY97837@kernel.org>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
 <20240725220810.12748-13-ahmed.zaki@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725220810.12748-13-ahmed.zaki@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1722335333;
 bh=Yd+bFiBGSdyUAsFPoD3rjwVsN8k4aiUTyN/gHuNRwgE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kwrMR20JHV3l9hUYKC6oOCVwzywWsF0UBP3B/hJQh8r73Wpi8P97Y/yPiP7rFLx6o
 5Ss2j2FA+WyJ8/fge8RcebwW1eF/0+4Kgo1zTQlJDOqSYRLZgqXPcYBUqwqLHjQsBZ
 CoHtMfyrzma3GvQrB99VNkL9U/+8jKxGHD5NxQxLHSLeetrssXMvuendfKFogqIAXn
 gu+Krbrtxh4y5h0anNQuH66zsGFWxgqmHs8CdWi9MHxk6rG5iLhe1MXPD5PdsWmznD
 OLsROdameDBpIlWRK4Wm+U3YHrTnr5WzvMnvl6L5qQHLIF+L4uoJvmAYGa8d70O5HL
 Q4LNnyl+DX10w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=kwrMR20J
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 12/13] iavf: refactor
 add/del FDIR filters
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
Cc: netdev@vger.kernel.org, Rafal Romanowski <rafal.romanowski@intel.com>,
 hkelam@marvell.com, Marcin Szycik <marcin.szycik@linux.intel.com>,
 anthony.l.nguyen@intel.com, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jul 25, 2024 at 04:08:08PM -0600, Ahmed Zaki wrote:
> In preparation for a second type of FDIR filters that can be added by
> tc-u32, move the add/del of the FDIR logic to be entirely contained in
> iavf_fdir.c.
> 
> The iavf_find_fdir_fltr_by_loc() is renamed to iavf_find_fdir_fltr()
> to be more agnostic to the filter ID parameter (for now @loc, which is
> relevant only to current FDIR filters added via ethtool).
> 
> The FDIR filter deletion is moved from iavf_del_fdir_ethtool() in
> ethtool.c to iavf_fdir_del_fltr(). While at it, fix a minor bug where
> the "fltr" is accessed out of the fdir_fltr_lock spinlock protection.
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

