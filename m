Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E524DE95A91
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Oct 2023 15:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C4D760ACE;
	Mon,  9 Oct 2023 15:22:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C4D760ACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696864972;
	bh=pYijD653jJP81mZVTBF2Pypfp2sj9AR85VxVoFHTr7Y=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=319c26oWgX2Ie/CzCY6NyxJfYfyzng63ZlimfPnBu1kDHrgnfaSlfnlGZyCX362gu
	 tk47lFediitN3IR2PHjGUNhjtRE4sk0uegImArXyJ90wUX4z+zmKhuukgPlHQz3bbp
	 o/4Ka/AcCywoXlaRBuXjyzpa5EaeFlagorZG60VYUu4UCB4TSmVXyMP1v7ERa/2lm6
	 C8yhhm7cTvfiw6+WR9EL/20Z/N8e4Ow4K9GERdVuJBtA7dZs2GERBRYgZM+CZQpI2L
	 MYBgV+ZLu0LCo5clz5QA6DZI0MzNw1FekWPIP1KEEejmLHS1Y7AClh4V9gA2SqCX81
	 5GFwp3UBplN8Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GIG6x8JiAqqH; Mon,  9 Oct 2023 15:22:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91CDF607F0;
	Mon,  9 Oct 2023 15:22:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91CDF607F0
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 73E901BF364
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Oct 2023 15:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A3F941B71
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Oct 2023 15:22:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A3F941B71
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ORXEFfx1BHHo for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Oct 2023 15:22:48 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A8104194E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Oct 2023 15:22:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A8104194E
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D38C0CE176A;
 Mon,  9 Oct 2023 15:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B787CC433C7;
 Mon,  9 Oct 2023 15:22:44 +0000 (UTC)
Date: Mon, 9 Oct 2023 08:22:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20231009082243.6a195cc1@kernel.org>
In-Reply-To: <ZSEzG0TpTI6W9+tL@nanopsycho>
References: <20231006114101.1608796-1-arkadiusz.kubalewski@intel.com>
 <20231006114101.1608796-3-arkadiusz.kubalewski@intel.com>
 <ZR/9yCVakCrDbBww@nanopsycho> <20231006075536.3b21582e@kernel.org>
 <ZSA7cEEc5nKl07/z@nanopsycho> <20231006124457.26417f37@kernel.org>
 <ZSEzG0TpTI6W9+tL@nanopsycho>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1696864965;
 bh=90Nw7C1r5590JsH2IC90ojg36mM9j5xrkmofzz7IoGE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=p0HeAhKFk41isBvY6kT5E6FaB/5ZFJwCpTABsYgt5p2hJQAxqk/1ECkcIDeJv2MjP
 yTM7tsO8Lj5+ho0w1xdD9s4jM6tS/SJA58YnPQ1cum7HoF8H70UExVNbPAWyjA0t8y
 8h7mqzElVTIazDk57OYNNT4DgWRtKG9hAQ7sxm8iVQIUDILyPx76M9nlPcoNUL4kft
 TyIKYqfIWWG1v1U+gjN8oMAp1+h8W6aLXxFnyDlBa2AoDMiYeIuIxQmm9mkNSG1RAX
 xQtynLCfBZKHljxCOrMwwl0XDwjNJs10rgbfQtwkNRbGQMy+s6Tv5VGYaWINzHEa/B
 gLbPTC9MQimvA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=p0HeAhKF
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 2/5] dpll: spec: add
 support for pin-dpll signal phase offset/adjust
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
Cc: vadim.fedorenko@linux.dev, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, jesse.brandeburg@intel.com,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat, 7 Oct 2023 12:29:47 +0200 Jiri Pirko wrote:
> But since by the policy we cannot break uapi compat, version should be
> never bumped. I wonder howcome it is legit in the examples you listed
> above...

Yes, even it's the 0.0001% of the time when "breaking' uAPI is fine,
the change in the family spec can these days be much more precisely
detected using policy dump.

> Let's forbid that in genetlink.yaml. I have a patch ready, please ack
> this approach.

Ack, please remember to move version into the # Start genetlink-legacy
section in the genetlink-legacy schema.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
