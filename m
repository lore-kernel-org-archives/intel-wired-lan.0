Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E495606A685
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=D5crtDAz;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FRKbaUW1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34C0C6066D;
	Thu, 26 Nov 2026 08:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9iZwskgYHX4K; Thu, 26 Nov 2026 08:51:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B40560634
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795683080;
	b=cHo4CqZ87fVwQDX9EuMk8/fbFD+++10cnLCn9aGGarFk9uWSjm6/lnXs1q7YCrJgcnjv
	 kKS+cmRAY6HtT9LjtulhPcUs3PgCF+K/gHVwloyMxcJipS5huGmXvtv033oo5jlAEf7kb
	 QXx1ceLV9U6UTSrmmrFq7ADFm6I135mgSYwh76wqZsc9NAzydQKtmY8RpHcTsf81tNq/7
	 Kj4/ylEN4tKSncilZA+idv0L0oO/51E+eRCGrq1SCo5CE1jU5wj4vihh7pnOScUqTsbJE
	 BP6O/9upWu6n1lB0kv3YF4CaO4+l0wlIn7fvG3VLfpWVMTAAoDXZHiHY0AoaOb9gznA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683080;
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
	bh=4KgaJB5jGrUq7vsExVtlIWM7Dg+xBJA26WB8v2wHqu8=;
	b=FrOuZUJObvv6zAcMYSsJY+0ARO15gBtjdI14kEPIHJZXyUXpxXAlVRbV37cY1hwmCH4N
	 vVsFyklSZuOuMoV4c/7x1egXjFxdyc9we1/8sj3hZS60WxJZkQ0cyb/L6e1DKp2u6XZWN
	 Bdr8/1PHZVxUx7cWh8ywZdEEieTNqkPxDQAkMCzkrycbRi3XrI6MVBbSvUOOTqVw+SwBo
	 EYqQf2KDZNwmprcyxG2lA4cqxPfqU9R8B88KUAWaoe1tW5tC59YeTbk5BbiEL8hO8O/Ex
	 Y85enrprrIVhdNW2HB3cvYkdKUviPRrRwhX0NSDnkSzSrsE/JrqW03N1+SN7DR/KmoQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795683080;
	bh=4KgaJB5jGrUq7vsExVtlIWM7Dg+xBJA26WB8v2wHqu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D5crtDAzu4iHg2AdksWLkJxgGhBBtBhAYaxUcp95nsQ2++6qFPp4FgC9LSi1WMT80
	 kTcrnL2VvRnmHTD74qEfWBweh54wfzznnAWtHG9JlA1Fc3xwL2rXtUyjnIA9znmkid
	 PAe6T/OzILTKY5gppQJiB0/FPHaDQjUpdU+6IdjJUpHTdJv38O87h2MlVhpL/QP3XX
	 AK16XbZmd6sFzz8/VfnwQ+tjGenPz8Dxq4z/7cHGwdcT94qDBg7CnWc1e0wuBxUDqF
	 yhy30jJYlkitMZbN4TaSwM4GYcI+1PSGXbLY+YwMayShx6hLhW5sLE9JX6JUCM0rmI
	 yIG7Qq4Otzvow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B40560634;
	Thu, 26 Nov 2026 08:51:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 228AF22B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 08:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 086AB80FB1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 08:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4S5Ov16irUf for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 08:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 280CD80FA4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FRKbaUW1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 280CD80FA4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795683074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KgaJB5jGrUq7vsExVtlIWM7Dg+xBJA26WB8v2wHqu8=;
 b=FRKbaUW1yLtumX1IVyRfQEZqSTrI2WIv8VHtuj2ThA3qCcQWqNzxttgcgrKzjr0SVa/GXd
 +UCOpoI2eT3EDkYtwiePjfUTqcKuTT/jDIBhK2cPfDIm93kbgsFd6pxbOMyrf2lVhZnfTN
 oRwDNZMgSa1G5Gk5FDxKTHhhZIT6NN4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-ALNniIQTPaCin9xbeMD0Gg-1; Thu, 26 Nov 2026 08:51:12 +0000
X-MC-Unique: ALNniIQTPaCin9xbeMD0Gg-1
X-Mimecast-MFC-AGG-ID: ALNniIQTPaCin9xbeMD0Gg_1795683071
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4903fc8537aso4483400f8f.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 00:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795683071; x=1796287871;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4KgaJB5jGrUq7vsExVtlIWM7Dg+xBJA26WB8v2wHqu8=;
 b=DfqXsa+ehrhTeXYc5DuNJfn7seFVkzU0S0XcC4jLlo7PKga9ZPXFe0K6An8+d+SRpc
 2W2BiME+T1PpFqw8HtFwZgp1id3dIdpwK8OgASP4RqyCst1XnwOObcfX7qBw3UPr68Up
 vUxGj5Ea8xd3N8pcDNCdKS4kqr7saBsN36AQYCnwnas7kFwcvdBGarcQjEyoVeEkRTTB
 7Iin/d5qsPmunNsRG2OSB0i6JTOYUv6j9/xcJVxJGhuf56LFLWn4ywlj6zrRPJG71raV
 3RU1yHYQ5yYwJZzLV6rgOCFn0N45WOaBIvnYBPQHjx/o6euHEq6bN6QITpSLRbKd5HBr
 YCzQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFybMOYHHerPl7AlQ1AI3BkCAxOoYE4m6Gvf6M5zPEnTRxhmAy1Szj49k8ili86DGTlr7GfOQTxiVw4afqiRE4=@lists.osuosl.org
X-Gm-Message-State: APuU4Z85t2stySUmYyCk1HhcmcfBM57igeHkgEPHO1RDsIg3Y89z2KXH
 /JJoBfZJ2sOi/bOvgdg3f0IpIGjJTMTjMgOhamQu02khamTFUw5SFadkf8bBihmjwrPnBs0obYZ
 LIQq8bqwhR9abtMCnGkUntbZwXy7YSyQrIRmXlOq3WUWl0ealIIdIg3nZ9jn3SKuDOw/k75I=
X-Gm-Gg: AZFdTZc1HxCio2n2o8I5pYI+vZUK9LiyeyTuIQHsFqn5zSXviYsPMh0qEGLmOIT+GFd
 8Wkq31BY8qMh/oyL89gXyd7JgJYfLqJQ57TDAjhdXSh/heMJBFpewdiy6Vr7v0n73I6EjOrlRYt
 yHVx2n+bhpSM8GsWGf8M3pEkQzYc1awR/QYEVx8kXxeaFzpeaYgQ0I5TVe0Ir/RmjdY38K5N3+z
 9Lc2HJo5yWUm7XPJKkRMuKDF5qWQuszI9aP9AlPcDf0WiMYcomwNHd4cF9kVbn3AacVKWsr5tM/
 WfmYCCIHGvtJrtoIYlf0Njm33bnCZXZSV4dyRaeixiE0cVP+5htIpJWAvolyW8rwT0YFlX920zr
 v35F9FvpVGXRVDD6s2zbcmYCCNOPN8FxBmVieZUh2e+3rhZMxbqA+quu7lzxKUGQOPi53GOtuyA
 5lY5oHmAiW6PqztbLahhP9QQR5xzOYDDt4XIh24nYw31oq
X-Received: by 2002:a5d:6691:0:b0:4a6:c3f:9d0e with SMTP id
 ffacd0b85a97d-4abb3d2c0bemr28772233f8f.44.1795683071348; 
 Thu, 26 Nov 2026 00:51:11 -0800 (PST)
X-Received: by 2002:a5d:6691:0:b0:4a6:c3f:9d0e with SMTP id
 ffacd0b85a97d-4abb3d2c0bemr28772196f8f.44.1795683070961; 
 Thu, 26 Nov 2026 00:51:10 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it.
 [82.192.128.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c4353d6sm37852308f8f.56.2026.11.26.00.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 00:51:10 -0800 (PST)
Message-ID: <d3555d86-a7a9-4ff8-9e23-04bb3e351de7@redhat.com>
Date: Thu, 26 Nov 2026 09:51:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Petr Oros <poros@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 horms@kernel.org, Marcin Szycik <marcin.szycik@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
 <20261125124652.3843638-1-poros@redhat.com>
 <81c519b6-2d94-424e-8cfe-22ed8c1d728b@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <81c519b6-2d94-424e-8cfe-22ed8c1d728b@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Yi1Qsfq9phFtnryj638qo5kkowzTzrZFofu-wPIuqQ_1795683071
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 22:16, Tony Nguyen wrote:
> On 11/25/2026 4:46 AM, Petr Oros wrote:
>> It would also help if Intel updated the MAINTAINERS entry to match and
>> kept it up to date, so that it is clear who acks fixes for each driver.
>> Jakub mentioned adding maintainers or splitting the entry, and the
>> details would be for Intel to decide.
> Yes, we plan on making updates to that file
> 
> For netdev maintainers: Is a Reviewer: entry sufficient to be taken directly?
Double checking I'm reading the question correctly; let me rephrase it:

A 3rd party sends a patch/series to netdev. Someone @intel, listed as reviewer
in the MAINTAINERS file acks it. Can we accept such patch/series?

The answer is yes, if we (net maintainers and intel) agree on this process
definitely an ack from intel reviewer would be enough.

Please LMK if I misread the question.

/P

