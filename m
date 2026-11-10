Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B5606A325
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8HM4sTcM;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V+rfptOp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66BFA8100F;
	Tue, 10 Nov 2026 12:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eLNbFv7kjFd6; Tue, 10 Nov 2026 12:23:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3AC1B810E6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313435;
	b=Ex+0mWUgAbGj8i348f/k6mvbGbUt8+6+kAD+y1oEx56E65B7HlowOdV4wSzSqGPR7+en
	 ols54hHzPbaw4gK2sy5BR0suhOcaf3YUY1aCSPqFvI7ux8D9NHJcSQJfa4lqC+5fkYqB1
	 OcgvtRtBrG7Sqpib0EVI5r2UvqrypodVEVFjpO0E7FVAgVn3BkJTmQy10nZ+1XFrUol7Q
	 sFgIy5kUMIb9co+qpCTpHGDFzLRyKCCfRR39gALQ5RMgvnFT49T9ZFSemn2LJvqRzN4j8
	 t2eOkSy0Xl8EedYlJj8dZMwPW5Klo7VWytZEAIbdGaucP7oNBumCu+fRaBif6kdZUtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313435;
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
	bh=CSgKi+aMTYN0njuIxn8oWEHOLjbkmau8+4SbC4HMNdA=;
	b=cbJ2lsN5Ftw4axvX0tVWZamGSQXUpsuS0z6NaxEIOCkY+U7Rlc9r4rD5KEtXnsxpiYxe
	 JrijaBS4WFiNvFo9LWvna1vo5X6r5r4aIFPpPl7qydGf+B4lYP++qjLIwqpkBjtBcES8O
	 qYYLBPLFQG9vngTaNYyFV+EHc6oRqkWQY96Yyv77Gi61XDHpW2lqVeaI2EJk44zD2nyAu
	 V2QlWMZrTlR1nq1wukEIIJCBaM3fEp4l6FTHZygoyDntI0zAyYCE9MoZRLrfY/tqW6ery
	 RyLCrcIWa5Z4VqdPZbdY7V7dhXH6Q7KQqWhfldkR8UbDb9JwS7NfVBxFo6aa1FUsTRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794313435;
	bh=CSgKi+aMTYN0njuIxn8oWEHOLjbkmau8+4SbC4HMNdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8HM4sTcMDtOo8J+IL/2FDg3g9zBmhnx9NXb2vpoCRyYaYdqjAfpWOYxU1ftMnq/Y/
	 H8Vd2djeqJrO6upPn1U09tSqeBBxnRHCfRl8Jc5f3YFybF4XlcDsBNK5xbE/DtYIbu
	 9lSvxB2JZ3NF7UdXMJuzZhcJBnBF893l9ZDPkVVaSFiweOwT7BPZDzUiaKvmwZeCCR
	 LrS/KWBOBzF8YbpbJssgz+N/lv3b3Rv+dz89wLdTFZJvAG50G+SxufEnM3V+tXukoO
	 3PwlAvUpUUoIhlCx3xeUkT1mtD+lDgbORwGNrtcypK+vPjad9A1Hqg1RYAZDdgCOTU
	 0FcTHiDL+QF3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AC1B810E6;
	Tue, 10 Nov 2026 12:23:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C5551731
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B64406085C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:23:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oDEbMZncQFsJ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 12:23:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 149D360768
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=V+rfptOp
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 149D360768
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSgKi+aMTYN0njuIxn8oWEHOLjbkmau8+4SbC4HMNdA=;
 b=V+rfptOpnlv1NWQdJxVzs0P1Qh3Sovo2guz1VxwLTbEuM74uhaH2whUeLsSwV+yKJKWKvw
 YfFUnLBQIS371uej4gieOIOOjezC7BkXaVGYHRwoSsViVhlpmyNXJP7sWozHavTLVrQXCf
 aWan8mfqFI+vEu0F3mc1VN15TPzrrvo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-x20wEbqjNcunwGXyx-_Ytw-1; Tue, 10 Nov 2026 07:23:48 -0500
X-MC-Unique: x20wEbqjNcunwGXyx-_Ytw-1
X-Mimecast-MFC-AGG-ID: x20wEbqjNcunwGXyx-_Ytw_1794313427
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-490c1867460so1515415f8f.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313427; x=1794918227;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CSgKi+aMTYN0njuIxn8oWEHOLjbkmau8+4SbC4HMNdA=;
 b=YJPkhsBmtK/cGPuRostofNJSgJefDH6Y2etTChZPoRtnzxgkpbZQwXwlXISpPg8zRK
 tpFGb9k8B/FPNYl/ycjeNwDU/Jr2uiqwu+S4bBP4J98dwLdfe3BJIOxM5ZJprMuKAYsm
 ILHQOi17GPFvGSS6yMh6LPs35fiqPphEGwCEiKfNp6o59fX40KDjyBZUuQfZURsI7YCK
 N0uQ6ubfm4wQ40Phkn2u1+L5/A8J6WISR08V6Ipcsm1RuLQMeVnyODX4O6X2N5mabgBf
 rkfU1l0xFY0QDgXxP9ZvS9PwhbRsluSd1PLpLhK8QIRcczhkYauwt2tuIhI6LvWZWRdr
 oC0A==
X-Forwarded-Encrypted: i=1;
 AL+hErH5kJOEufe3qaLwwmLbEh1CUkUvC/ZbrxeCBueH3ezjv4U6nQop5DpnRXbyB8lpoFhmmUDNDvSwWDsRlW12Xr8=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/uT0GmtkEfFhXQHjD/83n8dgrPAwGcMg3qhnP67ux0LBgWBIq+
 wLKI5vMAc427x1COUF/LJwgr1MoA0cVCih298C3zw5HI5iOXhLuxJqSh+K6G4jixGsVbeJGQvBW
 ReIri4ExxOTEV0pQ4a73pphN2sfBeFSFHU79JZtH11xQy5ePzVutxJsGyMCZUhP80RRcdGn4=
X-Gm-Gg: AYBFou0atP+qKHlRRe2K4IN/OYI0ZlhsYw4P5Nlr99r29MKaA+QgLq7FJHsDCcEkdLx
 LgLekqHi26TOOfd5QAt7Sjn0d16szjVI7Tal1EDwLboz6R0VRjkc38GotRIUZXe0qZO3wWehCGm
 gbcMrI+J5gqi5uBGnyphxNth+QOR9kQcdyIXzeJAzDt7RJZTsw1RBxMfiO/9/MtAY4Mswnq3spi
 mVUEWCQob9KsqZjwiRY2hQ8nUQHmppDCtxv3Gert2VU0KMNvSbthlHmg/WlZ2DzY0Um3euc5AFH
 U2C1JSslkWx3xVIYcL11AwMLYcZTUPt64rWsFUt8iI/q3T8x5CGXr4pwSM0E07Kd4Tm+kPopCdp
 TCBEBHNCptTlcqi1nsiAfiWDullg3AtQuY0w=
X-Received: by 2002:a05:6000:611:b0:498:38b3:55a1 with SMTP id
 ffacd0b85a97d-49838b355aamr4136350f8f.15.1794313427061; 
 Tue, 10 Nov 2026 04:23:47 -0800 (PST)
X-Received: by 2002:a05:6000:611:b0:498:38b3:55a1 with SMTP id
 ffacd0b85a97d-49838b355aamr4136279f8f.15.1794313426580; 
 Tue, 10 Nov 2026 04:23:46 -0800 (PST)
Received: from [10.43.3.161] ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c30b1sm4836441f8f.46.2026.11.10.04.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 04:23:45 -0800 (PST)
Message-ID: <d4b6e270-044b-4181-a3a9-fd906980b0ed@redhat.com>
Date: Tue, 10 Nov 2026 13:23:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/10] dpll: take domain locks around driver
 callbacks
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
 <20261106121005.1327603-5-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-5-ivecera@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lp6tS56WxNTfPIVy_jKheT8A6B6we598iDPgdFS3GnY_1794313427
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
> Hold the domain lock of the addressed object wherever driver callbacks can
> run:
> 
> - netlink requests addressing a device or a pin, from pre_doit to post_doit
> - dumps, for each object
> - notifications, while the message is being built and sent
> 
> Callbacks of a device run under the domain of the device. Callbacks of a
> pin run under the domain of the pin, also when another driver registered
> the pin with its dpll or under its parent pin. All callbacks a message
> about a pin needs are thus covered by one lock, and only one domain lock
> is ever held. Domains have no lock order, so registrations can connect
> them in any way.
> 
> A request is atomic against other requests addressing objects of that
> domain, and messages of one object are sent in the order they were built.
> 
> Requests resolving an id run no callbacks, so they do not take the lock.
> 
> __dpll_{device,pin}_change_ntf() now also require the domain lock of the
> object. A callback can therefore only notify objects of the domain it runs
> under.
> 
> Callbacks stay serialized by dpll_lock for now.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_core.c    | 18 +++++----
>   drivers/dpll/dpll_core.h    |  6 ++-
>   drivers/dpll/dpll_netlink.c | 78 ++++++++++++++++++++++++++++---------
>   3 files changed, 76 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index d39c4905172f2d..dd09f528170994 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -520,7 +520,7 @@ dpll_device_registration_find(struct dpll_device *dpll,
>    *
>    * Make dpll device available for user space.
>    *
> - * Context: Acquires a lock (dpll_lock)
> + * Context: Acquires dpll_lock and the domain lock of @dpll
>    * Return:
>    * * 0 on success
>    * * negative - error value
> @@ -579,7 +579,7 @@ EXPORT_SYMBOL_GPL(dpll_device_register);
>    *
>    * Unregister device, make it unavailable for userspace.
>    * Note: It does not free the memory
> - * Context: Acquires a lock (dpll_lock)
> + * Context: Acquires dpll_lock and the domain lock of @dpll
>    */
>   void dpll_device_unregister(struct dpll_device *dpll,
>   			    const struct dpll_device_ops *ops, void *priv)
> @@ -928,7 +928,7 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>    * @ops: ops for a dpll pin ops
>    * @priv: pointer to private information of owner
>    *
> - * Context: Acquires a lock (dpll_lock)
> + * Context: Acquires dpll_lock and domain locks
>    * Return:
>    * * 0 on success
>    * * negative - error value
> @@ -989,7 +989,9 @@ static void dpll_pin_ref_sync_pair_del(u32 ref_sync_pin_id)
>   		ref_sync_pin = xa_load(&pin->ref_sync_pins, ref_sync_pin_id);
>   		if (ref_sync_pin) {
>   			xa_erase(&pin->ref_sync_pins, ref_sync_pin_id);
> +			mutex_lock(&pin->domain->lock);
>   			__dpll_pin_change_ntf(pin);
> +			mutex_unlock(&pin->domain->lock);
>   		}
>   	}
>   }
> @@ -1016,7 +1018,7 @@ __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
>    * @priv: pointer to private information of owner
>    *
>    * Note: It does not free the memory
> - * Context: Acquires a lock (dpll_lock)
> + * Context: Acquires dpll_lock and domain locks
>    */
>   void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
>   			 const struct dpll_pin_ops *ops, void *priv)
> @@ -1042,7 +1044,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_unregister);
>    * Register a pin with a parent pin, create references between them and
>    * between newly registered pin and dplls connected with a parent pin.
>    *
> - * Context: Acquires a lock (dpll_lock)
> + * Context: Acquires dpll_lock and domain locks
>    * Return:
>    * * 0 on success
>    * * negative - error value
> @@ -1099,7 +1101,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_on_pin_register);
>    * @ops: ops for a dpll pin
>    * @priv: pointer to private information of owner
>    *
> - * Context: Acquires a lock (dpll_lock)
> + * Context: Acquires dpll_lock and domain locks
>    * Note: It does not free the memory
>    */
>   void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
> @@ -1129,7 +1131,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
>    *
>    * Once pins are paired, the user-space configuration of reference sync pair
>    * is possible.
> - * Context: Acquires a lock (dpll_lock)
> + * Context: Acquires dpll_lock and domain locks
>    * Return:
>    * * 0 on success
>    * * negative - error value
> @@ -1142,7 +1144,9 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
>   	mutex_lock(&dpll_lock);
>   	ret = xa_insert(&pin->ref_sync_pins, ref_sync_pin->id,
>   			ref_sync_pin, GFP_KERNEL);
> +	mutex_lock(&pin->domain->lock);
>   	__dpll_pin_change_ntf(pin);
> +	mutex_unlock(&pin->domain->lock);
>   	mutex_unlock(&dpll_lock);
>   
>   	return ret;
> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> index 6705e81bc11de9..630c5a1ca572c2 100644
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h
> @@ -22,10 +22,14 @@
>    * @clock_id:		clock_id of the objects in the domain
>    * @module:		module of the objects in the domain
>    * @refcount:		number of dpll devices and pins in the domain
> - * @lock:		lock of the domain
> + * @lock:		serializes driver callbacks of the domain
>    *
>    * All dpll devices and pins created with the same (module, clock_id) pair
>    * belong to one domain, in practice to one chip or card.
> + *
> + * Callbacks of a device run under the domain of the device and callbacks of a
> + * pin under the domain of the pin, whichever driver registered them. Only one
> + * domain lock is held at a time, so domains have no lock order.
>    **/
>   struct dpll_domain {
>   	u32 id;
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index e5380d95f238b3..1b4e3a0166a744 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -861,27 +861,39 @@ dpll_device_event_send(enum dpll_cmd event, struct dpll_device *dpll)
>   
>   int dpll_device_create_ntf(struct dpll_device *dpll)
>   {
> +	int ret;
> +
> +	mutex_lock(&dpll->domain->lock);
>   	dpll_device_notify(dpll, DPLL_DEVICE_CREATED);
> -	return dpll_device_event_send(DPLL_CMD_DEVICE_CREATE_NTF, dpll);
> +	ret = dpll_device_event_send(DPLL_CMD_DEVICE_CREATE_NTF, dpll);
> +	mutex_unlock(&dpll->domain->lock);
> +
> +	return ret;
>   }
>   
>   int dpll_device_delete_ntf(struct dpll_device *dpll)
>   {
> +	int ret;
> +
> +	mutex_lock(&dpll->domain->lock);
>   	dpll_device_notify(dpll, DPLL_DEVICE_DELETED);
> -	return dpll_device_event_send(DPLL_CMD_DEVICE_DELETE_NTF, dpll);
> +	ret = dpll_device_event_send(DPLL_CMD_DEVICE_DELETE_NTF, dpll);
> +	mutex_unlock(&dpll->domain->lock);
> +
> +	return ret;
>   }
>   
>   /**
>    * __dpll_device_change_ntf - notify that the dpll device has been changed
>    * @dpll: registered dpll pointer
>    *
> - * Context: caller must hold dpll_lock. Suitable for use inside device
> - *          callbacks which are already invoked under dpll_lock.
> + * Context: caller must hold dpll_lock and the domain lock of @dpll.
> + *          Suitable for use inside callbacks running under these locks.
>    * Return: 0 if succeeds, error code otherwise.
>    */
>   int __dpll_device_change_ntf(struct dpll_device *dpll)
>   {
> -	lockdep_assert_held(&dpll_lock);
> +	lockdep_assert_held(&dpll->domain->lock);
>   	dpll_device_notify(dpll, DPLL_DEVICE_CHANGED);
>   	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
>   }
> @@ -891,7 +903,7 @@ EXPORT_SYMBOL_GPL(__dpll_device_change_ntf);
>    * dpll_device_change_ntf - notify that the dpll device has been changed
>    * @dpll: registered dpll pointer
>    *
> - * Context: acquires and holds a dpll_lock.
> + * Context: acquires and holds dpll_lock and the domain lock of @dpll.
>    * Return: 0 if succeeds, error code otherwise.
>    */
>   int dpll_device_change_ntf(struct dpll_device *dpll)
> @@ -899,7 +911,9 @@ int dpll_device_change_ntf(struct dpll_device *dpll)
>   	int ret;
>   
>   	mutex_lock(&dpll_lock);
> +	mutex_lock(&dpll->domain->lock);
>   	ret = __dpll_device_change_ntf(dpll);
> +	mutex_unlock(&dpll->domain->lock);
>   	mutex_unlock(&dpll_lock);
>   
>   	return ret;
> @@ -941,27 +955,39 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
>   
>   int dpll_pin_create_ntf(struct dpll_pin *pin, u64 src_clock_id)
>   {
> +	int ret;
> +
> +	mutex_lock(&pin->domain->lock);
>   	dpll_pin_notify(pin, src_clock_id, DPLL_PIN_CREATED);
> -	return dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
> +	ret = dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
> +	mutex_unlock(&pin->domain->lock);
> +
> +	return ret;
>   }
>   
>   int dpll_pin_delete_ntf(struct dpll_pin *pin, u64 src_clock_id)
>   {
> +	int ret;
> +
> +	mutex_lock(&pin->domain->lock);
>   	dpll_pin_notify(pin, src_clock_id, DPLL_PIN_DELETED);
> -	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
> +	ret = dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
> +	mutex_unlock(&pin->domain->lock);
> +
> +	return ret;
>   }
>   
>   /**
>    * __dpll_pin_change_ntf - notify that the pin has been changed
>    * @pin: registered pin pointer
>    *
> - * Context: caller must hold dpll_lock. Suitable for use inside pin
> - *          callbacks which are already invoked under dpll_lock.
> + * Context: caller must hold dpll_lock and the domain lock of @pin.
> + *          Suitable for use inside callbacks running under these locks.
>    * Return: 0 if succeeds, error code otherwise.
>    */
>   int __dpll_pin_change_ntf(struct dpll_pin *pin)
>   {
> -	lockdep_assert_held(&dpll_lock);
> +	lockdep_assert_held(&pin->domain->lock);
>   	dpll_pin_notify(pin, pin->clock_id, DPLL_PIN_CHANGED);
>   	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
>   }
> @@ -971,7 +997,7 @@ EXPORT_SYMBOL_GPL(__dpll_pin_change_ntf);
>    * dpll_pin_change_ntf - notify that the pin has been changed
>    * @pin: registered pin pointer
>    *
> - * Context: acquires and holds a dpll_lock.
> + * Context: acquires and holds dpll_lock and the domain lock of @pin.
>    * Return: 0 if succeeds, error code otherwise.
>    */
>   int dpll_pin_change_ntf(struct dpll_pin *pin)
> @@ -979,7 +1005,9 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
>   	int ret;
>   
>   	mutex_lock(&dpll_lock);
> +	mutex_lock(&pin->domain->lock);
>   	ret = __dpll_pin_change_ntf(pin);
> +	mutex_unlock(&pin->domain->lock);
>   	mutex_unlock(&dpll_lock);
>   
>   	return ret;
> @@ -1780,7 +1808,9 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   			ret = -EMSGSIZE;
>   			break;
>   		}
> +		mutex_lock(&pin->domain->lock);
>   		ret = dpll_cmd_pin_get_one(skb, pin, cb->extack);
> +		mutex_unlock(&pin->domain->lock);
>   		if (ret) {
>   			genlmsg_cancel(skb, hdr);
>   			if (ret == -ENODEV) {
> @@ -1999,7 +2029,9 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   			ret = -EMSGSIZE;
>   			break;
>   		}
> +		mutex_lock(&dpll->domain->lock);
>   		ret = dpll_device_get_one(dpll, skb, cb->extack);
> +		mutex_unlock(&dpll->domain->lock);
>   		if (ret) {
>   			genlmsg_cancel(skb, hdr);
>   			break;
> @@ -2018,6 +2050,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   		  struct genl_info *info)
>   {
> +	struct dpll_device *dpll;
>   	u32 id;
>   
>   	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_ID))
> @@ -2025,11 +2058,13 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   
>   	mutex_lock(&dpll_lock);
>   	id = nla_get_u32(info->attrs[DPLL_A_ID]);
> -	info->user_ptr[0] = dpll_device_get_by_id(id);
> -	if (!info->user_ptr[0]) {
> +	dpll = dpll_device_get_by_id(id);
> +	if (!dpll) {
>   		NL_SET_ERR_MSG(info->extack, "device not found");
>   		goto unlock;
>   	}
> +	info->user_ptr[0] = dpll;
> +	mutex_lock(&dpll->domain->lock);
>   	return 0;
>   unlock:
>   	mutex_unlock(&dpll_lock);
> @@ -2039,6 +2074,9 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   void dpll_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   		    struct genl_info *info)
>   {
> +	struct dpll_device *dpll = info->user_ptr[0];
> +
> +	mutex_unlock(&dpll->domain->lock);
>   	mutex_unlock(&dpll_lock);
>   }
>   
> @@ -2061,6 +2099,7 @@ dpll_unlock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   		      struct genl_info *info)
>   {
> +	struct dpll_pin *pin;
>   	int ret;
>   
>   	mutex_lock(&dpll_lock);
> @@ -2068,14 +2107,14 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   		ret = -EINVAL;
>   		goto unlock_dev;
>   	}
> -	info->user_ptr[0] = xa_load(&dpll_pin_xa,
> -				    nla_get_u32(info->attrs[DPLL_A_PIN_ID]));
> -	if (!info->user_ptr[0] ||
> -	    !dpll_pin_available(info->user_ptr[0])) {
> +	pin = xa_load(&dpll_pin_xa, nla_get_u32(info->attrs[DPLL_A_PIN_ID]));
> +	if (!pin || !dpll_pin_available(pin)) {
>   		NL_SET_ERR_MSG(info->extack, "pin not found");
>   		ret = -ENODEV;
>   		goto unlock_dev;
>   	}
> +	info->user_ptr[0] = pin;
> +	mutex_lock(&pin->domain->lock);
>   
>   	return 0;
>   
> @@ -2087,5 +2126,8 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   void dpll_pin_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   			struct genl_info *info)
>   {
> +	struct dpll_pin *pin = info->user_ptr[0];
> +
> +	mutex_unlock(&pin->domain->lock);
>   	mutex_unlock(&dpll_lock);
>   }

Reviewed-by: Petr Oros <poros@redhat.com>

