Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52357CD8C9D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 11 Jun 2026 17:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 047BE81110;
	Thu, 11 Jun 2026 17:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ysFqWC4uxR_M; Thu, 11 Jun 2026 17:41:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DA09810FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781199675;
	bh=EjwItpzvPJkGo0jkccdylAMrRo5z7vcmV579UMGldCk=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8QjOvjlm/kI/kV3mq0HK71cuM3a6cJpB4jyA3hVQNfyDz6mJpAyHueDAncx8EchfB
	 m8xZW+G5t48Bdchmi8bWGbfpkuktw3olRhbaWUn3UnB339Jf2dztXYcl8wqM3qgwTk
	 +EXa1Rm+4rutqdtt9mWx2NyJB49OQuUhFnvqikmQn4fvjed2Zcx7BZhl/wYi3kciOL
	 n2sdqQDcfsl3ufksqFXS2xkhP0u9YcCkgsJvbx2oWHPNImGg4fYurbGgyRIB3H+hYS
	 XD9px5WqAcxN38jEosB/0uH45cWWEV9fdQlcsAdJmtm3yOGKikWskd4Bu51jTKzFIM
	 vWEthPWbvM34g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DA09810FD;
	Thu, 11 Jun 2026 17:41:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B9834F4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 17:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AAE7405C0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 17:41:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-qkHaEc3e4h for <intel-wired-lan@lists.osuosl.org>;
 Thu, 11 Jun 2026 17:41:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BD9BE405AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD9BE405AE
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD9BE405AE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 17:41:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2856443715;
 Thu, 11 Jun 2026 17:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740E61F00893;
 Thu, 11 Jun 2026 17:41:10 +0000 (UTC)
Date: Thu, 11 Jun 2026 10:41:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Message-ID: <20260611104109.34063873@kernel.org>
In-Reply-To: <20be8f49-4d85-430b-a651-c4aecd172a57@redhat.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
 <20260607183045.1213735-4-grzegorz.nitka@intel.com>
 <5ad977af-9bbb-4376-b0a6-2b1867223145@redhat.com>
 <IA1PR11MB6219E71E2581AE3A4C91F870921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20be8f49-4d85-430b-a651-c4aecd172a57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1781199672;
 bh=EjwItpzvPJkGo0jkccdylAMrRo5z7vcmV579UMGldCk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=J/nTNmGccMsABDlTrZ04xGfARU0xvILX58TUYB3dA9f2a6q5eibxWpSAERdfHx8jq
 Fgf/eRyx3tSflBAn28Cw48+TP/7OJcfQSk07nT0+Kydb5/ifQcQZxF3mptkTTyNSFm
 xu8oxnfc2QH8tVzeuqVc0ch/J9BWJIqy1U5JzOtvejme9C+2UpSrI1/56Vh2sOy0jI
 oSnlih63GXEq9rRhTOyhnfHx08ucALLREzUo3QawqUUvQfztEgYrEetk3vbMjLttkV
 C66RInxKH2chgq77VWYyLHm4OoSw5V2cLpxRJnl9u/ikhYZUUAJsbQ5JBnzsq+/aDd
 RxDtHBhFtH6ag==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=J/nTNmGc
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
 "edumazet@google.com" <edumazet@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
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
 Anthony L" <anthony.l.nguyen@intel.com>, "jiri@resnulli.us" <jiri@resnulli.us>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 11 Jun 2026 16:41:07 +0200 Paolo Abeni wrote:
> Fixes tag could be stripped when applying the patches as needed, and I
> think that could be preferable to a repost just for such thing, given
> the current PW load...

To be clear tho, this series has already been marked as changes
requested. Presumably based on the other comments?
