Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6C606A325
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TBtKUZCj;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gaZ+IBrY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D24B40859;
	Tue, 10 Nov 2026 12:25:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5EOrkZ55rwEm; Tue, 10 Nov 2026 12:25:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B89294088B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313507;
	b=Y+hrrScy9n+u0sPT1TAjiemkcCepiUzw+cHTVRpox65oS1Atk3dSvXq/MtNmSnz+NIHZ
	 O/9W9pnX//h8Nfyvqjqk8ovL+zsbCU42xVOgtTs7mjEnK2bh8jeP/sO9buxOW/rOSuRFe
	 H5wdeqyLQnthjJRefnU3PsAc/Js4/ajyXqMddMbtSNGY1RXSiJN3FaCOIjRGWZCRnmdX3
	 bS04XscJ218qQ3uZLg47iZtU5U4TovgFOCNFgtkBJEH2d59CK1ieAEH5bWZULHpZTigpS
	 pglLWy0TB9AVfYDwoCFTnaE3zuouCS/gxqpTFDiu8QhlWSQ5J9Vx+CYHO0F3EvrmH5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VQa/zF/czqRgBTE3EecGrylKNQt9LYXwl13l8Xprd24=;
	b=eXPoWZtSslqnEvi1pfssJcUWXDSLehQuKnKKJTfvZO6EGTSIecQ2r+o0oBDOr140Kb0X
	 ZvuMO3vNKLvDhW5ucGSNxxQVTnNPsD/Q5okJfqwYd1nF7p2m7nIhGtdtpt/bCozPsEi4B
	 V8mLDLhMXfGoNJv3e4No5UnFP88dqO0ARxzubY6asVX4sWBTbOIpJKxR188PMQ6AiWiMv
	 v9BN/7K62UHtzvXUZ5OYWeolD9jPn8MKuyXF29kkyaRoOJedjsuNC3C1bXYe+nXrAfWVw
	 /gx7839lNa5y3w2QIH9GFG5X2TPemgRqMrCsV3PZ+X24+XRoChRpiRp83d3D7ykQ5wA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794313507;
	bh=VQa/zF/czqRgBTE3EecGrylKNQt9LYXwl13l8Xprd24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TBtKUZCj26XaczH18QdLHKodfCmZLvqQsb2fPX0h/PL0mFsXBv6s3oLuIkihyKYZl
	 +wFbFxsMjU0cR8t+kXF724JIddWhzSq0P059MScZ3uXiiRdcsNb9RIz5aFcryu8ezx
	 prKq1cQt3wbR55Y/tXlRUM1PV+hVbHMSYiMAj5LEY4jrCoQf+Q1WnOQpI2uD2sUBNN
	 gLt2pqFVzBXtLFTyoOjqZrke5bHPvCm/HXhunsuXUN7vGrJ3MCzPfdT3EMgkIaEVXH
	 8DLa5G75AisiqVaYrnW7nETsmZ9rCyucOe6XQKiyX7znbo/JGfY2kmtgS6XS84GNH9
	 dINxL/inbRtoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B89294088B;
	Tue, 10 Nov 2026 12:25:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 568499D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51160811FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:25:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atDXhmCss6Kf for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 12:25:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92C6A811C8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gaZ+IBrY
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92C6A811C8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQa/zF/czqRgBTE3EecGrylKNQt9LYXwl13l8Xprd24=;
 b=gaZ+IBrYaGjCsDwNYEB6oSb7EW9VO14HBJyLO59SM4yoyWfheDygnM5cEuoCQInMwVxdkS
 PUMGXLOQ50srcwtPyAJ5MYfAvsN8jVgz/uo8mfFoiLj1uHey8Peb/xNmqYFuWYOJqq1bDA
 p6n3r7IliiJaF5WrWdwgDliDSCiUcGo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-I8SMJnAYP32oyobfZJx-1A-1; Tue, 10 Nov 2026 07:25:03 -0500
X-MC-Unique: I8SMJnAYP32oyobfZJx-1A-1
X-Mimecast-MFC-AGG-ID: I8SMJnAYP32oyobfZJx-1A_1794313502
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4ba078abd78so1169565e9.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313502; x=1794918302;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VQa/zF/czqRgBTE3EecGrylKNQt9LYXwl13l8Xprd24=;
 b=OtXY+YrzbO8eu32fSSSJt/4hcBVWRZICUfcgoo1VLy5d4NeqlTtPty1hfuFK/15mbY
 lkcGqPEZf8FCyGXPrAS3wfOCgJiU7p3Mn4PFfKwQX5N669KkPQs6UlIT6/bfo7huyyPg
 QAPswwmmXGhbu9bcXNItUpHCpyujtSEgk/b1OlKC1+6x/8pjm/eG5bephQuHW/CvaYnk
 hD/JHZucm95p5NlOY683uqlknnkkCtJy1rURHNqG8em5qPaThkXLRRDzv2017BTZPHE+
 Zwpu7ZonRTngTlEQjVZ+Cf36kyVR0lb6po/SecjntZ8XiApUepFTOEnQlFmT0bSvLPer
 QOIA==
X-Forwarded-Encrypted: i=1;
 AL+hErGwyOiL87c+GCJL81M3Dw/s4djAjxpz94FXI55uI+YcoKfcUlPPQXMt/NszFoJsW4aePCZOdM3qEgMyHc1N3HQ=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+ll8vmhOcqQCrzEqRUzxgrVSQRAQQVocp9Z92NZcETDKYHdubP
 ZW2XK0GWA3r1NhGArx3bH/MpJ4asAI62VDkHLoXA7Z+DtH3vt1KJE/vW4dM/d3/P05Xno3/xWeo
 VJnnfq1sWhnZud6GKmLKKB8EDhQbO9BMm0kQh/nOOV4xt0Rcc6lGnuUqcSyoBufda9ZkTE14=
X-Gm-Gg: AYBFou1pRQkVi7ZL479ACjSSSBToNqF4Es3tX1snrP7rMmwNkZxrVqgOHDATyMJmxHC
 9LO5i5MTUrJo6ODqg2/RUkieSw8ushaUMh8pvVsbsTS6U/hzH7MG2DCRRecWviNEEuWHiwpbFa1
 vb/BjiRXlihg9a4Ed2mKgqQVySDeksfm+NGuMc0V3G98tvD6wkLxpUtXwN6oeyhRl8EG3UiaRxZ
 86qUTzLysXxEXEoqbPFrBjizPj3f/jS0MmFRjkHJSt1cbwHiPWzeXUNnPnIB87NaYssASORchyh
 ekj2tQi0UtUf9pjJtyKDQno9ETtYPlM48+mXVkxtfkbsGi/K8FXbLMzGWCEXXl6D5p5vZ0NVZTG
 8bx72N8H1NN/Ij8a4oBkbMh+dk/TQjHbYqqo=
X-Received: by 2002:a05:600d:82d3:b0:49d:1fa8:b266 with SMTP id
 5b1f17b1804b1-4ba0234ff73mr46627495e9.26.1794313501871; 
 Tue, 10 Nov 2026 04:25:01 -0800 (PST)
X-Received: by 2002:a05:600d:82d3:b0:49d:1fa8:b266 with SMTP id
 5b1f17b1804b1-4ba0234ff73mr46626915e9.26.1794313501466; 
 Tue, 10 Nov 2026 04:25:01 -0800 (PST)
Received: from [10.43.3.161] ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585c5b9sm4681271f8f.9.2026.11.10.04.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 04:24:59 -0800 (PST)
Message-ID: <42c9a0b6-0828-42b6-ba9e-cd49fb9ef4bd@redhat.com>
Date: Tue, 10 Nov 2026 13:24:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/10] dpll: zl3073x: update locking comments
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
 <20261106121005.1327603-9-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-9-ivecera@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SThx6TjzjvYf2uXKa7xBL_ijarRNewALyNojqKaOKYk_1794313502
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 1:10 PM, Ivan Vecera wrote:
> Callbacks are serialized by the DPLL core domain lock instead of dpll_lock.
> All channels of a chip belong to one domain, so what the comments rely on
> still holds.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/dpll.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 1cdadb8e46fb2d..6e5e2bb41f55d6 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -349,9 +349,10 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
>   	if (rc)
>   		goto unlock;
>   
> -	/* All code paths accessing per-channel reference priorities are
> -	 * serialized by the subsystem dpll_lock, so it is safe to release
> -	 * our lock here before iterating over the other channels.
> +	/* All callbacks accessing per-channel reference priorities are
> +	 * serialized by the DPLL core domain lock shared by all channels of
> +	 * the chip, so it is safe to release our lock here before iterating
> +	 * over the other channels.
>   	 */
>   	mutex_unlock(&zldpll->lock);
>   
> @@ -2401,7 +2402,7 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
>   	mutex_unlock(&zldpll->lock);
>   
>   	/* Send notifications outside the lock to avoid ABBA deadlock
> -	 * with dpll_lock taken by notification functions.
> +	 * with the DPLL core domain lock taken by notification functions.
>   	 */
>   	if (dev_changed)
>   		dpll_device_change_ntf(zldpll->dpll_dev);
Reviewed-by: Petr Oros <poros@redhat.com>

