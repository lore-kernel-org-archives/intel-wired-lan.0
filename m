Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE98606A321
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vYJ0kWLu;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e7c28ZRA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0AB440598;
	Wed, 11 Nov 2026 10:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RRXQ_6Jh8EiH; Wed, 11 Nov 2026 10:55:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4A3ED40624
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794394530;
	b=cK55mo229bDDiXq8bKcNYI73JmZK7ocZVgv8xMEz8rYO6nkIjpo0s8L9FyWSZyIuVfd2
	 vwwY9td+6ZfcSBiCk+tA1fupoA1WMFOhxV1qb2XjdaMYYbVKHdXW3E8YCDfEN1oT+EhOE
	 2rYJP0GE0Wn6PBUDBd8N+LhrfFffnObZ+JkDMnBp7kH/MEI/jap/hp+gaZYka7tj5jTSz
	 Qtq6ulGrSj8OXySx0EjkjCu8dmRvWyLDkB32UP6sjkqwC3WuYVfeCHrw6seWEJgQy5HfX
	 RPGdz4KzH86+zQzKgEjN3404BWCfdlOLOBGg0kjxrR27+kO2gHs63q59Niu0Rz1vsog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394530;
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
	bh=SF2NQhuQxu5m0bI5v5rpx1rhcNXkOJ4L4wUCi27ileQ=;
	b=MxPKYS7hHS2bhgPxB+mQOwEaOdeBlGck7aNoo7IHZtnM7X6daGjg5eLOu/h5xjE2/W7h
	 O/of31C76ZQcxfJf//CDYfjRWVvHBXrfn4NVsz3NqpDHh9umfQjiDKM6KYwMfotCTAqf3
	 3BqkfyQWsyoKrgBhAJfaCegusudTWo/fHUY6940AUUsoU6ncsOqNyEPUUTU9j+Wr5NKE9
	 vEGlBRWdEnNptTb2tJo5mUr5IndcpxqGbY6PklFqAf2BSOOvPibX4VvL+nCEnwzwe+hQ9
	 DJ7dztLciZTXY8ZFh56ZTirVjAibqHU64Wyaw6hajLpH+twcEM5dmt0oavzqAyUGC7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794394530;
	bh=SF2NQhuQxu5m0bI5v5rpx1rhcNXkOJ4L4wUCi27ileQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vYJ0kWLunJ+kx24k/anlX1dn9BZk1zilgDLYEcw7anAX2rZt/JRORaZ351WDKFSiO
	 FZ10BRj1dmL4lSmsZs5LJNmsWpbIRGXByc0JakCbip3k8y1BRlqYX+u6B5UXAR3Tsq
	 yvw3na3VSHRgJs8qtvNRYTupYwaONDyvVUr6qC0nPwzOHKJzQAosEIXHdQvl5Fradw
	 uh1bGMegl51501jLZutrxhlA6wUg5GjrnkhgzbDCPw3D6AwvoEIU3U2yNip8uUmYDc
	 oBmC44duWBGUGvVipUypfJYNtz4iXkkXjEaQOmztaXZBnVCKczDKd/OcZ6uOVv2r1g
	 /oBBLe66gBVRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A3ED40624;
	Wed, 11 Nov 2026 10:55:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 34B09731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1478D40217
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IGU8dd-JNHR5 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 10:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AC206400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e7c28ZRA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC206400D5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794394525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SF2NQhuQxu5m0bI5v5rpx1rhcNXkOJ4L4wUCi27ileQ=;
 b=e7c28ZRAT8ymtGjwBPQPIQt0wJ9p57/GNR7jsfIGv+g7BNDBhXrN7juVuvt3uxGVR378O/
 Erb7FwKw+x7cYjIyWAPuODTXH32YHy/ovX4vyfvqptwzjk33zDRkZdXnJNY7A6wfJibrth
 rIc0AUP50DW5kUVqM2NcuxtQEtq57eQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-Oqo0X7NTPyKcaINytLDz9g-1; Wed,
 11 Nov 2026 05:55:20 -0500
X-MC-Unique: Oqo0X7NTPyKcaINytLDz9g-1
X-Mimecast-MFC-AGG-ID: Oqo0X7NTPyKcaINytLDz9g_1794394517
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EAC619775DB; Wed, 11 Nov 2026 10:55:17 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 523A518004FF; Wed, 11 Nov 2026 10:55:10 +0000 (UTC)
Message-ID: <fe93c3de-e478-4bdf-877a-d3c5d345dd04@redhat.com>
Date: Wed, 11 Nov 2026 11:55:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] ice: dpll: notify TSPLL lock status from
 the periodic work only
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
References: <20261106121005.1327603-2-ivecera@redhat.com>
 <179433319925.994134.5092477928749468374@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433319925.994134.5092477928749468374@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ZXDGyKAFnuNxkWsDKAhJTKtjSRzmiIfZSg9Si9i65MU_1794394517
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 18:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] This patch leaves the comments in
>    ice_dpll_tspll_state_on_dpll_set()…
> 
> --
> 
> ice: dpll: notify TSPLL lock status from the periodic work only
> 
> This patch stops ice_dpll_tspll_state_on_dpll_set() from sending a TSPLL
> device change notification from the TIME_REF pin callback. The callback
> now only updates dpll_state. ice_dpll_periodic_work_e825() refreshes
> dpll_state on every run and sends the notification when the state differs
> from prev_dpll_state.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
>> index ade1fb3dd0674..bdbcf7af296eb 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> 
> [ ... ]
> 
>> @@ -2947,15 +2946,12 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
>>   		WRITE_ONCE(pf->ptp.tspll_locked,
>>   			   new_state == DPLL_LOCK_STATUS_LOCKED);
>>   
>> -		if (tp->prev_dpll_state != new_state) {
>> -			tp->dpll_state = new_state;
>> -			tp->prev_dpll_state = new_state;
>> -			changed = true;
>> -		}
>> +		/* ice_dpll_periodic_work_e825() compares the state with
>> +		 * prev_dpll_state and sends the notification.
>> +		 */
>> +		tp->dpll_state = new_state;
> 
> [Severity: Low]
> This isn't a bug, but do the comments in ice_dpll_tspll_state_on_dpll_set()
> still match how the notification path works after this change?

[...]

> Could both comments say that the periodic work picks up the new state
> through pf->ptp.tspll_locked? Then a later change is less likely to drop
> the WRITE_ONCE() as just a way to avoid spurious notifications.
Right, the first comment still gives the reason from before this patch.
Now the write of pf->ptp.tspll_locked is what brings the new state to
ice_dpll_periodic_work_e825(). v2 will merge both comments into one that
says so.

Thanks,
Ivan

