Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CB0D116ED
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Oct 2024 05:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 309D8608E8;
	Fri, 25 Oct 2024 05:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5cr3LVE6ikg; Fri, 25 Oct 2024 05:06:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D09D360659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729832782;
	bh=lrrFN+mHZMwxcP5FxfkCqubko9uzPwGKW+YiwvO7WRE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y5Hubl3EGmzqXzrXlBuUbqGKg/k9KapB6vLfOY/enkbCPgXNB0PED0ZV6oJBvvVOe
	 eB62jw8i/DxxSapzv9OG33vkw9zm1rZ8VPpkdLprQYAfJrZ6X2us706i7jpF2a5msM
	 AzHENk5Lj9AHMQlRnWTTmJGdtFc8vVDG5PdHZ7Ag/ms4T+8kP6QoY2r490w7KOcmhZ
	 76+uonvn5f0MCBvc/VDcxOmC3U/HEey7vPUnFQWVn0AKpdvT4bheCKIzCltrl1hZm8
	 4LxbMabkqn6s1NLlehb5b37HIbPjAkGOJYc/eZDXckqLQ0KvSHrOkW4rHIHeR/6sQ7
	 ixF2ENi0Fhudw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D09D360659;
	Fri, 25 Oct 2024 05:06:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6565B497A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Oct 2024 05:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 430C74017F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Oct 2024 05:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DkcLScIVBTb5 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Oct 2024 05:06:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::12a; helo=mail-il1-x12a.google.com;
 envelope-from=pjohnny0508@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B2497400A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2497400A7
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2497400A7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Oct 2024 05:06:19 +0000 (UTC)
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a3b4663e40so6072185ab.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Oct 2024 22:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729832778; x=1730437578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrrFN+mHZMwxcP5FxfkCqubko9uzPwGKW+YiwvO7WRE=;
 b=mqkPaTa7C9tvFKWGWsYgkqEgo9Oy0ZtFjJzrJV0UHuW9Yu9kVk1rpyVZ6HczJzWgYj
 D/y+wa28y1oVCskG0x3WQ+UrJQX0V1zCNrY/xb/J/677Tj2AJ0QMH5hnq9tObZ/EPYXH
 nzsUnlVkeer2EYaJhbl7uls0xh84PK+wfGlQb/2xQjPca7rE5v8mbvc68bKFJF71iv3Y
 6mRh2Yla0V7JasLdKX1DETpj5bDe3n2qubGioJVUQIFRqB5gO3xejSOJyvDH48Eg/LkW
 /m7O3z2/nCbyr0xcPVPA12nAu6nQw633Mcxy0tgivdqN8Ml8svk5VfGuhjt1MHdqa+Z4
 TBEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsth/nFGhp2b44rp9ErFsA1/Mg89yKVhepQjs+XHjdBddzMjFLxQ+JxXbnuOQgd6lnw92OiOK5e3PRabfYlfI=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyFBB3rljJTsMnbk4lfpNAf8zYzUtrAsNItPu2Rsfi9DXQ7y5Z1
 5A+i4osENdK5eYg17m0acd0H2SmbK80PIuh+THKRwvktjH5qSv0Z
X-Google-Smtp-Source: AGHT+IG9eFw1S1NRd1I3j1OEIDPkFWdnUdNub1uGVLvjvjh+3FMVMCl9vW8ceP5nCaJkh4kCZkZGJg==
X-Received: by 2002:a05:6e02:b2a:b0:39d:2939:3076 with SMTP id
 e9e14a558f8ab-3a4d5a0431cmr97853315ab.25.1729832778418; 
 Thu, 24 Oct 2024 22:06:18 -0700 (PDT)
Received: from Fantasy-Ubuntu ([2001:56a:7eb6:f700:63af:26f:9965:8909])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8a72e92sm224534a12.92.2024.10.24.22.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 22:06:17 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:06:15 -0600
From: Johnny Park <pjohnny0508@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: horms@kernel.org, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pmenzel@molgen.mpg.de
Message-ID: <ZxsnR_fJ5aGKWJTq@Fantasy-Ubuntu>
References: <Zxne9hBl5E5VhKGm@Fantasy-Ubuntu>
 <91005d18-37c7-483b-bda5-2fa57a884a17@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91005d18-37c7-483b-bda5-2fa57a884a17@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729832778; x=1730437578; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lrrFN+mHZMwxcP5FxfkCqubko9uzPwGKW+YiwvO7WRE=;
 b=M1quZSfCmpUe2i+aljhLuH95bNdzugNhuaWYQPHSLUUIIiJ0218HTrRYd2e+xNLjET
 NsOZt/4BCRuf0cYTzbLxEMT+xxRd3xTOakIW0TZLYCluHZVmUtjl2kkBFU4tOepjy+Fo
 EXkY+m0n5443Gt/TalU5MjCbXuM5kCkVat9CTeDtZyDkvsxfcysNvyOOHMHDea9J8gbX
 H7VL4ezOri5ZWwDlsDj82kMp4GKMUJwWwkRTkBxLGXG2g/wzXFQ/UdjG4WU4jZUYw8OV
 N5Vd6kQ/8ltO/R9lCszMIO+Fd97EUykla/ca9ePnACDJceG0mfTAalO2Oy5X9/qAcU7s
 AsXQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=M1quZSfC
Subject: Re: [Intel-wired-lan] [PATCH v3] [net-next] igb: Fix 2 typos in
 comments in igb_main.c
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Oct 24, 2024 at 10:41:25AM +0200, Przemek Kitszel wrote:
> On 10/24/24 07:45, Johnny Park wrote:
> you should collect Reviewed-by tags, as the one from Simon on v2.
Sorry, I wasn't aware of that rule. For future pathces I'll include reviewed/acked tags.

> for future Intel Ethernet drivers series, please target them to IWL
> (net-next in the Subject becomes iwl-next)
Sorry again, from the other patchworks https://patchwork.ozlabs.org/project/intel-wired-lan/list/ I should have noticed that pattern.  
> >   	ring = q_vector->ring;
> > -	/* intialize ITR */
> > +	/* initialize ITR */
> >   	if (rxr_count) {
> >   		/* rx or rx/tx vector */
> 
> Would be great to have capitalization errors fixed too, Rx, Tx, VF, not
> necessarily in this patch.
That sounds like a good idea, perhaps fixing those will be my next patch.
 
> to reduce traffic, I'm fine with this, to go via any tree:
> Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Thank you for the review!

Regards,
Johnny
