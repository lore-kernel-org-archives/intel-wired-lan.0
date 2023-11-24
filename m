Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896E3C61DF4
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Nov 2023 11:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B59F60B0B;
	Fri, 24 Nov 2023 11:01:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B59F60B0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700823699;
	bh=Eveofa5DqAvNQ4NuYV43u+VJ+gAwq7MD90jyi3zVZ+k=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=VfA3IFuj0AbVlUj4+S+aJ4G7wxMPsuxU6ZDBM/ze2UiCGl9Pz3GvlqzKrltG6wvX/
	 kdjVLKKzUU9WHMe77uyJt0vFCXFlU2f501CBpCG4tKY6AAJbeO1UkxvW0fMr1ijpJW
	 DG8qHL4mssaQx/Upo1Tdbd3/YnyvXpNSS4oyuMC+qTHVsICbDp8oyaanMOJj2Cm+3V
	 ziRSF2xBD3EruSVdi2z/jNQmA6UXsI0vALkRa/o6CUQ7lV0YNkJri/Wi/oiJhyNEI5
	 HwmJtv4zjGu1f/aTTOIzY1vmu9E9mYhEGZVc/pu+M5s/YFFvZoAF/wALRGAuczQew3
	 pbePgo786D29g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gj2rAGNvdrTH; Fri, 24 Nov 2023 11:01:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EAC7614FF;
	Fri, 24 Nov 2023 11:01:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5EAC7614FF
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 9841F1BF83C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F623614FF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:01:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F623614FF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ad61hLC1jo1D for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Nov 2023 11:01:36 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1AB260B0B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:01:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1AB260B0B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 2D722B81640;
 Fri, 24 Nov 2023 11:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62420C433C7;
 Fri, 24 Nov 2023 11:01:32 +0000 (UTC)
Date: Fri, 24 Nov 2023 11:01:30 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20231124110130.GI50352@kernel.org>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-10-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121211921.19834-10-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1700823693;
 bh=Jx1f6wkJcLzm1Hy547MP6/LLs7m6OTz+JG66A3EunOI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gEpnvQT1xf4GnynstqjjW5ERsQ4eM9lMvpMZCRFQpGkaxv8rHOA8RkaHx1QHZOAJO
 Az+Q4r4bZbFqBH0QBE+bX+SpEu4F2u0PFtxkpHPlveCa7zKH38eH7Tgc328F3BNbMQ
 xg/c3XrmFoLgQgRHrS0A96DqVVcW9u7QKq1a4nL3vvKFZ3w/3TxiKEWb3kNdnY12Hf
 wpKugQQ3jPl4zs9Kjmcwlz7gJ5Y2+3nwynPZdtY79WjftiL18vQefaQN89DtSAMAjz
 HO0YY0OjOBoTYPQbFdXdLs8SHKaZA9x/N/aVxL0qXMEbVu+urwKDSNFSMhRzE1p+3z
 tZ1AT5jFE/fwA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=gEpnvQT1
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 09/13] intel: legacy:
 field get conversion
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
Cc: Julia Lawall <Julia.Lawall@inria.fr>, netdev@vger.kernel.org,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Nov 21, 2023 at 01:19:17PM -0800, Jesse Brandeburg wrote:
> Refactor several older Intel drivers to use FIELD_GET(), which reduces
> lines of code and adds clarity of intent.
> 
> This code was generated by the following coccinelle/spatch script and
> then manually repaired.
> 
> @get@
> constant shift,mask;
> expression a;
> @@
> -((a & mask) >> shift)
> +FIELD_GET(mask, a)
> 
> and applied via:
> spatch --sp-file field_prep.cocci --in-place --dir \
>  drivers/net/ethernet/intel/
> 
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
