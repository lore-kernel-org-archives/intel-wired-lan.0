Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45555FE5204
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Apr 2026 10:32:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8E1F8488F;
	Fri, 24 Apr 2026 10:32:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7oSX63HAuS7J; Fri, 24 Apr 2026 10:32:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30CC28488A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777026768;
	bh=j8BpQcTU/HrFkQ0+UuHlyLaR2zAA5vDMBO2MGcO/oD4=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=siu6gEDpOp38OS8C4DYJm5KQ7maU1WhyAnIXORMvsnyVhsNutbzLNXeba2OC0VcAB
	 5LlR+fYZVg511uuegVmBFwwei4vMZEgj/thPtHQurbL1hAVgDqlXGiNorD1T/x8RwN
	 mJu6k3q/03M+PSAQRzVNGgcGMD+rYeRLj/LjfFRfHYj9WYRc+EjDJneLRr9OIj/0bE
	 HEVbXCX6qO5fOxeSFiRI50IjxXcLXEu7gllgCU7i6gN4n021WfI99aNo4sadZ0l0y1
	 8m4FL266upelwLvmS2ENWrNcXkbz/rOJD41VzXIeArrOJ5n1/twDUyE79Z7CtcXWLR
	 RRP6DXvp0C8HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30CC28488A;
	Fri, 24 Apr 2026 10:32:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9061A231
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 10:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 761B5425DC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 10:32:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZEesYMPSTmUM for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Apr 2026 10:32:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 60632425DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60632425DB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60632425DB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 10:32:45 +0000 (UTC)
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-Bb_4hFO_PMqekvjZMqwVzw-1; Fri,
 24 Apr 2026 06:32:41 -0400
X-MC-Unique: Bb_4hFO_PMqekvjZMqwVzw-1
X-Mimecast-MFC-AGG-ID: Bb_4hFO_PMqekvjZMqwVzw_1777026759
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3576E19560AF; Fri, 24 Apr 2026 10:32:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D9631800348; Fri, 24 Apr 2026 10:32:34 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: aleksandr.loktionov@intel.com
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, intel-wired-lan@lists.osuosl.org,
 jacob.e.keller@intel.com, jesse.brandeburg@intel.com, jtornosm@redhat.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com
Date: Fri, 24 Apr 2026 12:32:33 +0200
Message-ID: <20260424103233.622318-1-jtornosm@redhat.com>
In-Reply-To: <IA3PR11MB89862412A9F682D59474841DE52A2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB89862412A9F682D59474841DE52A2@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: vCfGEAvgW58uJPUEPRYVcBWNNcrv49Jb27livm0IXE8_1777026759
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1777026764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8BpQcTU/HrFkQ0+UuHlyLaR2zAA5vDMBO2MGcO/oD4=;
 b=Coyb/oFK7Br5U2AiG+8wWcKzVJ/oKE1nenOt7RHKrMxexDoruv8eYUg0nhaPG/dl3PQWhQ
 bfXLZ4Ovuk4oolIHDVyIY4lR/HkkXMDN3WcE/L+9aY6UB3IxF/ZgzLv7LJ8WV9Xb9JpoXB
 eORo4svU4RloqTZGfI3vz0ssO+qt3EY=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Coyb/oFK
Subject: Re: [Intel-wired-lan] [PATCH net v4 4/4] ice: skip unnecessary VF
 reset when setting trust
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

Hello Aleksandr,

> For me it looks like  cc: stable@vger.kernel.org must be added
I am not sure about that, because the bugs fixed  here (vf->trusted
ordering and race condition) only trigger when MAC LLDP filters exist,
which is an uncommon scenario.
And most users will benefit from the performance improvement that is an
optimization rather than the bug fixes.
I mean, I included the commit fixed as a reference but due to optimization
as the main reason, I didn't dare to request this for older versions.

> You declare ice_vf_clear_all_promisc_modes() returning int, but ignore
> the return value.
> Looks suspicious isn't it?
Well, it is used like that when the funciton is called locally (the
function is not modifiedi, just made public), and really my intention was
to clean as much as possible (so error checking is not necessary).
In my opinion it would be enough to warn about the possible problems
(already done in the existing function).

Anyway, if, despite the reasons I have tried to explain, you still think
the same way, please let me know so I can adjust them (if you don't mind,
I would wait for more reviews to include them in a next version).

Thanks

Best regards
Jose Ignacio

