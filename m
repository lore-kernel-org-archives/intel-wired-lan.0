Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0C1CE79D1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 20 Sep 2023 13:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 31DDC4181F;
	Wed, 20 Sep 2023 13:44:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31DDC4181F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1695217460;
	bh=mfhc1KhgHSaN6HPvuUD/OPNtRORdOGUiMicduQu7p0Q=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QNTiS1LtVaktvaaBUZeX8uqjcGfUfkFT/+fSOoVQ85Rcn17W3Cfq7vzH4KT/bMnGq
	 kla0Lt/SiMcgOWpOSJpvxuYlkD0hhKbGJ7P5jCwVMSDrjZ0ENpQ0MypKEQ4r9Htv72
	 1eulY5sudiJ3AxHmV1iLDBwwfqqScHKcjv+r/VqU98zUlynLr5SCjN+Fg2EucWPq3w
	 JY9QOip+UyMxQ3PBtMZ/P9otwSBeDAzaMm7VmTbES0Phu1k9GApMWnpksrc86oJYd2
	 R7mbNBdxgV00Q8YlO3oaG2mLCiBYXsdf6UadP32WTUHyxW7CaSyYqnMuLx22OnbEK4
	 YLJ9hEjyEmYPQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ypiILdN7iDq4; Wed, 20 Sep 2023 13:44:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F08A41821;
	Wed, 20 Sep 2023 13:44:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F08A41821
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id E5E511BF400
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Sep 2023 13:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B555961310
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Sep 2023 13:44:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B555961310
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ImPVw9VI56Al for <intel-wired-lan@lists.osuosl.org>;
 Wed, 20 Sep 2023 13:44:14 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B00DD61324
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 Sep 2023 13:44:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B00DD61324
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 90760B81CC0;
 Wed, 20 Sep 2023 13:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975FFC433C7;
 Wed, 20 Sep 2023 13:44:07 +0000 (UTC)
Date: Wed, 20 Sep 2023 14:44:03 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Message-ID: <20230920134403.GH224399@kernel.org>
References: <20230915153518.464595-2-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230915153518.464595-2-marcin.szycik@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1695217450;
 bh=x8NpMIW8Pp/mAHMBkzDCo1hL2KYMDL8gMyPggszSqTs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lTDilutzuNQ8Cq9DRivU0cu4sIvWpFMc+2nDJJACtK9H6FIX6jVv39897fjrBLVlO
 e4H8Lew4ran5F230aLrpeRk8tbsD64DPBWeuZc8TeVoAtYwCm3SiyOKNT8/Xrt6ZUj
 r17SDIDOeAiEVk/6yd0cfdcrmxDFf7kzlEbdm6gYTls5mytpU5FaCeAVwyq7pWRc7n
 siPNdJkHtBQ8mq4JKIUJLsBsWiGRBhcdVsDAXWUh9caAe5seJCG2iypF3mcvcWj9pZ
 bIpYhBT7qbV9fvRMCDv3QMQ2QAb0WoSphsX03ZkQteozaf6b6cjQ2y07sncP141VuV
 8H6xCaagoIINA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=lTDilutz
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: block default rule
 setting on LAG interface
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, david.m.ertman@intel.com,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Sep 15, 2023 at 05:35:19PM +0200, Marcin Szycik wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> When one of the LAG interfaces is in switchdev mode, setting default rule
> can't be done.
> 
> The interface on which switchdev is running has ice_set_rx_mode() blocked
> to avoid default rule adding (and other rules). The other interfaces
> (without switchdev running but connected via bond with interface that
> runs switchdev) can't follow the same scheme, because rx filtering needs
> to be disabled when failover happens. Notification for bridge to set
> promisc mode seems like good place to do that.
> 
> Fixes: bb52f42acef6 ("ice: Add driver support for firmware changes for LAG")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
