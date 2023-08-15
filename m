Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE0CC001B0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Aug 2023 11:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF7B46110D;
	Tue, 15 Aug 2023 11:36:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF7B46110D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692099388;
	bh=FQ/Gqgur4nMAHGEFCegHjED+fkmX3ADnsqhQynRUS2E=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mtfJ7xHn5/p/GAfOzTxAJsCwv8B8qLCAeKXObwcJGOfzn+FRAk513T7UQTDoCjTVC
	 l74zqpeMxddjZy4nEGaIjjs2tsCx+ren7OHqvpE2xwAwFV7ke985pRjfEvnQxezcAU
	 Q8+XYND2AtbAgPjzSbCLd1KdSu2mTFdCEoZ5bs/70xeMFaGHKo+fY7crhTbIQ++913
	 lrVG6RBi2v92N/km7HkUPk1HJIADqmRXCbzhRzncZ188YYGjgaquplboLydOfq7nlk
	 zFGIVULN4kVdW4vFRcCiZbrxsySvqjrHyxfYDeFYEFHeF92cczmA3zF1DndcVkImPa
	 svYf/6vEfFQNA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eTUP_h8a993u; Tue, 15 Aug 2023 11:36:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1299661102;
	Tue, 15 Aug 2023 11:36:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1299661102
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id CE6C71BF3FF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 11:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C7FC404EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 11:36:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C7FC404EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P4oGHPJ21Mr6 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Aug 2023 11:36:22 +0000 (UTC)
Received: from out-57.mta1.migadu.com (out-57.mta1.migadu.com [95.215.58.57])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 758064047B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 11:36:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 758064047B
Message-ID: <43395307-9d11-7905-0eec-0a4c1b1fc62a@linux.dev>
Date: Tue, 15 Aug 2023 12:36:11 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230814194528.00baec23@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230814194528.00baec23@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1692099378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdaOhJMcLy8g2NeNhcZ0hjcc5u5LnChRhx//RtiayQ4=;
 b=OWMV0nhGYN/Xpcdri2nKwD8iSdWtf+SoVmD0ynb6XBq7aevH38T/J7f4EyvMgs+IbLLaoK
 BBMPl5leCQ99nxanJAOjIDE7trjwwvU8TliNlMXmnZhpOKwqtRNKKOp6abth0eL3v/B9NR
 cHd9by0qtahbeg3ZcFMSJjLeTkHVYVw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=OWMV0nhG
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/9] Create common DPLL
 configuration API
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
Cc: Jiri Pirko <jiri@resnulli.us>, Bart Van Assche <bvanassche@acm.org>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-arm-kernel@lists.infradead.org,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 15/08/2023 03:45, Jakub Kicinski wrote:
> On Fri, 11 Aug 2023 21:03:31 +0100 Vadim Fedorenko wrote:
>>   create mode 100644 Documentation/driver-api/dpll.rst
>>   create mode 100644 Documentation/netlink/specs/dpll.yaml
>>   create mode 100644 drivers/dpll/Kconfig
>>   create mode 100644 drivers/dpll/Makefile
>>   create mode 100644 drivers/dpll/dpll_core.c
>>   create mode 100644 drivers/dpll/dpll_core.h
>>   create mode 100644 drivers/dpll/dpll_netlink.c
>>   create mode 100644 drivers/dpll/dpll_netlink.h
>>   create mode 100644 drivers/dpll/dpll_nl.c
>>   create mode 100644 drivers/dpll/dpll_nl.h
>>   create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.c
>>   create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.h
>>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>>   create mode 100644 include/linux/dpll.h
>>   create mode 100644 include/uapi/linux/dpll.h
> 
> Feels like we're lacking tests here. Is there a common subset of
> stuff we can expect reasonable devices to support?
> Anything you used in development that can be turned into tests?

Well, we were playing with the tool ynl/cli.py and it's stated in
the cover letter. But needs proper hardware to run. I'm not sure
we can easily create emulation device to run tests.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
