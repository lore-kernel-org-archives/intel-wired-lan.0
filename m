Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0490ECD6E6E
	for <intel-wired-lan@archiver.kernel.org>; Thu,  4 Jun 2026 22:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9681F80E1D;
	Thu,  4 Jun 2026 22:54:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cGJjB_SCyyy; Thu,  4 Jun 2026 22:54:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92DB680DC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780613668;
	bh=3lMPwTETgOHXdjVrbiyEjoY0H3xuhL5jFk2nN61vumk=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=fNjNaJ0mvEr505oDONjAiKXz7Z8qvsT0Rz67/JbWpv9TfXO1xBo8vP7s8lA+9biU8
	 QfYPdy74+plP0Up+rlRXV5rY6arSdZd9gOGkJQ4dqqh1v+zDLmpEzskqgb3eVfU7Jg
	 YzVRy21gWFDKRCFr9uZveRDnxS0nwQeblOQIiSmb6UUJvd/xsny67wFPHlROahxa4f
	 M03fdj2tYn1QfXfSAnq6RK96HjzBxnXtGAT0+W7SVbkPZPbCWhKnmNQpENMPYSyWvS
	 fc1wzO7mchxk+A31HKtPU7j2ls+ZKKGsqboI+ZVuJAfR/DBdujjtTI/G7G23VNVuCy
	 Z2++wvnIH4HXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92DB680DC9;
	Thu,  4 Jun 2026 22:54:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6528D26A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jun 2026 22:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56358429E6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jun 2026 22:54:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zoS1rRTpa5PY for <intel-wired-lan@lists.osuosl.org>;
 Thu,  4 Jun 2026 22:54:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 80FBC40B3D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80FBC40B3D
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80FBC40B3D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jun 2026 22:54:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20AB160052;
 Thu,  4 Jun 2026 22:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76051F00893;
 Thu,  4 Jun 2026 22:54:23 +0000 (UTC)
Date: Thu, 4 Jun 2026 15:54:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Message-ID: <20260604155422.167314ff@kernel.org>
In-Reply-To: <IA1PR11MB62197FC8E64BE92FBC108E6992102@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
 <20260603183036.7c4762d2@kernel.org>
 <IA1PR11MB62197FC8E64BE92FBC108E6992102@IA1PR11MB6219.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1780613664;
 bh=3lMPwTETgOHXdjVrbiyEjoY0H3xuhL5jFk2nN61vumk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=mWqVhDtl9S6NhuYYXnbfYOKqCQPIW+Ht1cApg/HEDqr1C792kFVYvQx9S0hUdEyRx
 4DlsmC/nV1JjporWCyz4mimRtjEgUv4woONpG1J5QuYaJXXFMPqxZJNl9XXn9M8oTR
 YmdudMQhInteUeITIoxa6pfFhK7D/vzKPaY1hyWVM4KW3i9aH7NoUkps3rGZ1OjXUo
 YoiRNk0LxO4kYy63w183d3gvSayScBFJiWD9i2UsI+pzas/CUgy2hX1LE32dXqZjDL
 tjZi7sInI33fhlM3jeukZY3un7hHLzOefigz4G8URTjoGQrtgFhfBDVKrEQNDFVaA0
 AGIsuZuYEVK7Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mWqVhDtl
Subject: Re: [Intel-wired-lan] [PATCH v12 net-next 0/8] dpll/ice: Add
 generic DPLL type and full TX reference clock control for E825
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

On Thu, 4 Jun 2026 20:05:54 +0000 Nitka, Grzegorz wrote:
> > On Fri, 29 May 2026 16:26:20 +0200 Grzegorz Nitka wrote:  
> > > NOTE: This series is intentionally submitted on net-next (not
> > > intel-wired-lan) as early feedback of DPLL subsystem changes is
> > > welcomed. In the past possible approaches were discussed in [1].  
> > 
> > I dug into 3 of the issues reported by Claude here and I think all
> > are really preexisting. But I don't see why we wouldn't fix those
> > first, and have a clean AI scan. Please send the fixes ASAP if you
> > have them, if they are trivial they may make it for tomorrow's PR.  
> 
> Thanks for your feedback.
> I'm not sure if I can identify exact 3 issues you mentioned above.
> I see couple pre-existing issues reported in
> https://sashiko.dev/#/patchset/20260529142628.1678955-1-grzegorz.nitka%40intel.com
>   - 3 issues reported in [PATCH v12 net-next 3/8] dpll: extend pin notifier with notification source ID
>   - 2 issues reported in [PATCH v12 net-next 5/8] ice: introduce TXC DPLL device and TX ref clock pin framework for E825
>     The first one is false positive in my opinion.
> 
> Did you mean those from patch 3/8?
> It should be rather simple ones. Shall I submit it as a part of this series?
> Or a new patch/patchset? (against next or net?)

Ugh, I think I missed that the caller looks at the ICE_FLAG_DPLL flag.
So most of the deinit bugs are not actually bugs.

You can add the fixes to this series.
