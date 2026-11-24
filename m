Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A932606A330
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=X/fordAe;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=dyfKhMnl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D738B80CDF;
	Tue, 24 Nov 2026 23:56:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A_Dqtk2EkaNr; Tue, 24 Nov 2026 23:56:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F330A80D02
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795564613;
	b=Q3nVYFB3Ut6dDcE14JnpBVtxyDkT5pGYXMbCRGLGy5ggdesTL1Yx5QzuYscfP9ATOkCe
	 IZA5TG0dSL79uWxPORVdEdj8F1CcCWTwWf+i6GHYTQRJkZy4WupSQ1JogKgO3XpMobIlf
	 ltdNxh6eI5l4Or4rkTPO+PCl1384f2HscZzkLNc+J+ERc4XehhMcPM7wGXczal36Yr2Js
	 3CSxSsUyfR4A8QFNloC7w6SCrG+A0e9m4ZrLJ1KjpE0iFCGne5m4i3kSYzqewxN6dgRo/
	 G4rt6+CkdRNvwr968NS4wWlgB/veLLaChtvDMnR6J5gmGDASFx5W6/7nWAmJyuwZvpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795564613;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Fz54SJ7qTGehb3UMp48cf/gfuNfCrF/Glse4fK+TDq4=;
	b=BBwcf0icXofZyXbq6MVPgewcAdfWnbuUGMy8OhaCxFWs3XoudBI1MwiWhan1udx9or0E
	 lBNSzGeOJoPpTxpst0zbw4sLxOebfhXFc8w9tjtCeuL4/iMZ+elF7qvLqKSFR730GTqkG
	 C+CljHZPRzRoVRmG2AIj/N42Kww3gecULWxofvqZqcagqUVWoWl7UAy8Ap/R8WdkkDUsU
	 X/zIuuWdmPpWGK3B65+RMnf8v7QG+jL4P0rQ7MLWwZCfcEbRev0FD2ws6L1CFtKpJ2L8n
	 QFZiemTlBnI+fTw1+j2o1u6/bh0ZaWb8HJD6tzrJdMHv8p39rxAde3cSR9Pu8TWEQMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795564613;
	bh=Fz54SJ7qTGehb3UMp48cf/gfuNfCrF/Glse4fK+TDq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X/fordAeR/NgMKJa5WxRuwnYbBhpY5vYGKi2bLYdnwah2kar+49cOo2zu70SWQTxD
	 jjQ92YrYUi32xam8jIuREdBYuhKD/JfbSujOdniKWX3sjK7z6FMfce0PF4EDHpiyEn
	 sykVtg2abURHHZetjkbbn1DKxBxysquxOYWyQY8SAt0ipBSiD7pt7l7vgRXbNwvt2K
	 3vgwVTFL1PIr5XmfXyCKIb7tq34HMllVRoD7qRVVxqI2eL7/z0Vpp4XS0V/htFuSAW
	 YoRjBbReHMBdGTLIFAdp5G/N5T1MYarIaRgqpzbfvXoo3DXDcyrVo0DnkeMN8dYJhO
	 wc9p/ntDj5hrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F330A80D02;
	Tue, 24 Nov 2026 23:56:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F34C2F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01E4B40072
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:56:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oFT_R9JrJmxZ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 23:56:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 953A740071
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=195.10.208.52
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.52;
 helo=mout-b-203.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=dyfKhMnl
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 953A740071
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:56:50 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jZ08Z5HxyzLmXR;
 Wed, 25 Nov 2026 00:56:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795564606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fz54SJ7qTGehb3UMp48cf/gfuNfCrF/Glse4fK+TDq4=;
 b=dyfKhMnl1ebbu15g20KDJk4eozwr11QnWM0LeNvIcuDD1o4AkY+BXVKr45lKeoWHGgo2db
 SStWtL3xsrPPsQHKpDaJIQVuBDsRZrbSwVQne9QA51d7xLemsNmyvrqj3UcRsjhRH0e+ym
 UvJJcxOsfzdlZLKoPIg2DCLW5yM3gmcHOHxvIZWaT/ICZ0ubwncW1t1tjQjtsJJ7CXbss3
 EcFJ6ZH7Iv+BmL+wQyXS+qBm057q9ZpKEFzdGhu/9A6+Q+XIiOXV+/DBCbKSaWxhxyLPbn
 kyvO1O/sstj6xD6JI5X4g46/8gyOzuq5X1bsMnzhnSgl/wsEG4woel5YwvBu8w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
Message-ID: <d678b277-6b66-4d97-8745-23cb0adeeccd@mandelbit.com>
Date: Wed, 25 Nov 2026 00:56:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/4] igb: link queues to NAPIs under RTNL after
 runtime resume
To: netdev-bot+sashiko@kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261120210134.133238-4-antonio@mandelbit.com>
 <179555632542.3135.3194340362837900458@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <179555632542.3135.3194340362837900458@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ08Z5HxyzLmXR
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 24/11/2026 22:38, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] igb_rtnl_resume_task() now calls igb_link_queue_napis(), which
>    reads adapter->num_q_vectors and dereferences adapter->q_vector[i]…
> 

Right, nothing cancelled the work item on suspend. v5 cancels it at the
start of __igb_shutdown(), before taking RTNL, so it only runs after
the resume that scheduled it allocated the q_vectors.

> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but igc has the
>    same bug.

yes, an igc fix is planned and will be sent separately once it has
been tested on igc hardware.

Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

