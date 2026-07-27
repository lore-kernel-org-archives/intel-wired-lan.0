Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88720C531D0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 08:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B31440648;
	Mon, 27 Jul 2026 08:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J1_7Tc4-MgIN; Mon, 27 Jul 2026 08:30:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08FB640637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785141040;
	bh=Wun0I1dkmxfa8qNfn0OQhv2DA5hF2iEgMMGgkdL9fIM=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jzj+DIBYIYMag+hfzCjU9XNlaFNpSe26fx8Op2ecv+DWIWqA0+UKeKJlu23Fa265J
	 NfD17dgBkn0nzeOYqK0qBFhFqjdzFzx/7BOSzRNnUnEWTY3oFTpLxxRL9b71SawyqG
	 c5TLaG5hJ6fKFm6z3VDNWSjwrR5XaChPcuaAEZk5MgZqvCug1F+FMWOpOOWAA/yd8s
	 QbdsjZo2aW5NTMJc8T7gFUSjOADePvPwM8fDdiXPgNhMtfyoCUkIPxtL3U1WPp0mR0
	 A9ABP3fbrRjtTqMYVD3dL+qXV7PI8mtcB66bRBhSlf/4qZvA5Lu6pI5R8SFCqesShB
	 dOngk+4MotP8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08FB640637;
	Mon, 27 Jul 2026 08:30:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BBC4490
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 08:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1261580B80
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 08:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WgDBCmjp9qna for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 08:30:38 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D234080B83
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D234080B83
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D234080B83
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 08:30:37 +0000 (UTC)
X-CSE-ConnectionGUID: TF8JRfkJQ2u2P9xVZQ9PqA==
X-CSE-MsgGUID: aMe6j/taR3e0ys1fQ3SsBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85573921"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="85573921"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 01:30:34 -0700
X-CSE-ConnectionGUID: zuBRshsISau4U4oJl9pq1g==
X-CSE-MsgGUID: S6JnVra9Qs26laDkF7yO1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="259417611"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.245.197])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 01:30:04 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Alex Deucher <alexander.deucher@amd.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Andrew
 Morton <akpm@linux-foundation.org>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Borislav Petkov <bp@alien8.de>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, David Airlie <airlied@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian
 Westphal <fw@strlen.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Jaroslav Kysela <perex@perex.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jiri Pirko <jiri@resnulli.us>, "Joerg
 Roedel
 (AMD)" <joro@8bytes.org>, Johan Hovold <johan@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matthew Sakai <msakai@redhat.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Maxime Ripard <mripard@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Mike Rapoport <rppt@kernel.org>, Miri
 Korenblit <miriam.rachel.korenblit@intel.com>, Nicolas Palix
 <nicolas.palix@imag.fr>, Pablo Neira Ayuso <pablo@netfilter.org>, Paolo
 Abeni <pabeni@redhat.com>, Ping-Ke Shih <pkshih@realtek.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>, Simona
 Vetter <simona@ffwll.ch>, Simon Horman <horms@verge.net.au>, Stephen Boyd
 <sboyd@kernel.org>, Steve French <sfrench@samba.org>, Takashi Iwai
 <tiwai@suse.com>, Thomas Renninger <trenn@suse.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Tony Luck <tony.luck@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vinod
 Koul <vkoul@kernel.org>, Will
 Deacon <will@kernel.org>, Yazen Ghannam <Yazen.Ghannam@amd.com>,
 cocci@inria.fr, amd-gfx@lists.freedesktop.org, dmaengine@vger.kernel.org,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
 iommu@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 lvs-devel@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, nouveau@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org
In-Reply-To: <20260724144822.6af8213f@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260724144822.6af8213f@kernel.org>
Date: Mon, 27 Jul 2026 11:30:01 +0300
Message-ID: <0ee1ef4aa7daa908bf28397ccc639c89b6aabd9c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785141038; x=1816677038;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=qWnqu6VCUiwZWG189ixa/W9uGeC6PMG4tY9t7kvdnXI=;
 b=JJvitefYLe07AMSyEpc7DGn/YG7kFCXhaQfVbbJwfTOYn6h27UZtCetQ
 2V4D8O/xI8P5Bf14SztgwaxdyU96ZuwNhG+epzZ6fjagj8hSR30fmfFUs
 xgnob9d5ZicLJa0BxT9MHmd3yl5YVfD7tw0X4nCY9U3xGV+9vqjt2ulOv
 DfdWmhKKbIetZJHGX6RJQaEMg08h7iZtBp07fzN7KE9jaBq2+XebY1ClZ
 brzHV5pVqGjHzXhGJY0j4TIiN6/PJ+3bW/7Fz0gL/ynYa8cL7sAK2GBcw
 hwPAJpvdutYUTe2SSMATAnwMjQt+OPo7F4kjL2TSqhVuGHpS8eHsdFUQ4
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JJvitefY
Subject: Re: [Intel-wired-lan] [PATCH 00/36] treewide: remove conditional
 returns with no effect
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

On Fri, 24 Jul 2026, Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri, 24 Jul 2026 03:45:02 +0900 Sang-Heon Jeon wrote:
>> Patch 1 adds a Coccinelle script that matches the pattern, including
>> negation and constant-comparison variants. Where a local variable is
>> assigned right before the check, the assignment and the two returns
>> turn into a single return of the assigned expression.
>
> Huh, I thought we already had such script. Various script children have
> been sending such "cleanups" in the past.

We did, and it was removed, I believe in 1a617a8475e8 ("coccinelle:
misc: remove "complex return code" warnings"), because people just don't
want this constant churn.

It's perfectly fine to have the error case and happy day scenario
separated.


BR,
Jani.


-- 
Jani Nikula, Intel
