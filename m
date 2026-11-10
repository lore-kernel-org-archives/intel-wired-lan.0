Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E4606A320
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=JDdaznmL;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UzB2w9lV;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCIX2bAT;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCIX2bAT;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCIX2bAT;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UzB2w9lV;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCIX2bAT;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCIX2bAT;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UzB2w9lV;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCIX2bAT;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UzB2w9lV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 171244082C;
	Tue, 10 Nov 2026 17:23:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n3kOl2sf-bG0; Tue, 10 Nov 2026 17:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 25EFB40850
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794331411;
	b=HO8OXgfqrYGJT25RNaJVIo2CbpR2WOIFwED/SbXohmOJ3vhgeDrOTyEou0YUFIKeps1b
	 +HyeDTmCD12vi1JsKvuVgPNqqYyo7ybsN+nFI+VgAa9R7+UA+zbc6Nl0c45Y6q/HMjTCG
	 sZMxryKdcf2oSjQeghnlJEsq8zskW2SO2Lta2ziySLnX1OCrbUIYZ3KKPVFQAD76K5IDm
	 1ATIUPMikO6taeBO6dtRKMiLVKrD4A+6JqbOPlKkTYMyO+sizuED7B/FkubofMb3Wxl0I
	 FultdW5+/IP+sjdg+wdsoLMJshnPcFwHo5MAxMQRbO/h0Ucl3GZpXjdLgg/VouB3Ztg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794331411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
	b=Rtc783dqSkaZhvXZS2g4/nuhjpD2JV/uJwppsKBnL1JLG9hLuP310RiVh3jjJ78NcY+Z
	 29Ncvkpqnw/H6Q+ibNQhbiNyRQZv8EQTs9xi7QqsVHMb+uDsYXWkqFOymgYpFfFy++MOJ
	 p37M41pwmuNEe8BrMA3SQMaExiby4PFgxrujXsCisSvbE23JpHrphC5criv5JNyQ02fhL
	 72KLWkjBvz2+xjtP+MxXzQIvK799Uhegx0KcOkCvMGOsyXkQQC+FMNHDcv+RFYgYzNAqX
	 OsrCMsC8sxTMtpDz/vu4IxzpUx38y8G79jdA3pRAb20+r10HAU0eIvAi4N04b9z24zw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794331411;
	bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JDdaznmL++hQVu1IPAYTTz/ixaejEsAytaMd4vFrZ+f9hM7xvgBnMp/BVL3DmMXLv
	 9jNyCkL6l/QEjm5Hqk1ldoL3/O93rmx2ihttbioIe9wrIYXO//g9Ld4q+i9dTHrsP7
	 dcwbi5b6rkFejHnk2RkP1RGzhnaqShUDtKeP1Y8Wm3iXiNWPGhAK6soa/mYeGzr735
	 jHFg85pxQ1Ma8AtithYsDlDoOJN8uVjrMVFsDkZCENdGm/Tp5H3habyARthK0Q/RvF
	 W1/AK1XcT3zFTK09yoQFnkMAlWuwP27b+R1cMd5BLSIGb345sRrCZv1btylFh1fMZt
	 7rkibvBa2gC4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25EFB40850;
	Tue, 10 Nov 2026 17:23:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C106731
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5185980DF9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:23:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P5GJ3SPPXJ-w for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 17:23:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 854BB80DCB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UzB2w9lV; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCIX2bAT; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCIX2bAT; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=HCIX2bAT; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=UzB2w9lV; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=HCIX2bAT; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=HCIX2bAT; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=UzB2w9lV; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=HCIX2bAT; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=UzB2w9lV
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 854BB80DCB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
 b=UzB2w9lVUbXPrjTXZr6qWceIUq3NLAUN6AMS0KQt4LfiqkwDEVRxHy1alYPCL6V+gH96XQ
 Kr7SMiyLNGQoStXNFPkPCUpJ+EBJroj61wOI4lXLYXlexMpUdx0taZkcAi7fULeLBU1es4
 CSN6xC08CFA6qC4TeSQfElWd8b9vJd0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
 b=HCIX2bATgdfuhDn6vBzA1CAwK2HNKz7slvI0IUxeXs9J0zPLNFf9zj+WhM8U0N4bqlNlvF
 0UrVggVs0r3YIvaQ2SofO7D5WFlUmIm1pgBOaxCUvfMuwSX1DzggvxEXhSmhDx8jBktx8F
 xPW2uKKrRPqYUOS8hueQTQqwc0FczRI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
 b=HCIX2bATgdfuhDn6vBzA1CAwK2HNKz7slvI0IUxeXs9J0zPLNFf9zj+WhM8U0N4bqlNlvF
 0UrVggVs0r3YIvaQ2SofO7D5WFlUmIm1pgBOaxCUvfMuwSX1DzggvxEXhSmhDx8jBktx8F
 xPW2uKKrRPqYUOS8hueQTQqwc0FczRI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
 b=HCIX2bATgdfuhDn6vBzA1CAwK2HNKz7slvI0IUxeXs9J0zPLNFf9zj+WhM8U0N4bqlNlvF
 0UrVggVs0r3YIvaQ2SofO7D5WFlUmIm1pgBOaxCUvfMuwSX1DzggvxEXhSmhDx8jBktx8F
 xPW2uKKrRPqYUOS8hueQTQqwc0FczRI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
 b=UzB2w9lVUbXPrjTXZr6qWceIUq3NLAUN6AMS0KQt4LfiqkwDEVRxHy1alYPCL6V+gH96XQ
 Kr7SMiyLNGQoStXNFPkPCUpJ+EBJroj61wOI4lXLYXlexMpUdx0taZkcAi7fULeLBU1es4
 CSN6xC08CFA6qC4TeSQfElWd8b9vJd0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
 b=HCIX2bATgdfuhDn6vBzA1CAwK2HNKz7slvI0IUxeXs9J0zPLNFf9zj+WhM8U0N4bqlNlvF
 0UrVggVs0r3YIvaQ2SofO7D5WFlUmIm1pgBOaxCUvfMuwSX1DzggvxEXhSmhDx8jBktx8F
 xPW2uKKrRPqYUOS8hueQTQqwc0FczRI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
 b=HCIX2bATgdfuhDn6vBzA1CAwK2HNKz7slvI0IUxeXs9J0zPLNFf9zj+WhM8U0N4bqlNlvF
 0UrVggVs0r3YIvaQ2SofO7D5WFlUmIm1pgBOaxCUvfMuwSX1DzggvxEXhSmhDx8jBktx8F
 xPW2uKKrRPqYUOS8hueQTQqwc0FczRI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
 b=UzB2w9lVUbXPrjTXZr6qWceIUq3NLAUN6AMS0KQt4LfiqkwDEVRxHy1alYPCL6V+gH96XQ
 Kr7SMiyLNGQoStXNFPkPCUpJ+EBJroj61wOI4lXLYXlexMpUdx0taZkcAi7fULeLBU1es4
 CSN6xC08CFA6qC4TeSQfElWd8b9vJd0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
 b=HCIX2bATgdfuhDn6vBzA1CAwK2HNKz7slvI0IUxeXs9J0zPLNFf9zj+WhM8U0N4bqlNlvF
 0UrVggVs0r3YIvaQ2SofO7D5WFlUmIm1pgBOaxCUvfMuwSX1DzggvxEXhSmhDx8jBktx8F
 xPW2uKKrRPqYUOS8hueQTQqwc0FczRI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
 b=UzB2w9lVUbXPrjTXZr6qWceIUq3NLAUN6AMS0KQt4LfiqkwDEVRxHy1alYPCL6V+gH96XQ
 Kr7SMiyLNGQoStXNFPkPCUpJ+EBJroj61wOI4lXLYXlexMpUdx0taZkcAi7fULeLBU1es4
 CSN6xC08CFA6qC4TeSQfElWd8b9vJd0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-ioCKuOKXMjSJKhTx4vXA4g-1; Tue, 10 Nov 2026 10:23:01 -0500
X-MC-Unique: ioCKuOKXMjSJKhTx4vXA4g-1
X-Mimecast-MFC-AGG-ID: ioCKuOKXMjSJKhTx4vXA4g_1794324181
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso16928975e9.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 07:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794324180; x=1794928980;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1IKv8y20r1vzev+9QcpCTiSM8EabciUUIoas3eSK7bk=;
 b=KW7u24486TfSevW/ZtJRM4OXQjSD24JTzTUMT/6vETHVgj3YHq8kzz3tEHgfTh12Wb
 VHZzN68BoWPvqBTHsB1bFNYYuzzx7hf/JoKslebAwaJWI7NpIZ0MtJYizIXIRkXQF+Kz
 t8kf7TvXy9V/9s7Sd20/pkRuVuZcHspgkfDmWb/nfA2KAV+tYSYmwYJPUvfczGeNT0gp
 oyFVWZjVNjVxR8fza09MC/NKAMi/PAiZVxF1wGFE9yUXT/7F5IMABoN/pXzhzu23leg/
 gfV8iBiqZEXM0hRM0XamS2wg8Bp/yvGEikhrJmiuaiK00BIRvi87VlrSOgSaA05h55rb
 naxQ==
X-Forwarded-Encrypted: i=1;
 AL+hErELViKGN0gofaFLIWsIR/XruQvZ1MhNSnV8FUECrVrBy3k0RjlbMhvLOgD2LgZRCf5LOiKirAngojpuIa+xvMY=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8YrWeQAmNXbGJM39u90dj/6mvAXU7WKBtVfR4SuvM+I2Ruhbfm
 GJan+GZL3UwfI6rwqz2EyyQqXKMITKFMTwkt3Lmf4cw7UBYw158dehVc+Pkp4I0EEylyidfmwmj
 GZgob5agCGqIwGsBzDphZmihxmOuQn/vlGa0NGd+tq/R1LJMlUokd8NQaQhajKdM9gNTT0Ao=
X-Gm-Gg: AYBFou3MAdctJrwLZiqtWCo2HjE95qIFszDAIErUnN9kOa1vMLmsBdZMZQZhtY0SxzG
 oH7/HhWG7WUzW4j+CdvDX4ZSwDL7EEopt2rZQSmG12OGBwLHAWco39dNiHOMCKxtKhrmrZG9oF0
 YCRbi4WuDn30fiBNqfdIU3fuZVhmo/mZamsRFoyowECK+lS5CNA7H2I1O9qMimfbCQLEz6sGtn5
 yowt9K6bHkjynUJm6QLNQMRSNt8t2SNEAcvGEhI3ua30NpvuQ8mz76VHEEYPoamno9x6uPZmGXE
 QZvGGBNLrpcZjS8ekQol50ktDUgEDKyoViVv5TGchhjNmCIV2SA6nf1xhxb2Th4zhr6BYsIWf7a
 nIb0vyx7UCm2Kr/EwFkStSk6inU6stGanZV8=
X-Received: by 2002:a05:600c:3b98:b0:4a7:462c:6b9e with SMTP id
 5b1f17b1804b1-4ba02351506mr60403455e9.32.1794324180555; 
 Tue, 10 Nov 2026 07:23:00 -0800 (PST)
X-Received: by 2002:a05:600c:3b98:b0:4a7:462c:6b9e with SMTP id
 5b1f17b1804b1-4ba02351506mr60402605e9.32.1794324179979; 
 Tue, 10 Nov 2026 07:22:59 -0800 (PST)
Received: from [10.43.3.161] ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba022fbf75sm58097845e9.0.2026.11.10.07.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 07:22:59 -0800 (PST)
Message-ID: <cf90b9bc-80a1-4905-8669-823ff80c575b@redhat.com>
Date: Tue, 10 Nov 2026 16:22:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ice: dpll: serialize changes of the SyncE CGU
 registers
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Schmidt <mschmidt@redhat.com>, Jakub Ramaseuski
 <jramaseu@redhat.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20261110094350.184185-1-ivecera@redhat.com>
 <20261110094350.184185-2-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261110094350.184185-2-ivecera@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ydFhM-Z5zHE-avFf1kepLurDLNQSXP-uL8Zu3CWZCOE_1794324181
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



On 11/10/26 10:43 AM, Ivan Vecera wrote:
> All E825C PFs share the CGU registers R10 and R11. On dual complex E825
> the second complex reaches the CGU of complex 0 through cgu_peer. RCLK pin
> callbacks read, modify and write these registers under dpll_lock and the
> pf->dplls.lock of their PF. ice_ptp_link_change() rewrites R10 under the
> pf->dplls.lock of its PF only, so a link change on one PF can write back
> a stale R10 and undo an RCLK pin change made by another PF.
> 
> Add a mutex to struct ice_adapter, which all E825C PFs share, and hold it
> around these sequences.
> 
> Tested on GNR-D with dual complex E825, with a 2 to 4 ms delay after the
> read of R10 in the link change path to widen the window. Toggling the
> RCLK pin of one port while another port of the same complex went down
> and up 143 times lost 120 of 86814 updates of the mux in R10 without
> this patch, and none of 76992 with it.
> 
> Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_adapter.c |  2 ++
>   drivers/net/ethernet/intel/ice/ice_adapter.h |  4 ++++
>   drivers/net/ethernet/intel/ice/ice_dpll.c    | 11 ++++++-----
>   drivers/net/ethernet/intel/ice/ice_dpll.h    |  4 ++++
>   drivers/net/ethernet/intel/ice/ice_ptp.c     |  2 ++
>   drivers/net/ethernet/intel/ice/ice_tspll.c   |  4 ++--
>   6 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
> index 536923b6ae979d..aa2d8addae5bef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> @@ -72,6 +72,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
>   	spin_lock_init(&adapter->txq_ctx_lock);
>   	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
>   		mutex_init(&adapter->cpi_phy_lock[i]);
> +	mutex_init(&adapter->cgu_synce_lock);
>   	refcount_set(&adapter->refcount, 1);
>   
>   	spin_lock_init(&adapter->ports.lock);
> @@ -85,6 +86,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
>   	WARN_ON(!list_empty(&adapter->ports.list));
>   	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
>   		mutex_destroy(&adapter->cpi_phy_lock[i]);
> +	mutex_destroy(&adapter->cgu_synce_lock);
>   
>   	cleanup_srcu_struct(&adapter->ports.srcu);
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
> index c61bd645e460de..fd5585005d91ba 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> @@ -41,6 +41,8 @@ struct ice_port_list {
>    * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
>    * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
>    *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
> + * @cgu_synce_lock: Mutex serializing changes of the CGU registers R10 and R11,
> + *                  which all PFs reach. Used on E825C devices.
>    * @ctrl_pf: Control PF of the adapter
>    * @ports: Ports list
>    * @index: 64-bit index cached for collision detection on 32bit systems
> @@ -53,6 +55,8 @@ struct ice_adapter {
>   	spinlock_t txq_ctx_lock;
>   	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
>   	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
> +	/* Serialize changes of the SyncE CGU registers (E825C only) */
> +	struct mutex cgu_synce_lock;
>   
>   	struct ice_pf *ctrl_pf;
>   	struct ice_port_list ports;
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index ade1fb3dd06743..5148e419f49a07 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2027,7 +2027,7 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
>    *
>    * DPLL subsystem callback. Set proper signals to recover clock from port.
>    *
> - * Context: Called under pf->dplls.lock
> + * Context: Called under pf->dplls.lock, acquires adapter->cgu_synce_lock
>    * Return:
>    * * 0 - success
>    * * negative - error
> @@ -2035,14 +2035,15 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
>   static int ice_dpll_synce_update_e825c(struct ice_hw *hw, bool ena,
>   				       u32 port_num, enum ice_synce_clk output)
>   {
> +	struct ice_pf *pf = hw->back;
>   	int err;
>   
> +	mutex_lock(&pf->adapter->cgu_synce_lock);
>   	/* configure the mux to deliver proper signal to DPLL from the MUX */
>   	err = ice_tspll_cfg_bypass_mux_e825c(hw, ena, port_num, output);
> -	if (err)
> -		return err;
> -
> -	err = ice_tspll_cfg_synce_ethdiv_e825c(hw, output);
> +	if (!err)
> +		err = ice_tspll_cfg_synce_ethdiv_e825c(hw, output);
> +	mutex_unlock(&pf->adapter->cgu_synce_lock);
>   	if (err)
>   		return err;
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
> index bce0bea9a664bc..3f9a993129acef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
> @@ -158,6 +158,7 @@ struct ice_dpll {
>    *     txclk_notify_rwsem (read)
>    *       -> pf->dplls.lock
>    *         -> ctrl_pf->dplls.lock
> + *         -> adapter->cgu_synce_lock
>    *
>    *   - @lock serializes all DPLL state mutations on this PF. When the
>    *     controlling PF's lock must also be taken (e.g. updating the shared
> @@ -169,6 +170,9 @@ struct ice_dpll {
>    *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side
>    *     standalone (not nested under any other lock) to drain in-flight
>    *     readers before pins and the TXC DPLL device are freed.
> + *   - adapter->cgu_synce_lock serializes changes of the CGU registers R10 and
> + *     R11. All E825C PFs reach one CGU, so @lock, which is per PF, does not
> + *     cover them.
>    */
>   struct ice_dplls {
>   	struct kthread_worker *kworker;
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 7980eaf9ce2535..449819cf8c8791 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1368,7 +1368,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>   				break;
>   			}
>   
> +			mutex_lock(&pf->adapter->cgu_synce_lock);
>   			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
> +			mutex_unlock(&pf->adapter->cgu_synce_lock);
>   			if (active && err) {
>   				dev_err_once(ice_pf_to_dev(pf),
>   					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
> diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
> index 85bacb7c3a7903..b99e02cfe559bd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tspll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
> @@ -792,7 +792,7 @@ int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
>    *
>    * Set reference clock source and output clock selection.
>    *
> - * Context: Called under pf->dplls.lock
> + * Context: Called under pf->dplls.lock and adapter->cgu_synce_lock
>    * Return:
>    * * 0 - success
>    * * negative - error
> @@ -898,7 +898,7 @@ static int ice_tspll_get_div_e825c(u16 link_speed, unsigned int *divider)
>    *
>    * Set the correct CGU divider for RCLKA or RCLKB.
>    *
> - * Context: Called under pf->dplls.lock
> + * Context: Called under pf->dplls.lock and adapter->cgu_synce_lock
>    * Return:
>    * * 0 - success
>    * * negative - error
Reviewed-by: Petr Oros <poros@redhat.com>

