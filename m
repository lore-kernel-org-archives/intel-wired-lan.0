Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A97606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LnOEgYrQ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YUrtG9l2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACAB960906;
	Tue, 10 Nov 2026 14:49:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zEUBDZ4ja4o3; Tue, 10 Nov 2026 14:49:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB646608FF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794322174;
	b=C/fWngTfhYBLpVOdpWjyPaqCzy2fVl5u5tdU7D1wrIC3/p6MPwZiruIct/n6A+Y8wxJV
	 VwxS1D2LnmNKXi6kE8Dg6/iISyanfadjZqfbQ8vrzBWooGu5w+wfVaYHEnsIgX1ROQ6jB
	 2YQbTcsLE21hgjbWCuxCZrS2Tl5nBJpbHATzlsgZglgyhrqnNof8vTTTFB/CtPlDVCMBY
	 40fAzxpxMDIVQEo0BBkvmnproZYirqLnA3GNrmplkybSUMAQOW9zoowMvXWltqpWaCtGa
	 Lxwu6F0XlnFbx357Jh4qhO+wOkZkPkwdFlEa4MnUHTW+z7ayxOs+/9hqo7FaY2m9WTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794322174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
	b=eIIFacDzwZNxy+PQDpizNGStT12FDAMP9Vr4L1vQgMj1wQ6P3vBfhzLwKr28yAbuTUR0
	 hcuuysYtVsNdgzHmxTXyyDgt6d+z/8POgSilUvXHM0QVMFDhG6P8eLIQ0ZVrXr0HPmtws
	 UQddp3tYg1Ny/4V0yvhzbjwZFm1aSYynzf4x/Yq37MLUYK9y72WL9pAD8GeX+2vpqYKMb
	 lqrkw91Zuf5W4Acb56Ff7hfrCunECekwG0GqJOV7gjii/362kGu+Cw4/G+0l/VWXAtxuv
	 frK3/TZgrS12Cb0u5G8hwiTZF+BadbTGuY72tEV1QKMAA0kuMIAB85JGvKzFF/HjGbw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794322174;
	bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LnOEgYrQnFZTlKVVJyaexJNPOw6soUhsUcX9uFGyeVa4fNX4Jn11oaR5b0HOQxbNf
	 gWhDnQh/QqaLnUTIEgvMd/hm7+Gdv66IG7ApDtzZuvut4bt5nZKZvMbZ+VFP7dx7q1
	 Vd6E0F5mYv4H/1SISrfSn+z+UChQpRju7NGLuw6W36qMl8Kkx5VH0Z6jbcY0Pio2IJ
	 p5hFxEAnDsjT10ech5AxDp+J/zGcicGsJntjfoNSbv9d1kiuP9vPravDBxRbR4HfxF
	 xOfT/6JF7SxWcErhsJspAjyhfexVBg26rBNSR08+yrHVCaix8xOlM1lInl9ivXVn1l
	 gucYEA6lqBVuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB646608FF;
	Tue, 10 Nov 2026 14:49:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 972629D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 14:49:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CA6D40851
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 14:49:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4IiE1m5ltQOc for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 14:49:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 040754082F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YUrtG9l2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 040754082F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794322170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
 b=YUrtG9l2z9XHD5kyAntbGFs091KV2+Xg5n7/FU76KJDjLmKcR1M25etOTTiF97/Zgg4KKt
 hYEs3KwR+06qDav47CIW1zTYgxXgwVmruRgk74lgQcrX5uV52pjM554n7ii+RL2SCp1YfU
 jDeqdzzr1DHrM3k8ifwqDIX8PfMGpjg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-lbYdLauTOaSjNnlb9fxPHA-1; Tue, 10 Nov 2026 09:48:23 -0500
X-MC-Unique: lbYdLauTOaSjNnlb9fxPHA-1
X-Mimecast-MFC-AGG-ID: lbYdLauTOaSjNnlb9fxPHA_1794322103
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-49337a224a8so1966545f8f.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 06:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794322103; x=1794926903;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
 b=Z4qmwXlJAm/cXYzsz510arX1eFH5VxS6Kae8P7rRs8I/uJQ3pfNBgWwk151/dWMqtO
 w1X5PRtkdr+uo3Oji7a6iHdCSJNqS4/OnLIXLzCDCVV9k3fYAPb2sBouHfp5kwhGYSSR
 gKYBgnfgD/rcakVyzgQomls80akIqhGSBuTSnP/K8P/IXQJfUwcPdIoF03JekIolIxM/
 Ge+cEy1AdKlnsgKupuDyw6Ybtn7Myz13iiHFGtDIovrdBXNlXMuEgytMI2BAkAA0L7cB
 wP1gAPZv0bsdWMXAX0sOXoHjdCEdRGpXBA5uh6wmTUhAO3Zth1hOF2wxv6IACuwSdtML
 pkWg==
X-Gm-Message-State: APuU4Z854CvYle/xtuOsWic+Z+/zpyHfEfmet02AlhXbtwFffTkjNrx6
 LJWAd7U7E0XPuKwVyqBhwYJ1pYqH4+QpTtYM70AyrcROAvbggloHNKzW5nUpkcQIEF7FItnu/ss
 gVO0NXtdK/ehqODhFM3+KAJJfXtQVHupsI/Aa5Vrmv3siqNPPoXh+QzYM3pFh+sIbP//xAO4=
X-Gm-Gg: AYBFou3Ok80grX96A/xJRh4MQ6lepmJUuITQ70IELGu/XdLZFBR0wHaSuRC5e0E8q+1
 DZ6kRFZxp94OfYvcL8zD9gGXk2qaV+nJ7V1Ildoqc6Stmeg3sOcOhvtsUgH05W8zvpF6r+h4+x8
 QPcIF/xHAV8F6OPlLnVQaAFbAZvAzG7fkicLRfzkZ3P1IdmPAPTNNDLoU+ZQVwIEk3Xi3qsmPAK
 AEQB2JDgDmDrpWZOd+Ma+6C67KDmlab/1lflzGFpamYVMCzN/TgFw9EYlLEAANq4kqGnXcprdjU
 q+gyu6Bx3zFLMh0UD3M8RxR7620XMBRlo4IF1jM8x+ANNoV3X+qrNabkslZXnLDNP5pKEvkwPdY
 FF6nuyi3dT1BNBvXORbNaGGlVjvcc+3juJAiyKq/jlA5XDgvSABcZAdkJdwsoxWBr8nnSyHWf/w
 V0MFG/fKYV5vZvEkkG20Kg1OjyDzuykhf0eMUKWMY4Z1x0
X-Received: by 2002:a05:6000:3ca:b0:48b:174:eab1 with SMTP id
 ffacd0b85a97d-49830d81adamr5057433f8f.36.1794322102638; 
 Tue, 10 Nov 2026 06:48:22 -0800 (PST)
X-Received: by 2002:a05:6000:3ca:b0:48b:174:eab1 with SMTP id
 ffacd0b85a97d-49830d81adamr5057392f8f.36.1794322102119; 
 Tue, 10 Nov 2026 06:48:22 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it.
 [82.192.128.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585923bsm5635389f8f.11.2026.11.10.06.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 06:48:21 -0800 (PST)
Message-ID: <984a9f14-d8d3-41d4-a846-6750f710c741@redhat.com>
Date: Tue, 10 Nov 2026 15:48:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igb: do not let a VF set other VMOLR bits through its
 frame size
To: tkusters@aweta.nl, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Duyck <alexander.h.duyck@intel.com>,
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <20261104-igb-vf-rlpml-v1-1-729621b60eee@aweta.nl>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261104-igb-vf-rlpml-v1-1-729621b60eee@aweta.nl>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ouupQ7OoPcsScJSH0ShyudjdRqD-kh82ly38xVakQb4_1794322103
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 07:34, Tjerk Kusters via B4 Relay wrote:
> From: Tjerk Kusters <tkusters@aweta.nl>
> 
> igb_set_vf_rlpml() gets the maximum frame size from the VF's
> E1000_VF_SET_LPE mailbox message and takes it as a signed int. A value
> with bit 31 set is negative, so it passes the "size >
> MAX_JUMBO_FRAME_SIZE" clamp, and it is then ORed into the VF pool's
> VMOLR without masking. Its upper bits set other bits of that register,
> such as AUPE and ROPE.
> 
> A VF whose port VLAN was set by the PF has AUPE cleared, so that it only
> receives frames tagged with that VLAN. Through this message it can set
> AUPE again and receive untagged frames. It can also set ROPE, so that its
> pool accepts unicast frames that match the Unicast Table Array; while the
> PF fills that table, in promiscuous mode or when it has more unicast
> addresses than receive address registers, that is all unicast traffic.
> igb_set_vf_promisc() does not offer this to VFs.
> 
> Take the size as u32, so that such values are clamped to
> MAX_JUMBO_FRAME_SIZE, which fits in the RLPML field.
> 
> Tested on an I350 with two VFs and kernel 7.3.1. VF 0 got port VLAN 100,
> and a test build of igbvf sent its frame size with bits 31, 26 and 24
> set. Before this patch, AUPE, ROPE and STRCRC were then set in that VF
> pool's VMOLR (0x8f010bce); with it they stay clear, and the size is
> clamped to 9728. The normal igbvf still sets its size (3022 at VF MTU
> 3000) as before.
> 
> This was found by the Sashiko AI review of another igb patch.
> 
> Link: https://lore.kernel.org/all/179370458190.488856.17697539789438631896@kernel.org/
> Fixes: 4ae196dfd61d ("igb: Add support for enabling VFs to PF driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
I still assume this one will go via the intel tree first. Please LMK
if I should apply it directly, thanks!

Paolo

