Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3452C2BD09
	for <intel-wired-lan@archiver.kernel.org>; Tue,  9 Jul 2024 07:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA2AA40E80;
	Tue,  9 Jul 2024 07:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WgKOzHEneBL1; Tue,  9 Jul 2024 07:42:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89EF340E72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1720510960;
	bh=FJZgvgQA75xzsAsrq5KoxO+L5yCGhMO5nS2m28hlGKo=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BP1J7PShR2buVoFWq88bC/dwbHYj6Lssrrq3BY29JwGEt8UJHr82SkkmSHKTJ71fS
	 VW1PV/jUHuZrhbXQ2/HCO4zmLCkn9d4pEKutT5uBYShDgstrdlWmmVG9gm8j/5Uw0C
	 5ezYPW+8JCdOLesxukrWSnkX1mJ0FwABYujm7W4pow0c3kHQLg9Jhidt0NKs2rFDGW
	 ZgkajTnhYAS+d9jSsx3Df+jsMVFoiL0vjxLDxCHRqNYhgFGgh4BvqdpTpgA/Gq3C2k
	 HtuLJNsbAXM3iUYflh1wYeu2KDr+us8HcW+sfwjV8boW8pHKEW1PSgYk3DUkzOWCj+
	 9h2tM/Yz9VKAw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89EF340E72;
	Tue,  9 Jul 2024 07:42:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 8ED361BF86C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Jul 2024 07:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84AFE40632
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Jul 2024 07:42:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PmHIJyHGsujq for <intel-wired-lan@lists.osuosl.org>;
 Tue,  9 Jul 2024 07:42:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0DF4F409B2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DF4F409B2
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0DF4F409B2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Jul 2024 07:42:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B0E37CE0CE2;
 Tue,  9 Jul 2024 07:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917D6C3277B;
 Tue,  9 Jul 2024 07:42:32 +0000 (UTC)
Date: Tue, 9 Jul 2024 08:42:30 +0100
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Message-ID: <20240709074230.GC346094@kernel.org>
References: <20240625184953.621684-1-aleksandr.loktionov@intel.com>
 <20240627173351.GH3104@kernel.org>
 <SJ0PR11MB5866CE95533821CC0D31282CE5DA2@SJ0PR11MB5866.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5866CE95533821CC0D31282CE5DA2@SJ0PR11MB5866.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1720510953;
 bh=GBeiqwlDsV0o6ErL7k4rlnz6KPezop0q6y37fiUHMvE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uSVLd1Zf6Tw2tO56UV/zCO9rhYfXQs/UUHdj5anLA8C2OvR/mtn4QZCRbB2V5TWVl
 n2/mXtgxY5fy6ssu05acW4dZgOFG8cMnjI5xUnymS+a4khfz+vwxKaqOKp9tmc6Y0J
 vctxqnxPtCOVTCMzk1UQic5QRnbocea7WRG7lSPj4KhGBU9mOy3LuZ+dBr/6AsMsk4
 8SeG8D+FlQyXu/B14Z1jDnh2MP/VqyAXVlKnJmoD3P2TfIXsxf62nHFhBHRPTzepQv
 ymPR6ger9Nah84bmO+9nzo+T1lRJq+u4bz54e8g26PCjzSWrYXnNgWIl2jW/ty7iuy
 8M8fIACPQ4ZBw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uSVLd1Zf
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5] i40e: fix: remove needless
 retries of NVM update
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
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Kang, Kelvin" <kelvin.kang@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jul 08, 2024 at 03:38:11PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Simon Horman
> > Sent: Thursday, June 27, 2024 7:34 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kang, Kelvin
> > <kelvin.kang@intel.com>; Kubalewski, Arkadiusz
> > <arkadiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org
> > Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5] i40e: fix: remove
> > needless retries of NVM update
> > 
> > On Tue, Jun 25, 2024 at 08:49:53PM +0200, Aleksandr Loktionov wrote:
> > > Remove wrong EIO to EGAIN conversion and pass all errors as is.
> > >
> > > After commit 230f3d53a547 ("i40e: remove i40e_status"), which should
> > > only replace F/W specific error codes with Linux kernel generic, all
> > > EIO errors suddenly started to be converted into EAGAIN which leads
> > > nvmupdate to retry until it timeouts and sometimes fails after more
> > > than 20 minutes in the middle of NVM update, so NVM becomes
> > corrupted.
> > >
> > > The bug affects users only at the time when they try to update NVM,
> > > and only F/W versions that generate errors while nvmupdate. For
> > > example, X710DA2 with 0x8000ECB7 F/W is affected, but there are
> > probably more...
> > >
> > > Command for reproduction is just NVM update:
> > >  ./nvmupdate64
> > >
> > > In the log instead of:
> > >  i40e_nvmupd_exec_aq err I40E_ERR_ADMIN_QUEUE_ERROR aq_err
> > > I40E_AQ_RC_ENOMEM)
> > > appears:
> > >  i40e_nvmupd_exec_aq err -EIO aq_err I40E_AQ_RC_ENOMEM
> > >  i40e: eeprom check failed (-5), Tx/Rx traffic disabled
> > >
> > > The problematic code did silently convert EIO into EAGAIN which
> > forced
> > > nvmupdate to ignore EAGAIN error and retry the same operation until
> > timeout.
> > > That's why NVM update takes 20+ minutes to finish with the fail in
> > the end.
> > >
> > > Fixes: 230f3d53a547 ("i40e: remove i40e_status")
> > > Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
> > > Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
> > > Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> > > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > 
> > Hi Aleksandr,
> > 
> > Maybe I'm reading things wrong, I have concerns :(
> > 
> > Amongst other things, the cited commit:
> > 1. Maps a number of different I40E_ERR_* values to -EIO; and 2. Maps
> > checks on different I40E_ERR_* values to -EIO
> > 
> > My concern is that the code may now incorrectly match against -EIO for
> > cases where it would not have previously matched when more specific
> > error codes.
> > 
> > In the case at hand:
> > 1. -EIO is returned in place of I40E_ERR_ADMIN_QUEUE_ERROR 2.
> > i40e_aq_rc_to_posix checks for -EIO in place of
> > I40E_ERR_ADMIN_QUEUE_TIMEOUT
> > 
> > As you point out, we are now in a bad place.
> > Which your patch addresses.
> > 
> > But what about a different case where:
> > 1. -EIO is returned in place of I40E_ERR_ADMIN_QUEUE_TIMEOUT 2.
> > i40e_aq_rc_to_posix checks for -EIO in place of
> > I40E_ERR_ADMIN_QUEUE_TIMEOUT
> > 
> > In this scenario the, the code without your patch is correct, and with
> > your patch it seems incorrect.
> > 
> > Perhaps only the scenario you are fixing occurs.
> > If so, all good. But it's not obvious to me that is the case.
> > 
> > I'm likewise concerned by other conditions on -EIO introduced by the
> > cited commit.
> 
> This commit do not introduce -EIO errors.
> Before 230f3d53a547 ("i40e: remove i40e_status") some specific F/W error codes were
> converted into -EAGAIN by i40e_aq_rc_to_posix(), but now all error codes are already
> Linux kernel codes, so there is no way to distinguish special F/W codes and convert
> them into -EAGAIN.

Right, this last part is the nub of my concern.

> Our validation has been tested regressions of current patch and gave signed off.
> 
> Do you propose change 
> 	if (aq_ret == -EIO)
> 		return -EAGAIN;
> into
> 
> 	if (aq_ret == -EIO)
> 		return -EIO;
> ?
> 
> It will require additional testing...

If the problem I described is indeed a problem then a suspect a more
invasive change is required, to differentiate between the different
cases previously covered by internal error codes.

However, that is speculation on my part.
While your patch has been tested.

So I suggest, contrary to my previous email, that this patch moves forwards.

IOW, I am not blocking progress of this patch (anymore).

...
