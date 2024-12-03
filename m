Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0F4D7833F
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Dec 2024 10:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C793081239;
	Tue,  3 Dec 2024 10:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsDjWmmtZgyU; Tue,  3 Dec 2024 10:05:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D817281327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1733220322;
	bh=w+eDx+VgoEQ3QiNLY+qda7zHiuY7NeamJ2T4xW8wJUA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TdMsjLT/LzHdgPiJK3FVzIFCkTjNah8isUGykTEf5+T/B52HTiGitpT2y8k5WfPUU
	 hHPO+iCqsd42h8izbBjohDbS2Fzqry9yDzbitDx8MST5nSStozNcpWnAUV7x/+On6A
	 /lbZhAaak4xgYNb7UisLuIon2S07GN58gAeq06MEkcx8zq4ZSxZQb6witC7yStRKHD
	 o6m7KTAZgT7Tjtdw1hOIs0NIv5BlvcdMmxjpXQqM2v42szQZwxkimvGSK3kzQusuId
	 a3Lx9L7rq2lvY+7+nG3Y4ZERUoLdM3RK8OrvenHwFgYRQmyquEbMLxeGvVwcfX5CcA
	 VysVhyQm5FHpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D817281327;
	Tue,  3 Dec 2024 10:05:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E142860
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Dec 2024 10:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF1934011C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Dec 2024 10:05:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0ae1pW87Ajp for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Dec 2024 10:05:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9BC16400BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9BC16400BD
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BC16400BD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Dec 2024 10:05:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id DD2CDA40FFE;
 Tue,  3 Dec 2024 10:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E48C4CECF;
 Tue,  3 Dec 2024 10:05:17 +0000 (UTC)
Date: Tue, 3 Dec 2024 10:05:15 +0000
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20241203100515.GB9361@kernel.org>
References: <20241120075112.1662138-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120075112.1662138-1-arkadiusz.kubalewski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1733220318;
 bh=0dyAFi3mgH37ToqffYxIhXQZMaqsvfnhFo8NhpPxFTk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ck5YN/WqQdVO6zL80YUzgSdv6CxCAAhxn0MB0RySr3lWO6O2ho/MDJkdJOLj4R4FM
 20Qclz6EH2DnesIdRQmaAVyJlhAtuj+VneXnt8cN9jOjSDnU3avU6AnrQIfR5u94zb
 vTZIcZOYInJNRTxerimHqMufcdLFRug3v+GIuaCeA3spmEnzv1gBD9xMd6oPg1/3uJ
 vdLt+yYJl6R20ILeZKh9FMnPAiek2tSR9DBskVkJx3JqUYvBHjApFmwZGllgMnsuop
 jqQwjaSecQTbRkpE+FG5Lwt4J28etY9aUi9pKRcBk2+2vSOzPOgQB9UdFFrtQFPeDo
 9tFqT2MbOdsRg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ck5YN/Wq
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix max values for dpll
 pin phase adjust
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Nov 20, 2024 at 08:51:12AM +0100, Arkadiusz Kubalewski wrote:
> Mask admin command returned max phase adjust value for both input and
> output pins. Only 31 bits are relevant, last released data sheet wrongly
> points that 32 bits are valid - see [1] 3.2.6.4.1 Get CCU Capabilities
> Command for reference. Fix of the datasheet itself is in progress.
> 
> Fix the min/max assignment logic, previously the value was wrongly
> considered as negative value due to most significant bit being set.

Thanks Arkadiusz,

I understand the most-significant-bit issue and see that is addressed
through the use of ICE_AQC_GET_CGU_MAX_PHASE_ADJ. I also agree that this is
a fix.

But, although I like simplification afforded ice_dpll_phase_range_set()
I'm not convinced it is a part of the fix. Does the code behave correctly
without those changes? If so, I'm wondering if that part should be broken
out into a separate follow-up patch for iwl.

> 
> Example of previous broken behavior:
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
> --do pin-get --json '{"id":1}'| grep phase-adjust
>  'phase-adjust': 0,
>  'phase-adjust-max': 16723,
>  'phase-adjust-min': -16723,

I'm curious to know if the values for max and min above are inverted.
I.e. if, sude to the most-significant-bit issue they are:

  'phase-adjust-max': -16723,
  'phase-adjust-min': 16723,

> 
> Correct behavior with the fix:
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
> --do pin-get --json '{"id":1}'| grep phase-adjust
>  'phase-adjust': 0,
>  'phase-adjust-max': 2147466925,
>  'phase-adjust-min': -2147466925,
> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/613875?explicitVersion=true
> 
> Fixes: 90e1c90750d7 ("ice: dpll: implement phase related callbacks")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

...
