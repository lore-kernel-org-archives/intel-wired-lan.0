Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084CF606A337
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hpL+e/eo;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A/SQjXka
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC86680DF3;
	Mon, 16 Nov 2026 08:24:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0tVoOrMgYg57; Mon, 16 Nov 2026 08:24:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 22BBC80E47
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794817497;
	b=hqfAPgcKmQyi/1MxwndYfK0/z02a5yD+kwtN+uyBARCG5iSI4fFb/6EQx7YiXGx/SVdY
	 jstaofo1uWu7kBdiSYmNUnNfcs/kInHKJQd96XeJteNQ4bd+nTtNLAYEtQLr31QOou4X3
	 aSSKGmViEyrU0RBsQCSOkxOYeGwqjvrV4w1xPOncqI8M/4ccuJbOlb+vtSWhzE/bsgMky
	 37nLiz0akyE4YJHpV2zsV2eez7jsmJvfwKS4Z50wsRT5/Zk3FjpYQkX+BqEqOwMWyxFg3
	 vcPyRE5Q+XxlXK5vjge/4iDR0/SE3goW2q143EkHvMIWatfuIDgVXWZdKn/A6SnYPtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794817497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 References:In-Reply-To:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Language:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0JNXirIXq/TDKZ0NaZ1yStkjBc16eXaBQqcskBQBeTI=;
	b=YE/28MtYhn9w04OYxsQX+l81n+L2WeDyEAMPimg1FnKajV5J//2vROyXWVNGzKQG+czq
	 lJoQoVbr1rgIl94/OO5lDf1J3TVSmUShxqMMZLPuKQhHT0AnT9Bi0y3ZYkGnNOE/axsQl
	 2FOM1+TuXgR/CuwCAAdFLcQ+8Fx+B5tF47aSaUOu9P6QqXY2JFrrXgE8LwIdcTQS52h/Z
	 4u7yv6sCzyCwVNv2az2QCkoGRJzFlH1pdtPqS/b5YD1WA0VJZMQ0p2q5PAYEVvU5MC9WB
	 jKbXSbojilVQvyE86d+t0t2MA8/u0D+6IN47+Uu7VBq0/MGm3P8Ilf4FBajPazOkVjA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="A/SQjXka";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794817497;
	bh=0JNXirIXq/TDKZ0NaZ1yStkjBc16eXaBQqcskBQBeTI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hpL+e/eodiC7ItEPgtXYUR4RrVD6t2ABQTwrsw28+fTye1onsbJzEd2GlHAtDtoCn
	 nSMAkRFW1Qvj5sgGrdjasSHr6asa8w/6uLGTCwULV8znqgkq/WLxA36vUsftzz4tgr
	 wI4wsOhL0vv0AkbNzS4Xgf7IIN2EkaFMV/LN+WfE/7DGqksS4DIWQYmZK8ps+dNqPR
	 gqWh7ZE6uv6qVj8zo5DWp4WOEUZwKyRIik2wxYHgxSkzrLwqDWV0p1N81TMYh8mEm6
	 Byj26KlYmbKe7F81dCbfgddHrDsOPv1N8vXg73bxJG/9G65dlJB+P0d2d9YO4UQ4vN
	 QqzyMu+zImE8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22BBC80E47;
	Mon, 16 Nov 2026 08:24:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 417831A6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32D3B80E47
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:24:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rw8SdHvVMX1B for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 08:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4861C80DF3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=A/SQjXka
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4861C80DF3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794817493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0JNXirIXq/TDKZ0NaZ1yStkjBc16eXaBQqcskBQBeTI=;
 b=A/SQjXkaNr8RdiFaydh5ipv/Ya08tZ5rWDFsSc74ufjX9jW0a+/Hmzz8zBaT6K1hs9ldYm
 QwvScQlS+ev6taUwEpzdAHo6VN9diJW/75JHDA5XNjROhUdBNVGTSXFBGfz6HACDBcGWqJ
 GZ+1Y9r5ANqEenx8VCU2S3DRTmBOnto=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-onXJjqY7Mi-8IUXNEOKGMQ-1; Mon,
 16 Nov 2026 03:24:50 -0500
X-MC-Unique: onXJjqY7Mi-8IUXNEOKGMQ-1
X-Mimecast-MFC-AGG-ID: onXJjqY7Mi-8IUXNEOKGMQ_1794817487
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E25F119560B6; Mon, 16 Nov 2026 08:24:46 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDB01410; Mon, 16 Nov 2026 08:24:40 +0000 (UTC)
Message-ID: <de304923-783b-4533-8507-514a15b3556e@redhat.com>
Date: Mon, 16 Nov 2026 09:24:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: AMM4wlNqV_NJGJP-Rxxn1t5WsYVV1CUer6UfOIT9v1Q_1794817487
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jakub/Paolo,

v2 no longer applies to net-next since net was merged in. It conflicts
with 7a3837929d04 ("dpll: notify about a reference sync pair only if it
was added") in dpll_pin_ref_sync_pair_add(). Patches 3 and 4 fail on
the same lines and the rest applies cleanly. After patch 4 the
resolution is:

	down_write(&dpll_lock);
	ret = xa_insert(&pin->ref_sync_pins, ref_sync_pin->id,
			ref_sync_pin, GFP_KERNEL);
	if (!ret) {
		mutex_lock(&pin->domain->lock);
		__dpll_pin_change_ntf(pin);
		mutex_unlock(&pin->domain->lock);
	}
	up_write(&dpll_lock);

Patch 3 is the same, with mutex_lock() and mutex_unlock() of dpll_lock.
KUnit passes on the result. The SyncE CGU fix that the series needs [1]
is in net-next as well.

Sashiko found only low severity issues, I answered them in the replies
to patches 4, 8 and 9. Would you resolve the conflict when applying and
take the fixes of those issues as a follow-up, or do you prefer a v3
rebased on net-next with them fixed?

Thanks,
Ivan

[1] https://lore.kernel.org/netdev/20261110094350.184185-1-ivecera@redhat.com/

