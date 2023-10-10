Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C78E95A8F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Oct 2023 09:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 750D3408BC;
	Tue, 10 Oct 2023 09:59:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 750D3408BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696931995;
	bh=w/7nHog+38B3mEbCAM+yNSMspP44kI3FxHWnwFQ4wGk=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=MzTD2KJojfbrSuPFB26uOwLXjmJytU7eqs4g9Z6BVNPIMHwJmeb+c3YttHRWwdkG4
	 KssaFtucei9CdtGo/eAAuNlwt4s8HgPeyCWeHliLQt5BrUxLnd74+4z1wvDELLgMgB
	 SzcM1zUjBOPN2ckKwc5txU6YWwBcPeQVWi8Bbxs3fbOfG4JEA0zZWByuGUeOGSLXow
	 kcKTAi901X+REmcxdjQcFeMs4ga+ZKsxJWVtXd/mntfukJXP+4Micw0KSPIZnxNv+W
	 Bquf5QZ4FurVJeKrY94eMCEH8qxUQEySWfuAoHEtPQWea18d+GMFxnKkmkCCyDimpg
	 4mP/JwN6jy/Lg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TPEylO3vdnxW; Tue, 10 Oct 2023 09:59:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7EB5B40A93;
	Tue, 10 Oct 2023 09:59:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7EB5B40A93
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 9BD4D1BF20B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 09:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 396EC80F89
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 09:59:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 396EC80F89
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ch-9Ekwoqrgn for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Oct 2023 09:59:51 +0000 (UTC)
Received: from out-196.mta1.migadu.com (out-196.mta1.migadu.com
 [IPv6:2001:41d0:203:375::c4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E87B80EE0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 09:59:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E87B80EE0
Message-ID: <8b727f96-1dfd-4a93-9d10-e9bd3f8eebc9@linux.dev>
Date: Tue, 10 Oct 2023 10:59:37 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org
References: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1696931983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLTR3Fa5NU1FJ0mPUCV17BXWlC/RQ59d9nTce1fx2KM=;
 b=JMLc+Q+7l0vIDURftnwdjjdsJLixj3ifTOXqqF00ihEFQkN0d6E00eGp0nphAWelDmVVhN
 ZCkVlzM6xSa+le8V49PWChfPucXF2y+2ml/qxrTT93Zz0K8Dcb4aUf9F/l3Bu91JynHHnJ
 u2+5xXzRnNABRz9ez3owztBf3lljSeA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=JMLc+Q+7
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/5] dpll: add
 phase-offset and phase-adjust
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
Cc: jiri@resnulli.us, corbet@lwn.net, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 09/10/2023 23:26, Arkadiusz Kubalewski wrote:
> Improve monitoring and control over dpll devices.
> Allow user to receive measurement of phase difference between signals
> on pin and dpll (phase-offset).
> Allow user to receive and control adjustable value of pin's signal
> phase (phase-adjust).
> 
> v3->v4:
> - do not increase do version of uAPI header as it is not needed (v3 did
>    not have this change)
> - fix spelling around commit messages, argument descriptions and docs
> - add missing extack errors on failure set callbacks for pin phase
>    adjust and frequency
> - remove ice check if value is already set, now redundant as checked in
>    the dpll subsystem
> 
> v2->v3:
> - do not increase do version of uAPI header as it is not needed
> 
> v1->v2:
> - improve handling for error case of requesting the phase adjust set
> - align handling for error case of frequency set request with the
> approach introduced for phase adjust
> 
> 
> Arkadiusz Kubalewski (5):
>    dpll: docs: add support for pin signal phase offset/adjust
>    dpll: spec: add support for pin-dpll signal phase offset/adjust
>    dpll: netlink/core: add support for pin-dpll signal phase
>      offset/adjust
>    ice: dpll: implement phase related callbacks
>    dpll: netlink/core: change pin frequency set behavior
> 
>   Documentation/driver-api/dpll.rst         |  53 +++++-
>   Documentation/netlink/specs/dpll.yaml     |  31 +++
>   drivers/dpll/dpll_netlink.c               | 188 +++++++++++++++++-
>   drivers/dpll/dpll_nl.c                    |   8 +-
>   drivers/dpll/dpll_nl.h                    |   2 +-
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 220 +++++++++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_dpll.h |  10 +-
>   include/linux/dpll.h                      |  18 ++
>   include/uapi/linux/dpll.h                 |   6 +
>   9 files changed, 518 insertions(+), 18 deletions(-)
> 

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
