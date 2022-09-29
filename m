Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DE3C04A95
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Sep 2022 07:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EEA883EF2;
	Thu, 29 Sep 2022 07:53:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1EEA883EF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664437998;
	bh=UZIAiT33pIUV2/55QES0cekPSthsLO/XRR2Oo9C4i2s=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=m+2nw6VuYIzHPOiT0xBTw1VkWjE7e9CZaCkwTa1TbVdqLyYDu/ytoN06yT4LBDnht
	 Ja3P694WR0LHmxJ+rvgFi31h2lDYlC56/iWaftdLQyn/nF0MC+PemlTq6sUzcee8LT
	 CA3wWpKmOmBUv89UsHw0aOnCaH4ypCN8+2KVUba2ibp7qyzWHUdRxaIxRYNaEVW1dB
	 A37fpW5FUbhW2My4EZkDB0Tipq+QedTfA/07chCs8eic3yB8E0LndhfhNfBUvCbgHn
	 kO+9cN4OP92gw1XfZ0vU4edIuFESzJcnyBNP/oorXjqeBJbJEkgEOs7udOtBdlIzU8
	 fmxHOzpGq6S6g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f6px-Fgi-K2k; Thu, 29 Sep 2022 07:53:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A15D83EFE;
	Thu, 29 Sep 2022 07:53:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A15D83EFE
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 02DDA1BF83C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Sep 2022 07:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDBB760AB7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Sep 2022 07:53:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDBB760AB7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BZLdWfeBEina for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Sep 2022 07:53:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1ED6760A71
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1ED6760A71
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Sep 2022 07:53:14 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-5dcL323bPQ2nWLfnv8dFUg-1; Thu, 29 Sep 2022 03:53:10 -0400
X-MC-Unique: 5dcL323bPQ2nWLfnv8dFUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53676185A794;
 Thu, 29 Sep 2022 07:53:10 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.40.192.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38063207B34A;
 Thu, 29 Sep 2022 07:53:09 +0000 (UTC)
Date: Thu, 29 Sep 2022 09:53:07 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Message-ID: <20220929095307.2c60d651@p1.luc.cera.cz>
In-Reply-To: <20220913140206.64330-1-kamil.maziarz@intel.com>
References: <20220913140206.64330-1-kamil.maziarz@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1664437993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1zhQIXI1JbKkBA3zFvjEnGbRNywHn+9ETBg5i6Hm+0=;
 b=Gs/BMdlRISAmekfi9Lscj2ROqX2q7BZcuCSdm0DQiKXNkEQeuyaUCsjFWVIei5BaId/KLk
 v0WiDo1ShTi6QKfeRST+10hqPsXNwfrnwnBhzVld6EonQG/e6ElhoKPhyVESiq0xcfwXvU
 958BtryCyyIFJYxNNuGvVNXO1sr9xLU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gs/BMdlR
Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: Fix not setting xps_cpus
 after reset
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
Cc: Michal Jaron <michalx.jaron@intel.com>, intel-wired-lan@lists.osuosl.org,
 Kamil Maziarz <kamil.maziarz@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 13 Sep 2022 16:02:06 +0200
Kamil Maziarz <kamil.maziarz@intel.com> wrote:

> From: Michal Jaron <michalx.jaron@intel.com>
> 
> ...

Tony, I'd like to ask what did happen with this commit? During Monday you applied the patch to
40GBe branch as:

commit ce8d8ae335f469a399805f56e74b98390f327184
Author: Michal Jaron <michalx.jaron@intel.com>
Date:   Tue Sep 13 16:02:06 2022 +0200

    i40e: Fix not setting xps_cpus after reset
    
    During tx rings configuration default XPS queue config is set and
    __I40E_TX_XPS_INIT_DONE is locked. XPS CPUs maps are cleared in
    every reset by netdev_set_num_tc() call regardless it was set by
    user or driver. If reset with reinit occurs __I40E_TX_XPS_INIT_DONE
    flag is removed and XPS mapping is set to default again but after
    reset without reinit this flag is still set and XPS CPUs to queues
    mapping stays cleared.
    
    Add code to preserve xps_cpus mapping as cpumask for every queue
    and restore those mapping at the end of reset.
    
    Fixes: 6f853d4f8e93 ("i40e: allow XPS with QoS enabled")
    Signed-off-by: Michal Jaron <michalx.jaron@intel.com>
    Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
    Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
    Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

but later the branch was force-pushed, the commit is not present there anymore nor
in upstream... Was it silently dropped? What was the reason?

Thanks for clarification.

Ivan

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
