Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9CBC001DF
	for <intel-wired-lan@archiver.kernel.org>; Tue,  1 Aug 2023 09:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A78240600;
	Tue,  1 Aug 2023 09:57:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A78240600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690883850;
	bh=fHhzdwhOaj9FPXEiSlm0/YQimffENOLx4mzqltZQcsM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ooVP9gmdzIQYhrz6KvZPZmsXN/5XMh0CFofVuKZvtm2sMuhj1VfaKFCyPml+uFi3X
	 mk67CnkfN3nAUasKRjD7co+xgr3Bbmp6oGbLhFljfLoj+U6v862x8F2fiIZ6nrdH/q
	 Q75hjBoE26R9s5mqse2vWlYKsiLelr6Y60XrdoJKiGl0/PhS/IFq5lV57Aj4myWD9G
	 yxlQepV5J1nnPiK61AnC2klzYbJVCGO/r6A3dUvTa5/ZgBFW1jfSUjsEt+3nhykzXw
	 UaTnuuW6D5nT6AEVtG9tAzCAJMeVlNziyqT0P5WLehGoY0bs+hYfqrrdRJyCUzLYId
	 2WoiOq/DHBtYA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KmTve4AgeUve; Tue,  1 Aug 2023 09:57:29 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFA5740971;
	Tue,  1 Aug 2023 09:57:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFA5740971
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id BB48F1BF2EC
 for <intel-wired-lan@osuosl.org>; Tue,  1 Aug 2023 09:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20A4D61063
 for <intel-wired-lan@osuosl.org>; Tue,  1 Aug 2023 09:57:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20A4D61063
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hAsURz1ROw6E for <intel-wired-lan@osuosl.org>;
 Tue,  1 Aug 2023 09:57:08 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D922560F1E
 for <intel-wired-lan@osuosl.org>; Tue,  1 Aug 2023 09:57:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D922560F1E
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7641E614F4;
 Tue,  1 Aug 2023 09:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9DCC433C7;
 Tue,  1 Aug 2023 09:57:03 +0000 (UTC)
Date: Tue, 1 Aug 2023 11:57:01 +0200
From: Simon Horman <horms@kernel.org>
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Message-ID: <ZMjW7XeEqpoHhQFd@kernel.org>
References: <20230801011518.25370-1-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230801011518.25370-1-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1690883825;
 bh=9FY6QFn/zgOA97cCVuiCWjqBomFGV5Q4vBQBuoSs3mg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sMe2ZQEdBvjFlnAwHkLLGPKi3ZBSRU10BB+lfHVrEbf6OO2e4c0X+djp/lunrENJN
 wwgxlQ8gjlJbK8++ppgrjenkdF6MnPFV9usWQ94YwfYlACfHcI5jieQkSTuzizKkX1
 Io+4FS2JplLvqGIXUu3uacYyzcOg8+w6yBHc2hguS7oW+WaqMkQmsco5yYSMJdszMo
 nnGQS9hEo6H9wbhhbxPSY+jpGYfKv/IqqvRJNZkFEspjETPYH7gDzkI71aGSa60dMM
 lMd7e/L4XLsU107XLb/2b4KJkhkbKPSV9gEAX4k0d7qJpyW8CAoWD+l5qfWKSvvsui
 fvfgm0viIFtug==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=sMe2ZQEd
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3 0/2] Enhance the tx-usecs
 coalesce setting implementation
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
Cc: intel-wired-lan@osuosl.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Aug 01, 2023 at 09:15:16AM +0800, Muhammad Husaini Zulkifli wrote:
> The current tx-usecs coalesce setting implementation in the driver code is
> improved by this patch series. The implementation of the current driver
> code may have previously been a copy of the legacy code i210.
> 
> Patch 1:
> Allow the user to see the tx-usecs colease setting's current value when
> using the ethtool command. The previous value was 0.
> 
> Patch 2:
> Give the user the ability to modify the tx-usecs colease setting's value.
> Previously, it was restricted to rx-usecs.
> 
> V2 -> V3:
> - Refactor the code, as Simon suggested, to make it more readable.
> 
> V1 -> V2:
> - Split the patch file into two, like Anthony suggested.

Thanks for the refactoring.

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
