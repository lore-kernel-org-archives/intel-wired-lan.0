Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947C6CD4F5E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 May 2026 11:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50BD241D85;
	Thu, 21 May 2026 11:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9b_GNwm7LeVq; Thu, 21 May 2026 11:44:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C86741D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779363885;
	bh=iNnbfmHcW0NGw442nS2PoBdygOAsR81qw2FLANfMcw0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m5ib6dW9pKfy8PbzanENAYv7PVPIdfPrugtVx7N3582PB1g1lGdf5bvCb1HDiPf7a
	 6i+p1x395d+CxxX8cmKrW5CDYnqpj8joop1Ht/c5aBFDiSou+gfkOLbnvdoMPp1lme
	 LDYRK8cQIXerxRrNUdxK93UpOZ7GgdEOkxEfwL+pg7FMFalcxocy1R+jXg9yyH48dl
	 hr8AvSNlggfSEmlmYe+LGGslMVYRij09otXw2ZdISRECF4pD+heLqgFV8Nq4XKX7Rp
	 EJ8UfTwDTnxO2LN1ZrJAXFMJgkoXN1p/C2NY61Uwq/coaXTxApX9O2kbIMNLvnt5cb
	 /6OgY4/tu1rZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C86741D1E;
	Thu, 21 May 2026 11:44:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C52AC265
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 11:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B693A41549
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 11:44:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oL_PtmN12PiC for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 May 2026 11:44:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1E03B41547
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E03B41547
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E03B41547
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 11:44:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3CD743889;
 Thu, 21 May 2026 11:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601E61F000E9;
 Thu, 21 May 2026 11:44:41 +0000 (UTC)
Date: Thu, 21 May 2026 12:44:38 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260521114438.GD1506108@horms.kernel.org>
References: <20260518123611.2252139-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518123611.2252139-1-jedrzej.jagielski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1779363882;
 bh=iNnbfmHcW0NGw442nS2PoBdygOAsR81qw2FLANfMcw0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oB87bd3FrVyGHG1FvoPIaplTVUD0KiT7JNCyKbXKCLK2vTlz/ihHKzxOM9mbbYTfm
 0WLP/u1QMEFP10NPXnKWdnxeK5f+rlfTQt30rp24wnKJFKY/374651ypMQkXwPYEkl
 SEn+lB/CnsiIvctF8CIrzoz6Sy+z6hMckJTQBla3gdzpZVS8GczProzYBMPCuOC38c
 v+QXnA5N/fs0dnC8cWJkoioAWmWFn9PstLu1KFobKmhsqxk++uc41z4YLbCZS0XJfe
 hEF4N0YGzzPbNuDNxzr/o91WnzCvBYgJpEx29eJSGV4GNtyJbgvRe7s4PukWddTfBJ
 JlAO6J/A3uOVg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=oB87bd3F
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: LinkSec deprecated
 macros cleanup
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

On Mon, May 18, 2026 at 02:36:11PM +0200, Jedrzej Jagielski wrote:
> There are some unused LinkSec macros. Get rid of them.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

