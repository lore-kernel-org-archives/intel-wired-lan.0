Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D26C4332F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Nov 2023 19:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AE1E40185;
	Wed,  8 Nov 2023 19:00:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AE1E40185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1699470002;
	bh=RsTTj85b6EGM/ouQGNjFkmwu52yEt2uYoQ5KuqtPOV4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Y0L7KYkcux0Ujjjsa0GLCATePaTM4DNPOSHnB2sWFrUhpcp5RdVKO/SS9+oQGrdyq
	 Av5KOT+wnw0L8YD2mg/UNSlFwaGandJPPE0DhvD3GiWXc4ZUTz8L1SDh9yvJhlCdN/
	 b0ndoXpUWZrdaB8j41r1ec4Duo5LHUrIQwTQnt9odKZXAmLx4enG6ouB7/QyoqcfMD
	 OzIdRAAZvVL8Wz357QJOBI7q7XUyGop9gRw63Pw6pXOMqfgBkaP2HrzcPedrlsPjG0
	 sEX7IZKieMdEN4+Y0/a2qxliU+b35TKmHmgcmr/D71id9dxezOXHfGiCRTtbQ46LFH
	 plqzVzl/ReWxg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FUNStDskFFpH; Wed,  8 Nov 2023 19:00:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4719A401BB;
	Wed,  8 Nov 2023 19:00:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4719A401BB
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id A94231BF215
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Nov 2023 18:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FC386077D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Nov 2023 18:59:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FC386077D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xnayvZ_MrF-0 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Nov 2023 18:59:58 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 466FF60761
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Nov 2023 18:59:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 466FF60761
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 1CDC1B81DAC;
 Wed,  8 Nov 2023 18:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAB0C433C7;
 Wed,  8 Nov 2023 18:59:52 +0000 (UTC)
Date: Wed, 8 Nov 2023 13:59:51 -0500
From: Simon Horman <horms@kernel.org>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Message-ID: <20231108185951.GE173253@kernel.org>
References: <20231107173227.862417-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231107173227.862417-1-paul.greenwalt@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1699469994;
 bh=v3G0suFuSmu2T8ydyAp7Qupj+ZJkhevbQT+X0L5Plq4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BMxkl6rjHtARSgLUKCfaKY7dL8FOPzGBmz08vbvy2tXotYk/YTjDsRtZWpXfV0B7o
 kmlormRXApzecYV5LVzRXTiuM3osLP7pqrhFrb3LCcGO+zseyLSVhWH3eKx4ady4nO
 pgpuJS5amOoZLtxw5e8eCW/rdGIOW6pBtTVzlWsGaEDfFuKPQnEQ+lhbvxyyP5nHUq
 ZA54kJByRrer55129aQMhwDRSTI2bo34d2eH+wFgaWsYYA3Yt2idFrajqrXAcm+w0S
 v64wEeUaVyPZack2Rv6yRhoBc+Q+rtdUR+KrvoAbuFuFo8ELesymjoYA/tWlwBdWAc
 v8IgVmMC82YYA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=BMxkl6rj
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] ice: fix DDP package
 download for packages without signature segment
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
Cc: Dan Nowlin <dan.nowlin@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, Jacob Keller <jacob.e.keller@intel.com>,
 anthony.l.nguyen@intel.com, kuba@kernel.org,
 Wojciech Drewek <wojciech.drewek@intel.com>, intel-wired-lan@lists.osuosl.org,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Nov 07, 2023 at 12:32:27PM -0500, Paul Greenwalt wrote:
> From: Dan Nowlin <dan.nowlin@intel.com>
> 
> Commit 3cbdb0343022 ("ice: Add support for E830 DDP package segment")
> incorrectly removed support for package download for packages without a
> signature segment. These packages include the signature buffer inline
> in the configurations buffers, and not in a signature segment.
> 
> Fix package download by providing download support for both packages
> with (ice_download_pkg_with_sig_seg()) and without signature segment
> (ice_download_pkg_without_sig_seg()).
> 
> Fixes: 3cbdb0343022 ("ice: Add support for E830 DDP package segment")
> Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Closes: https://lore.kernel.org/netdev/ZUT50a94kk2pMGKb@boxer/
> Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
