Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1243AC4167B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Nov 2023 12:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B48B040285;
	Mon, 27 Nov 2023 12:16:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B48B040285
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701087367;
	bh=21SRJDoouk4Eh/44npJ1P9RNs22KQnpbOHummYMuo3U=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BJsc74Mb/dYkicW8dIoxc0TfOcbYvZWb7+js1owR46p+n3HEhxopgTkKmxUkmn1/I
	 thfKXS9xVLZYim6uPl2L+8Fpn7B7o14dzHKJmsi9T6CSB9iOLqxV2nf5AzgjkQedwy
	 SpYRQKdupWzyAKf8v39QrCy+NfnV3OwEbP8orlWZaNgUkLU64FSnRWqMTLA9j3wJGP
	 LxvXYIOS4NISW+XvULNHFc/9T2vCWKJ9E1uitfSxCSBcXUVD4QtkvSGS+KavyrbF5w
	 Rg/Gl5flc0APfWdTIT9N10xNN/zxHcvPRZzXxymhwW0185T+RpGX2hQjPSkS0WXe6K
	 9P6RWVNK1Lptg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m18x3prtOfoT; Mon, 27 Nov 2023 12:16:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3ED2402A6;
	Mon, 27 Nov 2023 12:16:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3ED2402A6
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 5A4B51BF3A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 12:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C26B404FE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 12:16:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C26B404FE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AONjEFtgrVcz for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Nov 2023 12:16:03 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6FCE7404FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 12:16:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6FCE7404FC
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AD8F261180;
 Mon, 27 Nov 2023 12:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3A6C433C9;
 Mon, 27 Nov 2023 12:15:59 +0000 (UTC)
Date: Mon, 27 Nov 2023 12:15:57 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Message-ID: <20231127121557.GE84723@kernel.org>
References: <20231114223522.2110214-1-poros@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231114223522.2110214-1-poros@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1701087362;
 bh=s9rET20v/rSXQlRujYuxlhNNOKLKtQvmV96idnskVkA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rU/txeKTYQCMDfJtJqGVSHHioO6RTS2LrchPi7WT3rvPBWAHUuDJf3DKcW4VIHhYN
 dmddKcScUVE1ysBY6T4/EegoY6QVaUd4getqOkOFqptv7xQB3Y9FWGq7bmAYHZK2P0
 QwcnsQJyJTNBYiDuT9UMXJvgz7au7lknobJ+36PsOSEdFQkSeIWvD1OfM7PLUwsJAZ
 jVhHvo3HpCvUA394KLioh4+I7eFaw5b1QfpEcz7jm9xEDrZXQ5f27wAhpfpJTNhSND
 BUPBNGaeS9pJej9O0uXq7tgKGRksK4vDZWP1Q/2ftgo3aSfbyU8igVRDXN7vyvpNAu
 RpQzyUXmmgiMQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=rU/txeKT
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next] iavf: use
 iavf_schedule_aq_request() helper
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
Cc: wojciech.drewek@intel.com, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Nov 14, 2023 at 11:35:22PM +0100, Petr Oros wrote:
> Use the iavf_schedule_aq_request() helper when we need to
> schedule a watchdog task immediately. No functional change.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: rebased on net-next

Reviewed-by: Simon Horman <horms@kernel.org>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
