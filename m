Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75027D778A7
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Jan 2026 18:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B72E406A9;
	Fri, 23 Jan 2026 18:05:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11OxeZkyXRZ1; Fri, 23 Jan 2026 18:04:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BDE740688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769191498;
	bh=VOM4SyNA68QQ2p8aAOF41WvlFHdTbeExsr9QyIlsXUY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=lxoy5o7TsyWBg/EzyFMmttrrL3R+XfoaU3Qp3JBDnajsCyl4wiOxkY+1+9L3BpxlF
	 DMe0Q/ihCNrgYI7irICZz0NKtaPZh4eLVKtkyNZLldkME+mLE62TjwdqoGisL+luaj
	 EOH84t1XB4OwGzdqZcj+acawL+Ozd1H6SSWlnIh7lswKICXyQMEmPvrIvz3eHh4Cvo
	 YCEidnleBlIG+q6MXAYr1yqySmvZdZAah85rWw87PMW3qt9A9HuUYR6IJ+JbBuOZo1
	 IekX8cvwdBBBZCaAVhZNkaN1m9488SRhlu/7A2QozZ4Br6Cgql/EO8Y5sQmv3Kncn3
	 rlOPi+eZY+rgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BDE740688;
	Fri, 23 Jan 2026 18:04:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E9AC9122
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 18:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA64660894
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 18:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nbm10TjWOX5N for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Jan 2026 18:04:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0CA7F60892
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CA7F60892
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CA7F60892
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 18:04:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BE3B44596;
 Fri, 23 Jan 2026 18:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72716C4CEF1;
 Fri, 23 Jan 2026 18:04:49 +0000 (UTC)
Date: Fri, 23 Jan 2026 18:04:47 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Message-ID: <aXO4PzKrud1h3uYL@horms.kernel.org>
References: <20260116184610.147591-9-ivecera@redhat.com>
 <20260121001650.1904392-2-kuba@kernel.org>
 <f676c151-e871-4b2e-83f6-6d62bc146337@redhat.com>
 <aXOMiAhf-NdQTonz@horms.kernel.org>
 <6da98781-9cf2-4756-a6b1-89cc650c9bce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da98781-9cf2-4756-a6b1-89cc650c9bce@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769191495;
 bh=0DvNaXsBMKsLBkqZft0cqd9Fzf0jP09zTVPIXy7A82Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dw3YL1b4wRL0gdmgXTHfy275iYbUQUxqlxtSSSygZ+j2gf0OINHEbN351xA3Ob0mJ
 XW/2t3eZNrkwIEAWj96KY6Cw9L+EqDtPezRJPJjacGPT69rkq7oO/DzRp7hGf9YFA9
 JyDnqzyZeTVFa9Q0c/dOfKJC7b/ymlhz7pUZIiNaIdaFCThb3TfCdbEyCJsoIH0lFe
 dmqO/vRYoqce7mCECBwS/q4p4p1YuaXi/lO8TLtnCe/kW3yorCoTaRqXqejwPWVo1m
 XJWi1LGt9yI4yVBAULOtYqRoXjcVHoALzN6j+O0KKxsTfDt6RfMsaZfmgtM4bxFddW
 YaWjnc5CpBkcw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dw3YL1b4
Subject: Re: [Intel-wired-lan] [net-next, v2,
 08/12] dpll: Enhance and consolidate reference counting logic
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
Cc: edumazet@google.com, anthony.l.nguyen@intel.com, robh@kernel.org,
 leon@kernel.org, andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
 przemyslaw.kitszel@intel.com, arkadiusz.kubalewski@intel.com,
 aleksandr.loktionov@intel.com, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
 devicetree@vger.kernel.org, conor+dt@kernel.org, jiri@resnulli.us,
 richardcochran@gmail.com, saravanak@kernel.org, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org, mbloch@nvidia.com,
 linux-kernel@vger.kernel.org, tariqt@nvidia.com, aleksander.lobakin@intel.com,
 jonathan.lemon@gmail.com, krzk+dt@kernel.org, saeedm@nvidia.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Jan 23, 2026 at 04:27:21PM +0100, Ivan Vecera wrote:
> On 1/23/26 3:58 PM, Simon Horman wrote:
> > On Wed, Jan 21, 2026 at 09:18:02AM +0100, Ivan Vecera wrote:
> > > On 1/21/26 1:16 AM, Jakub Kicinski wrote:
> > > > This is an AI-generated review of your patch.
> > > > 
> > > > Dunno if there's a reason for having this fixed by a later patch,
> > > > if not let's fix. I'm sending the review mostly because of the
> > > > comments on patch 12.
> > > Will reorder these patches... Maybe it would be better to send patch 9
> > > separately to net as this is the fix for the bug we found during
> > > development of this series.
> > 
> > Hi Ivan,
> > 
> > If it is a but in net, then yes, that sounds like a good idea to me.
> > 
> > Please include a Fixes tag if you take that route.
> > 
> Yes, it was submitted to net with Fixes and recently merged as
> 
> https://git.kernel.org/netdev/net/c/f3ddbaaaaf4d

Thanks, sorry for missing that earlier.
