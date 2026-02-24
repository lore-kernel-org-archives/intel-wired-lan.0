Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E49F4BB8B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Feb 2026 21:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 026A2845BF;
	Tue, 24 Feb 2026 21:07:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5l8q2SEMuoWn; Tue, 24 Feb 2026 21:07:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 361F3845B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771967268;
	bh=fjF7NEN+dfezboUfv+Fi4YeidnyPLLtSFJ6fLbWx69Y=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dFkImbdxhKB8OAOdNO9oAWMdYncBGrS8L0JmQK6KNIqLBCH9TL5r9tjl6DzoGb7O3
	 TvTota3wola12Ix4pHwPqLZG1ZKsrcUzRF6wkSfY74/4reZjJ3jBo9VLef6EznlMYT
	 I2xdRAoMWGH4hx7tObXNkgyVyB2UBwWVzdXBFaEgVa3Cp+yEvlbU1O5uGWgDFOld0p
	 4wn7N5YSIC/gl2Lwz5eg7bMDVibVV81BfGSi0HDkP/hCSrAm9XtLQbt2J7DnE4ZGx4
	 z787dCKU2zlA+cwZbGI4ndNQ03jFW7pQi6d2hjDK5nIeHIm7aNb1dy42Cqs00DOpw6
	 i3/SQ8FXRUb6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 361F3845B6;
	Tue, 24 Feb 2026 21:07:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 62DB11B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4874642269
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKE8dqywE_o9 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Feb 2026 21:07:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=vinicius.gomes@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6E66142260
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E66142260
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E66142260
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:07:46 +0000 (UTC)
X-CSE-ConnectionGUID: W5aS0uKcQLGjZSlI8bIWwA==
X-CSE-MsgGUID: 1QwU/FDgQpuD3zaF9akJrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73175345"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; d="scan'208";a="73175345"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 13:07:45 -0800
X-CSE-ConnectionGUID: HjvEF+m1S/WtKYDGdB8YSw==
X-CSE-MsgGUID: YYb1drJ/Qd+8azGkruqmsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; d="scan'208";a="220529667"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1)
 ([10.88.27.144])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 13:07:46 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Richard Cochran
 <richardcochran@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
In-Reply-To: <20260224111044.3487873-2-mika.westerberg@linux.intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
 <20260224111044.3487873-2-mika.westerberg@linux.intel.com>
Date: Tue, 24 Feb 2026 13:07:45 -0800
Message-ID: <87tsv57sv2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771967266; x=1803503266;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=vKIBtaARH7PRWjwpjY6J96lNoDByzUY/geYAam/OTIw=;
 b=U5TXgwUvVnC7aRdxE5GKI4ejruICEXYFkQfKHUFDmKcWxS20YsmYcbnn
 YRCeeCJQ8jT0wxoTXszpY6xwX0wwQ7TKF1RzdGoequthLzbSe3wFhpniH
 610NEBnnxgzeJMsoAhb11ixGI1UetkRSGAQ77GnEcS/vn3/gOq+DSSl2Q
 +1lnMUKhLcI1jhZOzu5PB5b21CJnAH/SfuF0bhWSGXUoG9jQR6DXaR8+e
 uD+GqlyHdpfV9XEG4Hak9w3UYCNxyRY9cbTdqii+31k5AQuM06W88DUG0
 zIGNeTzuDdXVUB9D32G6QChjmcCeL9bLsJ+7b9Tof9lRdsYMpaB9Cb7WG
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U5TXgwUv
Subject: Re: [Intel-wired-lan] [PATCH 1/5] igc: Call netif_queue_set_napi()
 with rntl locked
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

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> When runtime resuming igc we get:
>
>   [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)
>
> Happens because commit 310ae9eb2617 ("net: designate queue -> napi
> linking as "ops protected"") added check for this. For this reason drop
> the special case for runtime PM from __igc_resume(). This makes it take
> rtnl lock unconditionally.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Typo in the commit subject: rntl -> rtnl

I think it's worth fixing, anyway:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius
