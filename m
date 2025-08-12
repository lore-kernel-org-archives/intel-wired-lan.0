Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD7ACA0EC4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 Aug 2025 20:07:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 769F084137;
	Tue, 12 Aug 2025 20:07:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqAgaTKcMLBP; Tue, 12 Aug 2025 20:07:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9F0E842F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1755029278;
	bh=uUsro2byKaW8l4QNqOc5JTcFk2uTBDAMHcKDS+phVpQ=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vk9uQko5aFqAIkCzK3U4d5Dm4jm5GmaWGmn1W2tRJ7AHLJSwlpe6g+ccQOSoFwO3j
	 bj6osW0J597RmX1+Ipl1TvTngMrKGYAyQhF/0L85KF4Xjr42gZMS1oTK24+m5aouqU
	 +aFHCdYirefBDH6fIairAHkeMsjM/iUaG7tD4s7hFRPdP/WTHGtiULTe8TF25DWkO6
	 hAY5yi/ksuC5+vvo7LBPIrYrQTU2tMF6T7vGaT/OlwDeRz6Q6iopnbEEMzjGAqOkqo
	 sZzENPlcVAE+zijdiTzM9djpdLcssO51kxOGCK7cKkkHj8kuoi3bQ9To46hXT43CaP
	 XAqRZkW0SmN1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9F0E842F7;
	Tue, 12 Aug 2025 20:07:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D478C1B5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Aug 2025 20:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5A4C60656
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Aug 2025 20:07:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aOYEVR1-n-pl for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 Aug 2025 20:07:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C06FF60647
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C06FF60647
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C06FF60647
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Aug 2025 20:07:55 +0000 (UTC)
Received: from [192.168.2.202] (p5dc555db.dip0.t-ipconnect.de [93.197.85.219])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id EFCF561E647BA;
 Tue, 12 Aug 2025 22:07:40 +0200 (CEST)
Message-ID: <edbc1372-b063-4294-b045-72752adf37b3@molgen.mpg.de>
Date: Tue, 12 Aug 2025 22:07:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
 <20250812132910.99626-3-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250812132910.99626-3-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH 02/12] ice: split queue stuff out of
 ice_virtchnl.c - p2
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

Dear Przemek,


Thank you for your patch.

Am 12.08.25 um 15:29 schrieb Przemek Kitszel:
> Add copy of ice_virtchnl.c under the original name/location.

Why not mention the rename in the summary/title instead of p2?

> Now both ice_virtchnl.c and ice_virtchnl_queues.c have the same content,
> and only the former of the two in use.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/Makefile       |    2 +-
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c | 4611 +++++++++++++++++
>   2 files changed, 4612 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl.c

[…]

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
