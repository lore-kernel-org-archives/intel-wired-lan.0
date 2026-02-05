Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C188EA7950
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 02:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD70760E17;
	Thu,  5 Feb 2026 02:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QmQ0WB0s3VAd; Thu,  5 Feb 2026 02:35:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E84DF60DE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770258913;
	bh=u0GBB6+Hj7CpJN+vOTxjQeBme661T2E1y0ZZW4Sej8w=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LWhqObCIyXLthwn0Zj9ovF1MqS4S5LNY4BBelZnH8esTUlDoKRTDZBT21zIgFrm4l
	 IFGGaXyyJwaVSYb9XeTgyzpD8W/IR6A4NFvpWwBdI1QXMx9zLt6qCLPIVUte25WV61
	 v6jEXsnKUg4MBcJYAxIYY/zB0UZPS1crqyJ5u8jWfScb0euTRE3bexyptY1eju/vTt
	 0kUkJgyqXe5ANriiIO76fPrR13SHHO5r6SwblX5cEVh/60HxrhMLuVxbuWLfBs+Wot
	 hW7Y++9T7HXk/JGngvIWxDDIaoog5AeoJbOGXpEj2H4jUfa2t17zY8Z0BZMkPl8YTV
	 bteNsbfreq5EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E84DF60DE0;
	Thu,  5 Feb 2026 02:35:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1624617A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 02:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E95E782051
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 02:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id anab88FFfa6o for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 02:35:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=kmta1236@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2C9F282016
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C9F282016
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C9F282016
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 02:35:09 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3543b9f60e3so139728a91.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 04 Feb 2026 18:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770258909; x=1770863709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u0GBB6+Hj7CpJN+vOTxjQeBme661T2E1y0ZZW4Sej8w=;
 b=f4F8/kGIgPzvKNvBYCRr9n4xYhcN9HbXRuHBiDk8S0vAq9fF6Up7ChPvM3V1OQYUgN
 dgMuBi8v2jcrpMj/qyg025Z9oxPNat2Qz4H0f7uho7PRTV4qJj7ErTo49NleAtJAYRkf
 Nl9rWJylch7HNBqqHQ9E2uPbmzC4o0G+yMVFqQdXUOXoSbPF2ri9BIPbMzPxH7BQWJrl
 8H2Rz2uAW74AihOvnbn9sWHgH7hhvs58n3qBq/WxRApGRX0Ab5umtykL4Fn7Q2kcLDOS
 7jAomyuCPedFIJCcHUhr1nsGnY7q9J5mMI2rqo2Gf5yb1xwSaD4dok77dNPKRU8vPx6F
 AcUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Lso6B70BywlPnUxD3GoGIEMsjuHc8ATA3dXG7OrzclQ+9GeW5+WvCIDopR70Pa9DtXgKGk/ix+GQ/yk3z2Y=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzS9mkgqkp0yb+APTc6H7EbDLdqVAqviskbj3x2UO6mg07qqKpK
 cpZoAqE/o6QcpwFmT5S5iAix6WK0fDGsyD6j/CO6ZnN0qZFSJ4k99JSN
X-Gm-Gg: AZuq6aIE4RItHOa+QHZ9BFMEDlJzXEomfCobWOrWxPs5Zfgpu4EPCR8QDjA0K5E78Qn
 JvLqPpOW6McFmZU3IRFPmz0Bm6n3oTM0beie9J0cXrlm65Wms1qXKUyZ9fcXu2GUfp6s7EUcgTo
 9eHFVv26Dijw2TnBp+XYHPzQZtuVJ1KMFi/Seb8b0hXU7UuV1Au4qbH7s1QbFaIai6qIApOgbiQ
 nZVhXM7vU6kgre6hZYKUWnx7HaZmYPMXBNXidcb79l6r8H6MaDGD7iplUxNz51N8hdiBcyeEcYR
 nqSWirDnGd9Sgs9I8vxHXj9qq8BLbdi9ORPh3ALO0UGFlqAwjvfeNzXvGgFRQ9JLvFBm4S0q7hx
 iX/zEUaF5Z9adZVr9ISLu83zIvZu1EEs17SV6O1k7dFv/KLz3jzZzYwqt5GIsWFniXS6AkN8ik9
 wZD88qNu4W8HQeWraMPBuOnldAky0XDLPpvFlcJFwnec93G5Ehum82ekIogAwdnyozWHvheHU/
X-Received: by 2002:a17:90b:1b41:b0:34a:a1dd:1f2a with SMTP id
 98e67ed59e1d1-354871a9551mr4399957a91.20.1770258909166; 
 Wed, 04 Feb 2026 18:35:09 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3549c28204esm712679a91.10.2026.02.04.18.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 18:35:08 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: aleksandr.loktionov@intel.com
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 kmta1236@gmail.com, netdev@vger.kernel.org, przemyslaw.kitszel@intel.com
Date: Thu,  5 Feb 2026 11:34:36 +0900
Message-Id: <20260205023436.208694-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <IA3PR11MB8986EB459D2FD1697644CF98E598A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986EB459D2FD1697644CF98E598A@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770258909; x=1770863709; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0GBB6+Hj7CpJN+vOTxjQeBme661T2E1y0ZZW4Sej8w=;
 b=BUXqBZrcSBwFjZkk2GtJsgFVZwLvi1V/6lzS6CXv7/TwMe9ca/qg+x6+RBJgItQZK1
 uRzVUuSVrY1RPWjdW3vvICW0a/3VMQWk6FvTxFXvYBbsTNI9+u10jzsCEqCWLRDjSIRS
 PZL6QXEh+ZiO9TBb1+cbvK6TqC1fKs+5lZHETHTHQyoeOSRMEg6MPMAxVfwdTXYf06sZ
 jxDKdBBJpU/fKDqa8bOLxKzQb334cWej/nqbb/vDALBdqGgej03lK/cM5bI0kbk/dUFn
 OCM3zYiFio39b8YMKsh8O1kOX3+10Iw3CPLububd2a4RSI28cMNZ5UfvXzOHVvjYsc29
 uINA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=BUXqBZrc
Subject: Re: [Intel-wired-lan] [PATCH] ice: fix race condition in TX
 timestamp ring cleanup
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

> Please use proper bitops for concurrent flag updates (e.g., clear_bit()),
> or show that tx_ring->flags is not modified concurrently.
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thank you for the review. Will update the patch.
