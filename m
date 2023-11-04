Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73125C4332F
	for <intel-wired-lan@archiver.kernel.org>; Sat,  4 Nov 2023 15:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 28BD540A54;
	Sat,  4 Nov 2023 15:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28BD540A54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1699112032;
	bh=QzG9JHxorCZhrAXyptSuTdYDCCwvecTpLVIJolMu2R4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=fVbsYuPccSPgGqlCE34OLhPtmWUEtLBWuF0IFhgSmDxuSkNVrmUkD4PLOX4ooFzjv
	 t1DQO9rr9ezXnmMD099IP+YTfjhzcUV5ZBFLWuAVSXNAkyu1qCZsQMkk/sLlSV65Bg
	 dR+PLWW20o6G2r6XpK10KJnbDwIfREDPoUJSAnWk5bs8S2VrAZeojMejQUjeh/myfq
	 AUSwnILcVi1uMtDjtuOTi6UIvHcaale5Ds0bjhgZeYAF0IelbpfZ5laQq+MRPVwTzA
	 +234Vjj43Xw+qTdDfR+d+/qYQShKxj26N5zEdO6zDDyqqpbh1MWha59CEdo3DmIYVX
	 gUpZI4uwKhvJw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5SlOhP5HTfJF; Sat,  4 Nov 2023 15:33:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 718A540A60;
	Sat,  4 Nov 2023 15:33:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 718A540A60
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 99F231BF2AB
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 15:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71E2F41E81
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 15:33:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 71E2F41E81
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NPRs0lLkBQzd for <intel-wired-lan@lists.osuosl.org>;
 Sat,  4 Nov 2023 15:33:47 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DF1E41E78
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 15:33:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DF1E41E78
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 66C5360472;
 Sat,  4 Nov 2023 15:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCF9C433C7;
 Sat,  4 Nov 2023 15:33:37 +0000 (UTC)
Date: Sat, 4 Nov 2023 11:33:31 -0400
From: Simon Horman <horms@kernel.org>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Message-ID: <20231104153331.GJ891380@kernel.org>
References: <20231102155149.2574209-1-pawel.chmielewski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231102155149.2574209-1-pawel.chmielewski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1699112026;
 bh=CneH2QCNOFwdP3vrdBROQilhh3jKjpF9b3jeDVy9MwM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SGUWWvSCp6S+YsbOpxdxMXZS7IG5+uckjzR6vI86t8b1AimcNoEhQ1wPFN577zfZW
 9ht3nhJFpqZlqORI5uTTqfSahmBazKbq1VEO5B8ERzj2D/kfZv2wJapWPXPLtWitIm
 CX3E5XXgGuBFUcjYelg6j7Qy+PGd4OnsE4QEzECVq13S6dw5NDC2/dAnBqmIGz73f1
 kYwz7N4rAXTIxn2LoP1H25I1UasXFMVIeLi7LEO/dino0YkJpifEUr4kj96r5zUEa0
 zZQv6rM/AGG01x3M4m7llmeLkLN4dno1sW26ESLibYUtCP9l+W1Fgnf4GVDmsiFv+5
 Rx/TsI2zzkZdg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=SGUWWvSC
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: Reset VF on Tx MDD
 event
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
Cc: pmenzel@molgen.mpg.de, netdev@vger.kernel.org, lukasz.czapnik@intel.com,
 intel-wired-lan@lists.osuosl.org, Liang-Min Wang <liang-min.wang@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Nov 02, 2023 at 04:51:49PM +0100, Pawel Chmielewski wrote:
> From: Liang-Min Wang <liang-min.wang@intel.com>
> 
> In cases when VF sends malformed packets that are classified as malicious,
> sometimes it causes Tx queue to freeze. This frozen queue can be stuck
> for several minutes being unusable. This behavior can be reproduced with
> DPDK application, testpmd.
> 
> When Malicious Driver Detection event occurs, perform graceful VF reset
> to quickly bring VF back to operational state. Add a log message to
> notify about the cause of the reset.
> 
> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
