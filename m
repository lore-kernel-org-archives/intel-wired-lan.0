Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3383E937E5
	for <intel-wired-lan@archiver.kernel.org>; Sun, 12 Apr 2026 14:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97B69844CE;
	Sun, 12 Apr 2026 14:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SYiizuhGb2ys; Sun, 12 Apr 2026 14:50:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E83F28446C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776005459;
	bh=uT3jkQEWGfRe9a1eYcVLdjKJ46PzqgyIBTDWzxD0li4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=jgq/pbZpqnMQpsUHtvmtvDq8GI8c3Tvz7z+VomSui5m+SA17se8rkP6SjY0cOMvix
	 cRJJl+pLmwQrKVSDDCRurySviTRKfM//YuWV7lISDORhgZck5hjPWYmw2yRvzvBkI8
	 QxCLBdF5r75gbnvYgVcmUGgMKfJuAvnAyE0j29KpR88R8phqxVPX1qHuxCaRyYv8MJ
	 ca+nsMJGHdft2rn2GL5yN/1dXEkkdCYhS2JIjVQ5+zWX/giXl8eBz8IevACQ5bwQ5O
	 Svv/VOGD+8CrVFkWWC7RysJmwSMNWlykc1ArEOWM1haheY1xRzkFhJhJ/1SreWngqs
	 NIRKqwHsNybgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E83F28446C;
	Sun, 12 Apr 2026 14:50:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 453C1194
 for <intel-wired-lan@lists.osuosl.org>; Sun, 12 Apr 2026 14:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E93240E59
 for <intel-wired-lan@lists.osuosl.org>; Sun, 12 Apr 2026 14:50:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vFq7jcukX5zk for <intel-wired-lan@lists.osuosl.org>;
 Sun, 12 Apr 2026 14:50:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4DBAB40E07
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DBAB40E07
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DBAB40E07
 for <intel-wired-lan@lists.osuosl.org>; Sun, 12 Apr 2026 14:50:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9221D40AF7;
 Sun, 12 Apr 2026 14:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A897EC19424;
 Sun, 12 Apr 2026 14:50:54 +0000 (UTC)
Date: Sun, 12 Apr 2026 07:50:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Message-ID: <20260412075053.23660721@kernel.org>
In-Reply-To: <IA1PR11MB62195E2AF6FE5B102B2EECD392272@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
 <20260406192312.0f7a2760@kernel.org>
 <IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260409181041.395a0c37@kernel.org>
 <IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260410133812.4cf9b090@kernel.org>
 <IA1PR11MB62195E2AF6FE5B102B2EECD392272@IA1PR11MB6219.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776005455;
 bh=S32mcILpghlDeygeLc6FWvgkzRilryCAAV2qjAvE7zU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qn/duyMbgo37GSHoV3G2LBAX/Q7Mg5TMfft/GqI9baJml7Kwngrxp/fKSpMtigjBU
 0RdXxHMONadZFd5hcDODRKBnRb1Z+LBlTCl+qA7Ki0xOOh/+9n6HMAeF/opCr577sK
 4+tTD7qROvuftcL1WMYzeOyQusfrjlpRmShhqMJMAEDWHabDrxj8NPTm44YAeI78DN
 WzDqZMWe4AtHofPAUKpyMjL4D5bIy4r+CuUtM7lBGNj79HsgP8DdQ5ve0NpmxRB+hc
 HIOEq/86m3ca2jWogZRdXjP6MgBducQ3TztjaXEN7BgRM/zXG8q7AattQu4ttOZGxu
 SPLb53CxJwrZA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qn/duyMb
Subject: Re: [Intel-wired-lan] [PATCH v5 net-next 0/8] dpll/ice: Add TXC
 DPLL type and full TX reference clock control for E825
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
 Anthony L" <anthony.l.nguyen@intel.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, 12 Apr 2026 13:50:23 +0000 Nitka, Grzegorz wrote:
> > > Proposed solution just seems to be clean and fully reflects current
> > > connection topology.  
> > 
> > Do you have the link to the old proposal that was adding stuff to
> > rtnetlink? I remember some discussion long-ish ago, maybe I was wrong.
>
> This is the patch from the discussion I put the link in the cover letter:
> https://lore.kernel.org/netdev/20250828164345.116097-1-arkadiusz.kubalewski@intel.com/

Let's go back to something like that. But leave the OC info out of 
the XO, just ext-ref, dpll, xo? We can add the xo types later if really
needed. Sorry for the flip flop.
