Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA3606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MQUwlclT;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GeQZcQ4l
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B11780A54;
	Mon, 16 Nov 2026 08:23:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pp5Vs3QHEbLk; Mon, 16 Nov 2026 08:23:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E7F280A91
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794817392;
	b=OM8KIKL7D3KoQN8M1VcDeC09OgsfW18W8gacHzvz+FgpdNUhhhWKKJZbiunMsf71ngVa
	 nKsBbjRTlkBV0MUVVW3aS8vIAtyh6sHboEOpnWvdbnzhihUd+CPgwL0srwA1DV/p1cOTe
	 nUuK077MFppTXVtwReZ6bWYShmXYUFCjcZURRtzpvCI/EcrvS1fS/uxSgkalSgoDLJhI1
	 1tBudNjVjaA78vKzea6yN2ojzqhp3+4uvXc1SoMPNOf5q18VEN2JIbqmSu1Opy0kVnN7T
	 f3jKLcTZnsIwgpKSuFWo89UQkyr+FlT0rGg1tcOew3+6uV75LTpKBeoJuNtiMYipjUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794817392;
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
	bh=eRLAUvIEWrETBMDYOWYYXgV19ey9LCVHccz+7GsLjNc=;
	b=IVzzQN2kJkcD8n9RDTlfX7aQaqp2NQBGtkGQ0aExvloZpbz/TuJKXpn3+Uj+AqoQ0ON5
	 1Dc65d+qg0Ea/eo8HJuNTQi4t+zQC6ZSrvc89RYiZweZfE2XMgbZRgZIMwGSfAMLVMeOS
	 tl2z0H3DOSsT9+bYvWUN/AtU+wbHv4H1zTj99B9woqJkURzsQpZLMsZEDs1ulq5So/2Qj
	 NSd/W8cGuswKPkmgk6BohY0mqjD1Vh+mUGE5Xsps4tZpKL+AfF+l7FoedLeU8b5yO61Hd
	 Xijd9EwSXf2fcIFFvyB+4mFYBVNCMyEa1J2nfo1/TtQuSO5EulzimwzfCjHvlRNUgVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GeQZcQ4l;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794817392;
	bh=eRLAUvIEWrETBMDYOWYYXgV19ey9LCVHccz+7GsLjNc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MQUwlclTplU8Wi7shI1zbwDs6i5s19MB3cN91saAcErVkNJrslp6kFn4//W4GQmov
	 n6UejWKeBNtw3gRO9Kc1KWmGaUndWkKeHotfneeUwvc0ivtLPIMlGhfpLKNtGDzyEC
	 uas1pre+gi3NicaRmIEr4d7SNrzrxBS9qaGBwSjaaD9eMHPMiVdlsdo2SlocC2Iv/a
	 LIWTK+YM3qMEm9icAHkKxCQf3u74sgyBdO8ekZLjGqtFVYFfzDYG9K/gaF+4XNLQya
	 T76uu51hoYPeTnPT8sIyPTcgjbYisHOJcXYweVtnonDSazypulL0hQ0pllrOuvTWGa
	 5AH3d2tfm/yNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E7F280A91;
	Mon, 16 Nov 2026 08:23:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D04F105
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F0B480A54
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5X8yl2twtN3x for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 08:23:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18BE380935
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GeQZcQ4l
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18BE380935
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794817388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eRLAUvIEWrETBMDYOWYYXgV19ey9LCVHccz+7GsLjNc=;
 b=GeQZcQ4lpGzyNdQQh0+8yTcWsBqO/RCFchG2yC8Syip++C+2x9wkdLGcyyFCM5Gd3v7SqO
 MXt/Iwm7xtEh66PRqKpGWtsyV48cMa4+aQI8JQ3tLko8vpNnEWdoLsJbal87JCQabUBO3W
 fLysc0+fat9DpXcwG3x6kJNYHZFld9Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-8PejBK4ZNU6mTRnG3rbrgw-1; Mon,
 16 Nov 2026 03:23:04 -0500
X-MC-Unique: 8PejBK4ZNU6mTRnG3rbrgw-1
X-Mimecast-MFC-AGG-ID: 8PejBK4ZNU6mTRnG3rbrgw_1794817382
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DBCF180054C; Mon, 16 Nov 2026 08:23:01 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B0241955E7D; Mon, 16 Nov 2026 08:22:54 +0000 (UTC)
Message-ID: <d4b5ad98-7c50-4705-96ba-604c720b794f@redhat.com>
Date: Mon, 16 Nov 2026 09:22:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/9] ice: dpll: update locking comments
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
 <20261111164021.273409-9-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-9-ivecera@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: WQWmRpPsNY7sIVbwld_N6rqmhyi8_tGfpmOFRLZrC9s_1794817382
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

Sashiko reviewed v2 only on its dashboard [1], with a low severity
finding, so I am answering it here.

[1] 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111164021.273409-1-ivecera%40redhat.com

 > Is "use three different clock_ids" always true on E825?
[...]
 > The conclusion that only @lock serializes everything still holds, since
 > fewer domains only add serialization. Could the text say "up to three
 > different clock_ids" or "may use different clock_ids" instead?

Right, it is up to three. Only the PF that owns the source timer has the
TSPLL DPLL, and without a valid permanent MAC the TXC DPLL uses
pf->dplls.clock_id as well. The conclusion holds, as you say. I will
change it to "can use different clock_ids" in a respin or a follow-up.

Thanks,
Ivan

