Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5630D262B2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Jan 2026 08:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A227E60E7A;
	Wed, 21 Jan 2026 08:18:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pga9jRTi8kSn; Wed, 21 Jan 2026 08:18:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62D7D60E77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768983504;
	bh=aLjuYxOngZSy7JCsu6Pfdx7HjhY/QhYRMKePJQYZ+kE=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=E47+Mn+tHJzMbSMMSWhe/+UW8VS1zd5dunKr1mSxmueWv0a55obuvi8thH4eg6ISO
	 4wpG9Nbdr6vJE/KczEPbC+AArLty/7T3bPH6VWRl47S3scz57Ohr1Nud2i7OOdPNxH
	 bIm3fONsZ+Cd35tpMKZBrShv09TUAPLuAsSgEqC/HCJuYXVjk0bVGrL7EAMCcUFTKo
	 UKjjKfKhxSmAEDXQfEK2bnaLlK02phR6kW/qTCObxVIoVCcL1ukBhbS60vGQgSjfOi
	 tWXLt+tjtIF79FnlPQKQdaCgs0gT9GhlAH491V3QRNbPoJ7tDUOrtGpNBUm9qo6c/U
	 YOJm+O+FLt7DA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62D7D60E77;
	Wed, 21 Jan 2026 08:18:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E5FCE160
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jan 2026 08:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA1EA83F0A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jan 2026 08:18:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lRiqxjmLGeuW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Jan 2026 08:18:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AD97D83F03
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD97D83F03
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD97D83F03
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jan 2026 08:18:21 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-218-VjNYMlmT1VsvIqeGiQ-1; Wed,
 21 Jan 2026 03:18:16 -0500
X-MC-Unique: 218-VjNYMlmT1VsvIqeGiQ-1
X-Mimecast-MFC-AGG-ID: 218-VjNYMlmT1VsvIqeGiQ_1768983493
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6F8E19560A5; Wed, 21 Jan 2026 08:18:12 +0000 (UTC)
Received: from [10.44.32.187] (unknown [10.44.32.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E467F19560A2; Wed, 21 Jan 2026 08:18:03 +0000 (UTC)
Message-ID: <f676c151-e871-4b2e-83f6-6d62bc146337@redhat.com>
Date: Wed, 21 Jan 2026 09:18:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jakub Kicinski <kuba@kernel.org>
References: <20260116184610.147591-9-ivecera@redhat.com>
 <20260121001650.1904392-2-kuba@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260121001650.1904392-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1768983500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aLjuYxOngZSy7JCsu6Pfdx7HjhY/QhYRMKePJQYZ+kE=;
 b=SqWCvrLoFy5uwjN9vj2nFJQzqIa+4P8tXYB6qLu35xmVskSqNJSeNeCOLL+6ZdNrIrxppi
 /iPWmcuxsngzPKwJT7gpxjkW1uwucqvHfrN6MoHNrDzolgYkTj/QerAXzmfYhOgaQLmJzO
 EKFnuTRsnmxtmn3YThqryRF7qfuJKNg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SqWCvrLo
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
 pabeni@redhat.com, devicetree@vger.kernel.org, conor+dt@kernel.org,
 jiri@resnulli.us, richardcochran@gmail.com, saravanak@kernel.org,
 Prathosh.Satish@microchip.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, mbloch@nvidia.com, linux-kernel@vger.kernel.org,
 tariqt@nvidia.com, aleksander.lobakin@intel.com, jonathan.lemon@gmail.com,
 krzk+dt@kernel.org, saeedm@nvidia.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 1/21/26 1:16 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch.
> 
> Dunno if there's a reason for having this fixed by a later patch,
> if not let's fix. I'm sending the review mostly because of the
> comments on patch 12.
Will reorder these patches... Maybe it would be better to send patch 9
separately to net as this is the fix for the bug we found during
development of this series.

Ivan

