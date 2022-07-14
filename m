Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7B2C433EF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 14 Jul 2022 10:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C69128470B;
	Thu, 14 Jul 2022 10:30:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C69128470B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657794657;
	bh=5bc3tPpAkqJuXBdtloXYwaphpoPqnQrQCebrzSkodWs=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qNQLabHRCsNR6NjHruY24ccVeFZy172vVhnHID57uqUUZPLqHQMFYJbRKAsKLhoA8
	 pLsUkxAZNvvgWz8IrIcqWGrkMQNQ26pVncplKRDrc1PKphWf5zfO6Znq2sbUlOF36B
	 jB6RpSx/NYM7YDxbgGX1mS7MQ8ClsyF+lEjhTeaj82Agsozof3HuTEOsmX5fhoh1zF
	 aCrNCukrwczUW7f3OAC/JZlHyHk4zBkp/B9J2sDz4QgDiyQkaICKJ+rUUx+jBgcfJN
	 2zQRAa5qsM0Pl7CVqyO3Bf6H5wDD2+KB0Nuy6S+izh2jMOyvjnPB/DtkxMpft6Dlyt
	 lJFyHwuHO+s9A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rC7ivNAkvSbn; Thu, 14 Jul 2022 10:30:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2FD084717;
	Thu, 14 Jul 2022 10:30:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2FD084717
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 4F2DF1BF36F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Jul 2022 10:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2741961558
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Jul 2022 10:30:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2741961558
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4BK0GbB26aNo for <intel-wired-lan@lists.osuosl.org>;
 Thu, 14 Jul 2022 10:30:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 646516154D
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 646516154D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Jul 2022 10:30:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265263893"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; d="scan'208";a="265263893"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2022 03:30:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; d="scan'208";a="571021636"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.11.253])
 ([10.13.11.253])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2022 03:30:52 -0700
Message-ID: <017eee5d-9b39-6f72-8273-4ab9967ffab0@linux.intel.com>
Date: Thu, 14 Jul 2022 13:30:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Sasha Neftin <sasha.neftin@intel.com>, intel-wired-lan@lists.osuosl.org
References: <20220705041910.3849895-1-sasha.neftin@intel.com>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20220705041910.3849895-1-sasha.neftin@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657794654; x=1689330654;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=2dDHlxU+2VS/uXyYZ14gRwfDhN81jfTJ7Wz0y6m5rMs=;
 b=IKqTel5dyqPhe0wyucyejIR1Az0tcYIAul51dNKYmZjJ1a4bjQh8vCGT
 stc4/wWXjCUCFj0MVNjKTScRCqJfkoQmkIlbHY4vsFYVozrXWuWU6+cAf
 MMYhqdO5Iam87fpE9q4QMESgSmfjJo0v9socNzlcdClNdM1JZyVfyMp79
 IbmaWPw3xkvMwY1ZA9gv/Vo98sbnUOLnC3Iz8aeoaPVwa2NDw8dO/KsNJ
 nZjiMIDzL5e944JI2dZM4Q/y7TCpwyTOJBDYeOWuf99LoINLkLto1kmL1
 WeWferlwsQhTLAkBg9YW62UQaMD1FrVO7mcvI5Rrg/1p/JwMJaYFwXNNV
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IKqTel5d
Subject: Re: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove MSI-X PBA Clear
 register
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 7/5/2022 07:19, Sasha Neftin wrote:
> MSI-X PBA Clear register is not used. This patch comes to tidy up the
> driver code.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_regs.h | 3 ---
>   1 file changed, 3 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
