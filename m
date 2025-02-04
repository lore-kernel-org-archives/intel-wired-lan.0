Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1E5C02193
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Feb 2025 20:11:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 351BA60DFD;
	Tue,  4 Feb 2025 20:11:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cjs6iNx5g378; Tue,  4 Feb 2025 20:11:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9713D60E03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1738699874;
	bh=oYpYFiVdWybN0jZGct9NoBnywFaUftZ2owtwxUI9TBA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SqgZHDNTSwc5N31RIFbWexWhCvbnK3M2xiF8wVR7RyBNXqLzRldml3ijJLRLZVczd
	 q7C8N+RLvcvrV7+hbrVAqB4+yY0gkgR8PK9vWEo2P95dy4I4+4qVArHHDMULLu7sZ3
	 osRTkrFapgS5apiBzuMggqiiEUyKYVHE31I6W2hk6EOrfRc8bVs72onJiPVBxCyXPr
	 GMus1Mc5WmSIGeD70lH5caP/5vlbvYsD7o/s/BHJ7AbaYqejPy5ood4jjYcWxTcih5
	 olzHz1l5lMsxsjfqhCRwfThimoOWM5pZ7atD6BFhoyTJxPDN/Xp8cLHXc/zqM57EU7
	 d/RZ/9MObv61Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9713D60E03;
	Tue,  4 Feb 2025 20:11:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FFCA1A6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Feb 2025 20:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1285841448
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Feb 2025 20:11:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iTI-UrqG7_-e for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Feb 2025 20:11:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4A1FF41434
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A1FF41434
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A1FF41434
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Feb 2025 20:11:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 46C7F5C65CB;
 Tue,  4 Feb 2025 20:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F362C4CEDF;
 Tue,  4 Feb 2025 20:11:09 +0000 (UTC)
Date: Tue, 4 Feb 2025 20:11:07 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, pmenzel@molgen.mpg.de,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20250204201107.GP234677@kernel.org>
References: <20250204071700.8028-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204071700.8028-1-jedrzej.jagielski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1738699870;
 bh=fn7KECgeaEFokVrniGp68GeakWgPDRa7VOMu32zpqRc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IxMYra2HBjrkqod/mKwUkhu1n3hwnf2vL9SsegCIXmTmidaQG4bS5XKbITgmIGWlN
 jpL5Balj1q04TVaZvhQic0yIrVnDm1rv08T0/Ck23hLCnMY95j9bTDmqcFGZE+dvYS
 N7VNyvzp+iAee0B+GcpLJqgY0tmqf19tW1X/etzrVK6ujp7EIcJ+1k2U2Kwm7BVfsh
 /y1YFAfE7gGtjhW1IxKxkcES58c5VMw1jOG/3XmMdggkMz6dqDTiG6SC0DWoy7rtch
 46To/7tNs+vihC0J49Vb42xgLZVx8eAcezKn197WkJNiyOguU1b0zrAaDrDrSgsBl1
 RgdSJA8TveuFQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IxMYra2H
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ixgbe: add support for
 thermal sensor event reception
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

On Tue, Feb 04, 2025 at 08:17:00AM +0100, Jedrzej Jagielski wrote:
> E610 NICs unlike the previous devices utilising ixgbe driver
> are notified in the case of overheatning by the FW ACI event.
> 
> In event of overheat when treshold is exceeded, FW suspends all

A nit flagged by checkpatch.pl --codespell.
In case there is a v3 for some other reason you may want to correct the
spelling of threshold.

> traffic and sends overtemp event to the driver. Then driver
> logs appropriate message and closes the adapter instance.
> The card remains in that state until the platform is rebooted.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

...
