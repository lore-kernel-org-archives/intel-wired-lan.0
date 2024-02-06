Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9C5C4828D
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Feb 2024 15:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 59DE041590;
	Tue,  6 Feb 2024 15:38:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 59DE041590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707233891;
	bh=HcRdM+xyPVPY/68XA8jP+tIUSlfkOLnEtyZxspjOPlw=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=MLVxKnB6aC/77kaWzIuyn6P0e5Hbprd66GlF4cwrV8JIqXxOxgt7OK/nCWEonb4Gy
	 h2hYtnm3GfSoRd9vyO4pPUkLBI1bDNHwQpnynP4nZCbs5PdWcl9tM1WizB06WLxTiM
	 4ljbwlBGxO8u75vhn80RsSSkiAXupm26cCXn6iYw8I0rQ6MfrSc88+W/Kfpk/ZRFbf
	 zqZGW9U2Zs9dNJG+lVcmCKjrxxo7m+5qfpXmAdDs9bj5D0ke6pkOc1DOg2E2/5/ZAb
	 kLNbsKa5JCbaIl0OOkk6NYLtFBA8M5mcbbcCfqJRSSNBP+I+VsyBgNW9yXWGIrJhKi
	 26xyx6p6YRSgw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u8GoQYP4OGXY; Tue,  6 Feb 2024 15:38:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 602F1415C2;
	Tue,  6 Feb 2024 15:38:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 602F1415C2
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 66B971BF215
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 15:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 398A141590
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 15:38:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 398A141590
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rz5rFvR5UAGf for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Feb 2024 15:38:06 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89217415A2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Feb 2024 15:38:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89217415A2
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1DE9BCE13D7;
 Tue,  6 Feb 2024 15:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DB0C433F1;
 Tue,  6 Feb 2024 15:38:00 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:37:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <20240206073759.4d948d1e@kernel.org>
In-Reply-To: <c90e7c78-47e9-46d0-a4e5-cb4aca737d11@intel.com>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <c90e7c78-47e9-46d0-a4e5-cb4aca737d11@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1707233881;
 bh=GS8UEbSCgKgB/gRexnGVpyWM7USUW2+rfEyDI5KxFn4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MeC0/nmpBcpRMXw4qehV9ITDmznAf7JstSxhzuhPvmSPmjuZdqbsqo9BNmRWeWoWd
 o6eg1wrNN0GLFHvCP4CrxHM1IUwHDsbtV2bixepEFmxUcEkfWDFOuQWczE7xxRSG3e
 fkjZ9WfXNGazSJn3AhGHp8LkWiNAfqf0MISuAAroSLY8+e2CMIL38rjyPOIA1Hr4af
 I/WAm6tx7tx/or2mxg+UxmdYJA41uax1G65P1WiukM+x0qx0inmSelMJJaw8HwkCgk
 pf5HGsj/y9OPoA+7/Isz2zUwgz2b/aQ3J1pOh51tJl+5J6UnLmIkqdM6dBb6L22Lkb
 A9JQU7chc1uxw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=MeC0/nmp
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 00/21] ice: add PFCP
 filter support
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
Cc: Andy Shevchenko <andy@kernel.org>, linux-s390@vger.kernel.org,
 ntfs3@lists.linux.dev, Wojciech Drewek <wojciech.drewek@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, dm-devel@redhat.com,
 linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Eric Dumazet <edumazet@google.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Alexander Potapenko <glider@google.com>, Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, linux-btrfs@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 6 Feb 2024 13:46:44 +0100 Alexander Lobakin wrote:
> > Add support for creating PFCP filters in switchdev mode. Add pfcp module
> > that allows to create a PFCP-type netdev. The netdev then can be passed to
> > tc when creating a filter to indicate that PFCP filter should be created.  
> 
> I believe folks agreed that bitmap_{read,write}() should stay inline,
> ping then?

It's probably fine, IMHO. I mean, I think we agree that the rarely used
inlines should not sit in a header included by half of the kernel (not
an exaggeration). But IMHO a better fix would be to move out whatever
cpumask.h xarray.h and other common headers depend on to a cut-down
version rather than making your helpers not inline.

So I think all we need for now is for people to ack the respective
patches? Looks like cio and ntfs and missing acks, so are some of 
the bitops core patches.
