Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858D60A2608
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ab8qiiiX;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OrU5yJJt;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OrU5yJJt;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OrU5yJJt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4259B810E6;
	Tue, 10 Nov 2026 12:23:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XoifpIpjdnDx; Tue, 10 Nov 2026 12:23:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 60D508112A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313399;
	b=ApNo2dcHmFl9Rt3WDVisvj0aXSirqm2c+psjdhaC4ZchqysFyVBs9s/0qZgyKmY41ilX
	 psXyb+W5YQ1in8O0Qz2L335kCRkUPtkdztrs8oLEyt0voobrcLS6o/c4iYh23/VTy/Ind
	 CXQuwl0wUeFUmIfUbzP6NOtMv0MV2roygQcnbEDtv7GDpSycHs/rlbzT72j7v0mn2uvEy
	 8FOJht3khfj2j+HBU03YOCPIKKazsiwWETDi//BZ5Bfy6pTUGjkx208HYLHOQQi1Aj+u8
	 AJ39OMURAwuabZHeA3VGv/KJkKKYAPBj3Tq6gxFOLPRTPJTURTlxUG8146UT3ogxvqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313399;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LiIl7kgsfTWpSgySm1Nh3N0Z7OZvnmYj+mfXUmSTco8=;
	b=PCYho/rvVmD1zXYuaVyZ+OYUvRT46qeIPx20wP2QvI4+0siUySWo2FnpZ8N3RwnFFGqd
	 JZtfzz9ss3lleB0eJ5eZG98u1Hh1LZhrejjF610499aXrKhKFK6pEyPjyit5faSC+hJHK
	 gAZDTCLGWDENlokafu4vAE/y7TP4udt8SBY+nAhPqC8Zet8jANvpkn6bwyydUScWnL6Ik
	 xRbDsyxqwoGryj1HEOzvraOFs1A2myRx2f7VaXARbWB3Jk9xsb3Fr5WxQFsaW3Bjhxg79
	 aOEx1bOaqu8T1MeJL7m5I3HPULsj5heBq35/PrgDn9ByZ+8Ka7UwWJFITMKrLpFX8iA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OrU5yJJt;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OrU5yJJt;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OrU5yJJt;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794313399;
	bh=LiIl7kgsfTWpSgySm1Nh3N0Z7OZvnmYj+mfXUmSTco8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ab8qiiiXSK09tGWqVw4cThFEofu8ul6J3Dv2ufL28hLumDaK3fgadT25leCxOhGfg
	 TChu8vctX+TgoMdbQigguQ50EhPTRhA/KKtQTuNZWPF97+c+np+2rrfGSA7BxvP6P9
	 6jq9glCPHUtTft602EOq1J4J8gp4wD1vFd6RP/74ZSHhfdYPSaH8cBRzrwNVtuvlYz
	 7USc02cJMzLbwYr2/ddbJXdLe/RHWeHLUlUn7H/o1uW/BmalhXr23wuSyFaCPx+9vz
	 wQb8/qWLhUqmoLGCayE1x1OWrCGRSZiGEt2a+HNxBAEeM5CYEdycciEygJWcE8n11G
	 oYq6RPY3E672w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60D508112A;
	Tue, 10 Nov 2026 12:23:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B0621731
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0DA4810E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hgOkphr4YMfN for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 12:23:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36EC68100F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OrU5yJJt; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OrU5yJJt; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OrU5yJJt
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36EC68100F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LiIl7kgsfTWpSgySm1Nh3N0Z7OZvnmYj+mfXUmSTco8=;
 b=OrU5yJJtu/Btuj7cDFGGqY3Vu/AfMExTwnxYseVkCNqpQZ1bab+TtK8UWuIgQpkQJ0nbyL
 lE7qZXDX+a/xk9BidG2ALHMzInSXQxN4Nnz4mmsaEL5sMrezOcysQUI+kQBUjxnN+6yibm
 YGTDvmTXb2CIK9hNRdJuj5WVwYXOahE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LiIl7kgsfTWpSgySm1Nh3N0Z7OZvnmYj+mfXUmSTco8=;
 b=OrU5yJJtu/Btuj7cDFGGqY3Vu/AfMExTwnxYseVkCNqpQZ1bab+TtK8UWuIgQpkQJ0nbyL
 lE7qZXDX+a/xk9BidG2ALHMzInSXQxN4Nnz4mmsaEL5sMrezOcysQUI+kQBUjxnN+6yibm
 YGTDvmTXb2CIK9hNRdJuj5WVwYXOahE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LiIl7kgsfTWpSgySm1Nh3N0Z7OZvnmYj+mfXUmSTco8=;
 b=OrU5yJJtu/Btuj7cDFGGqY3Vu/AfMExTwnxYseVkCNqpQZ1bab+TtK8UWuIgQpkQJ0nbyL
 lE7qZXDX+a/xk9BidG2ALHMzInSXQxN4Nnz4mmsaEL5sMrezOcysQUI+kQBUjxnN+6yibm
 YGTDvmTXb2CIK9hNRdJuj5WVwYXOahE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-mL0xfzkLMUCsCgirW4mMpQ-1; Tue, 10 Nov 2026 07:23:14 -0500
X-MC-Unique: mL0xfzkLMUCsCgirW4mMpQ-1
X-Mimecast-MFC-AGG-ID: mL0xfzkLMUCsCgirW4mMpQ_1794313393
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e0461e040so1568943f8f.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313393; x=1794918193;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LiIl7kgsfTWpSgySm1Nh3N0Z7OZvnmYj+mfXUmSTco8=;
 b=WbXnpx5FB7+/yTbfAkYyXQnaVM8eNzEtL6enxTAhGpdxQeR5o3S7z7tRRd2OVKT1Rf
 C216bBZVBdZEYE7SQRiiy8UeQS4iiapk12z8UVlRoK+OTZbauj1U1OiBKReeYJcLMexm
 mKVj5fjfWL0qjJ7KZWWBBBv03/Q7kDFMzStMB4qdNrueQQAmnG9BhCk81sRgjvOjN1An
 LoUaNVkiOAz3GpGr0oM18BWJ0y5dq6N326SwRWfiosZpezKwaW2OWAGOADA1wbFrPS3w
 iNp9gng879b0pHkq1trE3I2A55SeOwR9k1qrCS07Rr8lm59E1pTpCK0PDUd2C3NdzC++
 hliQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF3GNqTx3LjIQ4aZHukpLb1NVtx9+5J72OmiwJeSKHJq8XKylDtE54BdD/YjeT6J+fYUO0NCr3zprmaAvh9kt0=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9oxdRY4sIjOJ3ysF736erYIdUcfxQTT1MhFFib/3FsRBIuqFrJ
 xbHKxCpCj0gm52Qy7bOVyjCi8xU8dz1hHbxdLNYXvGb4NAszlFvEGF3u/WXgwHC8ncKRvDdl8yr
 dRSpvCnXaFctrwq6UwNAmvRL8YKkm7SVbUZXmC2/S8F1PdQrdSa/MWtBITA0ZY3wqHene6UHw8/
 Z+YDMR2g==
X-Gm-Gg: AYBFou34SQyiZJSOrHnaBC8CMkvaLumZ4hHWmFcDgX6B/GRj4Zfg9xvNrm2gu/bLW9R
 WJZm9IZU3ToUy5GDaP5HDNydnMkq3uo1igLRFBpF7Z25RBsCHIMMX4mVPK+JIOzWDTWyH/qKYxH
 SJiKvTUqpvdzPV6oGIoVhkJnW6B5I2qjOi9t5WfOkZU/0T+bQgp6nqGX9DZzqFwuLrBC/qdUCMZ
 lIAuh3fG5Rf65NKH2esJ1+ZCaY7XJFmhQDayJ1i/P+TXO5guppYPEpk6pMbYyded/4Y76a4eRFn
 nRvDWAqP3v+OTZeOgKAeNvQA/Id9QML2N91kWMmeovl94WGg1sYfY0rLcocs/CRsus1ahaLQtGi
 DoCYOHbk8ZVMN1M/Kv2GW7j47haDXUOyBlz8=
X-Received: by 2002:a05:6000:310d:b0:491:45bc:d69a with SMTP id
 ffacd0b85a97d-49830b9797bmr5613038f8f.44.1794313392915; 
 Tue, 10 Nov 2026 04:23:12 -0800 (PST)
X-Received: by 2002:a05:6000:310d:b0:491:45bc:d69a with SMTP id
 ffacd0b85a97d-49830b9797bmr5612980f8f.44.1794313392451; 
 Tue, 10 Nov 2026 04:23:12 -0800 (PST)
Received: from [10.43.3.161] ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983600bc9asm4459078f8f.29.2026.11.10.04.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 04:23:11 -0800 (PST)
Message-ID: <ef9829b0-845b-41bd-bf58-dd8c28baaab3@redhat.com>
Date: Tue, 10 Nov 2026 13:23:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] dpll: add domain object
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
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
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-4-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-4-ivecera@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8zuqEAQ34PWqfd52RVKW-XP-yruT3VQoSHaYOHkU0Xg_1794313393
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



On 11/6/26 1:09 PM, Ivan Vecera wrote:
> All dpll device and pin callbacks are serialized by the global dpll_lock,
> so a slow device stalls all others, whichever driver they belong to.
> 
> Add struct dpll_domain as a preparation for serializing callbacks per
> driver instance. A domain groups all devices and pins created with the
> same (module, clock_id) pair, which is in practice one chip or card. The
> same pair already identifies the owner of a pin in
> dpll_pin_own_dpll_ref_first().
> 
> Domains are kept in an xarray, like devices and pins, and they live only as
> long as their objects.
> 
> No functional change.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_core.c | 61 ++++++++++++++++++++++++++++++++++++++++
>   drivers/dpll/dpll_core.h | 27 ++++++++++++++++++
>   2 files changed, 88 insertions(+)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 8389983f425695..d39c4905172f2d 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -24,6 +24,7 @@ DEFINE_MUTEX(dpll_lock);
>   
>   DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
>   DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
> +static DEFINE_XARRAY_FLAGS(dpll_domain_xa, XA_FLAGS_ALLOC);
>   
>   static RAW_NOTIFIER_HEAD(dpll_notifier_chain);
>   static DEFINE_IDA(dpll_pin_idx_ida);
> @@ -88,6 +89,50 @@ void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
>   	call_dpll_notifiers(action, &info);
>   }
>   
> +static struct dpll_domain *dpll_domain_get(u64 clock_id, struct module *module)
> +{
> +	struct dpll_domain *domain;
> +	unsigned long i;
> +	int ret;
> +
> +	lockdep_assert_held(&dpll_lock);
> +
> +	xa_for_each(&dpll_domain_xa, i, domain) {
> +		if (domain->clock_id == clock_id && domain->module == module) {
> +			refcount_inc(&domain->refcount);
> +			return domain;
> +		}
> +	}
> +
> +	domain = kzalloc_obj(*domain);
> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +	domain->clock_id = clock_id;
> +	domain->module = module;
> +	refcount_set(&domain->refcount, 1);
> +	mutex_init(&domain->lock);
> +	ret = xa_alloc(&dpll_domain_xa, &domain->id, domain, xa_limit_32b,
> +		       GFP_KERNEL);
> +	if (ret) {
> +		mutex_destroy(&domain->lock);
> +		kfree(domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return domain;
> +}
> +
> +static void dpll_domain_put(struct dpll_domain *domain)
> +{
> +	lockdep_assert_held(&dpll_lock);
> +
> +	if (refcount_dec_and_test(&domain->refcount)) {
> +		xa_erase(&dpll_domain_xa, domain->id);
> +		mutex_destroy(&domain->lock);
> +		kfree(domain);
> +	}
> +}
> +
>   static void dpll_device_tracker_alloc(struct dpll_device *dpll,
>   				      dpll_tracker *tracker)
>   {
> @@ -120,6 +165,7 @@ static void __dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker)
>   		xa_erase(&dpll_device_xa, dpll->id);
>   		WARN_ON(!list_empty(&dpll->registration_list));
>   		ref_tracker_dir_exit(&dpll->refcnt_tracker);
> +		dpll_domain_put(dpll->domain);
>   		kfree(dpll);
>   	}
>   }
> @@ -159,6 +205,7 @@ static void __dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
>   		fwnode_handle_put(pin->fwnode);
>   		dpll_pin_idx_free(pin->pin_idx);
>   		ref_tracker_dir_exit(&pin->refcnt_tracker);
> +		dpll_domain_put(pin->domain);
>   		kfree_rcu(pin, rcu);
>   	}
>   }
> @@ -366,6 +413,12 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
>   	dpll = kzalloc_obj(*dpll);
>   	if (!dpll)
>   		return ERR_PTR(-ENOMEM);
> +	dpll->domain = dpll_domain_get(clock_id, module);
> +	if (IS_ERR(dpll->domain)) {
> +		ret = PTR_ERR(dpll->domain);
> +		kfree(dpll);
> +		return ERR_PTR(ret);
> +	}
>   	refcount_set(&dpll->refcount, 1);
>   	INIT_LIST_HEAD(&dpll->registration_list);
>   	dpll->device_idx = device_idx;
> @@ -374,6 +427,7 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
>   	ret = xa_alloc_cyclic(&dpll_device_xa, &dpll->id, dpll, xa_limit_32b,
>   			      &dpll_device_xa_id, GFP_KERNEL);
>   	if (ret < 0) {
> +		dpll_domain_put(dpll->domain);
>   		kfree(dpll);
>   		return ERR_PTR(ret);
>   	}
> @@ -664,6 +718,11 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
>   	ret = dpll_pin_prop_dup(prop, &pin->prop);
>   	if (ret)
>   		goto err_pin_prop;
> +	pin->domain = dpll_domain_get(clock_id, module);
> +	if (IS_ERR(pin->domain)) {
> +		ret = PTR_ERR(pin->domain);
> +		goto err_domain;
> +	}
>   	refcount_set(&pin->refcount, 1);
>   	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>   	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
> @@ -678,6 +737,8 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
>   	xa_destroy(&pin->dpll_refs);
>   	xa_destroy(&pin->parent_refs);
>   	xa_destroy(&pin->ref_sync_pins);
> +	dpll_domain_put(pin->domain);
> +err_domain:
>   	dpll_pin_prop_free(&pin->prop);
>   err_pin_prop:
>   	kfree(pin);
> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> index da8a369556ed11..6705e81bc11de9 100644
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h
> @@ -9,18 +9,42 @@
>   
>   #include <linux/dpll.h>
>   #include <linux/list.h>
> +#include <linux/mutex.h>
>   #include <linux/refcount.h>
>   #include <linux/ref_tracker.h>
>   #include "dpll_nl.h"
>   
>   #define DPLL_REGISTERED		XA_MARK_1
>   
> +/**
> + * struct dpll_domain - group of dpll objects sharing a lock
> + * @id:			index of the domain in dpll_domain_xa
> + * @clock_id:		clock_id of the objects in the domain
> + * @module:		module of the objects in the domain
> + * @refcount:		number of dpll devices and pins in the domain
> + * @lock:		lock of the domain
> + *
> + * All dpll devices and pins created with the same (module, clock_id) pair
> + * belong to one domain, in practice to one chip or card.
> + **/
> +struct dpll_domain {
> +	u32 id;
> +	u64 clock_id;
> +	struct module *module;
> +	refcount_t refcount;
> +	/* Serializes the driver callbacks of all DPLL devices and pins
> +	 * that share one (module, clock_id) pair.
> +	 */
> +	struct mutex lock;
> +};
> +
>   /**
>    * struct dpll_device - stores DPLL device internal data
>    * @id:			unique id number for device given by dpll subsystem
>    * @device_idx:		id given by dev driver
>    * @clock_id:		unique identifier (clock_id) of a dpll
>    * @module:		module of creator
> + * @domain:		domain the device belongs to
>    * @type:		type of a dpll
>    * @pin_refs:		stores pins registered within a dpll
>    * @refcount:		refcount
> @@ -32,6 +56,7 @@ struct dpll_device {
>   	u32 device_idx;
>   	u64 clock_id;
>   	struct module *module;
> +	struct dpll_domain *domain;
>   	enum dpll_type type;
>   	struct xarray pin_refs;
>   	refcount_t refcount;
> @@ -46,6 +71,7 @@ struct dpll_device {
>    * @clock_id:		clock_id of creator
>    * @module:		module of creator
>    * @module_name:	module name of creator
> + * @domain:		domain the pin belongs to
>    * @fwnode:		optional reference to firmware node
>    * @dpll_refs:		hold referencees to dplls pin was registered with
>    * @parent_refs:	hold references to parent pins pin was registered with
> @@ -61,6 +87,7 @@ struct dpll_pin {
>   	u64 clock_id;
>   	struct module *module;
>   	char module_name[MODULE_NAME_LEN];
> +	struct dpll_domain *domain;
>   	struct fwnode_handle *fwnode;
>   	struct xarray dpll_refs;
>   	struct xarray parent_refs;

Reviewed-by: Petr Oros <poros@redhat.com>

