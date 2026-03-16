Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E604F53D91
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Mar 2026 19:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 369F183592;
	Mon, 16 Mar 2026 19:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m0RAPUW2cpkr; Mon, 16 Mar 2026 19:41:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 876E583576
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773690072;
	bh=zAS1USyAQYni2mHN1dHdWcJ/9C2Y6YMcT5syY77rR2E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5IBF+ENtVIG9Udyxt4wllFvAl5AWmWzh+4pSNXgXjV8Vimqt9fvaYoLVaXHebZ07m
	 QAEXevKb7D221BmCdoBmFd5mKF+P5CNl5k9dJxVkfvG3CiAuRoiTt9S1181PbmJSpH
	 8CPn3iOl8Pw2Mp05yCfHoHjAefqzC8akdW/BEh5ANyIHeNVp6+JNEjtpnwDrhgtVVc
	 ymhTujhcEJCcs/vOoJJC41JZDvb3/H4+slHIuoKKz9acG0qR2b43E0Aiie+HiwCcN4
	 p1ekKgbcFMILCbIG7wtd+NcXeM8xHKjRmY8IFwNM7Q18VHqc8MycxAI1EBaqj8TeQB
	 9Zl2WbG/CWBPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 876E583576;
	Mon, 16 Mar 2026 19:41:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B1483BE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 19:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CAE183576
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 19:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1EWhA--RgGp for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Mar 2026 19:41:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6330B834EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6330B834EF
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6330B834EF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 19:41:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A7584385E;
 Mon, 16 Mar 2026 19:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBBCC19421;
 Mon, 16 Mar 2026 19:41:08 +0000 (UTC)
Date: Mon, 16 Mar 2026 12:41:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>
Message-ID: <20260316124107.0dd3cc2b@kernel.org>
In-Reply-To: <878cd07a-b7fb-491a-9cec-8ddbab2bb13b@intel.com>
References: <20260313150917.271086-1-marco.crivellari@suse.com>
 <0ca7f92b-ec4e-469c-ad2b-648d278bcfe9@intel.com>
 <20260314091048.235a6d0b@kernel.org>
 <878cd07a-b7fb-491a-9cec-8ddbab2bb13b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773690069;
 bh=+r/rKSDJHKoEyUKWlrdPrbGCuVC2E2OzQyf0nGl0zCc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=t6gf85r8cnydejSet9c0sttbHQI2BMNRJUEL4LM4qSqlCJPzzGrYam2YVn67iGS6l
 UsQQkMIXKR/3xG0sCF3Wxa4rzDUn8mCMroPEAiHofQNkMgtxKsvXC5lI6kVEmpsmnA
 qSraGb/SPn2C47x4f/prj3MqR7r6mTTJFdCNdgPhrjnCRGyyOSKsN/UJFO60tGmw3b
 9qcfktfmvpFSoaPZl/ufmkfdQYL2LDdO7qV7v7psaivdxOReDjwVRD+NozCIzeAzPa
 Pf5gxG1Aq5ju6cAFsij9yibQ2GqLAQM7cFvAxE+zIwfMaj7Y8qQYql8y4xa9qf/MJW
 Qoo16doqzV/Tg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=t6gf85r8
Subject: Re: [Intel-wired-lan] [PATCH] idpf: Replace use of
 system_unbound_wq with system_dfl_wq
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

On Mon, 16 Mar 2026 09:58:29 -0700 Tony Nguyen wrote:
> On 3/14/2026 9:10 AM, Jakub Kicinski wrote:
> > On Fri, 13 Mar 2026 17:08:57 +0100 Przemek Kitszel wrote:  
> >> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>  
> > 
> > Process question - even tho you are also a maintainer I only read
> > Tony's tags as "please apply directly". LMK if that's right, I'll
> > try to remember / make a note..  
> 
> I talked to Przemek about this a little this morning. Since the 
> Reviewed-by tag is used more prevalently in our process, perhaps an 
> Acked-by could mean take this directly and the Reviewed-by keeps the 
> same process of going through IWL. Other thought would be to explicitly 
> ask/state for it to get taken directly. Open to other ideas as well if 
> there's something else you'd prefer.

Sounds complicated :S Let me continue ignoring Przemek's tags for the
purpose of direct application. I guess it's more about who sends the
PRs than who is a maintainer. If you send PRs I naturally never see
your review tags, as the patches will eventually come out with your SoB.
