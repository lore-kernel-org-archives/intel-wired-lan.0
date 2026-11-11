Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DD606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TET56i7h;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bX6mOSMM;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bX6mOSMM;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bX6mOSMM;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bX6mOSMM;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bX6mOSMM;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bX6mOSMM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F8F140B0B;
	Wed, 11 Nov 2026 11:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DnaKpQAq5RqC; Wed, 11 Nov 2026 11:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B841340AF6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794395020;
	b=H3ipTg0jhLLo1/nUfsm8Z55orV1nCSnjOtXVa6k8IcqnHWBctN/6K9eiI6EmcjWXeJW0
	 mQaLhZtgzJQNg5Bs0fMKJHfb06S9ZhyizCq5Pk0Z/+UJtlCURUa/LfkEvW+FJj/qd+7No
	 sdb6jIP6xZ/b29OIJNi0I17kVLzYJdpZ84b9+K93rcvTm5y5TlOY6szcmKELK0LfC/g9l
	 HdfS9jF/V4M/S6mWJkcaZuUIv8PKEtLtpfZs9dCXbrSYaQIo+DS0RSuKp3hoRtabjC4L6
	 j8FtYvh8ScIDeseunobB3K8pqcSuN2JKFNejrwV9U2qRAOBmOb6Qg7UQgWLhywinTLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794395020;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9xCaKikxY5SCwLczpS9oMIGpBnm49BMiWeY8N1jcjvk=;
	b=prTvN4olevhuNs3TlUK2/wvJsFTYy15tPE4w4xNLs7vlalo1J0DWoYeBjhWYzKfXVqQh
	 pPuxcwLjMsCxczXMJzkw6MJIK81AgoJEl3Id9IUCv8RbR8nw4X0WGbfcrmZoSV/FlaKMk
	 zJ6dQ1TOSkpHCS26AWK1XtFXfUtgkGtNwpiuVPihXsa8TNA+7R2hcrgnlITxnqoEdIHjZ
	 caoZ/cXxBKjRq+vm3Sctk95Y9x3cJoIXXFgxHoQYYzqdIZuxxc3Sxylqmuyl4gSDxqc0P
	 qqbH9Y/T5K3q9ldqbFVBZgVwcxokaEERm5Mgvqazc2Y4P9bFFfI8BW5Uzcl+UkHuM2Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794395020;
	bh=9xCaKikxY5SCwLczpS9oMIGpBnm49BMiWeY8N1jcjvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TET56i7hPTKWCaNz5M96GgB1X4C34/clbJqhzjyqdKYp5tk68r2Ek1cyrhpMHTgsC
	 fbfQq+YL7AphUjNh2TUOtPpvI9m0UuY1CnyjLUL9RyQIt2gnO93TNZX7kYY6RTd6zJ
	 TGPqmuo2X/mTG7wuUNLD937ec5gexTv6vMIzrno915oIS09/kY4poYYbB+C0v56eS2
	 yIZAmvRuOCviLLWPexmV81KZv3+YRoIjQdTGUJruD7yuWsAVV3Xd+JJbLI3nsUi6sg
	 HG64tqNRnSLbwfakJkcgeqHZAYiTZHf+brOOAUlr9xo0c0S80F7QFaqjmLkJQ1rWh4
	 bPi2oNPX3ovwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B841340AF6;
	Wed, 11 Nov 2026 11:03:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 569D4F22
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C9CE60796
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:03:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U57_9SE2AUyf for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 11:03:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E31860793
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bX6mOSMM; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bX6mOSMM; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bX6mOSMM; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=bX6mOSMM; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=bX6mOSMM; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=bX6mOSMM
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E31860793
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xCaKikxY5SCwLczpS9oMIGpBnm49BMiWeY8N1jcjvk=;
 b=bX6mOSMMBJ+JRmOa4IXEeeS20w1j/cBjSVShHAu4yNLvq0vvJ4feLj7enxjZ80C1BLgXvw
 pNwvp9FLW9gV/Wc701br1Fhh5f9LDPgWwZY1phnBd1BqOhzx4GmiSga/wYj5XRcwQbq510
 xHHk+YA3/wjBXGdtuV9xLmNX6ukURkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xCaKikxY5SCwLczpS9oMIGpBnm49BMiWeY8N1jcjvk=;
 b=bX6mOSMMBJ+JRmOa4IXEeeS20w1j/cBjSVShHAu4yNLvq0vvJ4feLj7enxjZ80C1BLgXvw
 pNwvp9FLW9gV/Wc701br1Fhh5f9LDPgWwZY1phnBd1BqOhzx4GmiSga/wYj5XRcwQbq510
 xHHk+YA3/wjBXGdtuV9xLmNX6ukURkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xCaKikxY5SCwLczpS9oMIGpBnm49BMiWeY8N1jcjvk=;
 b=bX6mOSMMBJ+JRmOa4IXEeeS20w1j/cBjSVShHAu4yNLvq0vvJ4feLj7enxjZ80C1BLgXvw
 pNwvp9FLW9gV/Wc701br1Fhh5f9LDPgWwZY1phnBd1BqOhzx4GmiSga/wYj5XRcwQbq510
 xHHk+YA3/wjBXGdtuV9xLmNX6ukURkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xCaKikxY5SCwLczpS9oMIGpBnm49BMiWeY8N1jcjvk=;
 b=bX6mOSMMBJ+JRmOa4IXEeeS20w1j/cBjSVShHAu4yNLvq0vvJ4feLj7enxjZ80C1BLgXvw
 pNwvp9FLW9gV/Wc701br1Fhh5f9LDPgWwZY1phnBd1BqOhzx4GmiSga/wYj5XRcwQbq510
 xHHk+YA3/wjBXGdtuV9xLmNX6ukURkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xCaKikxY5SCwLczpS9oMIGpBnm49BMiWeY8N1jcjvk=;
 b=bX6mOSMMBJ+JRmOa4IXEeeS20w1j/cBjSVShHAu4yNLvq0vvJ4feLj7enxjZ80C1BLgXvw
 pNwvp9FLW9gV/Wc701br1Fhh5f9LDPgWwZY1phnBd1BqOhzx4GmiSga/wYj5XRcwQbq510
 xHHk+YA3/wjBXGdtuV9xLmNX6ukURkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xCaKikxY5SCwLczpS9oMIGpBnm49BMiWeY8N1jcjvk=;
 b=bX6mOSMMBJ+JRmOa4IXEeeS20w1j/cBjSVShHAu4yNLvq0vvJ4feLj7enxjZ80C1BLgXvw
 pNwvp9FLW9gV/Wc701br1Fhh5f9LDPgWwZY1phnBd1BqOhzx4GmiSga/wYj5XRcwQbq510
 xHHk+YA3/wjBXGdtuV9xLmNX6ukURkA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-N6vwd9lROFKYldtDPkqikQ-1; Wed,
 11 Nov 2026 06:03:27 -0500
X-MC-Unique: N6vwd9lROFKYldtDPkqikQ-1
X-Mimecast-MFC-AGG-ID: N6vwd9lROFKYldtDPkqikQ_1794395004
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A14B818002C8; Wed, 11 Nov 2026 11:03:24 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 621521956087; Wed, 11 Nov 2026 11:03:18 +0000 (UTC)
Message-ID: <230b9191-ed71-47b2-8e64-456b6c60b480@redhat.com>
Date: Wed, 11 Nov 2026 12:03:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] ice: dpll: update locking comments
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
References: <20261106121005.1327603-10-ivecera@redhat.com>
 <179433320858.994134.3648996641880038315@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433320858.994134.3648996641880038315@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 91Q3UyrVM-oUP0GjVfQ6kBDHf2KloG4-c40m9H23M0Y_1794395004
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
> - [Low] The locking note this patch adds to the struct ice_dplls kernel-
>    doc (drivers/net/ethernet/intel/ice/ice_dpll.h, lines 168-170) is…
> 
> --
> 
> ice: dpll: update locking comments
> 
> This commit updates the ice DPLL locking comments now that callbacks run
> under the DPLL core domain locks instead of dpll_lock. It also adds a note
> saying that callbacks of the external DPLL's pins run under that DPLL's
> domain, so only pf->dplls.lock serializes them with the rest of the
> driver.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
>> index 4ba76e2e2e0b0..39e041a30090d 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
>> @@ -165,6 +165,9 @@ struct ice_dpll {
>>    *     tx_refclks usage map), acquire pf->dplls.lock first, then
>>    *     ctrl_pf->dplls.lock. Skip the second acquire when pf == ctrl_pf
>>    *     to avoid recursive locking.
>> + *   - Callbacks of the SYNCE and TIME_REF pins of an external DPLL run under
>> + *     the DPLL core domain lock of that DPLL, not of the TXC and TSPLL DPLLs,
>> + *     so only @lock serializes them with the callbacks of these DPLLs.
> 
> [Severity: Low]
> Could this note be clearer that TXC and TSPLL are not in the same core
> domain either?

[...]
> The new sentence is accurate per DPLL, and the first bullet still says
> @lock serializes all DPLL state mutations. Since this patch exists to
> document the domain-lock rules, though, would it make sense to say that
> TXC, TSPLL and the DSN-domain objects are each in their own domain?
Yes. v2 will say that the core serializes callbacks per (module, clock_id),
that the TXC DPLL, the TSPLL DPLL and the other objects of a PF have a
clock_id each, and that the SYNCE and TIME_REF pins of an external DPLL
are one more such case. @lock serializes all of them.

Thanks,
Ivan

