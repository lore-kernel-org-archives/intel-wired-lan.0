Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAF8C4321E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Nov 2022 13:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F06F40441;
	Tue, 29 Nov 2022 13:31:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F06F40441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1669728693;
	bh=EykT0Ke2rUVRFqZ2eHdwxTq9hE8rn1yXlUXwyG1KYZI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=o93I1c/Bx+T97b/p43kG685G2YiJ2/HXI8lEh3mi1l11hjgYQDCFCPlS1emO9gqr5
	 u26xRi+dyo5XZQ7DXjtIIW0LiRHG9zJHHJF4/KQ7hgNGoh6ZpAEr8DCCpOHIoQTdQ/
	 KGtLlSbPQ8GvEFaj4nzaK8YjPe530kNHjA5iiUyBrzu3WPZ0h4n2Minmu8nYU633kN
	 lInRLpQddohxAgF+iapzzCMWjwyCcpQkSqRNKrI2MJCpJlpbpXE//3Y6S1YoLmB6uy
	 nZKthvMkvVnYsQrOoCiHiH2bejff61PlWN4nIxfAhygzXWRTr1M3rQLJk5V4S1NfRX
	 /8YwXgETvlLSw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mrqEsuqCIRZW; Tue, 29 Nov 2022 13:31:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A676409EA;
	Tue, 29 Nov 2022 13:31:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A676409EA
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C75301BF41A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Nov 2022 13:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FC6F401FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Nov 2022 13:31:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FC6F401FD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HWoYwqI7Z3UV for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Nov 2022 13:31:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2D104018E
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2D104018E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Nov 2022 13:31:29 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316941062"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; d="scan'208";a="316941062"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2022 05:31:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="888843473"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; d="scan'208";a="888843473"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
 by fmsmga006.fm.intel.com with ESMTP; 29 Nov 2022 05:31:23 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com
 [10.102.20.203])
 by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id
 2ATDVMWd026263; Tue, 29 Nov 2022 13:31:22 GMT
From: Alexander Lobakin <alexandr.lobakin@intel.com>
To: "Wilczynski, Michal" <michal.wilczynski@intel.com>
Date: Tue, 29 Nov 2022 14:30:32 +0100
Message-Id: <20221129133032.3084152-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <074d1d3b-41e8-55a9-8c9b-0002e3d7f60d@intel.com>
References: <20221128214749.110-1-paul.m.stillwell.jr@intel.com>
 <20221128214749.110-4-paul.m.stillwell.jr@intel.com>
 <074d1d3b-41e8-55a9-8c9b-0002e3d7f60d@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669728689; x=1701264689;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xjVGIP03vO2wra5epNwzdgITL6lHO8uFoZLol1w5eTY=;
 b=hEnXqMWCHchSxYqufAFBXPXo93tOiYysKtLW4Vn+VLKjxLYKDce6GrV3
 fdfq5JorjcF+/tQ5gDGeyjS702Jye4uOeIsYPFf1N3THuJV79kO/laLyo
 XF/vAY6tojW9H4yrTRYQuwZHnuVQ0XfmPZai1RVHdwvUTgtvnr3+J0HZo
 ypNdIVnFm5xp7Rftlr4+DkV6bg2ig586DSUS96gKzOMABS608WqUNj4QR
 oHyxsFOin7d940YuJyQj4W+XrYpkhNLYv7icjGmf+ou+XPoPlEXWSWIaa
 4EGZLEwG5VzroOomLRCWcLvxkrqaAOdhxq6sXBGpHVAnLLMGjoaby2c5r
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hEnXqMWC
Subject: Re: [Intel-wired-lan] [PATCH net-next 3/5] ice: add ability to
 query/set FW log level and resolution
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
Cc: intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: "Wilczynski, Michal" <michal.wilczynski@intel.com>
Date: Tue, 29 Nov 2022 12:48:25 +0100

> On 11/28/2022 10:47 PM, Paul M Stillwell Jr wrote:
> > The E8xx has the ability to change the FW log level and
> > the granularity at which the logs get output. Enable
> > the ability to see what the current values are and to
> > change them.
> >
> > Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

[...]

> > +	/* send the cfg to FW and register for events */
> > +	status = ice_fwlog_set(hw, &hw->fwlog_cfg);
> > +	if (status)
> > +		return status;
> > +
> > +	if (hw->fwlog_ena) {
> > +		status = ice_fwlog_register(hw);
> > +		if (status)
> > +			return status;
> > +	} else {
> > +		status = ice_fwlog_unregister(hw);
> > +		if (status)
> > +			return status;
> > +	}
> 
> This could be simplified i.e
> 
> if (hw->fwlog_ena) {
> 	status = ice_fwlog_register(hw);
> else 
>         status = ice_fwlog_unregister(hw);
> 
> 	return status;

	return hw->fwlog_ena ? ice_fwlog_register(hw) : ice_fwlog_unregister(hw);
> 
> 
> > +
> > +	return 0;
> > +}

[...]

Thanks,
Olek
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
