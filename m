Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56849F459F7
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 16:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 041BA610A9;
	Fri, 10 Apr 2026 16:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id svVZz7AtA1I1; Fri, 10 Apr 2026 16:25:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38A5E610A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775838358;
	bh=WIgf06YVrt3i8IDBeTEXTOVKt6Ma5XHOJR3hB7Q6upw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ub+LSyfBatpFhqucztCGz8/C+c76UDWF7UUnwR2dyMxxUY0D81DmNkUo0E1so5ofy
	 pIrB+D8WAc+7c4HSk1Dq61TTe965WVpUMV4F9G1d0s34cBMy8Z34Dur56hPolEZQ0n
	 y+6nzFtMj/n5+W9PwZ3BJhJ0X2MuRjvotSEY1lfHkD/as8vQguddMh757ixqRQi4S0
	 Cq8NINv0wXPYowExuwmkRYbU7bed2XFhyzAWUbkFwtW6yuaPj+L5abwPP3wka81j7R
	 uDYsCZ+eiU1zVoo+mNu0mrN9HB/cvPh/W5Zy0YQ0irk9C8plaiRrQx6KrF/cwXIv1P
	 ll9XxKR5GeaaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38A5E610A6;
	Fri, 10 Apr 2026 16:25:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 684A8237
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 16:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 558B640B63
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 16:25:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HJuxIgweDRMb for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 16:25:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 344BB40B58
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 344BB40B58
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 344BB40B58
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 16:25:55 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-uRPQk7QlOeyjSGPY8gCZmA-1; Fri,
 10 Apr 2026 12:25:50 -0400
X-MC-Unique: uRPQk7QlOeyjSGPY8gCZmA-1
X-Mimecast-MFC-AGG-ID: uRPQk7QlOeyjSGPY8gCZmA_1775838348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A82C3183EED1; Fri, 10 Apr 2026 16:25:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.88])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F5B01800B7F; Fri, 10 Apr 2026 16:25:43 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: przemyslaw.kitszel@intel.com
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com,
 jtornosm@redhat.com, kohei.enju@gmail.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Date: Fri, 10 Apr 2026 18:25:42 +0200
Message-ID: <20260410162542.209743-1-jtornosm@redhat.com>
In-Reply-To: <30d48647-8c1d-4683-ae9d-becb33cf8d4f@intel.com>
References: <30d48647-8c1d-4683-ae9d-becb33cf8d4f@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 0fegZ1P81zMaraHSGwpZIIfQSXEyrL5cFR7UdHohQ54_1775838348
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1775838354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIgf06YVrt3i8IDBeTEXTOVKt6Ma5XHOJR3hB7Q6upw=;
 b=HQcHSvh2v+oMPkfSsvTJfZrWARm8hoSxHYnSFBB6cxlKM1nQ/R20JRmVgbLiO/KPklLZvs
 fwVxNEGgdSgFrcBQFriQ2XyEcGq0E9hp5zTBgGckQXouHiqrFu0078Qi5Vw7xizDqMCZrC
 Fm6BTB/DQVTVRrj1bpxIQz4cF/E0y88=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=HQcHSvh2
Subject: Re: [Intel-wired-lan] [PATCH net v2 3/4] iavf: send MAC change
 request synchronously
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

Hello Przemek,

Thank you again for your comments.
I will try to include the new ones too in the next version.
In addition, I will analyze the suggested integration with existing
iavf_poll_virtchnl_msg() and possibly iavf_virtchnl_completion, but maybe
better in a new patch of the series as a refactoring.

Best regards
Jose Ignacio

