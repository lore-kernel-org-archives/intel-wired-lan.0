Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AC9606A321
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=C26li4Au;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JzGO672f
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 132156089E;
	Wed, 25 Nov 2026 12:47:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vn70m8q4DF8Z; Wed, 25 Nov 2026 12:47:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48E0F60891
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795610840;
	b=KholL0Qx+wp9YJdqFxxHZAz3XgWElT+qqpmqttEI6rvwtHZUZ3Q8JlmjGVmgOZPdDbc/
	 bU4iKNWzV4zIdRfMFlsclg0cHum/pyTxcd9HqZBqTnnQdOZrQ4FdrP7VBZYSPUGj6gkJP
	 e03bzYZhGMqZ5wLT6lmRV3YMQynLjiwcK/nhc2XKWc178dNO0PZ14YJiqkpeHKWDWTg5r
	 oEkzZBglYQ7V8HDPX/WQUC6klTf9bV0zyiOsldkvMIIFkH9pNQYsj10nr6ZAr0Vo3pg5A
	 YhO3saRM03f0Og6B8doeiJLu0BqOVZbYojyJHRt/Pg0OS8yu+4iZrubo3AtKAWX1uOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795610840;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UOswtumIqV73ZgPCkcgKR3Mw8N0TWTgh9bOwnMdx/iw=;
	b=n3Pak3/mCDN2WMcSQi+OYUjsmLiT9OxjEsjzLKVem8jmIyV+BQF2YAywZgewHE/Dicw+
	 hi6LpCvphkfGgV8SNx8BXy/gz5DSbL3KQZ+g50ffkfylXTpfJOWfp12Iyupv1Eysy5N1p
	 Ie0+hPhNYxJ5fXn5ZO2VE/IaWfRTgRxzlYTimm9G9QpTZAZLLiaL4DfQjRg27ThiXg9Eq
	 BCT+mZx73U1N0Py73yD3J5uUW3/Hh/xMBawJqo5U2LyQbNfQJdQOCuqHEPfGQ3zDiI8IH
	 GCYaSry6hvo1mdgydRFXvpiXf6s82fnd6MiXkodfGSLw339281VGP+HRUCRfinAQXyA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795610840;
	bh=UOswtumIqV73ZgPCkcgKR3Mw8N0TWTgh9bOwnMdx/iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C26li4AuUORlFML23zKNty4ja4ayqY58MSdJ1btHfrb+mvmh/TdD1gEqXNQilew97
	 H1Qt9LFqPWwVYtVB65EGsouYgwjwoDNhg3MjlBgPRnruYgKxXGA7Lb8z/cyR0fse4q
	 93W2sCU77bcCwUY3vzMm8ILnMKIzEDhZaWjz6nGAwANi5Mn8GrtZcVd0bS/LLf4epZ
	 CaMiLlS9gUQxJiZ1eHdT8IlS289QO+dMopYJJS371FkArY4MpIkqD3RFKlOvysY1k0
	 oEGXucZEkKFPiozbzYl3d5IALHRQ09SfEBvLOrDwGNX084DvHbGPWNouqK/yo0m6Bj
	 XfbmG8oVYuNSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48E0F60891;
	Wed, 25 Nov 2026 12:47:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 596891C9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 12:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3ED88406B7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 12:47:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXIieKXgYTlb for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 12:47:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0572D405BA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JzGO672f
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0572D405BA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795610835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UOswtumIqV73ZgPCkcgKR3Mw8N0TWTgh9bOwnMdx/iw=;
 b=JzGO672f0YbEH/R29R9ziICO3ILQBD+0+wypkveBj/9wzN2LBLbLnfxo6IQDUS40uGxSC1
 kl2vZLfQyOR8/Ev7pRJZwt8maZrHguvERHZ0UsYvazBBDWxX2fIYCIX08iUS0tCjPUyjmU
 gKG/tqAKSFfz5WyAWbWQISB/K2lx0Tc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-xH8KfcU-PdWNfgvM9U5ZvA-1; Wed,
 25 Nov 2026 12:47:08 +0000
X-MC-Unique: xH8KfcU-PdWNfgvM9U5ZvA-1
X-Mimecast-MFC-AGG-ID: xH8KfcU-PdWNfgvM9U5ZvA_1795610825
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE3541801323; Wed, 25 Nov 2026 12:47:04 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8528E195B3D0; Wed, 25 Nov 2026 12:46:59 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, edumazet@kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, horms@kernel.org,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
Date: Wed, 25 Nov 2026 13:46:51 +0100
Message-ID: <20261125124652.3843638-1-poros@redhat.com>
In-Reply-To: <20261118115915.116177-1-poros@redhat.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: I9kD-8j1xrSZR4wgskcqL2nGAlGg5bKrcfswl-E1fTM_1795610825
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

Thanks everyone for the input. Jakub wrote that netdev is happy to take
the patches directly once a maintainer acks them there, and Przemek
that they will ack more on netdev. Building on that, here is a
suggestion for how it could look. It is only a proposal, for anyone to
comment on or change.

1. Fixes could go to netdev as [PATCH net] with intel-wired-lan in Cc
   and be acked there by a maintainer listed for the driver, so they
   would not need a separate round on iwl-net.
2. Patches that are already queued could be sent again directly to net
   by the people who originally posted them, the same way.
3. Later, once this works for fixes, the same might be worth
   considering for net-next.

It would also help if Intel updated the MAINTAINERS entry to match and
kept it up to date, so that it is clear who acks fixes for each driver.
Jakub mentioned adding maintainers or splitting the entry, and the
details would be for Intel to decide.

Does anyone see a problem with this? And who can make the final call
on how to go on?

Regards,
Petr

