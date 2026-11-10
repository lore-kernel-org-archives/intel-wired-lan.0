Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F31606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=HwCPwvUj;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=brwFeHkH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50DC94064C;
	Tue, 10 Nov 2026 17:05:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C0aSKPG9-1AD; Tue, 10 Nov 2026 17:05:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD57840660
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794330310;
	b=JUgPiPOrGL3VpFTQu4+3Z+prWWvEu1Lm3K1FHJBhdEhPe1pmV6BZBzI/gdzcdBmXy+/s
	 51CtJKsvnZNtXrMhb9Iiy6KlSGmt6vmECAC/RTC5yKMpetsT38xNykW6q4G0K8s9w5xBr
	 JqR9hjP6t0vC5NMwnz45qLR2CRt7BBEcAU5/OcNSd9Pl7qXd03Mfzf08IJAHRnCxgKGSD
	 CggsIZtz8XOU32jUux/2L6E7+kdwhvNM9P+GRBk02prsXbKnxp+JzxJQns9+fYEZAJZbY
	 X0pC5jQuwl0XQ88WBy3XeK53Cajti9z7XjTS652Kl2aaYh36fS1Wh9RXcfKverBZfBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794330310;
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
	bh=YHOWSzBYEeT0XkyHE5eg98zTT/FM3f1qF9Pogxz7NlM=;
	b=Q5t39bg/1iuIxiqWkXAqZ9f7W+Rl4pcgUCtbnS6p36BTG5Xan74cuteeZwlcNK/SZ4hR
	 U22+ZS3OhWFzhhdfUl2Huv4IeAIfCDvhkl4gT7Wu7uZ8exzCari4CqAqFIWyA/o+j7Dsz
	 Alyhpvx1jimFFYbtjEGLFTD6lzmIPZcN+C7NDzZnJ3NGgF9YNA24Flm3kXiFcaAI1tz06
	 ykATrdUKPI/uHi/mU2BjwTBvcYzcW09I+pX5hLg2RzhJay1An0Ja614RUeEorLD2/VNQ8
	 coCuVOFhTaxlO2yQz6AssF62BDOYFpBZ+WXqegH/LtzZC5xiwd90PKcGJeIzE5co//g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794330310;
	bh=YHOWSzBYEeT0XkyHE5eg98zTT/FM3f1qF9Pogxz7NlM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HwCPwvUjwus1iHdfaye9fzdX+yo6/SHzZjKQw7QR+VvrwJm9wTDqDn3ViQlAJsR0g
	 l40xWAoheytBFllVNbT5zi9BeiUZpsL+sTT8TuYy9VX61HtNES+hsREO4NZRVHRRXp
	 pkc8GPatK3dI7ndwYlHDkLVVafDuiw7a9RH20gRXYtZXGqLQO81Vy6UNyrulSP3y1+
	 TvOvr7aYTBcjmVrXk37xyvYaVMwVBxf8fvat8SCo23kb11bWE+8Z4xqxPxVFo9ZLQn
	 7DAw7nn7Y5biesTc0V7aLXjxFNkHDtIfD2KWCLfbArAL7tzdX6tqhYWJYLeD6pGkVc
	 A3HCaT1bw3ulw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD57840660;
	Tue, 10 Nov 2026 17:05:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C45FE388
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B555F812E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BOl-rKX1F9lI for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 17:05:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C806F812D5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=brwFeHkH
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id C806F812D5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794330306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YHOWSzBYEeT0XkyHE5eg98zTT/FM3f1qF9Pogxz7NlM=;
 b=brwFeHkHg0s4oe4SBDvBBNgbmnHZ4G1yNLam/jymzIIcMlo5wcgdk1Pmfg9DWga5FkkEIx
 4j7yjc75yUgOJwyW13VUfnc4tuGkOEIP477+pzzeAJpUdx8otFy00R4xT1K99RSypvwnCj
 hL+coz9IcMG6zkcpWDIY9a1I73PTEP4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-vC-TTDbwOza7AusNkcychA-1; Tue,
 10 Nov 2026 09:48:40 -0500
X-MC-Unique: vC-TTDbwOza7AusNkcychA-1
X-Mimecast-MFC-AGG-ID: vC-TTDbwOza7AusNkcychA_1794322119
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 668D41956043; Tue, 10 Nov 2026 14:48:38 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57D0F30000E7; Tue, 10 Nov 2026 14:48:34 +0000 (UTC)
Message-ID: <e16342c4-bfb8-489c-9785-f78a3dfdfc17@redhat.com>
Date: Tue, 10 Nov 2026 15:48:32 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: dpll: refuse pin states that are not valid
 for the pin
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Milena Olech <milena.olech@intel.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20261110143119.2313907-1-poros@redhat.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261110143119.2313907-1-poros@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: LFxvCGBLKrbqnf9h2nn70Veq2eAKwVoPzVasKwv_-fU_1794322119
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 15:31, Petr Oros wrote:
> The DPLL core checks only that a pin may change its state, which states
> a pin accepts is left to the driver. The ice callbacks turn the
> requested state into an enable flag by comparing it with the one state
> that enables the pin, so every other state disables it, including the
> one that has no meaning for the pin.
> 
> The inputs of the EEC and PPS DPLLs are enabled by selectable, as these
> DPLLs select their reference automatically. A request for connected,
> which Documentation/driver-api/dpll.rst reserves for manual mode and
> for pins with the state-connected-override capability, disables the
> input. On an E810:
> 
>    # dpll pin set id 1 parent-device 0 state connected
>    # dpll pin show id 1
>    ... state disconnected on both DPLLs
> 
> A recovered clock pin is connected to or disconnected from its parent
> pin, and a request for selectable disconnects it:
> 
>    # dpll pin set id 2109 parent-pin 2094 state selectable
>    # dpll pin show id 2109
>    ... state disconnected on parent 2094
> 
> Add a helper that translates the state for a pin given the state that
> enables it. Disconnected disables the pin and anything else is refused
> with -EINVAL and an extack message. Use it for the input and recovered
> clock pins, and for the output pins, which already refused selectable
> and now tell the user why.
> 
> The SMA pins have the same problem. It is left out here, as the rework
> of the SMA and U.FL pin control that is queued for net-next refuses the
> states these pins cannot serve.
> 
> Found with the pin state selftest of the dpllsim series running against
> an ice E810.

;-) good catch!
> 
> Fixes: d7999f5ea64bb1 ("ice: implement dpll interface to control cgu")
> Signed-off-by: Petr Oros<poros@redhat.com>

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

