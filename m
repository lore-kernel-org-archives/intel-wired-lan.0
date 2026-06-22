Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E422CCDB46F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 22 Jun 2026 10:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ACF36F84A;
	Mon, 22 Jun 2026 10:52:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pR4OSVMp9AHu; Mon, 22 Jun 2026 10:52:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9349F61CF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782125531;
	bh=dP7YOQdMFFWMe6SFbBqJUEKuKE6sG1VVyWa1eKmnmZ0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cIUrpnfeo9PTcwp1naW2tYxTnMfqufsZBU97axRjmJNlOL122zMZ1gVVqu2EY0JrR
	 lSD9FMdW1LXnOYWFAfJso9sSN/zKipt5AqnBlAur49RMyw5fPhFmVfqkC1slNe/wnS
	 AIz/tAyQYr6+di1m4CdUI3nR8QHXhLU5K0XQgAycjJMWLosaIY0x0TQmxqnMk8SNkE
	 cP+wtMxE+I1WUIH1UQRTE1GbQ13wildYuZ80yeqUSaVVXkn8RcYKvS0s4T3/8tl5iW
	 lMzxCzWlAgU+ffmtgSH3TigGxqMJTyfxQ4xKTIQZ4P1nb/IH53MtKosPIXIt0GFgw7
	 83ay7Mj1lUY3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9349F61CF5;
	Mon, 22 Jun 2026 10:52:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B44D24D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jun 2026 10:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CD7B86592
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jun 2026 10:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n-cX7G7uKt0u for <intel-wired-lan@lists.osuosl.org>;
 Mon, 22 Jun 2026 10:52:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A90228658E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A90228658E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A90228658E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jun 2026 10:52:07 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-LNoohOtNOv2JJmqnfWRb-g-1; Mon,
 22 Jun 2026 06:52:01 -0400
X-MC-Unique: LNoohOtNOv2JJmqnfWRb-g-1
X-Mimecast-MFC-AGG-ID: LNoohOtNOv2JJmqnfWRb-g_1782125520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B86B718005AB; Mon, 22 Jun 2026 10:51:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.91])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DD96195608B; Mon, 22 Jun 2026 10:51:54 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: horms@kernel.org
Cc: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 jacob.e.keller@intel.com, jesse.brandeburg@intel.com, jtornosm@redhat.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com
Date: Mon, 22 Jun 2026 12:51:51 +0200
Message-ID: <20260622105152.24016-1-jtornosm@redhat.com>
In-Reply-To: <20260622103159.GZ827683@horms.kernel.org>
References: <20260622103159.GZ827683@horms.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: -nC4Zl2C45IgMLS2zhaf0Pm5trXAfXP4drxAv05FABI_1782125520
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1782125526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dP7YOQdMFFWMe6SFbBqJUEKuKE6sG1VVyWa1eKmnmZ0=;
 b=YEd44H5tbZMd0Au77mYJyA4JqF+Z4ORd4XtLz2yens75OeojT5E1FfOVEVgDclP+4qLn0I
 NSmwYFnmBN5/zMyDv6uLoMC3JelbD1BlDIpnzw9Ihb1/ekgV/aiIkVFr+Ra5X8vtetWRlA
 +NQkCCUbjNC8c6jwx+l/lo362/vosEE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YEd44H5t
Subject: Re: [Intel-wired-lan] [PATCH net v6 0/4] Fix i40e/ice/iavf VF
 bonding after netdev lock changes
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

Hello Simon,

> Unfortunately the Netdev CI was unable to apply this series cleanly against net.
> Would you be able to rebase and repost?
Sure, I'll rebase on current net and send v7 shortly.

Thanks

Best regards
José Ignacio

