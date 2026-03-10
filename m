Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978E0EB105A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 14:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 507D760B29;
	Tue, 10 Mar 2026 14:52:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gZ7Lp6V6Wv7K; Tue, 10 Mar 2026 14:52:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E0F4608A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773154352;
	bh=UIxw8ifz/vx6UnFqbAoU5fFu1LJG7g45kyv4F9G6+b8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8kafRFu0JyMmuS2DVL9oRbPEGqDCFFriM39+r2zCDS5wlhV+IzyeIVSU5NRFoVZPg
	 q/ums375P8FaGnx8bLmZU26lWdc6+cWBOj8Ndb0Q/dxgNY4JX8MGOYIeiIJNNxOom3
	 F9L54WWaOt+ov+dXnnoB36S/aP61IcLnOzy7uiJ2YbPqRbzMsfqfzgHne9cILagdbE
	 bjpmF3rfvWY6LLjNg5cjzFcFeegaOF6AJOLqCWZp9Lxm9utk+5gYJhBYUhi0Jp9y7S
	 INEyKiVkxb4XZSS29KtcO4TrR/DbWYvvowL6wjUWdGL8tqqGRpRd0BzsSa0hvfT88h
	 MIlIb7zWG3YHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E0F4608A8;
	Tue, 10 Mar 2026 14:52:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 84C9535C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 14:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E75D40872
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 14:52:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ecuJqkK9z_1Y for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 14:52:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jramaseu@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 54D5D4086A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54D5D4086A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54D5D4086A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 14:52:28 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-aeIt4Q60NxWy3SkSzoovHg-1; Tue,
 10 Mar 2026 10:52:24 -0400
X-MC-Unique: aeIt4Q60NxWy3SkSzoovHg-1
X-Mimecast-MFC-AGG-ID: aeIt4Q60NxWy3SkSzoovHg_1773154343
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED2221800610; Tue, 10 Mar 2026 14:52:22 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.tpbc.csb (unknown [10.43.3.226])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DCBA1956095; Tue, 10 Mar 2026 14:52:20 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: aleksandr.loktionov@intel.com
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 jramaseu@redhat.com, netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
 przemyslaw.korba@intel.com
Date: Tue, 10 Mar 2026 15:52:15 +0100
Message-ID: <20260310145215.1128416-1-jramaseu@redhat.com>
In-Reply-To: <IA3PR11MB8986B891354A9AEBB0289BEEE546A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986B891354A9AEBB0289BEEE546A@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 2HRdvoIPftg7qPVw4uoMVIxVZ9fgJ7FnBJauiW1HTj4_1773154343
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1773154347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UIxw8ifz/vx6UnFqbAoU5fFu1LJG7g45kyv4F9G6+b8=;
 b=K5GY5H6GWJ/lVuPf5DZ5N3AWvWU5Gq/xFYYbyJRdLMEL6ZBZiYId0qqSK9IhjspiWTKVLP
 4zYXQdOEcc8FF2qto71DoEOYQ2JgmGaEwHkrMJDtUx8myBSEo7eiPL+lSig+amiRSw7avf
 86QGb22G8QOsMnAIyRDV+r8B4kKCiPI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=K5GY5H6G
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: enable NETIF_F_HW_CSUM
 for GSO packets
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

Dear Aleksandr,

> Please update commit message with exact commands for reproduction if possible.
that is sure to be done in v2, for now try

for the side acting as iperf3 server:
```
#!/bin/bash
# tunnel creation
# IPv4 addr         192.168.42.11/24
# IPv6 addr         2011::11/64
# IPv4oIP6GRE addr  192.168.44.11/24
# IPv6oIP6GRE addr  2023::11/64

ip l a gre1 type ip6gre remote 2011::12 local 2011::11 dev enp65s0f0np0
ip l s ip6tnl0 up
ip l s ip6gre0 up
ip l s gre1 up


# gre tunnel addresses
ip a a 2001:db8:1::1/64 dev gre1
ip a a 2023::11/64 dev gre1
ip a a 192.168.44.11/24 dev gre1

# device addresses
ip a a 2011::11/64 dev enp65s0f0np0
ip a a 192.168.42.11/24 dev enp65s0f0np0

iperf3 -s
```

for the side acting as iperf3 client:
```
#!/bin/bash
# tunnel creation
# IPv4 addr         192.168.42.12/24
# IPv6 addr         2011::12/64
# IPv4oIP6GRE addr  192.168.44.12/24
# IPv6oIP6GRE addr  2023::12/64

ip l a gre1 type ip6gre remote 2011::11 local 2011::12 dev enp65s0f0np0
ip l s ip6tnl0 up
ip l s ip6gre0 up
ip l s gre1 up

# gre tunnel addresses
ip a a 2001:db8:1::2/64 dev gre1
ip a a 2023::12/64 dev gre1
ip a a 192.168.44.12/24 dev gre1

# device addresses
ip a a 2011::12/64 dev enp65s0f0np0
ip a a 192.168.42.12/24 dev enp65s0f0np0

# tests with single stream
# test gre throughput
iperf3 -c 192.168.44.11 -t 20 -P 1
iperf3 -c 2023::11 -t 20 -P 1
# test normal throughput
iperf3 -c 192.168.42.11 -t 20 -P 1
iperf3 -c 2011::11 -t 20 -P 1
```
I hope this is expected answer.

Best regards,
Jakub Ramaseuski

