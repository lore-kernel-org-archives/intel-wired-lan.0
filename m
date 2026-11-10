Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC60606C67D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=O4ckvti8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PDj788tq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF5BB606E1;
	Tue, 10 Nov 2026 09:45:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AzFBftdt9jNe; Tue, 10 Nov 2026 09:45:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 24669607AC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794303935;
	b=G4sMEQbOUIPdvqvsYIqz8IF5RzNRn+7huv2ubEF4lpBkkh75fM0DNzFNkY+gA892o0fF
	 ZlI3zvDuqa9Yy48yNg36+A+G9rzaj2cQPFZ2ZsXuEF0doyRP/lJXDHOFetzZhTFfDM6DQ
	 edQ+tHgnups+dibYxckg1Y6MYObMM2hkSN6Lvji4nka+OK8TAva1u5LD9k/mRXudjYqjd
	 YkCGoJP4JmChap/ynVkQ5jW+0ymuZa1QUrmHXITFExoBQHszzcr1+qzp7inAXtUOtHGnB
	 xM4qehfOm5EgylrmYhv2L4iDsE2O3HEta+ur7v2TwSlt+ky5mXmHlOOibTaZaZpTAlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794303935;
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
	bh=I0aHNpYYYJjXnks0yXtv3vruSoxZWqR1NIB39pb6v0Q=;
	b=Da3fBx6oNUoo1pP4Sa2owTH9KDB6qUq+6ogQeFSjkc3YMyXnnnEkFX9oZZ7bkGzdf8g3
	 DAc8sEcCtzreXmPAFS0Yl6wVCzN4xSmYDC1jxa1ELlSNKUSH3N5s8vOfS3D8rMyvLNGHV
	 4Q0wdmJGBOiZrBAYPG/NDz2BuauCUZMSUgwlhtUGORPrF6v8qj9bAcnrdzpPxo9rBK3Ov
	 hM+NNanCxKVrBlZDOPrrZHvRCKHzLNYwZQKqVHB4Wg/0XPi4sQ5f6L8sXjVWWjZzo27Kd
	 4VX8NYZpnVwxTWqz8+xDbVmdWNhYiYCuaqsk99dxnLZhFab0K1BYYW5VCnWkW19rpIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794303935;
	bh=I0aHNpYYYJjXnks0yXtv3vruSoxZWqR1NIB39pb6v0Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O4ckvti8WHi/6llBhZsSeIpxsI4aKywzA2rL9lZY+wXC3iPNHbHdBllYWVwiw9VJh
	 mQ3ovlR1Vhxdnhga5Hvml9Hge7i9tYV7qpE/11b0A9qm9q56wR4JXxW0oQFyAXZnMY
	 uAz6XsTjhCgCrRj3PooYWVEWYR8vxHbEwtOkhhF95WPqyENqcYRz26qd8zcdgeVEQu
	 lUTt9j7XF6kX083NCHNZ+/+n97PUHwcazobZv/zVohziiGndkA+SIrcdr1R26awYs+
	 4LloXbu6lvvrV+IolXivlbuLHu0MHDCBtg0+3gLy4efykNDF5UijIl7Cp6mKnZZmfs
	 PFcWR41xb40GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24669607AC;
	Tue, 10 Nov 2026 09:45:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CF2F1FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A5B8405AD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pBhlQTxvQsYD for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 09:45:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9FA36405A9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PDj788tq
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FA36405A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794303931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0aHNpYYYJjXnks0yXtv3vruSoxZWqR1NIB39pb6v0Q=;
 b=PDj788tq2Ybt7hmH+lpvdKGfFnurGot/cpRXvsJImimVa4W2uJLrnXU2yiviwz/LAkmVo9
 M/4bcKX6NsfEwamZYWfeeUp7QbDs+6hxLkYtS+A7BBC6AebTx2iEp5vfskLkOg1Z9XPNav
 yl754wD3IB7Cqm4SfyDiy1Wxtz/wsVk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-M3SqPeGFPAiHztvTxAVf4g-1; Tue,
 10 Nov 2026 04:45:23 -0500
X-MC-Unique: M3SqPeGFPAiHztvTxAVf4g-1
X-Mimecast-MFC-AGG-ID: M3SqPeGFPAiHztvTxAVf4g_1794303922
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A52619560B7; Tue, 10 Nov 2026 09:45:22 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B840A1956086; Tue, 10 Nov 2026 09:45:21 +0000 (UTC)
Message-ID: <d5acc725-dd95-4e96-89ca-364db2444b61@redhat.com>
Date: Tue, 10 Nov 2026 10:45:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/10] ice: dpll: serialize changes of the SyncE
 CGU registers
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-3-ivecera@redhat.com>
 <sashiko-outbox-202874@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <sashiko-outbox-202874@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 7T9kqR8cmIacgmGcp6XoKg6h1-fWpTCytmhV8vvWXQw_1794303922
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/7/26 13:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] ice: ptp: unconditional R10 write and lock scope in
>    ice_ptp_link_change()
> - [Low] ice: dpll: missing Fixes trailer for commit ad1df4f2d591
> --
> 
> commit 6fdc60cccd47bebe7d61ff60807ee77303bf58bd
> Author: Ivan Vecera <ivecera@redhat.com>
> 
>> ice: dpll: serialize changes of the SyncE CGU registers
>>
>> On dual complex E825 only complex 0 has a functional CGU and the second
>> complex reaches it through cgu_peer, so PFs of both complexes share the
>> CGU registers R10 and R11. They read, modify and write them when the
>> state of an RCLK pin changes, and ice_ptp_link_change() rewrites R10 when
>> a link changes, under the pf->dplls.lock of their own PF only.
>>
>> ice_ptp_link_change() does not hold dpll_lock, so it can already overwrite
>> an update of another PF. RCLK callbacks are serialized by dpll_lock, but
>> the DPLL core is going to serialize callbacks per (module, clock_id), and
>> each complex has its own DSN and so its own clock_id. With that change, a
>> test toggling RCLK pins of both complexes lost an update.
>>
>> Add a mutex to struct ice_adapter, which all E825C PFs share, and hold it
>> around these sequences.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> [Severity: Low]
> Since this fixes concurrent CGU register updates in E825-C SyncE support,
> should it include:
> 
>    Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
> 

Yes, the race with ice_ptp_link_change() is there since that commit. The
patch now goes to net with this tag:

https://lore.kernel.org/netdev/20261110094350.184185-1-ivecera@redhat.com/

v2 of this series will drop it.

> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 3df08714510da..4d4b6aaaf30c2 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -1395,7 +1395,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>   				break;
>>   			}
>>   
>> +			mutex_lock(&pf->adapter->cgu_synce_lock);
>>   			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
>> +			mutex_unlock(&pf->adapter->cgu_synce_lock);
>>   			if (active && err) {
>>   				dev_err_once(ice_pf_to_dev(pf),
>>   					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
> 
> [Severity: Medium]
> Should cgu_synce_lock also cover ice_tspll_bypass_mux_active_e825c(), and
> should ice_tspll_cfg_synce_ethdiv_e825c() be skipped when active is false?

Yes to both, also there since ad1df4f2d591. Patch 2 of the net posting
skips the outputs the port does not drive and checks the mux under
cgu_synce_lock.

Thanks,
Ivan

