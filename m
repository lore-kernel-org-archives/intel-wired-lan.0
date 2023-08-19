Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82625EE49A5
	for <intel-wired-lan@archiver.kernel.org>; Sat, 19 Aug 2023 11:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED00083BF3;
	Sat, 19 Aug 2023 11:46:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED00083BF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692445617;
	bh=SSLTtLwMgBUdLZdNAGotRhWli/w7V0cEaAj4J826RZg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=6FiKWWilqHtbgZ+qXtw0Qo9pDgeRIK64/qyNyxuWvvq0Oy1elYD4WgNI0PXlPQ/0w
	 oL26Ao5RvjPcgTGZ4eFRsP2Scwsm8fIoR/dOemtobN5P41mN0p2vfe6D85R4cm9Dmc
	 jfr0/HTYP31wgr3OFsKeHUgc6HxR4zxAd3cI7zYabGTz0ecBPjrcddorrRg9u4qba3
	 3z9ClsxYA9grwBy+7FiCWqpVM0cnoed8k54PaQRB7zTFpgU/Rs+zf9bFrwPBT5lFTQ
	 IFPLNl1GAPMusSDMOwLdg2brWDMSsOaGV6370k74pttzIJAUBxwISx1jzmqZN47nBg
	 /ABq5SmYQes/Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2siu3X2I9W0u; Sat, 19 Aug 2023 11:46:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D162A83BF4;
	Sat, 19 Aug 2023 11:46:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D162A83BF4
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id E5A8D1BF2BF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Aug 2023 11:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B576683BF4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Aug 2023 11:46:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B576683BF4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RvNWs24Gj_Bd for <intel-wired-lan@lists.osuosl.org>;
 Sat, 19 Aug 2023 11:46:52 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 938B483BF3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Aug 2023 11:46:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 938B483BF3
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 702AB60CEE;
 Sat, 19 Aug 2023 11:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DFBC433C8;
 Sat, 19 Aug 2023 11:46:50 +0000 (UTC)
Date: Sat, 19 Aug 2023 14:46:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20230819114646.GO22185@unreal>
References: <20230818105929.544072-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230818105929.544072-1-przemyslaw.kitszel@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692445610;
 bh=ktSR7J8kTyZkpGc5dJeshn+lv17xi4wH7+hNWwwXTrk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WVXFD22oipbPgfc2UZMjlLE88kQ4DeEjVayVcvGUIdSAVcH/EGemYxj5uvrT3ICi+
 ugGwf6y6Tz1sZw5ZdMTtwdnOXoVKYywqwF/Kf86fiYwLD1O3bJ4zSkz32xhqV9gNu2
 SYm4fZ9MFSO/oEMhDqh2s+I6x1fXpJ3birMPUo79xbEOy2smHrsbNouRFRrx+5i4ph
 vgubo9He5YNGTXH6U6KWfrvS3tQtyVXHWcFz5AlOi81hzIzHEmVPM837mfGwidt7JO
 tp7SASQeNbgiHRfoq0pPym9HY0lmfcJfJNYu0OjlFG3qW/d+gv+QwG2rCGw8Gr/jln
 iqbD8s1C0XYkg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=WVXFD22o
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: remove unused
 ice_flow_entry fields
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Aug 18, 2023 at 06:59:29AM -0400, Przemek Kitszel wrote:
> Remove ::entry and ::entry_sz fields of &ice_flow_entry,
> as they were never set.
> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c | 5 +----
>  drivers/net/ethernet/intel/ice/ice_flow.h | 3 ---
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
