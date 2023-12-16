Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3859FC38147
	for <intel-wired-lan@archiver.kernel.org>; Sat, 16 Dec 2023 10:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE53C83EE3;
	Sat, 16 Dec 2023 10:05:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE53C83EE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702721107;
	bh=DZ35c1lZvFF7BQXpp81RrEcZgCiz93SJ0HVKFk23kt8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BQvitRN3dQYSUOd31fuui7qnLcTR3LCFMM2fyGI18uAIL5J+1EY+qt9E9Jk/sdNMg
	 O9u9c80cnLLTitR7IMj++aHEskUYg3BHnxVTW+Pn4OUCxLfWSry/MkLV+9L8jw53m0
	 BkgR1snlJD3NkDcGLde2P0VqFeuTTOA0OCm+PO4CZ7rbsKqB1t4iCY/1P9nAJflOFt
	 avma/OTIc+bEvPzPsHm2KnsmAwagaJ/nBt2xpoVris8eMPvD1oNGkAGJ3PKf04kzjc
	 7SDL260IYvGKg30e4koeTeJdVkmUYI2V/TwaN1ZwcxTNJMsweH1DGot7A5OvgiSbfu
	 NKNVHwuDIr2og==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Y0vAj8fKauI; Sat, 16 Dec 2023 10:05:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02B6E83EE7;
	Sat, 16 Dec 2023 10:05:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02B6E83EE7
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C1BD21BF34F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 16 Dec 2023 10:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98A414168A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 16 Dec 2023 10:05:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98A414168A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FqRsZhKB-FFu for <intel-wired-lan@lists.osuosl.org>;
 Sat, 16 Dec 2023 10:05:05 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33A83415A7
 for <intel-wired-lan@lists.osuosl.org>; Sat, 16 Dec 2023 10:05:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33A83415A7
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 29567CE08C1;
 Sat, 16 Dec 2023 10:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B907C433C8;
 Sat, 16 Dec 2023 10:04:11 +0000 (UTC)
Date: Sat, 16 Dec 2023 10:04:09 +0000
From: Simon Horman <horms@kernel.org>
To: Lukasz Plachno <lukasz.plachno@intel.com>
Message-ID: <20231216100409.GM6288@kernel.org>
References: <20231214043449.15835-1-lukasz.plachno@intel.com>
 <20231214043449.15835-2-lukasz.plachno@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231214043449.15835-2-lukasz.plachno@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702721052;
 bh=60CNHiI28W+RPdvZLBBxAVevQrzUhn11pjItGrKDp6k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hv8quTZ9Nnxady0pn3xYyJUwJY8+DY0ZXofAiSRdf6TTM5Rk5m7NRjprDuzINonWW
 F+1knSCQKlofNMTiAmimpUbdEQK2TqITVsvCiBUAH7vzHp3q/dDfoiWgy6OiSQ4t5T
 bmg59zMUj+KbPQP46aOu17ctpUzYhyOWSeCiO/eLmkKqnxUcY0DMnwhpt0sx1XG1uC
 38DxuW2XA3RhIF4aNNedqqQ3ffNb+ez+r5f06iI02tsAgaWES5ETOTdytHrReqz2dZ
 yZ2dtezdAuyJYWrq4wdhiP7yOqTHg3v0c/oAGbYlGMzc+3l35DosdIsB1QZhprT8cp
 WUMx8JNfmPF+g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hv8quTZ9
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 1/2] ice: Remove
 unnecessary argument from ice_fdir_comp_rules()
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
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Dec 14, 2023 at 05:34:48AM +0100, Lukasz Plachno wrote:
> Passing v6 argument is unnecessary as flow_type is still
> analyzed inside the function.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>

Thanks, this is a nice clean up.

Reviewed-by: Simon Horman <horms@kernel.org>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
