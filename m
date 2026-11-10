Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87852606E800
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5VRd85U9;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2Ztfg4+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66CAD811D0;
	Tue, 10 Nov 2026 16:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xx9AcpOK_bYR; Tue, 10 Nov 2026 16:36:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BBF51811DD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794328587;
	b=IEgddLmxu7sbbPLC1Nmxjko14Fd+1dW5m/T4ko5FbYtsKwa5w51LJ/SFLJsPmreJE5/X
	 p32CatXg039MpWH+N+c5yk/41jU/uMm6GAW5lruwKLjxlZetdy0/iWEMoEe4+Eo5NS1Mg
	 qGIWJw4Cy0DA/ql1Vp7e193K7NxTAq5Xc/2L9U44+i2Um+sQxrWgNpVhOfMgyA+/wEREU
	 L0NLl1I489QISvaHw9aXdv0NWD7ZgiJTey1sVypK7/K5JD1HlfGvz2qoXTkXKJKVJHYtE
	 9/EqL9vNYNd+NqUEHrkTGy/nvsZExXbbTklfj6WINHAhfjQtl8Fj9VBcfujecMdUU0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794328587;
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
	bh=kPdufsPBJpaLhkzWQqqT8FSuhylKhYmUXeIW0aMLwqc=;
	b=d5TO3y30ZSU+mNw/79m8LDwkOkabHqeD1pmZXHjlA+cLXGlXcegq1SMRrytnPXweuKrj
	 rO6RgC8gsVeGTHw2hJKSVszZmmfcwM6MnF/0IWJ6sgc0LtJOGXcK7LmMs1UHJ3kHgdhEB
	 8UYXiS8rFLifKZ8a+xuMzVy52Q3QIahTsdC99AdnW90kkkXQfVx2cxdZdkv62PsYQAzyR
	 EgG3KoDBHFt5ZR90rX5voY9E11tijmgxycTlfL9aepeg9hQhnfY59jvQFpER3fLHXUY+2
	 g1M3m3/60nBnhJ4bqmR+Z6Qrte2mI8VYJfwz92fsrhNz4j7Dt81BnBtY5iotiKpnLmA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2Ztfg4+;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794328587;
	bh=kPdufsPBJpaLhkzWQqqT8FSuhylKhYmUXeIW0aMLwqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5VRd85U9YywR/qUCOyf6axZcLuuAczJttBhjRFO+8u0epV5pST2AOOXqAdurdeMJq
	 hcbCwhBOWxy02x3OriKgO2z4Ges9zFXmUPvUcEqSAHROcU6JVUddPr2OaB7lRYctX2
	 WzFriyofWiqBHiCl+NwsgPwOlUk4p1dHK3HGm4QDNuv8GJehMWUXOKNixDba4dp9FK
	 6Qcbb5xluHJqT3So9U60C5woX627mRR27coVd6g+X1jTnX2HxWy2q+7ccqHR31PfvW
	 c/nVnVOUMRhlXkULOzHBySwtETTyaJaJMJ6cr6En0a2kLxK10/kehrlH5zb/6XxrrL
	 XDT5VjXltVjtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBF51811DD;
	Tue, 10 Nov 2026 16:36:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 239209D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 16:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21251811DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 16:36:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ltT8nFAPL9qk for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 16:36:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C377E811D0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2Ztfg4+
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id C377E811D0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794328582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPdufsPBJpaLhkzWQqqT8FSuhylKhYmUXeIW0aMLwqc=;
 b=K2Ztfg4+9kaDE8mpda23r9HOb+btpwMGiDv72oiVeWls3JD7tklOI3KvObEfbixFXC2p13
 eFnbeLW42sf4d9PFg/EA+uDfueKViW9lfKe/Px31TZilUGewwVX07529yPOOMxKYQcwdM1
 8W8evVWcRCMp8YARU1h+ahbQAPi3Vh4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-4XRTACMBOiqS4J-NcXo_FQ-1; Tue, 10 Nov 2026 07:20:13 -0500
X-MC-Unique: 4XRTACMBOiqS4J-NcXo_FQ-1
X-Mimecast-MFC-AGG-ID: 4XRTACMBOiqS4J-NcXo_FQ_1794313212
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4901562b819so1752007f8f.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313212; x=1794918012;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kPdufsPBJpaLhkzWQqqT8FSuhylKhYmUXeIW0aMLwqc=;
 b=uWZ+rEkcF22gjzzLlk9/8oKTBUxolEXccLxZxC5c36ztXpUhrIXjGqStpG6WiSJXv0
 JLN8JYVpZLfhDFY1WVAihq02RQyLRS5s+5ovOjsOn+SnQ4V2kN/7lP6kM28y+Emj6G5+
 gu7tzQYkCxpYgLAbRTHEtvY7DTcBnvzK9iL6YZwjv4JiOfM4CqFoLa9Lwmo3cs2wDA00
 523JWpxCbOy6j2lEwsXSNCYylkOy/zPy3x02FBtrO0NjS5A2xfZpo7EdJN5BCswi2rLt
 niLRThF8doToL6Z2T5hs0tphbjB9kNNh1qa7Ps83wt6iXQd8FkKlT92SLNUgltzyKHAA
 n7nA==
X-Forwarded-Encrypted: i=1;
 AL+hErEXg5BbikvWoISTsohrfIkgYjD0JjXPkR0ElH25nBiLIv3irKMaWnZffIcok/OK6RlcOW0x5tahH0iF4AOrQWk=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/24pJcR5NBm8p5BSDF5T56XIlca4etETenKr9b9VWMSmCIbjCL
 4MaNsesWuNqV7wXSz7U+gHo69MgVGCCNC1zCqsEzVhK5WjBWVpVM6lCcwhR/8Zr8QljP5Gn6G8p
 zL+997akORXDWMY6AdDVV7ctjqXcbPVyO90eZH2VPKkQ2hAI+nFKLG/Wp7YisQZJFXJana50=
X-Gm-Gg: AYBFou0wjBvQI1HGYzhgm9C4kX6cw3G8g7XPp5171UKo/+J5EfajCvBsdLY/Es6Ao31
 ybZyx2mvOgVH59z/uHmMfMjFoQIc8AMLTEXNrG59kMuQqKi+TzCs1BHcj2fTishmSjQ6kwPj8h0
 f3eSiTMxKY2zUGTdPMyRKItrCc/kZ6T6+CngROmtdwkOTJx7O8g4QWh3ewvVMSff2ZYRfnqQlGJ
 FKGpf/1X54AIjd9pN14JCFgvqhjqlM6I0ZeZT0aM96kJbYQ5pmLReaVi+AeSH8lZ/PrJml7Gdgt
 7vdYoXxEsQ8HlzwNOA9OBO3gxWUfaDAMih8exweow3yhnWt8neVx9O6ZKBJmeAhj1t9qylRijj4
 gsqkh1Y69Fy4sMYAIuuf50Gn53N++XD6JO+k=
X-Received: by 2002:a05:600c:1c0c:b0:4a2:150f:1607 with SMTP id
 5b1f17b1804b1-4ba0233e877mr44341255e9.13.1794313212360; 
 Tue, 10 Nov 2026 04:20:12 -0800 (PST)
X-Received: by 2002:a05:600c:1c0c:b0:4a2:150f:1607 with SMTP id
 5b1f17b1804b1-4ba0233e877mr44340455e9.13.1794313211833; 
 Tue, 10 Nov 2026 04:20:11 -0800 (PST)
Received: from [10.43.3.161] ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835c377fdsm3961339f8f.21.2026.11.10.04.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 04:20:11 -0800 (PST)
Message-ID: <a873e0f1-ead6-49da-93af-d2c2d79c9741@redhat.com>
Date: Tue, 10 Nov 2026 13:20:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] ice: dpll: notify TSPLL lock status from
 the periodic work only
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
 <20261106121005.1327603-2-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-2-ivecera@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xgIdvOMTFhtyKufr5k6d1vZvLuO2nQBDzrwEZ6gYSlA_1794313212
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



On 11/6/26 1:09 PM, Ivan Vecera wrote:
> ice_dpll_tspll_state_on_dpll_set() notifies the TSPLL device from a
> callback of the TIME_REF pin. This pin belongs to an external DPLL and the
> DPLL core is going to run its callbacks under a lock of the pin's owner,
> which does not cover the TSPLL device.
> 
> Only update dpll_state in the callback, so a device get reports the new
> state right away, and leave prev_dpll_state to
> ice_dpll_periodic_work_e825(), which then sends the notification. It now
> arrives up to 500 ms later and after the reply to the request.
> 
> Refresh dpll_state on every run of the work, as the state written by the
> callback can be transient and the lock status can return to
> prev_dpll_state before the next run. No notification is sent in this case.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index ade1fb3dd06743..bdbcf7af296eb4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2914,7 +2914,6 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
>   	struct ice_dpll_pin *p = pin_priv;
>   	struct ice_pf *pf = p->pf;
>   	enum ice_clk_src clk_src;
> -	bool changed = false;
>   	struct ice_dpll *tp;
>   	int ret;
>   
> @@ -2947,15 +2946,12 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
>   		WRITE_ONCE(pf->ptp.tspll_locked,
>   			   new_state == DPLL_LOCK_STATUS_LOCKED);
>   
> -		if (tp->prev_dpll_state != new_state) {
> -			tp->dpll_state = new_state;
> -			tp->prev_dpll_state = new_state;
> -			changed = true;
> -		}
> +		/* ice_dpll_periodic_work_e825() compares the state with
> +		 * prev_dpll_state and sends the notification.
> +		 */
> +		tp->dpll_state = new_state;
>   	}
>   	mutex_unlock(&pf->dplls.lock);
> -	if (changed)
> -		__dpll_device_change_ntf(tp->dpll);
>   	/* TSPLL reconfiguration may complete before lock is reacquired.
>   	 * PTP periodic monitoring tracks and restores the final lock state.
>   	 */
> @@ -3372,8 +3368,8 @@ static void ice_dpll_periodic_work_e825(struct ice_pf *pf)
>   	mutex_lock(&pf->dplls.lock);
>   	new_state = ice_dpll_tspll_lock_status_get(pf, true);
>   
> +	tp->dpll_state = new_state;
>   	if (tp->prev_dpll_state != new_state) {
> -		tp->dpll_state = new_state;
>   		tp->prev_dpll_state = new_state;
>   		changed = true;
>   	}

Reviewed-by: Petr Oros <poros@redhat.com>

