Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C00CD98CF
	for <intel-wired-lan@archiver.kernel.org>; Sat, 13 Jun 2026 20:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9957F41163;
	Sat, 13 Jun 2026 20:27:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oqruvu1rnzAw; Sat, 13 Jun 2026 20:27:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78E2E410C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781382477;
	bh=QMmcuE8DSjrHYXf/QWms+/WUULv13ijGbv3LUEQ15xM=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=V9Cz8rJVLuloJ1nDDHXn4ChbpQEfXFUrBiu6uQZDhm1MdILsnJIma9OEWO+3TybQI
	 YPg3e7j+mnj7acPw648kogwqWyXJJfwGg7h3CFXpg3VATUL+YaNUoR5Zpr+K8/fdOQ
	 ujhiaEU5XzRXRQhQpaOr1t/kfS2KnsrFcjFxbFHA7FW1136MO7kPcCY2ZIiTiGV+yu
	 MmSprbtZIxkRbse20YNdmdRiI+IBw4OF/gr+YAx3mCZKFwS7n6YgI7VpEaK0JURfs3
	 T8ZhLil3NGMC2qGOese1Tba4aQ32A29JlTLrOGJUvyx2fiDGNASQl1+m9lYPHprKYF
	 67ZVNY8CsUqUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78E2E410C8;
	Sat, 13 Jun 2026 20:27:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2248A322
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Jun 2026 20:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1375C841B9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Jun 2026 20:27:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fRxHZVOqSqA9 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 13 Jun 2026 20:27:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7343D8419A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7343D8419A
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7343D8419A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Jun 2026 20:27:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5C3140412;
 Sat, 13 Jun 2026 20:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BE71F000E9;
 Sat, 13 Jun 2026 20:27:54 +0000 (UTC)
Date: Sat, 13 Jun 2026 13:27:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Message-ID: <20260613132753.2b3d1f07@kernel.org>
In-Reply-To: <IA1PR11MB6219B836E61D44198B0FB5AF921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
 <20260607183045.1213735-4-grzegorz.nitka@intel.com>
 <5ad977af-9bbb-4376-b0a6-2b1867223145@redhat.com>
 <IA1PR11MB6219E71E2581AE3A4C91F870921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20be8f49-4d85-430b-a651-c4aecd172a57@redhat.com>
 <20260611104109.34063873@kernel.org>
 <IA1PR11MB6219B836E61D44198B0FB5AF921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1781382475;
 bh=QMmcuE8DSjrHYXf/QWms+/WUULv13ijGbv3LUEQ15xM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=KgpB7cChLyT+d4tgCLbidRVA08Bl5Xk8A6GLm6ZX3WBxB84nWepw1vCNruS88uc2i
 5JTozl6uSmI+wawmrlUPl3Q7atMO3ByVqIyugMdMhixTTwj89Oc7eyK/Y3Mn+b1+Gz
 c/zg7u8KYBkCdmTp8A3gVzbLylXWReQeq1YsuhBNnt1JrJ8lnjRksue+yAq4zTmCwU
 gG96+1C3qh+cV+ZO9O1S/Qd+OW1TKtb/DxWIAg4/v7OC0BQbe+25uhsY4pS0WF2khP
 3fWnOH+VsU/IkteKUnMmnM1MRVJt1mf3SjyRm0e06sJkQueLmTjJ7Z/n4lBpr+2yy8
 iU2CjH56ZmNyw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KgpB7cCh
Subject: Re: [Intel-wired-lan] [PATCH v14 net-next 03/13] dpll: fix stale
 iteration in dpll_pin_on_pin_unregister()
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
Cc: "Vecera, Ivan" <ivecera@redhat.com>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 11 Jun 2026 18:36:14 +0000 Nitka, Grzegorz wrote:
> For v14 patchset, I got only comments from Arek and Paolo.
> In my opinion, after rethinking, Arek's concerns are not valid (explained in
> the responses). Maybe I could squash some changes, but the final code would
> remain the same as for v14.
> 
> Paolo raised 'Fixes' tags which I added and critical divide-by-zero panic
> Regarding 'Fixes' tag, It might be my fault or misunderstanding.
> I can remove them if we want and re-send the series.
> Regarding div-by-zero - see my comments about AI concern list below.
> 
> Also, what was raised by AI, I unintentionally changed WARN_ON to WARN_ON_ONCE
> in patch 2. I'd restore it to WARN_ON.

Alright, let me apply this.

But please investigate the situation with the notifications.
Maybe there are two create notifications because we add more info
to the second one? If not we should drop the duplicates.. YNL can
monitor the notifications during tests if you need a repro.

You can follow up with the fixes during the merge window.
