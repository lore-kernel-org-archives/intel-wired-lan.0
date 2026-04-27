Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50008FF8862
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Apr 2026 08:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D39980F88;
	Mon, 27 Apr 2026 08:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PnjttQyV8ZKB; Mon, 27 Apr 2026 08:00:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F9D980EF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777276812;
	bh=8muKc8/uv8ZwFs1HhIEKd2DGHtuHL4YiGE08g4+DiMc=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=emdHkRMZduq6IcCRpEuAFUhEXYNtSVWknX8hP94jLVyG12lgJgG3E7L5x16g/pOR0
	 mWwIlsVvzXfu0jvrmJ5WXCeZTw9lMXcuT6cdeluTM9qO6KAzafQKPZKMJ/mcK/dVe0
	 K6LtcS8i7/AcqOEWkRTy60lDIDwVvoaATcW0vKn+ubEcfaxEdWByjmzsOW3JoSzKDw
	 EwIqqKbIDfAMPi0tAKPSEEw11KSRHzp+WvWO2+CkXHZ74Ksi8eRvA6LHMXiU/Cl9Vf
	 c4iQN/dj354t+AL7kTQjb0X9Q/N3AL/atjStbTb8G+zBXiNbzIpEihUsdLjhTH69xL
	 ZQGQu/Lk4CUUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F9D980EF7;
	Mon, 27 Apr 2026 08:00:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60EA31B8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 08:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1A9961579
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 08:00:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DFAeMiRF-BG1 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Apr 2026 08:00:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1791F6132D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1791F6132D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1791F6132D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Apr 2026 08:00:02 +0000 (UTC)
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-QMhenUDpPoqrWVabTYQnhg-1; Mon,
 27 Apr 2026 03:59:56 -0400
X-MC-Unique: QMhenUDpPoqrWVabTYQnhg-1
X-Mimecast-MFC-AGG-ID: QMhenUDpPoqrWVabTYQnhg_1777276795
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C6221956046; Mon, 27 Apr 2026 07:59:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.96])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF372180047F; Mon, 27 Apr 2026 07:59:49 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: aleksandr.loktionov@intel.com
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, intel-wired-lan@lists.osuosl.org,
 jacob.e.keller@intel.com, jesse.brandeburg@intel.com, jtornosm@redhat.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com
Date: Mon, 27 Apr 2026 09:59:48 +0200
Message-ID: <20260427075948.870208-1-jtornosm@redhat.com>
In-Reply-To: <IA3PR11MB8986BB8F2B8FBA03679590AEE52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986BB8F2B8FBA03679590AEE52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: QsrTqtHCvqQEHQL9ndU5nkfop6e-YjvhFJgtSaqk-6E_1777276795
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1777276800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8muKc8/uv8ZwFs1HhIEKd2DGHtuHL4YiGE08g4+DiMc=;
 b=Xq3QQQ+Jw3nWYRGtyqdnWSxphmF2Pf2Dt+C9ZJoubc/F0MzfHC2i14U30TINr+Nm3m6QlC
 nTUnw1y5ZuMtYFtW09++24YCmw3kH1G/LTvP8KtLHfKhii73kJMMecN3rUN1RHhkUu52aQ
 3Pb7xFdD2D2yKvQF6AyfBY6S6X1RoFw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xq3QQQ+J
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

> One more nit, kdoc should end with '*/' not '**/'
Ok, in the current code there are already some functions with headers
ending in '**/' and others with '*/' , the functions I have added or
changed the prototype in the series will all end in '*/' as you say,
in the next version.

Thanks

Best regards
Jose Ignacio

