Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0E5C61D97
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Nov 2023 11:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5719C61506;
	Fri, 24 Nov 2023 11:00:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5719C61506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700823607;
	bh=ESmD8insANfmRU1OPrMbkB8S04BDKdhQLW0wOzF9nHo=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=e1D+IwnOFD1ASrTjoH+1qWDGXO8WX6Rx3Zt0wboBRWhCUsgAvHEkeRGnxYW9OGDQW
	 eZxHtd77561FlEiaiPkIqRXz5CLKQLnypbxCuZjcMlDsnUFaNhuyPbr4bi30iPVO3l
	 RsyTbqWmYJjE9dbMqnqqcqh9xDohjW9EVtdrtgpKQkoLBaQvKytV9Wb8XGh1iHL/H5
	 LMw/2GP5+4p5HV4qxRgL1Fz/ncigRly7+AAaKjep3NsrjO5mGwULB+cxsEvBP9gxOv
	 Zd2osY4Cu+D1KwdMFzEZMOyP1PBwP7Qn8V/DBmRGNwOzgcb1uIka1Mhf+hsahq5xmP
	 LPl1JsKGts4uA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 33wMGRe3jKRj; Fri, 24 Nov 2023 11:00:06 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AE4D61512;
	Fri, 24 Nov 2023 11:00:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AE4D61512
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 8B0CF1BF83C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FBB061508
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FBB061508
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sl5yEP60hnwW for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Nov 2023 11:00:02 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7425C60B0B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7425C60B0B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id EA4DFCE27F6;
 Fri, 24 Nov 2023 10:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D862C433C7;
 Fri, 24 Nov 2023 10:59:57 +0000 (UTC)
Date: Fri, 24 Nov 2023 10:59:55 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20231124105955.GC50352@kernel.org>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-4-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121211921.19834-4-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1700823599;
 bh=cezKeh7SdRtECU2OH5eZ7assfFSS+2PhuyPdiQNTe2w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hvqhBloi1w0AegPcQTeJ1DGNy4e0GSGTalSqBSAabtFSFyXQfQBhFNxnXUxCtv8iU
 NKAhtuQ+dbBhS/pR6gfNEOxNogHZFA5EHGLWBrW746+8yuyF8QRgRo9e0ClYBWs+Ce
 vjsQVPbtGrfPXfpzxZpGflb4zNH2YJXPrJV47nWtJfWwtNRE7HnFplQ9Cv3Gvdvtq7
 /o9/uuWSklZz+vIWntiykJtSweTbjQv/JYqG+aZNAvsoqlFklH1R/vEK3ZQBayUQKe
 QcaHZ8kQEiOooor8BwFj71lURDRnch76kM5k/+sWSHRabsPX5cjbfVlBAhV3keRs4T
 pb53uAmQ6Qu3Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hvqhBloi
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 03/13] intel: legacy:
 field prep conversion
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

On Tue, Nov 21, 2023 at 01:19:11PM -0800, Jesse Brandeburg wrote:
> Refactor several older Intel drivers to use FIELD_PREP(), which reduces
> lines of code and adds clarity of intent.
> 
> This code was generated by the following coccinelle/spatch script and
> then manually repaired.
> 
> @prep@
> constant shift,mask;
> type T;
> expression a;
> @@
> -(((T)(a) << shift) & mask)
> +FIELD_PREP(mask, a)
> 
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
