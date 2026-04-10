Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F18F36BB7
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 11:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AF4660BF3;
	Fri, 10 Apr 2026 11:12:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wpg3i6LIphEm; Fri, 10 Apr 2026 11:12:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D6BD60BE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775819541;
	bh=6q/fYiv79cBBdIHumevrLvgbJqRc865vCfOw9Njpits=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YAT1jlo+sO1HmSvsKmfFCoIzzbsxfsYr6EbNC0aKaECIQYjl95ocCsWQcnKwNl6qh
	 jfBX8evitEtTIjTPwuaL2h+9FuWgDvfjjyE4G34syVoQf/Perd574cMHYb8DBLTXNL
	 BUlk66SYc47Lf7xUlFXR4JPh1CtUvm6QeytuOnwdRnrXbs48LPbuiB12ALMRQln/lC
	 IrQE0+dDH2G+ZYWJJSefl2Bxiaoywb4BTcCj6uYkLMaMW/u52Rv420EWOv887FpV3u
	 V4pBxeHdIPBXkeukUAIghizJofGNw+TBP+7V25EjjSUNz4dOp1wS+d5faQ/iIGB3jV
	 GNOWYnuYXaD0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D6BD60BE1;
	Fri, 10 Apr 2026 11:12:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFFDA194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 11:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5F6A4043C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 11:12:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D6syjVvX4jqh for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 11:12:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B053E40399
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B053E40399
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B053E40399
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 11:12:18 +0000 (UTC)
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-cO40RGV6P32C3UDeo9Ngow-1; Fri,
 10 Apr 2026 07:12:13 -0400
X-MC-Unique: cO40RGV6P32C3UDeo9Ngow-1
X-Mimecast-MFC-AGG-ID: cO40RGV6P32C3UDeo9Ngow_1775819532
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8A2A19560B2; Fri, 10 Apr 2026 11:12:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.88])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECEF21955F2E; Fri, 10 Apr 2026 11:12:06 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: przemyslaw.kitszel@intel.com
Date: Fri, 10 Apr 2026 13:12:05 +0200
Message-ID: <20260410111205.84349-1-jtornosm@redhat.com>
In-Reply-To: <89bfd605-1877-4d40-95e1-bfeae6624168@intel.com>
References: <89bfd605-1877-4d40-95e1-bfeae6624168@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: hBjFN69n2X_4CmnPHROj6sWPBVDYUd5QwM5hpvXxW30_1775819532
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1775819537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6q/fYiv79cBBdIHumevrLvgbJqRc865vCfOw9Njpits=;
 b=BU9O0dKw3glWqHUEu+qCsAGnmAiFou+x3bSKC8ZiSwD5x8BQpTReEvSSK1R1+ByNM+T51n
 XG1BSCklNAn7WSm436m/5qVv4xlu1epq274bu97s7OmjruKXhekEi2zLeER0dH5iGj3pX+
 MojtEJizK/ntsNGpi2PRG4hImDAnNCc=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BU9O0dKw
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
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, jtornosm@redhat.com, kuba@kernel.org,
 jacob.e.keller@intel.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net, kohei.enju@gmail.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello Przemek,

Thank you for your comments.
I will try to include them in a next version.

Best regards
Jose Ignacio

