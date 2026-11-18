Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF96606A337
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YCDDSWaH;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=byhEssXT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21A2B405AB;
	Wed, 18 Nov 2026 11:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mGGu34XPgFXK; Wed, 18 Nov 2026 11:59:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4ACCA40643
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795003179;
	b=WsTaaZa+4965QDVqYw5kE7ZWiTrmjtb3dHif3AZ3e63hIsdAldDxy5K5e5/g6cZRISg4
	 f7ERakZy4pVWn9TS3mFrHzHp5w7ALrb7ZbzFOq+3lLFCxXbJW3OzOaDHhuDwARRkX/Irn
	 5DLeFwuFAsGhGMlCgIu2Q7g8sAcAMpp7TyMZ7g0530eOJb6CMLFdpnYE4b9jb9fZrszyU
	 o2tAu9iN3M0+d8ER7XXmfaRM/jB9gh8inaREyiTzdaNUb659mCMrfFeL8/50lGXi2T0IZ
	 bscGC2JAm1glLgWtGLskHQpylRn/rdwQlTAp0AdI/ByTyscdvIopUmk/Qhw0BSyuapQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795003179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2dDyleRAjZnoOMRs+CNNW7qYSeHY98cpTcJ7uqL70PY=;
	b=H96OMrKHDGdyN4S0EHx/dr+Dick71bidCSVoZVx0XHGmlW5zjNOxCJ5btRAf4cGLufz6
	 ttzS71LVUDkkHIaGyLAqirSegW8AJA9t9fA3ZaFT4/A8q7NsZy+wMVPCgGjlIc1FsVc/p
	 3r2uGd1lSSkEmfBuspzEd98o8q3eqB6IEdGEhszGK6DcCKYL2A2MKy+TEKWXl3VW+V/UE
	 9icrh1+xJNo7PI+mKjOlzhFkrdyQv/3WGBIaASmqq1AFOHC6IwKojCVo+90K8SsC3LUSq
	 i3BxK5HuCvE4qvSdwZ9HyXyVRnc4qirjQ3AXhrfkyGqcsCKgxSABhvcfrWpAgjk1MAw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795003179;
	bh=2dDyleRAjZnoOMRs+CNNW7qYSeHY98cpTcJ7uqL70PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YCDDSWaHQSg3TFIKcdzZdtiVqqjcYzwwOZ/6zMs9qHz5Ou2BdyCGHDjPywQp5WeLK
	 FACy8nNtwYlgi4CxwqMgaGpztA8nNROR2ynuOw08pj8ntHxmWwTaAoFiT9oMux7UiC
	 wrNOjJ5RNG5G0Z/GG64O70DfN9IM37YZ2esPWUH0bNKOJswx3b5CnWvPQEZB6U5aJu
	 xlW4PJzlqNeOqJ67IUzGLDcTDTKjK5CUQ/WLE+RVtxsAoAUitPtq9p9c7GH9NDVllW
	 1yHwg5xlViUis2f1Z0xzojYFrFX4/saQmdumt6q7Wx2bcqST/UW5sFCPUP6hBXumHx
	 j2EyuQ+lnl27Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4ACCA40643;
	Wed, 18 Nov 2026 11:59:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 800B19F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 11:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71E3B403D5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 11:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3R30nPGSuxJ2 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 11:59:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E95FD40060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=byhEssXT
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E95FD40060
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 11:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795003177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dDyleRAjZnoOMRs+CNNW7qYSeHY98cpTcJ7uqL70PY=;
 b=byhEssXTjo4IfaJ30x8u8X35scsPlKqnvOuLNH+q5mn80GYxn8MkbFnCHW31HgfYBNG1MX
 bCy6dGMHy/Cs93xw4W+NFggYk+0g9uR91WJf9WoUaqjxmk0W9OBWt6F92bUEzG7ihXxgcn
 h0KhTNP3CM5cSXcAOAgYe5JoTUuV19I=
X-MC-Rep: binary re single
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-A9drWmzQOaWLx45IHVKftw-1; Wed,
 18 Nov 2026 11:59:30 +0000
X-MC-Unique: A9drWmzQOaWLx45IHVKftw-1
X-Mimecast-MFC-AGG-ID: A9drWmzQOaWLx45IHVKftw_1795003168
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4EA31956057; Wed, 18 Nov 2026 11:59:27 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 48C26195B3C2; Wed, 18 Nov 2026 11:59:22 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 horms@kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
Date: Wed, 18 Nov 2026 12:59:13 +0100
Message-ID: <20261118115915.116177-1-poros@redhat.com>
In-Reply-To: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: szJrJ91ZP9TvR0XVdQLvYh4EcqcMcNjWBxUQ77kKpdo_1795003168
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I think this pull is a good moment to ask how fixes for Intel drivers
should flow, because it is not the first time a fix spent months on
intel-wired-lan and then hit a wall on net.

My patches 2/6 and 3/6 have been on intel-wired-lan since June, v4 on
July 8 [1]. They were reviewed and tested by Intel validation there,
and four months later Sashiko found real problems in them on this
pull. I have a v5 and will send it once it is tested.

Jake's E82x timestamp fixes went through three pulls before a part of
them was applied [2], and Maciej described the same loop on the i40e
pull in September [3].

I know Intel patches go through iwl and are not applied to net
directly [4]. But for fixes it means that the review which decides
happens on netdev months after the iwl review and validation, and every
respin goes through both again. And if iwl stops cross-posting to
netdev, as Jakub suggested [5], Sashiko will see Intel fixes only in
the pull.

So does the iwl round still make sense for fixes? Would it be better to
send fixes straight to net with iwl in Cc, and have Tony's ack and the
Tested-by from Intel validation on netdev?

[1] https://lore.kernel.org/all/20260708125755.706263-1-poros@redhat.com/
[2] https://lore.kernel.org/all/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com/
[3] https://lore.kernel.org/all/are4rBUJO3mzrkO8@boxer/
[4] https://lore.kernel.org/all/20260721174642.7749143e@kernel.org/
[5] https://lore.kernel.org/all/20260922112216.41e6f8cf@kernel.org/

Regards,
Petr

