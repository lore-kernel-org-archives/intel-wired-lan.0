Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B745E606A204
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YmQ6JY6y;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BRgueDG5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9500781342;
	Tue, 10 Nov 2026 16:31:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIfKF5TST6vK; Tue, 10 Nov 2026 16:31:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A9CF681304
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794328290;
	b=eAkNckesEiFRdr+uOpkPiDyJi1btBOJN4KKd4/ydG2CUAjcJQi3zXv3gxIJLgLkfcZAD
	 68vZT4Jra4E0PJAoPXVDXdLB1vhdC2Gf0ibErHfYLoKjjfdtYWSXuhTzGfyNHHTJrCVij
	 LskAb9F9KwY2S95IlvW6CI8ZIv/VzQ//f30XE7z5gLSNTQJSOuPbBIJsZPKmldZZSuNv2
	 q92imi/GVAg+r3Z+k2ovwSCHMLdycokpXb2z7HeJ52cyFvhWtooX5CvUuVSgBWUn/F7Ug
	 c5bD6k8dd48qx0HhgNKh9I+yLXJQ8uCmRDkbtnMKMLn5d0PQ/l2fiTQqfVzBhzEeAMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794328290;
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
	bh=gXjqAYmOZzBpoVOClTeMCf3Fr5RoD9/tZaRkMD38hnw=;
	b=b5zIyS/PkXU3/GCB73i8T8iZOfYlFNJgNPBw1PhFFo78ITItC9/ieXkUMQY7/i+QfO06
	 occta846H6zxMJj29F7xZ9Kb0kGZztnZXAiVn6X1eZUmT7tglVPCOyFzd2DEUoiiMccQr
	 828g4iYaI2qVky6EqydPvK93jNRfrB8V65jT8NQ3RTeHcHn1tnlwqA5dGSZFjcNseBQu9
	 kJRlHF7yWN5uAfdAnNvGhqMz1AcemW8Es1GZ66JtyTBlvJuwRB5iDrClT3J+IrGl6w55x
	 ZxFBbodQEf4bpLoSFB7JZNblXzdaS+isw/HDyJiI1tdvWkuJDJGCOAp9c6+oFF62wcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794328290;
	bh=gXjqAYmOZzBpoVOClTeMCf3Fr5RoD9/tZaRkMD38hnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YmQ6JY6ydJbQ1cmxrsNE+UQ1453twVld5/C593Y1UC8JnyRGqClZlC734dNY11ipb
	 i7FdC9qVkHk1FY5Z+YAQIO9rNdnxr3fLPptdRqIvDSOg+PyuzoYQ3/yZt03fqk1eON
	 gBcSehE7x6bancBBM/nFm1JyEsMsDIe0aBTl3emeZ9VPbj53QeAQWzyC5r3t7A8u1Q
	 nYy1ea+f0GodOdsrTEiBfwpIxw2hzI7i4rks634mSc8gQg4YZdL5XThxKlNhjgqroP
	 d0MXdKXm9J8jvQiaZfsemj9BcBdv3NQZDC3bQaMWjQQ05s9jtI2VC+Nf/EtfRl5N+r
	 1D/vQD+jg5ClA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9CF681304;
	Tue, 10 Nov 2026 16:31:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C94D71A6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 16:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5D0F60892
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 16:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJFquPvouN1q for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 16:31:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E2CE960872
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BRgueDG5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2CE960872
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794328284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXjqAYmOZzBpoVOClTeMCf3Fr5RoD9/tZaRkMD38hnw=;
 b=BRgueDG5MeaRxV3Z+yZWtdq9sVwbwtjMb3zGb2T7+Fhbcew2sLBchl7YDeee6UVy/HUtEQ
 ICGJpZiLvMM8dfxAOtwTio7hlHoYV5yZyjJmK4JNAEMs+oEPBG3JK7me5/NiHXhJsWQu9T
 NwsEblucE3xKyVrfupndxioWdvMyCYI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295--29stya8OC2ROZFuIZx-Vw-1; Tue, 10 Nov 2026 10:31:08 -0500
X-MC-Unique: -29stya8OC2ROZFuIZx-Vw-1
X-Mimecast-MFC-AGG-ID: -29stya8OC2ROZFuIZx-Vw_1794324667
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a0284121c6so16979825e9.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 07:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794324667; x=1794929467;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gXjqAYmOZzBpoVOClTeMCf3Fr5RoD9/tZaRkMD38hnw=;
 b=lZvC1Hwo/QIK9RqCcwy8IVjiXPq3L42yPfwH6d5Zfy2662AFumpgziSZHiPrBiAnzl
 g0VcjF5OE7ORMlqTsH6B3h1EK/MfB5iG3ThBKGodbmy2XWna0h4HfFWSApOjDAifyCop
 jp2AJiIhr+tARTG5Zdp1dDD4oCWa4eUkRttvAqkppng/8FExzdzv5zyxFqoFPg89X71p
 tBikY1oZgL/2Gmv99lLhd3JPm86874w4DTQIVO2Q9ubeItejFAVkC4UISXgXy6ODUBUH
 +dBVBFhk2aC8oGee73ETGiqfwGLvD6rlwCHeeKPQOzykmBScl0oD318yO+qvcSN20jqf
 tAbw==
X-Forwarded-Encrypted: i=1;
 AL+hErFFBJZaPQ4lSHDOzs4FPGQfp+C4uD0mk5RtSDFcQY4dnSq3rYHVubk9rdylFL1ib54Zf33xzQzM1J42NoEq8LI=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8CfH+6rf88/fjRZDhEjl172aykMegpIMxVa6fv4A0RvGh+mDAj
 x9ts/Ogzh4BgBWrZpFbmlOsrO9qyBU3mJz/cO07vZAx1pT3MHddWlMaAA5MJaCxga8p43WYnFpB
 WkNC+XxoQ8QSBcp7MLm+x60vul0n52IY8vTznGrTKJtJGfdomzJNF4WpYhC/zhVdSRJkxSAo=
X-Gm-Gg: AYBFou0oXvFKnbfca4hd0/SqkRrgGTy1bIQ604Ghccx35hG8yWrulsmX8WHNcjt8/a+
 TVxov4tVdqKZiTyvO1KUIgB0KOQyR5EAg2UXqbl3b1+ellRFOa5aZ3P2pBvWfj6c47KEp+oUvGA
 CjyQhiQr+8fzFPxvSFA8DAfCbb9hxcYn0DByWYvwiwhFUpi5rPPfN1bcsdQdLqDt+QpAJ1k3VFR
 2A12N8Awk3N8coqhKbdqPbhuxFGeASvbzDnDmP/aDcd5eIYzcc0fTFij1KKUIZHk491Ha/vvsxu
 tM6Ud/HavOSbTJTb1RVyPX25f54Fc9Q9syNvb3WBnsx7w8/2ILRSvDG7IYAx2O6TxaqreS/7puy
 8NLFgNqNGFCm1mbrj5/X5c3IAEZoj5m97Obg=
X-Received: by 2002:a05:600c:811a:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4ba02348d9amr50067615e9.16.1794324667005; 
 Tue, 10 Nov 2026 07:31:07 -0800 (PST)
X-Received: by 2002:a05:600c:811a:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4ba02348d9amr50066905e9.16.1794324666429; 
 Tue, 10 Nov 2026 07:31:06 -0800 (PST)
Received: from [10.43.3.161] ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba022ff5c3sm31998605e9.0.2026.11.10.07.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 07:31:05 -0800 (PST)
Message-ID: <f85f84fb-6e19-465b-8bd6-4d62998c1f5a@redhat.com>
Date: Tue, 10 Nov 2026 16:31:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] ice: dpll: update locking comments
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
 <20261106121005.1327603-10-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-10-ivecera@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OnJA0aiwTFb-FxPQnrzVazZbqeaTD6tt44Q0FHdkVjM_1794324667
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



On 11/6/26 1:10 PM, Ivan Vecera wrote:
> Callbacks run under the DPLL core domain locks instead of dpll_lock. Note
> that callbacks of pins of an external DPLL run under the domain of that
> DPLL, so only pf->dplls.lock serializes them with the rest of the driver.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 4 ++--
>   drivers/net/ethernet/intel/ice/ice_dpll.h | 3 +++
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index d6302409a2dacf..07cbd4cf0160ca 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -1178,8 +1178,8 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
>    * peer via dpll netlink learn about the update.
>    *
>    * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
> - *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
> - *          still held by the dpll netlink layer.
> + *          released.  Uses __dpll_pin_change_ntf() because the domain lock
> + *          is still held by the dpll core.
>    */
>   static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
>   					struct ice_dpll_pin *changed)
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
> index 4ba76e2e2e0b01..39e041a30090d0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
> @@ -165,6 +165,9 @@ struct ice_dpll {
>    *     tx_refclks usage map), acquire pf->dplls.lock first, then
>    *     ctrl_pf->dplls.lock. Skip the second acquire when pf == ctrl_pf
>    *     to avoid recursive locking.
> + *   - Callbacks of the SYNCE and TIME_REF pins of an external DPLL run under
> + *     the DPLL core domain lock of that DPLL, not of the TXC and TSPLL DPLLs,
> + *     so only @lock serializes them with the callbacks of these DPLLs.
>    *   - @txclk_notify_rwsem is held for read across
>    *     ice_txclk_update_and_notify(), including the out-of-lock
>    *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side
Reviewed-by: Petr Oros <poros@redhat.com>

