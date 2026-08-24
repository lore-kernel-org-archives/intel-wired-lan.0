Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2F9C5DF94
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 09:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D66B3405A7;
	Mon, 24 Aug 2026 09:18:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oF-QilExMfsS; Mon, 24 Aug 2026 09:18:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787563134;
	bh=4yPRMcPsx71HPb/WSobG7rjnIFEp+DLv4lz78CpE0J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YvjkipUq6u3E5UQqMX6Y7qU17lmNMl1Z5bM1TYDmVcGNyDkGkVcr7TxCSmyzwWz7B
	 zz6SDT0h4xNo1JHzl8j5nHNi31wOYH5vueLyBK/MWiDxyp2VUHT04hsLFIrA5KHnEs
	 cpSwLpZPLr7grpaNLyR3uTfsfcJvRyEAXZ9Ebw3QpkGG1QA+7wn1E7ENAsMVtwBcmT
	 EVkuN/GimjXCO9Uishl2sTzHz5i8NTO7P9PtwURBnp5mOA3/crFsFhDkqceU/rYI5E
	 bsTtr8odcbeFhJElbqwKtevmZaEcIzmcUXepxxFb3nF0AaILdzdPAxJ0i5vWKddPTc
	 59hKwe4e7Lp/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17B4C40557;
	Mon, 24 Aug 2026 09:18:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 29ACC279
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 09:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BC354005C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 09:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJc7Nc03EiFZ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 09:18:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=pavankumaryalagada@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WmQ2tke0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 74CC540052
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 09:18:52 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2689233a91.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787563132; x=1788167932; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4yPRMcPsx71HPb/WSobG7rjnIFEp+DLv4lz78CpE0J8=;
 b=WmQ2tke0WS/q8FDMV3UO0ll+bFR+Dos7Dx7oQRLvRo49hmDjb4GFhb+la1CWScQ/45
 3V8WURLqVK5ljw+5AsHXYR1UBlXj6cQ5gHa+GHuIjgOYMM8jQckbm8u32tPXXpGNAAbB
 DSwcGgPf3Mx424UTy3661gVkfP9iQLgpRSzrRF/QhWGRYPMJmRNkO7t9JlLmPLENFAsV
 TI+ySY8eTGetbUVPY6Qohs5xJQ6JZRpva55KI2CF6uYkrkR4l37e5ebpEPhSheckUMkw
 +DUCS7CuULktnZv/kFLpyAqOmUAm7b0m7H8quXWAS1ajyt0IjwO1K9F5eKwjjrQ9u24H
 hCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787563132; x=1788167932;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4yPRMcPsx71HPb/WSobG7rjnIFEp+DLv4lz78CpE0J8=;
 b=lfdbIN0M9ObrPHyDUiAUGdBc2RYQCg1aIl0ETl3wBtoghDb6ORaLq9uZe59jHZzL/n
 FLFPsV7t3HMut6vYmJQhinxgrOB9+QUWCUQQWqcmuMjbHq/mG7hDU8AvAlaswcR3Ze7F
 8ttjF/WUzzZ48LU1yvHkmnSRWbMtEHeN5jra8qNq3jaTfiyrX14S1E5i9qGbcwCCIAEL
 wkkgxnk4fwj4DZpVP2IERfNMz/UulMw0Ye6yWIaN2kpvYEO1FHZtWdYEh/15ExRdLIjU
 1LG6TyM2aBpWXmyXSdlGdq/vozhi8jv+v9XP0mh6Ni1RFg0WpC7fWz6Wr9RG6rb8j5vm
 xJQg==
X-Gm-Message-State: AFuF++mQepAZSjoXtvKJGMXC4zzwsYwmWFOFBVfQuKs1dAkdgEbtHQaM
 2iupePyHjL3zN65bNiagdQBNBed8wILZSdJT6WG0Chcv0CwbcTQw7Yyn
X-Gm-Gg: AR+sD12C30XIE+5CgJQiPCmKQGGlncGLLH4mrT15jNrYFHcv4OtBR0FFG80f97FNq9S
 eE7sEGkXIGGGXZ4vMpHcQvl2NulZqPuzmjvebJvuNUltNvNZkl0CrDHB478XgqZoK6RwWsRLoIb
 0OIy4Nu91OLm7L5uX6N+pybmCJXP+cwHuDEFcs6i7KWE8teskFBh/VwvhbKiZPvm4ARs4lKd9NC
 OEXqj98NWPOmYIwDP98NcrJlj7ducMYCz2kecsjor5nlCQr+2AAK1HPvp3GuiovXbXf+e+8kBTT
 evdDrEwVZj6tRFVe3mXmbX4OwKTZjo+z3n/YfQU1vHvkI6IHVFix5vIPSd+l/x+elXAqchqu1p0
 uL5XscGWwohEyNCZWGu9+7kahCWtLQ17i8TTPnfPpX8sQNlSB60hyCQYdIQLceXEpMNkzHenrq1
 i/ZGcpVTErE+hKJreSvwMQwaWIF54KqXWSujRS7Kk94t+zC0fUuHIbEmpjbMAwa6q08w==
X-Received: by 2002:a17:90b:268e:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-395c3a4f35fmr47590357a91.14.1787563131588; 
 Mon, 24 Aug 2026 02:18:51 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:4590:7268:2737:3d1e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d381csm27040421eec.19.2026.08.24.02.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 02:18:50 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:48:19 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com,
 kohei@enjuk.jp, aleksandr.loktionov@intel.com
Subject: Re: [PATCH iwl-next v4] e100: prevent shift-out-of-bounds in EEPROM
 access
Message-ID: <aowMW7qukxDgMhWc@user>
References: <20260820094045.41400-1-pavankumaryalagada@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820094045.41400-1-pavankumaryalagada@gmail.com>
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

Hi Tony,

I send this patch as single standalone patch with all the changes from the previous
versions and targeted it to iwl-next as requested.

Could you please take a look when you get a chance and let me know if any further
changes are needed?

Thanks,
Pavan
