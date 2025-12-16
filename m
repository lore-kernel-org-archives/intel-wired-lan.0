Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668F0D609C2
	for <intel-wired-lan@archiver.kernel.org>; Tue, 16 Dec 2025 16:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C629608E4;
	Tue, 16 Dec 2025 16:34:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uan3CrSIFZDN; Tue, 16 Dec 2025 16:34:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A07D6608EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1765902861;
	bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sAx6mHOs/c3n5lssKTdkLJTZekr/eu7rJjBlC4ScCRcZQ1FdM5DEkDHYoWHoL62I1
	 Qj9kmoQW2gKsMjpM3i7BOcv4ABwazC8cqDLeA2C/dr3JI2N+6xtD7dNQo9iMkHUyJK
	 FeoXyLEecp7Pe3V5I4d2qiUOhwjyMEN45w/RFrgVU/mKDYuWwO/OWS1LlHKOLmVIxg
	 2h6qy2Wds3boiHZtvp7JaPbKadgoFOBqKuxv6mkohxV2a3zUXHKbsYffw7uD5CpG6o
	 3bxr89kw3vitPuj+xdwzKMhfw4098pl8DTSEfhgeBf2s85hzPnmtN8dlG4+qfOX5if
	 UeCdmoLkEHw5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A07D6608EF;
	Tue, 16 Dec 2025 16:34:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 33F85151
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Dec 2025 14:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A9AE40705
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Dec 2025 14:42:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2MwiUOcE6lbV for <intel-wired-lan@lists.osuosl.org>;
 Tue, 16 Dec 2025 14:42:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgrinber@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0701D4027A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0701D4027A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0701D4027A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Dec 2025 14:42:00 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573--lV5ormIMLyJNIk5IUFCqA-1; Tue, 16 Dec 2025 09:41:58 -0500
X-MC-Unique: -lV5ormIMLyJNIk5IUFCqA-1
X-Mimecast-MFC-AGG-ID: -lV5ormIMLyJNIk5IUFCqA_1765896117
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4788112ec09so34166035e9.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 Dec 2025 06:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765896117; x=1766500917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
 b=J318Kn1hA/4HsDHwwtnjW7oASkNizv45rQjFyaV3WHVV9RqI1HzxsIqqOkNnmPEAky
 ysUaZLDGeIOMvwYRoiGpakXDztxSCFst5S42Zl6/urZmqZfsPx8Z8h3ZDfiJBHiKx2Sr
 X9V67p84pyaood34nkWoLygJf3zv2/QgO0YDIZh/8rR8bIyvz50PcYJ0ctmXRN7xRNgU
 Y4MyfIniGJ+S+y/mVnY3v7j86359wbdat+2VOFKcE78Sy6cTsmUyTuVmslpHUGaNtJsk
 5avjjWc4ydyzM6mdPsuTVxd5aTKwSKKJHnhQtVVCKFJL30y6lOJXgVwrBftGpKz8szWc
 Le7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmli4aWtFrEtgwzzcomlYbi0ML1sr4hrZdDuwprCrXYowbDiKa/panZQ15TK+x4ALuFmJCkg8fyXeZ6FB/OTY=@lists.osuosl.org
X-Gm-Message-State: AOJu0Ywg62NCgaHxorCf4bkEjkK798jYZoKq6VT0wDnpo16pMi7SnxuX
 dagIvWFY2875Pv2qoZhvfp1QvKcEAcHUGLJE4Ujvf7qVFUMPyhFy2VORR3gVbm6TvgoGodgS1LT
 eMHqf1cy/jEMfEk0SJneTzKYzeJfrwF1nMU4v86ZuUcJGGAXBpU6Vnkbz3n5eXGiUUAI1T8U=
X-Gm-Gg: AY/fxX65DX9dBGcSIDPypLXwOWIcAtHqQf6y6rgoQpyqCTKLkQ0MRrAGoz6CrsBJxuT
 EwgexZpcg2HxIaRMDdm6F7w4tFnU0jgbJ4Z1AutrCkrwiPAclNYvn6pc+E0bSOZ6OPZPv0fXinn
 mXD2wYNiBbsqukj8K1ikNKO6JTkNen5v33nJkZVZRX0sDlYO1gZV2hfDwm82p+07AjGhetRyzxA
 4gRNOX6UIh5GD18lFYvXuzFgzPXBuQoDjwXvKLndByJCJGf2nE/mllED4lOQaRi9llY5hnsbbYw
 kahbY0XyQct+hcRMsHHBkm4AZ1irpgwFmnVGzXfIzk2evrTpVyPDgoUUCkoSDlc7nhNKK+eG4mE
 5O6HbgDC47N5+mWWGrgakDB/MRb1quK4UKk9nRXoJq+kqgbany0ZFKoroyQ==
X-Received: by 2002:a05:600c:4e91:b0:477:641a:1402 with SMTP id
 5b1f17b1804b1-47a8f8ab745mr153358985e9.4.1765896117030; 
 Tue, 16 Dec 2025 06:41:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCHHUOLaChiULrMNPkPpFyOPs7hl3Y2G80tSl6Je//NwD5E5/AOJ5UHYUTERMFN0KxTwrq0A==
X-Received: by 2002:a05:600c:4e91:b0:477:641a:1402 with SMTP id
 5b1f17b1804b1-47a8f8ab745mr153358715e9.4.1765896116595; 
 Tue, 16 Dec 2025 06:41:56 -0800 (PST)
Received: from air.bos2.lab (IGLD-80-230-108-89.inter.net.il. [80.230.108.89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fbc6e3392sm24205212f8f.13.2025.12.16.06.41.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Dec 2025 06:41:56 -0800 (PST)
From: Vitaly Grinberg <vgrinber@redhat.com>
To: grzegorz.nitka@intel.com
Cc: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 arkadiusz.kubalewski@intel.com, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pmenzel@molgen.mpg.de, przemyslaw.kitszel@intel.com
Date: Tue, 16 Dec 2025 16:41:54 +0200
Message-ID: <20251216144154.15172-1-vgrinber@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20251120105208.2291441-1-grzegorz.nitka@intel.com>
References: <20251120105208.2291441-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hRN4-yXGmYHeKqfLCqJFp32Y36iAiGlrT5crJqq0i6M_1765896117
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Tue, 16 Dec 2025 16:34:20 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1765896119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
 b=Teu32sk0MC6l55r7acwWearoJWi/CdrAjdBID488Dv88oZZQY92pOrYhZsIJGz8u+6JcCg
 hO/9rNg9vQT+rcAioX9wT/cEHkQUapshUUOptLmw6GLzQEoT07t+P6Q9rQOzolwV36nI0N
 omX9XJzyc+Ui62kx+oyfznIDGbLNTxM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Teu32sk0
Subject: Re: [Intel-wired-lan] [PATCH v5 iwl-next] ice: add support for
 unmanaged DPLL on E830 NIC
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

Will a notification be provided when the lock is re-acquired?

Another concern is the absence of periodical pin notifications. With the E810, users received the active pin notifications every 1 second. However, the unmanaged DPLL appears to lack this functionality. User implementations currently rely on these periodical notifications to derive the overall clock state, metrics and events from the phase offset. It seems that unmanaged DPLL users will be forced to support two distinct types of DPLLs: one that sends periodical pin notifications and one that does not. Crucially, this difference does not appear to be reflected in the device capabilities, meaning users cannot know in advance whether to expect these notifications.

