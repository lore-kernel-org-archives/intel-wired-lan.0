Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0ECD74EEA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Jan 2026 14:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1866B40AEF;
	Fri, 23 Jan 2026 14:58:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J41t85ezMs1i; Fri, 23 Jan 2026 14:58:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 573CC40AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769180308;
	bh=P9NOYX/i0Iv8XMaIpAg24ZHD7meJmHYKrV/qo7XUTuQ=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=7WsxNnJxL5t52jeyUi279MFFjXiLqcAkafl4whICr/0KWIeQwaAGVFK/44jSPrzJ0
	 P7LS8vk24KkjsT99XmaZyA52SsOv3o3+bh4PQ1I1TUCqR789K44y/dD4MaUqCh2z71
	 h8VecejW5FPum7ce74q4NTODyeTQ8MAod+FlWEdPetKnQvdHySrFLm9dQvvQHg4wQE
	 ezzCWNqrFZYAou6EQgyh5d2d2A1i1177F77yWRKTN1VPd65f772x7Wul6/9Zvf8j5B
	 cBWkescY+lfavJ/Ch6/2jWpPQDOHGtSj0pVb76EoCKD1ymi0lo9vW5pzhq227Uxhby
	 333GAwtanKUTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 573CC40AED;
	Fri, 23 Jan 2026 14:58:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4974923F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 14:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38DDB40484
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 14:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ENwXQ46Dype for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Jan 2026 14:58:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 627E34047D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 627E34047D
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 627E34047D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 14:58:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C1F6B600C3;
 Fri, 23 Jan 2026 14:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1860C4CEF1;
 Fri, 23 Jan 2026 14:58:18 +0000 (UTC)
Date: Fri, 23 Jan 2026 14:58:16 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Message-ID: <aXOMiAhf-NdQTonz@horms.kernel.org>
References: <20260116184610.147591-9-ivecera@redhat.com>
 <20260121001650.1904392-2-kuba@kernel.org>
 <f676c151-e871-4b2e-83f6-6d62bc146337@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f676c151-e871-4b2e-83f6-6d62bc146337@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769180304;
 bh=WE1/H+pA0M/3cp7I12EZf75aU5FUoIcUNrJz5plzf+I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SZ+CT3APk84zJsU3fPjS/cljFGrh/epaOwqraMXSnLhGxxPPyuUvd8R2nRHnobE0t
 Axzf8KEbqpXEi06s4Tl1EjVi+gcvQTZI85r4qO33j7R+tMRkhgtXN2+TxQToF8hnnU
 zvuN90uhpTh5qQjnRUcl0lExnZUhj6iuuKMQJ1L7oL4UXOcxLvu0iC3mPKtdMkVXWZ
 HGoS/TwBDJtvzBAbwSrMZKHZI+ccvaar2vfPNFCIwTNqsp87EGAaEb7U06uIPieGbf
 qhMFRq0ktMd4DotsSv3Hyl0OT2SJ0ztfEwAk1w3s/NWkhj2W7yhovKjtnDZLEOK3Vm
 8ScnkolaB+4nw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SZ+CT3AP
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

On Wed, Jan 21, 2026 at 09:18:02AM +0100, Ivan Vecera wrote:
> On 1/21/26 1:16 AM, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch.
> > 
> > Dunno if there's a reason for having this fixed by a later patch,
> > if not let's fix. I'm sending the review mostly because of the
> > comments on patch 12.
> Will reorder these patches... Maybe it would be better to send patch 9
> separately to net as this is the fix for the bug we found during
> development of this series.

Hi Ivan,

If it is a but in net, then yes, that sounds like a good idea to me.

Please include a Fixes tag if you take that route.
