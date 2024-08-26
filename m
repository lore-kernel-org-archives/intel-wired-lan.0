Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F189C5321D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Aug 2024 09:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 48EE940111;
	Mon, 26 Aug 2024 09:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UeYGh8HOq6Vk; Mon, 26 Aug 2024 09:41:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80CB94056A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1724665290;
	bh=F/yl4cDXA4JumAEECmUq9Berw73DpEmSmXfJ3tVlu2w=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=HZxwzk4adVwXxkySA6ND8gOL2YYK7Uwrd4+EGzCgtkx/I21KPBuWsPCJrURhDnuK+
	 5EkZ8aiulmZVF3vTf+NlJC6jRQ1ziOjcv7RNMexnVA+OOvZUqGvbJhGEq3ioDhwkvc
	 GQy9E5N4o3tArz7cli3D+VXQuiIOJJmuMK9Xk89UsCNd7P5MKA4XAqc09/czi3mjw5
	 RRx+d5z4KABdQMLFMP7F+rkQBzYeyRgV3wVh3VGMfStUqwRrqaXAPA7petNnRwsx54
	 pZU/HEmbEc93vRCw7+XKvmdtbyg3Z5LhZyft4pX5U9mMhGT53b/gy1GexZCky2UilL
	 bQCZC9Ht6znwQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 80CB94056A;
	Mon, 26 Aug 2024 09:41:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 96C3F1BF2BE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Aug 2024 09:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 91B2B80D18
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Aug 2024 09:41:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0GESKKi5N1xJ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Aug 2024 09:41:28 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 24AEA80D0E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24AEA80D0E
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24AEA80D0E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Aug 2024 09:41:23 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so33708315e9.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Aug 2024 02:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724665281; x=1725270081;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/yl4cDXA4JumAEECmUq9Berw73DpEmSmXfJ3tVlu2w=;
 b=B+eS+4vat+FJE1187Tb7uu4rRgIRVXX/d83we+HogUpJszH10AQuRjXwjCq+Y7PUhq
 Fi4uZPq0ojZTkFgkR+a0R5PSr7iO49UNPpU5nhV/ArK2mzzpJjghx8vN4ytGbZcx2bc+
 Lyptf8bSEY4cfNkWxfcwPCazw38nSxqsghGuNXLuDcKVPj2GUiFjvFItfLsbhFW/ugkB
 PGKH23ZRKxE1HhjmRLw4ls5MGI17ii1W1H68cNmELHYuUKqm93J2YARMsk/0Clcyme42
 2Q+jfymMjLtGH09fgtHKhypcsY94QdX15koRLl5ee9qLpllysvt3+p6Whg+rbO0Kc0sS
 BOqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWagxFpGfH4djRr+3b9mtKVKpqdjV+P+S1ymCAg+cJIVZsr3YOWmDv01S48GtqZPT9RMd6v0mKZ9b17vc2aAp0=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxWb/L+o7mxxYm6H8v5rafzoxN7KI7tmudMO2dNTf/Pqv/uMB/P
 tK5TnPh33IuScKZDiNwsN+2ESzlSEIvcbOaF4ZfS/jTY7nImGGCAqT9jDUoVf5o=
X-Google-Smtp-Source: AGHT+IH2yCKZy4Z6frapl1ipVektXUVQIweouWgx90ThJuXoGKGjBkZtW9Gs6rZt18EuPg0v+LSAlQ==
X-Received: by 2002:adf:f451:0:b0:371:8748:cb19 with SMTP id
 ffacd0b85a97d-373118ee926mr5948602f8f.56.1724665281212; 
 Mon, 26 Aug 2024 02:41:21 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373082697f8sm10264617f8f.110.2024.08.26.02.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 02:41:20 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:41:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Message-ID: <ZsxNv6jN5hld7jYl@nanopsycho.orion>
References: <20240826085830.28136-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826085830.28136-1-tbogendoerfer@suse.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724665281; x=1725270081;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F/yl4cDXA4JumAEECmUq9Berw73DpEmSmXfJ3tVlu2w=;
 b=sLfRE91XCiHeU/OOJ37PgfZTyIX8X+5pSawpl5vIT2Gh+KmzFkyptt0ayu7HoDZr/w
 n1hlCtK86u664QE/l5MXfDi6IRJsvEdjIcC7fs20QjYNvP3lxA+cXczy2zqMc/QdbuVq
 vueTUK3f8VAfiZABv/14oDgZecPpIgUNXJf7tpLEIlROw3vggVhgjyKPDlHNqr2t+msn
 cuCjBBdoNWenebzyyB4bhcOM6tHfd4kYfN+sellAStR18Ysta5ysX8NG7j55rrKiqJHZ
 Mva7aR5Za1Dn3DvK+S99eExScdIpRQXFuFuqOp2TbB2qer60JZ4JIe2bfLoa50t1g37t
 jGuw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=resnulli-us.20230601.gappssmtp.com
 header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=sLfRE91X
Subject: Re: [Intel-wired-lan] [PATCH net] ice: Fix NULL pointer access,
 if PF doesn't support SRIOV_LAG
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Mon, Aug 26, 2024 at 10:58:30AM CEST, tbogendoerfer@suse.de wrote:
>For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
>allocated. So before accessing pf->lag a NULL pointer check is needed.
>
>Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

You need to add a "fixes" tag blaming the commit that introduced the
bug.


>---
> drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
>index 1ccb572ce285..916a16a379a8 100644
>--- a/drivers/net/ethernet/intel/ice/ice_lag.c
>+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
>@@ -704,7 +704,7 @@ void ice_lag_move_new_vf_nodes(struct ice_vf *vf)
> 	lag = pf->lag;
> 
> 	mutex_lock(&pf->lag_mutex);
>-	if (!lag->bonded)
>+	if (!lag || !lag->bonded)
> 		goto new_vf_unlock;
> 
> 	pri_port = pf->hw.port_info->lport;
>-- 
>2.35.3
>
>
