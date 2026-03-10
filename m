Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0160DEB1075
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF97640CD1;
	Tue, 10 Mar 2026 15:28:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 96pjDiD0KcXX; Tue, 10 Mar 2026 15:28:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4869B4040B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156502;
	bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BmVi0xACIC8+RsrVynyA0UribhKBroz2lV6F2GFq3y6fO0CYBwH2IVyy9ueTnAavh
	 m+vPwjATEP7VpkxXN5QBOsqo/zQ/zaWD/kHuakvS+IsNJN9KZ6xOKALqziM5z62+2j
	 E1KpXKlHkKAdguQqItae+drCV2H3qz8NRmRQaNTLxMpNLeaodE8+E7ksZOVyQ1Q1BZ
	 owSIqLaqSW/kw+09oIkEyuktBta1Wg30Bifm5jYBEChsv3UTCfW0ugrDoEC881czQN
	 Csz16nDIB9sluQKHEj7AW2mvS4TTfAzssNdlfOmrDpPC90dHwc/JWDqv/G8bJ8iSRa
	 D8i3HVBPtFVAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4869B4040B;
	Tue, 10 Mar 2026 15:28:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EADDB8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 13:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1461E40679
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 13:22:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6VzaqE0jZKyg for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 13:22:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AE96040676
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE96040676
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE96040676
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 13:22:08 +0000 (UTC)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-vUbXUQ7yOoupTP29pl8W8A-1; Tue, 10 Mar 2026 09:22:05 -0400
X-MC-Unique: vUbXUQ7yOoupTP29pl8W8A-1
X-Mimecast-MFC-AGG-ID: vUbXUQ7yOoupTP29pl8W8A_1773148925
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd81506677so1375229185a.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 06:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773148925; x=1773753725;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
 b=TEU1gZbFpE4jO03hR3HLNFIaQkyaJSD1oiUiuMzhtxq6CRJK5JvMkBpZ+lIgN8dviX
 ch/r1ciD0bvMcWwy14L5jVoE20VgSuAq/VQYY+W/CpliTEq9kQol3wdUuwrHdThMpf6J
 FaS3NDQCTshLcC5g5FYY7oyXYiSAkkwZjc1JY7+ntS/gOPfrysBJqY4Xz6+i39Io7ibu
 mAzk1OVng3FSeQwDBwZFEHhRH2SG0aLAytQ7Hrc/OGF65grbiTh+V3A3wxhSHkSvAgpe
 +yG7vGTwQG+pGwzXVgJ7BCIex9sfvdNU9lGz8Rn0DUIlDrLUx2r+xzIMHlj8gSTIbmIh
 cmgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC+trRCLQjGEuA/UPNvZTvn9mnkxi/jDJWGO3nSqrNYgyLO7NzQ2Qj3EOEVmJaknjANB57ziq5ueX6FnI6GqQ=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyrzImsKEds3EYG0k7iKsGoQxhzo6jnVu3UCiJ53K79NHjsttUq
 TUM/MeIgNXS8vQZ22QG7+3moLmIDZlWjmqdYvtUw7gKk/mME8wS3j0LwACASkF/+cqMkibDNThe
 5xt4EW640/ANlMURZ5D/cGaGeSEg3cG4OPtgNUmoaZCI2MRo50RgFUfAFmAlsCiXROT0ca0Q=
X-Gm-Gg: ATEYQzx6CvqrcJT49T0ADfoXXiKcBgw1XMjb1aWOMAWQFkdWhThlqdhGxj4WRzdlXaN
 UpcIcEh9nl4Lbu+gc8U+xbRZM3uWyjc4+cBP+27lgNtv4iRcAilZ5xDSxwuKRgAr/la2qjNkS0u
 u96Y55IbR75aLkC0Oeiw70vNgnSJH8I9nqlwwRm1UOBjMM7iPXzg4oQ/4ng3xSaSy8SOsp8xofy
 7mNlme6Bd3JEbpFoR3ygipDKvSWAalABafXlAjKLQAAGF5UXbyXQ5GK1hXsCcves/n9lR/UzRxl
 E9jFYHitGyjKuChqdtMYjE100xXLJ38q1WVxxQW5W9t+VqXOybHbiDnixglOlbrtZ/HF60xtVU2
 Uup//JSpCGA/ssRhZwNvvYQ8ysX1dRdCqsg7HKywgbGjsKUaUAQplU9/i
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id
 af79cd13be357-8cd6d4f9469mr1830789685a.45.1773148924775; 
 Tue, 10 Mar 2026 06:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id
 af79cd13be357-8cd6d4f9469mr1830766185a.45.1773148922638; 
 Tue, 10 Mar 2026 06:22:02 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net.
 [73.183.52.120]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm474754485a.47.2026.03.10.06.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 06:22:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:21:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
Message-ID: <abAa9vQg4BSxl1BJ@redhat.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
MIME-Version: 1.0
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fvnqDctnCjue5o9079SNZWXZnKLT3O9YYJUdsNggcvk_1773148925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:28:18 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1773148926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
 b=ADQQpd+bpcMvyiI6BuK6I/AtlFPVjRaT1jbvm8x0bcg2sn4Mv+l/q+wGsOaa7zGZavpvJL
 HOw6n0NTrJxN8BVrJlzy+3Oyq/AicE10gafpjzfnHFVMImjvlOy3qRSEO7jpexZVWETsUQ
 RoRPrXnJkd5ZbUZ0X+x9wM3CIJYSD9c=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ADQQpd+b
Subject: Re: [Intel-wired-lan] [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over
 manual NULL check
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

On Tue, Mar 10, 2026 at 12:49:22PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,

Semantic ...

> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

With the minor typo addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

