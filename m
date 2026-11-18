Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A360A2637
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=XR8D5Br7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=afda8mOJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68EFC80E8D;
	Wed, 18 Nov 2026 15:30:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqvDx2hMSVxY; Wed, 18 Nov 2026 15:30:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6172810A1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795015830;
	b=e1oppPXiRK8rct5yXm3PE+fs8U1daGaSOmwFZGBizZehhKcUrfLy9ud0rHic0mr3SEd8
	 zxBvR051m4ID5yA9LWFDW0a1EXMLwM6u1Bp/ZvniZrLCqHa6LalVhL+deRVrhQS01ghJb
	 Cw2tNOuOQJVcRdogoz3MhzMxmzwWkiqxcCp9WOnTB4B0hPw70dHtEq/Cd8BjkYaiLsYCj
	 aZ1RKaWarWWdpsK0fAy+E2nbIj8mGrVYIQMjpkKBNhUna1uBPF0W6l+NDwrSkYs732ra5
	 cT3bf6M0AoeVNu42t3FjxQNx5e2g1q6S77DLvBEmU9m4B2yQHB5WHCOaQfOrcGOyFaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795015830;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Language:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SJS70BAWykYwtLt0R9l5sSECIeSKnz9myNvBTFJeYzc=;
	b=aXX0pMoyerl5DuVv6yoHCHAREaQu3x6EVTD9Fi6SkgZ3yoJUPPIvT+kbsm9QUDYsJJPw
	 1xmOUwqKxD59UEGNXxEhsPBtoz9YqGeKvbRbb4ysr6PQE5BlI5TgqkPlEPTBYatNqZDxW
	 TsrxdbIwiGsWQIkJNspOd6bkCfpLCAVu2iO69L8LWHF3kPQ8DkCdhMQoNp4BCkbnu8iG9
	 jZna4jrSFgmO4PhCJ8K+fjYbCgxHt7uI73d/+SzAqZkOzERR+ClIJYG5rPFdMfb/26NJ8
	 apDvoJgJM3Avpyyz282TwKVOCXMSeHqvDM2cfQGLzXzMT6MJkgtBp+9cjvjjaWNQupw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795015830;
	bh=SJS70BAWykYwtLt0R9l5sSECIeSKnz9myNvBTFJeYzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XR8D5Br7eH/HhqSswLIegQpIYUdXvzauStU56TKAXrlmat+x1hsQKeGZuKbFy+lNs
	 foLuiK+uHE1iejwBpU4Z7NTSL57wJgn8kK89yPcPI43I5uANIGNtZeLDjkeKjSI/wM
	 8PEe5xXQmHX1lM8pYx3cmVtPVHPKgqcgUAm/PN/+Jwg9sQMWqRiLVqqdlxUErEoiCl
	 k2ecR8Bum3c6mnt8Ljv/vVe/Bm24t5V/mz9IJhk05kzFXsri9HtBEbI2qeJ0Of/gZJ
	 RlhsI5Y7JFZc5aDP75gnWPtwLk2GDVQeW67O4EXiMr+cZhEcMQCRXHG8gb2OOw72b0
	 TCEZXu/8V/pDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6172810A1;
	Wed, 18 Nov 2026 15:30:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D59728C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EA86409F5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:30:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZEtjHyn0e37a for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 15:30:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7DC66407F6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=afda8mOJ
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DC66407F6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795015826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJS70BAWykYwtLt0R9l5sSECIeSKnz9myNvBTFJeYzc=;
 b=afda8mOJ/daATZyH40SwRw6r7s1RI9NbJ0Se2pCgRRYctOLZBNAzyOc/UeL+kR4YRTBmfg
 FeXqOcXE2Ij43but6Arjoa9CXlJkUhvFbNXzBiKIJUg1DEM2p100J51GCVNw6Ajo0Qqjjb
 QoHbQH+Pcahk11hgzSIcaUxvyHYdfTY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-rGcLiJ-dP9KHVHSGNVzrkg-1; Wed,
 18 Nov 2026 10:30:22 -0500
X-MC-Unique: rGcLiJ-dP9KHVHSGNVzrkg-1
X-Mimecast-MFC-AGG-ID: rGcLiJ-dP9KHVHSGNVzrkg_1795015819
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA4231800556; Wed, 18 Nov 2026 15:30:18 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B9C91800543; Wed, 18 Nov 2026 15:30:12 +0000 (UTC)
Message-ID: <df8fccfd-375d-4f56-be37-d5ade5a47e25@redhat.com>
Date: Wed, 18 Nov 2026 16:30:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <de304923-783b-4533-8507-514a15b3556e@redhat.com>
 <20261116181715.6f7d7f09@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261116181715.6f7d7f09@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 5i7_oFaKdYg6s8OXQyYhsXpKeJxqsO8xBecQOO3Evn4_1795015819
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 03:17, Jakub Kicinski wrote:
> On Mon, 16 Nov 2026 09:24:39 +0100 Ivan Vecera wrote:
>> v2 no longer applies to net-next since net was merged in. It conflicts
>> with 7a3837929d04 ("dpll: notify about a reference sync pair only if it
>> was added") in dpll_pin_ref_sync_pair_add(). Patches 3 and 4 fail on
>> the same lines and the rest applies cleanly. After patch 4 the
>> resolution is:
> 
> What makes you think we'd rebase your patches for you?

Sorry, that came out wrong. I wanted to flag the conflict with the fix
from net, not to hand the rebase to you. I will send v3 rebased on
net-next once the questions in your other reply are settled.

Thanks,
Ivan

