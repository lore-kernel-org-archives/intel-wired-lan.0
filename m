Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A59C8302D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 30 Jun 2025 16:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 520C661060;
	Mon, 30 Jun 2025 16:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H89Zfddps-qc; Mon, 30 Jun 2025 16:50:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8C0160F28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1751302203;
	bh=/BxixbXTP5pxehLvXORC64MkC3XSXhbM4XGURvwXqhY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5fGQ79GM+3zMeqf5hz4sC5ydyeOVIN0BBTH/dHcCTegIGs4fKM7GA0k4VlANDCK7e
	 tQvhQLJarOhWn8tvur8hDAMyNuIz+FGNltXyi0fD9n+omp4XM+HK7rjGGTfpac91SV
	 yeHXU15OD8YaCsML6j9w2Z0akpzs0iLiJU7wF9DNoEqV4BmbKsCviomTxkXuLkqYZe
	 ixdQVrYvDE7s7jNSJ8u6mSmyhS7BA/UESTyPJdEZECjN3+YtTN/Z/VGvrSbYJ3qRts
	 MRtNKAiV5QGf6I6Y6op+rgkR8lnK0S61xYNPRrfXYfAbqOL68F+ZtE4nVCVIE0Q7ud
	 VClFdWyC+HYnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8C0160F28;
	Mon, 30 Jun 2025 16:50:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF5111C9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Jun 2025 16:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B58C760D66
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Jun 2025 16:50:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id chzJ-YcVlHE0 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 30 Jun 2025 16:50:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E9A3860E4F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9A3860E4F
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9A3860E4F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Jun 2025 16:50:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9E3AA5C61CC;
 Mon, 30 Jun 2025 16:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54999C4CEE3;
 Mon, 30 Jun 2025 16:49:57 +0000 (UTC)
Date: Mon, 30 Jun 2025 17:49:55 +0100
From: Simon Horman <horms@kernel.org>
To: Dennis Chen <dechen@redhat.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Message-ID: <20250630164955.GK41770@horms.kernel.org>
References: <20250618195240.95454-1-dechen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618195240.95454-1-dechen@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1751302199;
 bh=amikl6o2wzAqKCLElLnXacASC7JbfG35i+pN+kkodpE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OAd73jTr4Qx4sIewZhiPHeppN6ESqOnFVQaqI9pRlM4B2HGWGcZsuGSuhEOXM4LV9
 WigopD4UURVkN76D6r2SkpJlcDJ8LXCuMKxM7fC2YPTYPsQlAOrIu2U8kjj/0TvSzy
 C1qfPvpQDyWsVQNChAFxeB0ilLCfAwZuV+NAcQ7374+MAWNxzGseYkVtF5py+e5jvs
 gGgnhbRXWgrGEUty+jBhCNfuccsVb+6DiTVAfzO5rQ3FzU6uprQAtdb21HYljU0okB
 dz1QTgsHW21xBhXeNGwUi7IxQXhkGZOGN356knnqAxrnV73fdF9ql1KuPBe/iu6PtN
 pAqpYIE4UXbCw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OAd73jTr
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: report VF tx_dropped with
 tx_errors instead of tx_discards
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

On Wed, Jun 18, 2025 at 03:52:40PM -0400, Dennis Chen wrote:
> Currently the tx_dropped field in VF stats is not updated correctly
> when reading stats from the PF. This is because it reads from
> i40e_eth_stats.tx_discards which seems to be unused for per VSI stats,
> as it is not updated by i40e_update_eth_stats() and the corresponding
> register, GLV_TDPC, is not implemented[1].
> 
> Use i40e_eth_stats.tx_errors instead, which is actually updated by
> i40e_update_eth_stats() by reading from GLV_TEPC.

...

> Fixes: dc645daef9af5bcbd9c ("i40e: implement VF stats NDO")
> Signed-off-by: Dennis Chen <dechen@redhat.com>
>     Link: https://www.intel.com/content/www/us/en/content-details/596333/intel-ethernet-controller-x710-tm4-at2-carlsville-datasheet.html

Hi Dennis,

Thanks for the detailed explanation, it's very much appreciated.

One minor nit, is that there are some leading spaces before "Link: "
a few lines above. But I suspect you don't need to repost just to
address that.

Reviewed-by: Simon Horman <horms@kernel.org>
