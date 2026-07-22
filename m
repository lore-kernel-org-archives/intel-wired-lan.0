Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFBFC4452B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Jul 2026 00:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15EF980DD9;
	Wed, 22 Jul 2026 00:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UYZZ8xIiW7W3; Wed, 22 Jul 2026 00:46:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EE3080DDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784681206;
	bh=2Is18EtYtwVs1jbSXEvasX13S7pZoiJ+bguClsADUJA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mRvvmpEVGbY2zmvH9Yhxu6yacZsBwhABRmG1dYYvXvCghh+f6h4INumxFC+t1TFfI
	 +Eb0aC9JSASc+rEapMBl3vLl3ffQoEswqI5GukeEIqmbca/9N5TDk9aj9OpCpRuLl6
	 7Dm6bF1hpUqUtcU2z56kr9+5mNWp22AbWbU3Hlcf70s4rkTeoeYFXSm51PaQwqCejW
	 +K3eWJ7dsr189rkkUF0bkxFJbbgHIsNXDPLj1PkC5HCXaaJkkY4ApWmRzmOxNl886y
	 lFCv1HmTEylOsfXajxSmNlCjvC4W6Kf8OpOVzaelTAXonN1SCOa7/JF9mZSFHwWJpm
	 q1Sca0VDAHLvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EE3080DDD;
	Wed, 22 Jul 2026 00:46:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30BAE42A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 00:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E4C6406BC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 00:46:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J9Y-zgREys6V for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Jul 2026 00:46:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5E887406A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E887406A5
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E887406A5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 00:46:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 978E14323F;
 Wed, 22 Jul 2026 00:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1303D1F000E9;
 Wed, 22 Jul 2026 00:46:43 +0000 (UTC)
Date: Tue, 21 Jul 2026 17:46:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org, Milena
 Olech <milena.olech@intel.com>, Emil Tantilov <emil.s.tantilov@intel.com>,
 Mina Almasry <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ijae Kim
 <ae878000@gmail.com>
Message-ID: <20260721174642.7749143e@kernel.org>
In-Reply-To: <20260720143511.43408-1-mhun512@gmail.com>
References: <20260720143511.43408-1-mhun512@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784681203;
 bh=2Is18EtYtwVs1jbSXEvasX13S7pZoiJ+bguClsADUJA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=mcxYwQIspZ8TVcZ4aS1jAVHlbfeHMppudvhM3fQRjxqlzbJuK9VjhvRqKWBKCkH/4
 9+3eOK7er+I5ApQvIQWzNieKgulbttp1YEKoi79OYyCFRdZT0ELnnFAieSAhDcE7Dl
 dZDbMjuV31ZSQX8OOzRsyBu6neqpbOA6CcE1cRK7z7B3SBGhwAjIdOc6UX6cAUaaOI
 9bj3/yGX6S+OpAD1s48W9OmhMhhn2leAUz8ekToOoRCdSsnjx8kPsFO+8iPqKDmsq3
 XyjufTbrI6U9ciubSVy2NVZe643vRPytwKLs1Oq+JqTs3BJlb/tnJe3iBowZVves8h
 FWYKLf6b3VfQg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mcxYwQIs
Subject: Re: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe
 failure and on remove
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

On Mon, 20 Jul 2026 23:35:10 +0900 Myeonghun Pak wrote:
> Subject: [PATCH v3 net] idpf: disable PTM on probe failure and on remove

Please try not to change the subject of your patches when you respin.
It breaks version tracking. Ideally you'd tag this as iwl not net.
We don't apply intel NIC patches directly.
