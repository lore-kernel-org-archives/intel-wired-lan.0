Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E398AFF8873
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Apr 2026 14:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F2E842A54;
	Thu, 30 Apr 2026 14:48:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JYIKsyOFIzff; Thu, 30 Apr 2026 14:48:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAFA642A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777560535;
	bh=GPG74hKtodlgGgVqf59yV+kFwEXRytQRtPzNS2dUQpc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MYARI1cb2QqP0XakR15b3BgVeqpnpK0BXR8quivnEgZsE45fXPqqgRRTYMQfosATc
	 45jcTvidQ9KjSYRhgXm2ukMs6VJCqK1TjCsQrKu5vPC6mBBe4n3DlCGnd1/VwEM8t4
	 d9EI3RtEbDv1UfBbDc6PkXWanEGpTOawokG3VQgziGtY6AsB4hHHR+imqYOCJLxocA
	 pPBA8qUYmatI+6e9EcdIePFcPAt+z7Mkr285y5ytYtDte+034zvHN05hH+iEgdO6z5
	 SKGwbjPkddbfD5+agujBH2n/gqeiqEVyhAwOZ0lybFHn7VzDA5m2WHO73+x3f4dCzo
	 ZJM6A3mGCTWtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAFA642A4D;
	Thu, 30 Apr 2026 14:48:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 75DC7192
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 14:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BCB584D37
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 14:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jkbT-AN3N6S for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Apr 2026 14:48:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B1DB384D34
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1DB384D34
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1DB384D34
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 14:48:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A88660142;
 Thu, 30 Apr 2026 14:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED97C2BCB3;
 Thu, 30 Apr 2026 14:48:51 +0000 (UTC)
Date: Thu, 30 Apr 2026 07:48:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Message-ID: <20260430074850.78ed5bdf@kernel.org>
In-Reply-To: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
References: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1777560532;
 bh=y8zJk9caf7v4JlJgjE0gjutEn8ottL/lwMgaKWlC90M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JX/WfblH6PuwC/gGATZ14PS7j4Py7vglrSpWgh2wP6/Y7DQ44WO+hdIcB1A2TBf8z
 DHR+atbgR7pWusLzL6DqEnmXEDS7Lond3ywE1C7nZl+4N5kMNQFnNC8ScRisgkstkC
 DiYKyY5buUrQ7/w2EPbaDOaHM0SkKGrGkUBqkHbHBusoXnJ4sSzdlU/NrcGXLPhfOD
 NEpA78Qx6jh0JyJNzKUxs2uvCkwiPlJiCY5SUPsDZ90ZY3/ov+gQkjyn6zXxs5Z4hU
 OX9dyyMGPjsyOP1ffE/TPfZbJzAnvWDNVyzz/t/a+PiEAwzJFN+uVOCBCnfwFyefO1
 xvYG3xnKkkfjw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JX/WfblH
Subject: Re: [Intel-wired-lan] [PATCH 0/5] ice: five small fixes and cleanups
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

On Thu, 30 Apr 2026 14:25:57 +0200 Aleksandr Loktionov wrote:
> Subject: [PATCH 0/5] ice: five small fixes and cleanups

Please tag your submissions with iwl-* if you are cross posting.
-- 
pw-bot: au
