Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF61FF4BB8B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Feb 2026 21:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C578845A8;
	Tue, 24 Feb 2026 21:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KB3wR2hSSjTp; Tue, 24 Feb 2026 21:08:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD17B8224D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771967332;
	bh=YWKOEY4/b8YlFZx8gm+pqM2QTtVFquwY26TX8gM22Do=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wIu3jCyNYyAjX1u0phDjYxUNmWF1cpssGWmciTigmSJEfzDK1NWCJOtkkjkKMNGus
	 yo968VDjyDW4RD8RUJu8FlKi018rNd7EvdYtY9ppRpJSixu7DrZEfmEWT/yoYu3Mn2
	 /DRm2PWZefUj3hLQjMQttmF9pkw8WyZQXDriFqeo2R1ow8+y8yzFglUNUDMPGGLNFq
	 anbk/aTBYKxFZdjMjYd4NDmANNDqvbybb3htP8yAhwrJvCb6uaYH6BRVgBQia6fwdt
	 OVQPqwsuSLYSFj3+Z0i0O4nHRbpOCQyrX8yZrvNR6/D9NcvOtNCQ+JUA6E06dS6d4k
	 HAwvu1i7YJm+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD17B8224D;
	Tue, 24 Feb 2026 21:08:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 402CA1B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25FF58224D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:08:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKI8hGVyo2ZZ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Feb 2026 21:08:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=vinicius.gomes@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 23B658221A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23B658221A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23B658221A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:08:50 +0000 (UTC)
X-CSE-ConnectionGUID: ADO7eA/aTW2Tm+sxNPUHFg==
X-CSE-MsgGUID: 2f/uCg8aRB+vxdpVrNTcFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72967988"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; d="scan'208";a="72967988"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 13:08:50 -0800
X-CSE-ConnectionGUID: BBVJnObmTf6dX3BrMB6C6A==
X-CSE-MsgGUID: /P93JMUTRVaUi63HmbNT1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; d="scan'208";a="213224721"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1)
 ([10.88.27.144])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 13:08:50 -0800
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
In-Reply-To: <20260224111044.3487873-4-mika.westerberg@linux.intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
 <20260224111044.3487873-4-mika.westerberg@linux.intel.com>
Date: Tue, 24 Feb 2026 13:08:49 -0800
Message-ID: <87ldgh7sta.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771967331; x=1803503331;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=yZVE3IFGLgSzwdJm/9yVkBOGWvu/M2sKhlEwe2Wr6m0=;
 b=MfUtpisbAQxtgqIkFAkVLRp4Vs5ahk6e2jvFeYrsf6l6rtYCRqcSkQXm
 KwgYafyR6RNS8uJ0Y77MdGQ0IcJadAV1l1bi8utBtjAsGtpVuugls7/+e
 l35GIgM3l1gJEDO98EUYJkAzgtfa597DqYYolqgZfBuEze4sQxCiEiUvh
 JSFhK5lwTXQPbLdRqagFPJHsYzNmZNxLCd0YB+UlaaF5JaSLMC6bGL08U
 5e7cbhyB4NN/I15u8opgeSpiU3uR26oU96hh38IKWJvz9ildgp81p4vKB
 ETkN1Diju/Sb/ZcOaDhjJEyzZAf73lRg1eG+nVlzS7DYQyTynjuGucxgx
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MfUtpisb
Subject: Re: [Intel-wired-lan] [PATCH 3/5] igc: Don't reset the hardware on
 suspend path
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

> Commit c01163dbd1b8 ("PCI/PM: Always disable PTM for all devices during
> suspend") made the PCI core to suspend (disable) PTM before driver
> suspend hooks are called. In case of igc what happens is that on suspend
> path PCI core calls pci_suspend_ptm() then igc suspend hook that calls
> igc_down() that ends up calling igc_ptp_reset() (which according to the
> comment is actually needed for re-enabling the device). Anyways that
> function also poll IGC_PTM_STAT that will end up timing out because PTM
> is already disabled:
>
>   [  160.716119] igc 0000:03:00.0 enp3s0: Timeout reading IGC_PTM_STAT register
>
> There should be no reason resetting the hardware on suspend path so fix
> this by avoiding the reset.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius
