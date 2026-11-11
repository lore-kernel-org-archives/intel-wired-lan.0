Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F8606A33C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=w1j+AFfS;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FoNN5xMV;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=adzmzsXh;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FoNN5xMV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECF0D4056E;
	Wed, 11 Nov 2026 11:11:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ET0z6IForC93; Wed, 11 Nov 2026 11:11:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 640144059B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794395479;
	b=mCuvaK7VMYNl1hYzbUlSlt9rACUVOKLEzy04McdF10DnAqM3teszx0I4KaBrjkTvxqxu
	 +pW1BSrMp7eSndGXWdRhHUhLsheBMUfjNAVk7Xbq/td2vT4hr0MY06yhMznVBn0JdUUEi
	 uWRGb8O9h8X3Hqn6pubWBolfL2Xh3/QeoDokcMmiDqzpZru3dKYq4o+ilYEF/Omv5l2fk
	 X31jP+Z+F89MEp5YB02UAvpJiJFY+Ikbl+OMgLH/gAtk8j/NOkBTcF+sX20jL+zQZzDUA
	 CwrdCwMV9RdOhvGcLTQiHvyN7X9ZctDI439KcXpSm4Qkwh61zwGyQ3ys4DSEK75Yd3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794395479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Rp/bVGLD3Hu4GX8rmkPcKIk9iXQY7yCw/hdUf9azH8Q=;
	b=T+g3wMz+Ve9W2sIWzHJjT8Iq/OpOr9781n7MTmxoggoqBp+fk2agZVAed8Qgpx8d9TdG
	 TL1clRZu8cpGHTIdaU5wiJ1m3VdIECh8gDQi83NLaUDv8RYNmWuPrnekw44O6ekGhVLB6
	 Juy+/Tcg0qaFnRXKjARXquQNA2Ef3LKf23rnOjjsmqEcPc0jROz0k7b1vx7o1Xq3iyVYa
	 9v2w7/vnf3+l30nrh2tPFGTiKgydb4Te0fhPbPJ/Fp3rgOGrmI7p3fHuh4IMkGtL/uAdx
	 /FL0gCzTh8Rnx/dK+ii+vpSobU+TiODcAqs3oMz9DXYVT6bHTkV94HHE3yy8+vaZZPw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794395479;
	bh=Rp/bVGLD3Hu4GX8rmkPcKIk9iXQY7yCw/hdUf9azH8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w1j+AFfSbBH7VZoqO8x6GhhAXCYCTLVwUd94E1Qq+bYqLyQk+3+ISyreyPV5P4Knk
	 QXKHWVwczJ+sBQEe7+P9Ptv8bLgvBcGJzetQvFhoLkJ6PxhnVuYT8tZTBmLQJ+m42o
	 8A0VbKU8WnHVqHw/WXZdx4uGlBNco99zKOCe/a4jTE1T3k7hhPj8+gDx3H1rdsPG2n
	 btGGKa/bAwsFnYSAnkYGeNRB7Iq9X0uPrXSkVw5qOQcBk4YsnWhHSDSHRdr2oWZvLi
	 l4XoxWnLnjyUXBaanir6hWhRzBqhCtKpyTMeP/eimjAmbhJ7kAAVHmecqeBH+A0fTk
	 8xXeSzJM0voig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 640144059B;
	Wed, 11 Nov 2026 11:11:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B3B7731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CC4B60796
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:11:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 59hMXPLfOzbO for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 11:11:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C888F606E0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FoNN5xMV; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=adzmzsXh; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FoNN5xMV
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id C888F606E0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rp/bVGLD3Hu4GX8rmkPcKIk9iXQY7yCw/hdUf9azH8Q=;
 b=FoNN5xMVBoQw+hbmioG4IGCX9RuB3mudDDoB9SOUEinOSmb29e8ABTWaDMj6N7uL+EdNSp
 DZ+8TMD/joeQgo0QCKo6Ae9ScOONO7HDS4hSS2ylmUeGIrxVMJ2CWFHDI4EvP8RpkUAzgP
 ztCp/Ud4UhWt3AP5weRJSEA3Rim85EU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rp/bVGLD3Hu4GX8rmkPcKIk9iXQY7yCw/hdUf9azH8Q=;
 b=adzmzsXh57OEqV8bixblWp1bBGLcVja3qsgjYN4UMU8inwDO0x02H+hE5qWxP36EkbkCLP
 MTTwuyBNLj/fxjK9apZry5ZzIN+EFG+8r+Fy1hbBITnepLlftucJqJcfGgh0yKBfZI44Ua
 8KsFPLLC+UtIaRjqmHF3yJbRsroWywc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rp/bVGLD3Hu4GX8rmkPcKIk9iXQY7yCw/hdUf9azH8Q=;
 b=FoNN5xMVBoQw+hbmioG4IGCX9RuB3mudDDoB9SOUEinOSmb29e8ABTWaDMj6N7uL+EdNSp
 DZ+8TMD/joeQgo0QCKo6Ae9ScOONO7HDS4hSS2ylmUeGIrxVMJ2CWFHDI4EvP8RpkUAzgP
 ztCp/Ud4UhWt3AP5weRJSEA3Rim85EU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-wRYvuWRePkGJU8Nsa9FDjg-1; Wed,
 11 Nov 2026 06:11:14 -0500
X-MC-Unique: wRYvuWRePkGJU8Nsa9FDjg-1
X-Mimecast-MFC-AGG-ID: wRYvuWRePkGJU8Nsa9FDjg_1794395473
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 108D0180060B; Wed, 11 Nov 2026 11:11:13 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 285791956087; Wed, 11 Nov 2026 11:11:11 +0000 (UTC)
Message-ID: <3ab31a32-2517-449d-8891-9216f5f83636@redhat.com>
Date: Wed, 11 Nov 2026 12:11:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ice: dpll: serialize changes of the SyncE CGU
 registers
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20261110094350.184185-1-ivecera@redhat.com>
 <20261110094350.184185-2-ivecera@redhat.com>
 <sashiko-outbox-208713@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <sashiko-outbox-208713@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 3vG6OUsWZVnpU2hIPFM7MNDdq2js34QPSSLnKn7lfNg_1794395473
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 10:44, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Medium] ice: wrong port modulo in ice_tspll_bypass_mux_active_e825c()
>    [1]
> --
> 
> commit 54d93c3b2bb6d3588addc95fab52eae6473a669b
> Author: Ivan Vecera <ivecera@redhat.com>
> 
> ice: dpll: serialize changes of the SyncE CGU registers
> 
> This commit adds a mutex to struct ice_adapter to serialize read-modify-write
> updates to the shared E825C SyncE CGU registers R10 and R11 across PFs.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 7980eaf9ce253..449819cf8c879 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -1368,7 +1368,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
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
> This problem wasn't introduced by this patch, but does
> ice_tspll_bypass_mux_active_e825c() compute the wrong port index when setting
> active here [1]?

Yes. Patch 2/2 of this series fixes it, the check now compares with
port + ICE_CGU_BYPASS_MUX_OFFSET_E825C, as
ice_tspll_cfg_bypass_mux_e825c() and ice_dpll_rclk_update_e825c() do.

Thanks,
Ivan

