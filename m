Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E17CA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 09:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0FE6410F1;
	Sat,  3 Oct 2026 09:56:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qrIwJYPLWKVa; Sat,  3 Oct 2026 09:56:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 42DA3410F7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791021396;
	b=nBtT2lpUAxTtsYrOadsYxbKYXpfIMmnc/BPCgOrbFIOoXEUGrDxoSgONMmTkSYxhyTjz
	 I0YEHqMAKyzJAK30mvkqS0OuIam73wQ/N++OQndSBw6ly3WHirhYmb/ZEuL+2QUFMWEqt
	 Cc/apSrBtRwHXOVz3caXd56sScnDVjA9GpZJVJhMGl6ypDYYLPQS/n0nVF8H/MxFO7uIl
	 +YW6H5jPzaHOZhormnGD3pLAiWhjuGJ5OWmi5cWJwkyGZEbdjcR2HMY42Kq/aDjyFoGlX
	 ZvQmaZ2QufgGAwtGflfVBCwQxUG+p610LbwpQyqSWKJPvVXf9m2RuiAP5nyjIoE0oLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791021396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mhOGLNhVHuPmcWb8RMu9RvFxk+n3Vi1d2R+JLkaRA9E=;
	b=h9+X2xMFv3hjiarpM+2BjP2pXtYXRrTw4MQBPt6/R6C0NMZE5T3xIJn39Qvc9u51O/Cf
	 /j1PKa3+LKeCNA859EZ6xOKmNBTvtuWm1N65hhPE4Lq6MuMQ1cOvoM3OZXl5Lw25hwwIC
	 gATPcKjNDaojwMM5IxP/RQBb4eQD5r1Nj5mHHy9nUkAHJwPXW1YJFdQ7rGM9M5t6Y7LOU
	 XpObS4NEFmFFMMnH3TgSV655uKfXLDED2stvQsje5aCAf73fbxNGAnJmaMPwYvPo3WHrX
	 4E16fwpw3g4BGU3ZezRPhnYkc2JUJcKHBxCO2PHk5DE5MJuGl54X0j/0Q9CHtSd+1Uw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NivuZ0TG;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NivuZ0TG;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NivuZ0TG;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NivuZ0TG;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NivuZ0TG;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NivuZ0TG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791021396;
	bh=mhOGLNhVHuPmcWb8RMu9RvFxk+n3Vi1d2R+JLkaRA9E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LgsHJRc3FIZsSXVCWu7jtuWC6inJp2t53pYIjwIXX1t/1rQTmyGP+4yTnqrWSNrhr
	 z2CnwV3mhFejx+Wlq1w5YDDbH8jswiPyMtZb//5HSSedx5hzZ1P6f1mm57WysQ5RLD
	 syrMdk199YZiOC6Bj4i0E26cjfr3yhDaMi6rT9nPlfDnCET8G74OlE9FDN51rJzNyS
	 JvjQ4CODAl1PoX5xv6sWAvi9Vw4GnVa0ejU7EXqncYguVGgL3+eEg4oOITT81tqHoJ
	 mZFQ3Rbpwh9ad7sBEfshHfgrNDQWRPvMJcMcuV2nj2Ql5TtC0jwEE1dGQxuvrLDPsp
	 jsnpV5EBVNP2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42DA3410F7;
	Sat,  3 Oct 2026 09:56:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B643B179
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C7E2410F7
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UT5T4L3P7zmI for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 09:56:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CF861410F1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791021394;
 b=FLexbP5JODerpJlOzwusjoGW3CN8NnwHvVZ7K6x69Tlj06LsNT8bkzcYJv8Ni5VZLA+7
 wMlfQqyLkmaHWsygNFkVisTw6kjLAWUHjesTk4tefAvmPKigKjCbyi/u7gB2GvdPa7ukB
 +x9QHUPU0b9XGhk4sDivs0QwrkKbhF3YtJVt07Z9Wqtq7AhUBKlR3I4X2QJ7m49HbcJ6v
 1T2P2KJrIwboOZO2OReyBMOA52qmvbOoBQ7xPBKmLA+zF+MKiSSEnjubt1ERMsRgdT39g
 QqKBku7ieocpPHazNdtAvqry1cqXGthb3Bckog3XoZxCU+3uR1S2EdfhVGzNk+QcOQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791021394;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
 bh=mhOGLNhVHuPmcWb8RMu9RvFxk+n3Vi1d2R+JLkaRA9E=;
 b=h1Y5a4Je5eEE5v3yVuvwkdflxRzY2BkSuSapO7203EyaUDhklInukIEiGoNxaJ89JDUY
 CIC71JPyJSSp2eddxpS3xtvPGOGNMEaGTzR+UAtvxHfeIwOer4//SCOfzBL+qEdeypiqq
 cHCQcoBx+IEgvKBH8CvuX4SNuD75ajsLE3unjbeNx7EVuKTFQnbAF80/VT99kBnryucsN
 chVI43Dzh1Ml1JjY1zqqn0b2eaqcXuAkKA0Gz+HKFvgG/YAR0Cjbi5RNfKxjenplX8nwc
 JrRbDmUT1u2FwcKlUVDebLKarcq24ROYVwHwk78KoEAiePkLzO/FbBbTzXJo+EY9Klg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=NivuZ0TG; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=NivuZ0TG; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=NivuZ0TG; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=NivuZ0TG; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=NivuZ0TG; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=NivuZ0TG; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NivuZ0TG; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NivuZ0TG; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NivuZ0TG; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=NivuZ0TG; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=NivuZ0TG; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=NivuZ0TG
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF861410F1
 for <intel-wired-lan@osuosl.org>; Sat,  3 Oct 2026 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhOGLNhVHuPmcWb8RMu9RvFxk+n3Vi1d2R+JLkaRA9E=;
 b=NivuZ0TGbu0zAHUbCVglaupEHTjxD93iSTnUX0JtakfYo2sFXtONARhrSlZM//ubwP+ts/
 +qWOtGvrhXM8C8YO8VNnaY8r3RrB8/tb+HK9IVUrdL01BO3RxuN8Y1lIxb6nXTC5mdG1LX
 iBDXObizx2RPYRy7LOtzsZ3g7ZPF6xs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhOGLNhVHuPmcWb8RMu9RvFxk+n3Vi1d2R+JLkaRA9E=;
 b=NivuZ0TGbu0zAHUbCVglaupEHTjxD93iSTnUX0JtakfYo2sFXtONARhrSlZM//ubwP+ts/
 +qWOtGvrhXM8C8YO8VNnaY8r3RrB8/tb+HK9IVUrdL01BO3RxuN8Y1lIxb6nXTC5mdG1LX
 iBDXObizx2RPYRy7LOtzsZ3g7ZPF6xs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhOGLNhVHuPmcWb8RMu9RvFxk+n3Vi1d2R+JLkaRA9E=;
 b=NivuZ0TGbu0zAHUbCVglaupEHTjxD93iSTnUX0JtakfYo2sFXtONARhrSlZM//ubwP+ts/
 +qWOtGvrhXM8C8YO8VNnaY8r3RrB8/tb+HK9IVUrdL01BO3RxuN8Y1lIxb6nXTC5mdG1LX
 iBDXObizx2RPYRy7LOtzsZ3g7ZPF6xs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhOGLNhVHuPmcWb8RMu9RvFxk+n3Vi1d2R+JLkaRA9E=;
 b=NivuZ0TGbu0zAHUbCVglaupEHTjxD93iSTnUX0JtakfYo2sFXtONARhrSlZM//ubwP+ts/
 +qWOtGvrhXM8C8YO8VNnaY8r3RrB8/tb+HK9IVUrdL01BO3RxuN8Y1lIxb6nXTC5mdG1LX
 iBDXObizx2RPYRy7LOtzsZ3g7ZPF6xs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhOGLNhVHuPmcWb8RMu9RvFxk+n3Vi1d2R+JLkaRA9E=;
 b=NivuZ0TGbu0zAHUbCVglaupEHTjxD93iSTnUX0JtakfYo2sFXtONARhrSlZM//ubwP+ts/
 +qWOtGvrhXM8C8YO8VNnaY8r3RrB8/tb+HK9IVUrdL01BO3RxuN8Y1lIxb6nXTC5mdG1LX
 iBDXObizx2RPYRy7LOtzsZ3g7ZPF6xs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhOGLNhVHuPmcWb8RMu9RvFxk+n3Vi1d2R+JLkaRA9E=;
 b=NivuZ0TGbu0zAHUbCVglaupEHTjxD93iSTnUX0JtakfYo2sFXtONARhrSlZM//ubwP+ts/
 +qWOtGvrhXM8C8YO8VNnaY8r3RrB8/tb+HK9IVUrdL01BO3RxuN8Y1lIxb6nXTC5mdG1LX
 iBDXObizx2RPYRy7LOtzsZ3g7ZPF6xs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-r7bVdSx6NaGbGaA6imFaKQ-1; Sat, 03 Oct 2026 05:56:30 -0400
X-MC-Unique: r7bVdSx6NaGbGaA6imFaKQ-1
X-Mimecast-MFC-AGG-ID: r7bVdSx6NaGbGaA6imFaKQ_1791021389
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a022fee32fso4497685e9.0
 for <intel-wired-lan@osuosl.org>; Sat, 03 Oct 2026 02:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791021389; x=1791626189;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CFiXTFcRpKSwbR4iF//D20N/Ft4ckAh6KBeG1mHiTBA=;
 b=dzqhuCTTWxY2JNsJPAZqdMg4PPzwXdkxGJ3qCULsP+qrjOX6elSu57MxHvAmhM5p6e
 K8cTZT82Fs7PLUqUb+ZDV57LfI45712gdqKMqz4erWVwq4GoI24T4zs/TM2FHWut1Qbb
 oewWI67dcChN5iE3fSBVjNWdFWQ9PgMi/jCHEKt3nrkOfRQgSyitO8Kr4OyZyJuQ1DzO
 4EsuowlbyuC0/e01j+WfDoyenfNke/NAlq0s+gbplnGaXwExA4y5MKV68h4N4m6o5U1N
 iGC3ckRiTKkCzXqgHQ+4ZJI3Vj+qnY2KMHuDwUVqIC5MXZ6XmovzSoKw0K8r1m4MZ4j2
 lsoA==
X-Gm-Message-State: AFuF++nhAqUv4UoGz9vrhVTUD7RhZ92yrq2WWDo3XDq0kCYN3Uw17u+w
 V4GPNao8YdecrFjWj/bVZPbCBw6bCZmJbgBDZbwChjVUqAgrTvEpOJJy61sutKp/8HMXJElOA2l
 NG4o2FGb0gcMCjy3uKUh20NJIDx7y0POmfjb2kFlS6pIw6+wzgj3HvwiGaF5RfLBmSuJoBQfhqc
 0mVzxq+kiSK6kicqgwr4mu2D4+rPrAFGLucrGoEVD8uf69wmYU
X-Gm-Gg: AYBFou3gSMH1VzfyHv7uIRxPUx5CPTmOqpwGHN/ncSUjOkPbj0820JbnehsSzLZ92sE
 9kIvV5GTtFNs1SY2TcGbdBPkObNh9/d/U7iDDP9RJJsAVGnl1wK0KUB/J/hPMepBh9juqYcfcIX
 xD+SzqF/FfoPpYzautAdULu0n+PhlnRyvx0G1vi0N8wXRfgHb1pjnus4zLa9CFdCo6iVXFN7YHc
 Q+XjKCRGALCMuKkbnmAZGTuK947cEUR9bSMxb5wimceehCCgn5IFJK8Jg8Bm5Hlde5ByZxzBSKj
 2ogNhnY71GWFQ6bmqijOp/zOdJEJUGOFVG2shJ8hfQjkENOloGUqQLMFyaPs8EjcqfWNGOObsFL
 9wdxg/TWlEquQDBlyFhNjtlqQahI3mOBUY/Xd330=
X-Received: by 2002:a05:600c:3e07:b0:49f:fe39:5bc8 with SMTP id
 5b1f17b1804b1-4a027585dfemr89018165e9.12.1791021389161; 
 Sat, 03 Oct 2026 02:56:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3e07:b0:49f:fe39:5bc8 with SMTP id
 5b1f17b1804b1-4a027585dfemr89017735e9.12.1791021388657; 
 Sat, 03 Oct 2026 02:56:28 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0304407d2sm106558045e9.0.2026.10.03.02.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 02:56:28 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:56:23 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH iwl-net 10/10] ice: fix unsigned stat widths
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-11-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-11-poros@redhat.com>
Message-ID: <9235DF68-76D9-4B38-B8D9-BCFF3520E7D8@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fNAQoq3InvdROVkrDxqCHosyTpj1L9HkEUigsDrndVc_1791021389
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On October 2, 2026 3:07:52 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote=
:
>tx_restart, tx_busy, rx_buf_failed and rx_page_failed in struct ice_vsi
>are u32, but ice_update_vsi_ring_stats() fills them with sums of the
>64-bit per ring counters. The values are truncated and the ethtool
>statistics exported from them wrap at 2^32 while the ring counters keep
>counting.
>
>Make them u64 like tx_linearize next to them.
>
>i40e fixed the same truncation in commit 3b8428b84539 ("i40e: fix
>unsigned stat widths").
>
>Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice.h | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/i=
ntel/ice/ice.h
>index 6c596e5a315175..a985b81efbe2d6 100644
>--- a/drivers/net/ethernet/intel/ice/ice.h
>+++ b/drivers/net/ethernet/intel/ice/ice.h
>@@ -344,10 +344,10 @@ struct ice_vsi {
> =09u64 tx_linearize;
> =09DECLARE_BITMAP(state, ICE_VSI_STATE_NBITS);
> =09unsigned int current_netdev_flags;
>-=09u32 tx_restart;
>-=09u32 tx_busy;
>-=09u32 rx_buf_failed;
>-=09u32 rx_page_failed;
>+=09u64 tx_restart;
>+=09u64 tx_busy;
>+=09u64 rx_buf_failed;
>+=09u64 rx_page_failed;
> =09u16 num_q_vectors;
> =09/* tell if only dynamic irq allocation is allowed */
> =09bool irq_dyn_alloc;

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

