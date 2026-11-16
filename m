Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E74606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Ujr6PgIq;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fQZ84ft1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA46180E4B;
	Mon, 16 Nov 2026 08:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWYBUDjZHu9S; Mon, 16 Nov 2026 08:22:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 149E680E51
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794817339;
	b=enALIJ/V/p5wRgLlbAVu2WGzB+oUTx8Px/hJgwh55K2hDsWs8EvfHDhnzSWNQhUlLd8O
	 Qy+kGEBEuNp5jFq47Ns5Kjkbx2ipuC6A9WLl2K8AcBm2N/XburT+PG26nY5r34n7ek7Ai
	 FViAGCte3vjHIVeyAEc0EuQwHvQDuJIOmF9kaKOyovuMChUFcGGAVM99wweKANiad3v0j
	 jJydh+JcRVJW0phiK3GxL0VQzvwRD5N6rni5inTWwV1swwMjY9l8rp17IjIS1eARhWZPs
	 yDR6YYMInv/FDgqGk178jdDhGuFkLxLSUIR1RgFkyH0NWVoY6M7gk6NQ3mI7Es3aLMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794817339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 References:In-Reply-To:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Language:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gfIacyhfnvssNjldJA8LhzYaZPtCvyfmo//br/NPqo0=;
	b=b70TYtu2IdPg1dZDfTd6B5IXVRFbmh/HMp0YxlyjPCvWVosvsY8jiva6af2yXYfzAMb6
	 tXMPKhFxLKywnmsbWebY7l1xjPcKQVELGbyalsNicyuOHfoycX8uaEKoO68kngXGHdpd2
	 2qPFn0g7VOFWVHF+DotssTcdi3qENC4AHIvvD/Nta8xvk3m42TJf/u1f8gnzYsSh9W0fz
	 2L3/bM8V71+j5mOTGnAKlJTIrL0DZ2gDvN8k2HlsfSwnc9D7dvnrI4oBcm2YMuSRtWMVT
	 Xl3N2lZpUdrCZqGW2i2arOjcKg9aSANDlBXgRulKqpcCRlRx3eH13/lmFEKY2BdMasw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fQZ84ft1;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794817339;
	bh=gfIacyhfnvssNjldJA8LhzYaZPtCvyfmo//br/NPqo0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ujr6PgIq3Guodm/nYlZ+c93++2uq3AN9zwXSuANNaN9RgpbAgEgtVeBRjbbSsvwp/
	 t3KOlNtl84zaVWGz4mHB9id7pbSWP9AZ95Zs/APdiIPloGZBnqnrjQqcEsr+50BDZl
	 I4xOSNOfmr/A9Ml8YrnJqLojC23jfznBUiB9iCbe0uDn+zG4jl2MiXxS0ZwNY82Btb
	 SzpWPYk7tZeoUUN1FALoSytet5OES6vuwwgNQ3y3+xHmfOQyQ2bP7QD9iFE+xcKpKW
	 8mAY8V8li1pEAGzkbgK5z4Sv8Z8ChB06/yXtd6Ws4erU+OKG5z7TlUONEhXJa94EqM
	 JYkj1roYSLmQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 149E680E51;
	Mon, 16 Nov 2026 08:22:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9194D1A6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F1E280E55
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:22:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cb3CqqvW1LxA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 08:22:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 416EC80E4B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fQZ84ft1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 416EC80E4B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794817332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gfIacyhfnvssNjldJA8LhzYaZPtCvyfmo//br/NPqo0=;
 b=fQZ84ft1LYqoWqfxV+VJnUzlMoH/x2ceAHB77s6q1s/wgcbFLm/SFxaJrpZaGhSwRpGTcl
 7WxQprHNN7F9S9tyB7gd6O2qvhyusnjGJsAjtcsjSH7eP/tWFb+1X/VcwBjS8H71YS8YQI
 +kF8MbgI9v9FolVEnehadCFlOMNzp9o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-YeG4u82aP8Of6FAvye7dWw-1; Mon,
 16 Nov 2026 03:22:09 -0500
X-MC-Unique: YeG4u82aP8Of6FAvye7dWw-1
X-Mimecast-MFC-AGG-ID: YeG4u82aP8Of6FAvye7dWw_1794817326
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8B61180036E; Mon, 16 Nov 2026 08:22:05 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9625C1956088; Mon, 16 Nov 2026 08:21:58 +0000 (UTC)
Message-ID: <2770a801-e889-4181-84ef-d1846d6c9e15@redhat.com>
Date: Mon, 16 Nov 2026 09:21:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/9] dpll: convert dpll_lock to rwsem
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <20261111164021.273409-5-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-5-ivecera@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: J_rfYqV_5vLbTXf2Q5Kj_Se6PQYWGykxGjbUf6Kob8s_1794817326
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sashiko reviewed v2 only on its dashboard [1], with low severity
findings, so I am answering them here.

[1] 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111164021.273409-1-ivecera%40redhat.com

 > This isn't a bug, but zl3073x_dpll_input_pin_ref_sync_set() in
 > drivers/dpll/zl3073x/dpll.c still uses the old global serialization to
 > justify dropping zldpll->lock:
[...]
 > Could this comment be updated in this patch, along with the dpll_lock
 > reference in zl3073x_dpll_changes_check()? The later patch "dpll:
 > zl3073x: update locking comments" rewrites both. The stale comment only
 > exists between this patch and that one.

Right, both comments are stale between this patch and patch 7, which
rewrites them. The code is correct at every commit, because all channels
of a chip share one domain. The new comments hold from patch 3 on, so if
a respin is needed, I will move patch 7 before this one.

 > Pin requests now run with dpll_lock held for read and pin->domain->lock.
 > Take a fwnode pin registered on a DPLL from a different domain. Can that
 > DPLL's device callbacks now run without its own domain lock?
[...]
 > Would it be better to put that check in before this conversion, or in
 > the same patch, so this gap never exists?

Right, between this patch and patch 6 nothing rejects such a
registration. As you note, no in-tree driver registers a pin of another
domain with .measured_freq_get, so no commit of the series can hit it
with in-tree drivers. If a respin is needed, I will move the check of
patch 6 before this patch and keep its tests in the KUnit patch.

Thanks,
Ivan

