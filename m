Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D65606A320
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=c4vXmGol;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20DA14082C;
	Tue, 10 Nov 2026 17:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8u--XOZo8NX3; Tue, 10 Nov 2026 17:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68F7640850
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794331454;
	b=DAM0Xu1LsdxULsOIruMxPSt8j6Y4qsdwtt1EGbm3h7nSN10XjCbRZGr/YPKIHETErVOJ
	 UR8ZojZEVxU/VVO2G3VuEr8C79vxnHqQ6tu0ZH1fV3z9XqiGIW6Nx9RdYR6HNvF1NmWuv
	 jFV/EipSSOidYXqnA9p5rQyFkYa+dYcgSfyemghc/vHVvqJpsM4i5xZq1GgP7pP7ovzJO
	 sBlvnN8CEU+beq73/+rz5fZgutgnxKowuikUdkpmWM8mTjk5zcPMRTkBEa490EPUcs7QM
	 BO868sWhpOEM+q1Xz2F5L3kIYRm80+7/B9lPlPgOmNUyp1bwnMNeRa/yoD84lWNZoPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794331454;
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
	bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
	b=BkmZPFukPmcKnqtwTb3ZHsmqcQjqbuRRAdJIVJ7eYOSmAtHfjkjJrgZBC2THtZlnCe6E
	 jOAYXWDDJj175IkVxl8dNSJWsVGujXmcu3tkSiwI3NQapaKjNYH2uLicqn7iREYCS2Dm4
	 WqoAzQayLCKMv38CnlOQT2oampvYCcJZfhDDmfMUUXObqmrvyerXAm7N8pCuWYHfWEVQ/
	 dBtgOLK6BI4ciX7bR/Y4EiHStYSZmz5sA4JG8OybmlYh93hKN/q3KieBnifpnQnL1i2OC
	 8snyF0kfiREMCthT91cqrnI5Thu3ZUxJQ4IbouHhwYNT063ggJZjDIVzHDmO5V+ebOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794331454;
	bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c4vXmGolYol8fQFh5Q+yNpVl1Ei6QqN0QO95GVX1FARjGmbuTHN5rVwhTSqCNvuPh
	 3kIIXbAuKQtfkTtYGYM7b63P3XMNY+brKMDhEaYfTdoguj98GtKm+zHIpexAmoeA2m
	 pS32F2q1GYWsJuvETbPBuZ9645ovzRxDbA+0MJAVRBqVkC1AgqJyAiRiGl9rihldP/
	 rQbvRaHBD4GQCox1CAoHlCGG9cQjQFenT4eCQBcDn5I0G5ZF9T8Aq4794dL1yfiW2Y
	 4AMtlwYyekRQeHZxyTw/YNqi3odCVhaqkdMekqJJ941I4jN5pg7h3OZi1UAAZSACwM
	 htBC8ghh34hAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68F7640850;
	Tue, 10 Nov 2026 17:24:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F830731
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1505F80DD7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tCeftKZ7DaYa for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 17:24:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35B7680DCB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSGfeg6Q; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=jSGfeg6Q; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=jSGfeg6Q; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=jSGfeg6Q; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=jSGfeg6Q; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=jSGfeg6Q; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=jSGfeg6Q; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=jSGfeg6Q
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35B7680DCB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
 b=jSGfeg6QGzvgTdbHN9/kMR4Yo6L1bozn3Ru9rSmtlhsnbqDmjGMXnspOmzDkOIjJWdAkcu
 e4Uk7xiCFeSlPUfs9KuRUcqaNGWopdIN9Rd24+mBKAdUgducdP6/gOIy6xWSsunNX4oVKz
 pE8uFxGrQgpwMBTrKyB4gtTidbT+bJg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
 b=jSGfeg6QGzvgTdbHN9/kMR4Yo6L1bozn3Ru9rSmtlhsnbqDmjGMXnspOmzDkOIjJWdAkcu
 e4Uk7xiCFeSlPUfs9KuRUcqaNGWopdIN9Rd24+mBKAdUgducdP6/gOIy6xWSsunNX4oVKz
 pE8uFxGrQgpwMBTrKyB4gtTidbT+bJg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
 b=jSGfeg6QGzvgTdbHN9/kMR4Yo6L1bozn3Ru9rSmtlhsnbqDmjGMXnspOmzDkOIjJWdAkcu
 e4Uk7xiCFeSlPUfs9KuRUcqaNGWopdIN9Rd24+mBKAdUgducdP6/gOIy6xWSsunNX4oVKz
 pE8uFxGrQgpwMBTrKyB4gtTidbT+bJg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
 b=jSGfeg6QGzvgTdbHN9/kMR4Yo6L1bozn3Ru9rSmtlhsnbqDmjGMXnspOmzDkOIjJWdAkcu
 e4Uk7xiCFeSlPUfs9KuRUcqaNGWopdIN9Rd24+mBKAdUgducdP6/gOIy6xWSsunNX4oVKz
 pE8uFxGrQgpwMBTrKyB4gtTidbT+bJg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
 b=jSGfeg6QGzvgTdbHN9/kMR4Yo6L1bozn3Ru9rSmtlhsnbqDmjGMXnspOmzDkOIjJWdAkcu
 e4Uk7xiCFeSlPUfs9KuRUcqaNGWopdIN9Rd24+mBKAdUgducdP6/gOIy6xWSsunNX4oVKz
 pE8uFxGrQgpwMBTrKyB4gtTidbT+bJg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
 b=jSGfeg6QGzvgTdbHN9/kMR4Yo6L1bozn3Ru9rSmtlhsnbqDmjGMXnspOmzDkOIjJWdAkcu
 e4Uk7xiCFeSlPUfs9KuRUcqaNGWopdIN9Rd24+mBKAdUgducdP6/gOIy6xWSsunNX4oVKz
 pE8uFxGrQgpwMBTrKyB4gtTidbT+bJg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
 b=jSGfeg6QGzvgTdbHN9/kMR4Yo6L1bozn3Ru9rSmtlhsnbqDmjGMXnspOmzDkOIjJWdAkcu
 e4Uk7xiCFeSlPUfs9KuRUcqaNGWopdIN9Rd24+mBKAdUgducdP6/gOIy6xWSsunNX4oVKz
 pE8uFxGrQgpwMBTrKyB4gtTidbT+bJg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
 b=jSGfeg6QGzvgTdbHN9/kMR4Yo6L1bozn3Ru9rSmtlhsnbqDmjGMXnspOmzDkOIjJWdAkcu
 e4Uk7xiCFeSlPUfs9KuRUcqaNGWopdIN9Rd24+mBKAdUgducdP6/gOIy6xWSsunNX4oVKz
 pE8uFxGrQgpwMBTrKyB4gtTidbT+bJg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
 b=jSGfeg6QGzvgTdbHN9/kMR4Yo6L1bozn3Ru9rSmtlhsnbqDmjGMXnspOmzDkOIjJWdAkcu
 e4Uk7xiCFeSlPUfs9KuRUcqaNGWopdIN9Rd24+mBKAdUgducdP6/gOIy6xWSsunNX4oVKz
 pE8uFxGrQgpwMBTrKyB4gtTidbT+bJg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794331450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
 b=jSGfeg6QGzvgTdbHN9/kMR4Yo6L1bozn3Ru9rSmtlhsnbqDmjGMXnspOmzDkOIjJWdAkcu
 e4Uk7xiCFeSlPUfs9KuRUcqaNGWopdIN9Rd24+mBKAdUgducdP6/gOIy6xWSsunNX4oVKz
 pE8uFxGrQgpwMBTrKyB4gtTidbT+bJg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-VX9mSX-_OF2ItPzgvPYI6w-1; Tue, 10 Nov 2026 10:23:22 -0500
X-MC-Unique: VX9mSX-_OF2ItPzgvPYI6w-1
X-Mimecast-MFC-AGG-ID: VX9mSX-_OF2ItPzgvPYI6w_1794324202
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4901562b819so1929754f8f.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 07:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794324202; x=1794929002;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+CUnMRhHKdQfCRpByCe4Goi7VLzpKCgXnhT03CuzEEU=;
 b=BQu3my7nlbToLhOf7TJ1x7ywD14rMPqW8HUzTysHV2RWzg3nL8tumXDn+UmipJFPbP
 +tyym5xbF09a93Krh20vHIpsTI0BLUjayfXRUGqPUfauMAvlTVCmx0+GeD3lCeU0RZQr
 6lTNacMzpWDQprCy+HL++vpOKSzGWSDvxz0E+bPv3n0+DNu/8/4IeNYQFDqqWtFZ5NoE
 j9vgqrDDrpbTuvxd4qAbUIfK9Vgwi9hF4xH9/7BDDS1qViY/0KthGvUoNSs4cWEnc+DY
 1wF7JNZgG/B32m9nwfYCf6XhTyk+qrbhdpMIZGKG1f5cqriHnv6eg/2ZjZzlYLr7R6vB
 6IHw==
X-Forwarded-Encrypted: i=1;
 AL+hErEhrnPNWr837rXHf1X5I/OLv03aZVDOMgbky2vsGDm2BGztkLr6b5+8j/EGvPPjoqgtSAB+1lCeRdWmfOlu5BA=@lists.osuosl.org
X-Gm-Message-State: APuU4Z++ejKqRvaHJVfy0YANKMElPBS0Md7nU5rREtDJWTugxw6zBWCW
 eDvjdyv07xweIoPG9ZmvCNLyy6QTfEY+X5no4WAoA7vvabzIhwJAaDAwurtlJUPzCCVHNR3aqpr
 g6O0nOMGUdCHo99dx9IugDYPdqmI2T3eDNbKwpUaa1lfHOEvcsEA4iusbOnSQDBbXScA+TzQ=
X-Gm-Gg: AYBFou3vv82KLa3e/pWzVGBp0V3tq/YqpVPppU2c2foTlwy3v+yXnQVPP1NxjlY50bg
 NgBY3C48Wr79D0Rt8W35sce24bBSQ7oexKA6BYgah00ilgIa2UyL6kRUk5z7sKh+qGyqB/CI75A
 kq+BHJiYlsLR++sfb5+UMKef76I2DJMvhwHrjOV/t8XNjBrvAq11oWLSnHM9lA+Z7aEaHQt6GOy
 jcYHDCI4dyBzrQ8QHDTjiDGFetWk9gEDAYaWSmaYgQfg2tcGFOQTd4/37oMXbVJ/iUk/SKYAZCz
 iE1X+mun0QBiA2pw4yke66IfChU+XCew5A61BTNgF0wUXDwvoHlwWfxRw/OienncEVGsKpnLJoB
 6ceyK3xUvbvtWfwu6NEhKvStzYQKMq8BW/Cc=
X-Received: by 2002:a05:6000:26cb:b0:491:da8f:7276 with SMTP id
 ffacd0b85a97d-4982eb0b774mr5935827f8f.26.1794324201617; 
 Tue, 10 Nov 2026 07:23:21 -0800 (PST)
X-Received: by 2002:a05:6000:26cb:b0:491:da8f:7276 with SMTP id
 ffacd0b85a97d-4982eb0b774mr5935745f8f.26.1794324201090; 
 Tue, 10 Nov 2026 07:23:21 -0800 (PST)
Received: from [10.43.3.161] ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835f1772dsm5570076f8f.31.2026.11.10.07.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 07:23:20 -0800 (PST)
Message-ID: <17d805e7-4f5c-4184-ba53-3d3e2ed36df9@redhat.com>
Date: Tue, 10 Nov 2026 16:23:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] ice: dpll: set the SyncE divider only for the
 port driving the output
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
 <20261110094350.184185-3-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261110094350.184185-3-ivecera@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L-brdjHU7wLD3ia7UcYTHMSIi9tsoHbrgEKIyJ5QP6A_1794324202
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



On 11/10/26 10:43 AM, Ivan Vecera wrote:
> R10 holds one divider for each recovered clock output, shared by all
> ports. ice_ptp_link_change() sets it from the link speed of its own port
> even when another port drives the output, and checks the mux only to
> decide whether an error is worth reporting. With ports running at
> different speeds, a link change on one port leaves the output of another
> port with a wrong divider.
> 
> Skip the outputs that the port does not drive, and check the mux under
> cgu_synce_lock, so that another PF cannot select its port in between.
> 
> The check computes the mux value as port % ports_per_phy + 3, while
> ice_tspll_cfg_bypass_mux_e825c() and ice_dpll_rclk_update_e825c() use
> port + 3. With the skip, a port from ports_per_phy up would never update
> the divider, so use port + 3 as they do.
> 
> Tested on GNR-D with dual complex E825. With the RCLK pin of one port
> connected, five down and up cycles of another port of the same complex
> called ice_tspll_cfg_synce_ethdiv_e825c() 20 times without this patch
> and never with it. Five cycles of the port driving the output still
> called it 10 times. Both ports ran at 25 Gb/s, so the divider value did
> not change on this setup.
> 
> Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c   | 10 +++++++---
>   drivers/net/ethernet/intel/ice/ice_tspll.c |  4 ++--
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 449819cf8c8791..81565bbb692e9a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1350,6 +1350,7 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>   		int pin, err;
>   
>   		mutex_lock(&pf->dplls.lock);
> +		mutex_lock(&pf->adapter->cgu_synce_lock);
>   		for (pin = 0; pin < ICE_SYNCE_CLK_NUM; pin++) {
>   			enum ice_synce_clk clk_pin;
>   			bool active;
> @@ -1368,16 +1369,19 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>   				break;
>   			}
>   
> -			mutex_lock(&pf->adapter->cgu_synce_lock);
> +			/* The divider is shared, set it only for our port */
> +			if (!active)
> +				continue;
> +
>   			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
> -			mutex_unlock(&pf->adapter->cgu_synce_lock);
> -			if (active && err) {
> +			if (err) {
>   				dev_err_once(ice_pf_to_dev(pf),
>   					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
>   					     pin, err);
>   				break;
>   			}
>   		}
> +		mutex_unlock(&pf->adapter->cgu_synce_lock);
>   		mutex_unlock(&pf->dplls.lock);
>   
>   		if (linkup)
> diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
> index b99e02cfe559bd..0bfbea43529523 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tspll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
> @@ -746,6 +746,7 @@ int ice_tspll_init(struct ice_hw *hw)
>    *
>    * Check if given port is selected as recovered clock source for given output.
>    *
> + * Context: Called under pf->dplls.lock and adapter->cgu_synce_lock
>    * Return:
>    * * 0 - success
>    * * negative - error
> @@ -774,8 +775,7 @@ int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
>   		return -EINVAL;
>   	}
>   
> -	if (active_clk == port % hw->ptp.ports_per_phy +
> -			  ICE_CGU_BYPASS_MUX_OFFSET_E825C)
> +	if (active_clk == port + ICE_CGU_BYPASS_MUX_OFFSET_E825C)
>   		*active = true;
>   	else
>   		*active = false;
Reviewed-by: Petr Oros <poros@redhat.com>

