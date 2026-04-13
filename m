Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F97F34C64
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Apr 2026 15:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1090840EBB;
	Mon, 13 Apr 2026 15:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jfLc17a6v6v; Mon, 13 Apr 2026 15:50:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FB6E40EE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776095439;
	bh=QlHuDjWwTbII2UQLJeSMkY3ody9/ldfv/8v40wLXWW0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GIHAVpYMn6/HSZ8C/rGvvSWcRuGn0p0fzo/xApel5G4pQ061DDUP0DAf2pA7O3bpH
	 XswkYPng7acTRWi/idZC0dBmeh3kIug5WntHp6wFgBLdRNUhtQD6Zwmz9uADUtZ04A
	 zekI07e31UV7FsZNJFd1mGeotBYMEADhjDSm7DX2TMCYXCqyDUA4/lUXO40DGYSO/Q
	 8ESKGiorj30o/THz97LWcUpulgKkjXQQ+laR3UOkMNbxvIjVOQuh5E744y+IGl1w7s
	 P6Jm7/EcGPzXQbmxTWPm6Cv0qgOlF42n282hoF98XgPyZWIHro33vS1l7YVFXcnqED
	 J3iemIpKuXwDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FB6E40EE1;
	Mon, 13 Apr 2026 15:50:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B623283
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 15:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07ECE40289
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 15:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m97f72N9aGp7 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Apr 2026 15:50:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 62FC040094
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 62FC040094
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62FC040094
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 15:50:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A520C61336;
 Mon, 13 Apr 2026 15:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12803C2BCAF;
 Mon, 13 Apr 2026 15:50:32 +0000 (UTC)
Date: Mon, 13 Apr 2026 16:50:30 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <20260413155030.GS469338@kernel.org>
References: <20260409075523.3728506-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409075523.3728506-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776095434;
 bh=GbXCe4AZJ6wicsCGLe6ipRR64a2u6eUyDZXiLtFO9C4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KcB1Q6HFzfWN5mQxagsPV2Twyxs6kE63fmDwruq2yPhAcNZiuAf2K2qPW9czREmRs
 Yd+VIsJDMzpcMDxZhgG8jyAcCd0YS0+ty7nYe9ydr+oSIAIJHVRpYNuc5+1F7ebXbv
 gJDsDqxleYITPzEgwf73UU+NyFTJd4nO74W2hpqcoMyZy0XosS7MmcKEgR3fymJjGq
 aM/8nzbiip+XIu1TGO/sZjameXp8ejJp0qRTacDbVim6HoEvjan/lmtwQb5xOGBuj5
 ZW3JoaLjjUFC4ileF3rqK8UgjxTrV7Q8vNHuwK42on9XK2lc8047j76ONQMaJB6+7k
 2v3clHkAsXK0Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=KcB1Q6HF
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] igb: use ktime_get_real
 helpers in igb_ptp_reset()
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

On Thu, Apr 09, 2026 at 09:55:23AM +0200, Aleksandr Loktionov wrote:
> Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
> ktime_get_real_ns() and ktime_to_timespec64(ktime_get_real()) with
> ktime_get_real_ts64() in igb_ptp_reset().  Using the combined helpers
> makes the intent clearer.
> 
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

