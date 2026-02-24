Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61EFF4BB8B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Feb 2026 21:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A37ED8221A;
	Tue, 24 Feb 2026 21:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BiYju1_-s0cP; Tue, 24 Feb 2026 21:08:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E92B8224D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771967309;
	bh=LOPgYoP26GoGh4RTj0T66BhDNOSe1m7SVuI74TlDlr4=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GNz36kM8D2y9Sr+rfcMzwgl/lihUug2C87wzxNGenNn6kemS/YZxpUbnmORciqcKW
	 2+IYp3g3fmO6BCHE3jiXekJFI1oObvg/ubDL58DxLbNKRtJPBum5XWzYWO/wMlNdMw
	 9vkUKsNVdRSjUDtkt/Jg67x2F0QXXquKRwnbcvdSWjU7QjTGTo+UL9U+IQTVSX2S5h
	 zFSWgTe2jnZjbBhQ19fqFLkrdE68PYs1lbtEKo+mrss1mnDpIT04Xl59tMXbA3SINf
	 tfFJsGvARM4ZblvmVgAGln4QNnpYKykgmT4eyRnYb4WzGa+rqjPk/U5PgXX99FMrGY
	 GdV56pJgqh2VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E92B8224D;
	Tue, 24 Feb 2026 21:08:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B7A9D1B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D88741E0F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2qMz120U1rDw for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Feb 2026 21:08:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=vinicius.gomes@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org ED17741DF4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED17741DF4
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED17741DF4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:08:26 +0000 (UTC)
X-CSE-ConnectionGUID: 73TBB/U4S3G0vUs36lkyBg==
X-CSE-MsgGUID: eQZ7TAGBQtCHQorbvFHdVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72967954"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; d="scan'208";a="72967954"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 13:08:26 -0800
X-CSE-ConnectionGUID: hFqcFEXrRYqb6ew2ymxhvw==
X-CSE-MsgGUID: qXrn6hXuQXiWMqxckTAqtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; d="scan'208";a="213224711"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1)
 ([10.88.27.144])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 13:08:25 -0800
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
In-Reply-To: <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
 <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
Date: Tue, 24 Feb 2026 13:08:25 -0800
Message-ID: <87pl5t7sty.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771967307; x=1803503307;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=AQXanRAmXg0HtIipy0nniHzibAhiwalzJZWGFknrYJY=;
 b=jmnRGHO0f1oqD77Yl3aeEbmr27KrAeOfEy1RszuV2C/SZ/7u2ztRlqYF
 5oZ1nMs420j7+UuOaLZfoFuFMJsJYiELtUS0XnFEycT42EzcNQrm9Jf3u
 rfmBUS4N5FL2Mkm7jNjPSomnhrx/JvFNc98a0dxr3zHQOyuFecG4rpOAX
 Vqufv/TN1OxlGdaEFKvkkAmR4ElnNq/MikZln8UWHyvJ/KhLA9K/6mh/H
 6nYYrfK5mlQkc9asncbMbQIXjgDv2Pp/QCZsCIwnizibpacfREWzjgiPC
 iqYooCtHYvjieDnTIsJ59OzP/eRJxl+jN+WekfKrJ5lkxJIXUoPEynXch
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jmnRGHO0
Subject: Re: [Intel-wired-lan] [PATCH 2/5] igc: Let the PCI core deal with
 the PM resume flow
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

> Currently igc driver calls pci_set_power_state() and pci_restore_state()
> and the like to bring the device back from low power states. However,
> PCI core handles all this on behalf of the driver. Furthermore with PTM
> enabled the PCI core re-enables it on resume but the driver calls
> pci_restore_state() which ends up disabling it again.
>
> For this reason let the PCI core handle the common PM resume flow.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius
