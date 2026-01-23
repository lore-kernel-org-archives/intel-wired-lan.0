Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C4BD74EE9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Jan 2026 15:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B3D7822AA;
	Fri, 23 Jan 2026 15:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s_Fj22CchS-9; Fri, 23 Jan 2026 15:27:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A12BE822A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769182069;
	bh=m+56liWIY6rlDS8EqIYZo8N4mcFKH8UtPhn96TVJ+gk=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=TXzReISL6lfJ7zrOWTnttuZrEAylnN/O2T6+yCI1fhn/pvDrpzEQ/eEJEOrGN/p1P
	 +jDAH8oz/+66wqwzFFsWLFcUbgvWlp6uhh+9tabSqHQOjGREIx1CqE8KHllvUlaUoB
	 kB69RoRScOOC5Sfdk/KAAxjnrJv62oWM5dJRe5SSclY0vFGuXDH8f8aEYP8hRlqflF
	 bkMNV4OXjq73tQCyn2WsSVJ7JYLi1dNRinwCQYG4dJkFnw/0xYOoZyKUWpR9Y7tCMw
	 cCzATl207tZYSPM0maPD0mQiMD1z2FyHz3pFr7Fj66/OxAglBzmdXzqHAZM+zfx+cv
	 +YMHEU9u7lb8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A12BE822A2;
	Fri, 23 Jan 2026 15:27:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C70CA23F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 15:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8BFB40934
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 15:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BcRC29Ak8EM8 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Jan 2026 15:27:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9500740930
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9500740930
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9500740930
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Jan 2026 15:27:45 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-rNxsUbaiMsWxSlRGkiLwwA-1; Fri,
 23 Jan 2026 10:27:40 -0500
X-MC-Unique: rNxsUbaiMsWxSlRGkiLwwA-1
X-Mimecast-MFC-AGG-ID: rNxsUbaiMsWxSlRGkiLwwA_1769182057
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B3AF1800624; Fri, 23 Jan 2026 15:27:31 +0000 (UTC)
Received: from [10.44.34.120] (unknown [10.44.34.120])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 613A71956095; Fri, 23 Jan 2026 15:27:22 +0000 (UTC)
Message-ID: <6da98781-9cf2-4756-a6b1-89cc650c9bce@redhat.com>
Date: Fri, 23 Jan 2026 16:27:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Simon Horman <horms@kernel.org>
References: <20260116184610.147591-9-ivecera@redhat.com>
 <20260121001650.1904392-2-kuba@kernel.org>
 <f676c151-e871-4b2e-83f6-6d62bc146337@redhat.com>
 <aXOMiAhf-NdQTonz@horms.kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <aXOMiAhf-NdQTonz@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1769182063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+56liWIY6rlDS8EqIYZo8N4mcFKH8UtPhn96TVJ+gk=;
 b=V6i6XGfVqxK1YyzRh0XKLOGJ5545I+wTRr4N6cqHD/WZQKltbaPwUdu2ZcqYIEgeeLGJP+
 6d1aoVWHSbkDfvt46vsf8ZOp/Ff1NHL7Ke609CGf1fR36mavWduV8QzN+ORtAVZwTiXLVX
 /3WD7u4Q3ApVrfL6N6Q0MJoYH2wCUeo=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V6i6XGfV
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

On 1/23/26 3:58 PM, Simon Horman wrote:
> On Wed, Jan 21, 2026 at 09:18:02AM +0100, Ivan Vecera wrote:
>> On 1/21/26 1:16 AM, Jakub Kicinski wrote:
>>> This is an AI-generated review of your patch.
>>>
>>> Dunno if there's a reason for having this fixed by a later patch,
>>> if not let's fix. I'm sending the review mostly because of the
>>> comments on patch 12.
>> Will reorder these patches... Maybe it would be better to send patch 9
>> separately to net as this is the fix for the bug we found during
>> development of this series.
> 
> Hi Ivan,
> 
> If it is a but in net, then yes, that sounds like a good idea to me.
> 
> Please include a Fixes tag if you take that route.
> 
Yes, it was submitted to net with Fixes and recently merged as

https://git.kernel.org/netdev/net/c/f3ddbaaaaf4d

Ivan

