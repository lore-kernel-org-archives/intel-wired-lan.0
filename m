Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF7CED7B8F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 09:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0735C84A4A;
	Tue, 14 Apr 2026 09:33:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ybt3Bj_jszWB; Tue, 14 Apr 2026 09:33:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3926182861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776159207;
	bh=8nBth7dBkCvFY6MUPZLsx3RUZ83qOf3JKJahUuXGPY0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WiEced+D6q2aJMhwsyUy8bIIRJ3n6KzFbsjLYB9IqKrBg7IWHbMoqeSf7mx2z/Lf8
	 pwzLlIOi6xYnx1JFA7TUZGupzbA+W5myus/kg1W1r84huiPwYNhU9kyw5yIqJPnUhU
	 tVaKWIMHxCwOh66FWnET012ZfvfLGqjkBuyHYlo9BTBdfUaTs03+5ftYkoW6j6IkC8
	 LgK8O0YbMAcgl0FUBIwk33cn/L3UgQL9vFvKhLMGxHhhFpXLMPiZ0zafHa3/z+8zu6
	 blqtpZxf7L1HwHxDkmiuNJ870jo2J+H5cUB0ZFEaaPE/NXIkFPm4D4fq98kltYxCiE
	 idYD6l76RTR5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3926182861;
	Tue, 14 Apr 2026 09:33:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A060C283
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 09:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FD4F42703
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 09:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oHdzQnyQu_zd for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 09:33:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D3D3141021
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3D3141021
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3D3141021
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 09:33:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C411660018;
 Tue, 14 Apr 2026 09:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAC5C19425;
 Tue, 14 Apr 2026 09:33:20 +0000 (UTC)
Date: Tue, 14 Apr 2026 10:33:17 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <20260414093317.GY469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-7-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-7-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776159201;
 bh=LsW298vC1uXD4bNamm2iAeOtiJmLtwQwZUl1bRwVznM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i+Tbw0CcClfF8F75vv96rwLR7UM3a7fRL/T3bZ1hNRJnlyCrlJOU2NTgGmLhNngss
 4s+n7kvhJef/vDVcve6TDvBD3nqoMPQk075oWrebT/iPaLDoQwTBeZOpPt0e353zHg
 B09LaAtf44/1/Ffb4GBkMdjjo+eswm/xEAXJwcBJ4JpEQA1Mwz4nVE7KIm5PdHeYBD
 51CuH5Es5wmNcSlft0/RU9CoilQ3PdOkAUc1D2csJu+Mcxms6Vjk5Gee8J3ZQdA4Qc
 EYiwEQh5UFVDbEGKSm1Bp/bOPeeTgkSePmZ910I6Z2fKcXAGkiAHgbrNIDPcah5ARa
 dS9Z8eAqc5Iow==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=i+Tbw0Cc
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 6/10] ice: increase OICR
 interrupt moderation rate to 20K interrupts/sec
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

On Fri, Apr 10, 2026 at 09:49:17AM +0200, Aleksandr Loktionov wrote:
> The miscellaneous interrupt cause (OICR) is throttled to 8K
> interrupts per second (124 us minimum spacing). This interrupt
> handles VF mailbox messages and Tx timestamps, so the low rate
> imposes a minimum latency floor on both use-cases.
> 
> Raise the rate to 20K interrupts per second (50 us minimum
> spacing) to allow lower latency handling for Tx timestamp
> bursts and high VF message rates.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

