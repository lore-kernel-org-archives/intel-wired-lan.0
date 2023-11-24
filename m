Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BFBC61D97
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Nov 2023 11:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86DCC614FF;
	Fri, 24 Nov 2023 11:01:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86DCC614FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700823716;
	bh=5VGPZjnK/IYKk13XFKSL6RTFbklaguh7lKFoYC/5EYM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=4j+x7gWZHePp/iFbFwisOhkntheBoho3jzlM2U/YTyEgD0WfIapP+t5i03rHu+BUm
	 D7YlXFuBhwC6KlxqkJev3Nwd30C8vAV1iMO5sfL5LPsQlJwTYOn/5Z8yRwg78pKyVA
	 TfvUtjN7TgQo7eqFqEDjVU7lV0rZzmVYjcM/F7eWYpaEMWQhqPRwnF/e/pP7y/fwyf
	 4x5aZs5dyc/klDostp9VkxLK31OROOPhVn5FevD94S9Fy+z1Kpo9HjnT2MJybgM5WF
	 +Yve/tSZj98nqjTGjiTh/MzRu9jT8qEnkCSizsrlAV3K6lNH+6gHlhCcUyiJaM7gzF
	 pXJiIK6UHZxdA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DMp8ITvpBe45; Fri, 24 Nov 2023 11:01:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id A79D661502;
	Fri, 24 Nov 2023 11:01:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A79D661502
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id CD6C11BF83C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6F99821E1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6F99821E1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nGn_Um3p5Rcr for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Nov 2023 11:01:53 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 159B3821D6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 159B3821D6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5893C62136;
 Fri, 24 Nov 2023 11:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ECFC433C7;
 Fri, 24 Nov 2023 11:01:50 +0000 (UTC)
Date: Fri, 24 Nov 2023 11:01:48 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20231124110148.GJ50352@kernel.org>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-11-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121211921.19834-11-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1700823712;
 bh=pAzbhg6Np4McrtVqaHbOiqH3nSzqJr4A1M4dWs8QWcs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=trs3RDmwYZZRuqn9alxC+f9Ro3w4tXNH3I5yaB/hWOpxDdFOGFFi0/e+C18Nc0aUp
 PEWq8uP5GOmDXqKiU5aZjBQGH2hzMAKg4G+CNj4sIOAQOQmUymrMNKSsBHCWAn5lUe
 qEj0Eer+pTBlHvaXXzTtz7pAoR7IhpjbjDDrS5POJZD6s9sVVwB/aLgd5B8GKdwuFo
 03m65Eon0qFm5/gZACnlBxWCLLN5Tq0yWYb/EFAbnqrc3y35XyL9VW/pcRyqjkYXpD
 9fpMXuxVKtFSUsVvPZlF8nNxgse7TkUTY+AVKgE34CU7KtzyFeKQWi2OFQqnp4+ofm
 2jkPMvmX8A3Kg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=trs3RDmw
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 10/13] igc: field get
 conversion
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

On Tue, Nov 21, 2023 at 01:19:18PM -0800, Jesse Brandeburg wrote:
> Refactor the igc driver to use FIELD_GET() for mask and shift reads,
> which reduces lines of code and adds clarity of intent.
> 
> This code was generated by the following coccinelle/spatch script and
> then manually repaired in a later patch.
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
