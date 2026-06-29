Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579D6C43458
	for <intel-wired-lan@archiver.kernel.org>; Mon, 29 Jun 2026 22:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2AB460EA8;
	Mon, 29 Jun 2026 22:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZrbZNiYO3IgL; Mon, 29 Jun 2026 22:53:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F14060D6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782773630;
	bh=mQm2Cpdl7FUXTMgD3IZug5m2bpmaRdES+acA5DhlVW4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V2Yym9ZUi34pVVvR6vYgsvtfQGlndvPRQ6Yh4vTb3VDbMl5AFYRZDK7dlFokEVwmI
	 MuxnS4vur99h7klnjNOYg4h5WqCaJGit2aDSWvWRWPN+ObxbM4ijCQZ1I27cmrb+dt
	 R/bdt85qWZ5U1hyLsBLkCxkKvm/yCGwXn1ED2FEVi++7F0ERFLKauS6u7fCQFHRCT2
	 6tGy8yJLGHWiWFa91AkxCYZHceU+3dxnKnlyGWsa/cCd9VdskddvXXDod9qd4SD73m
	 +joomAmpWMpEtACD10OPBdtzORyaixFsSUnZULlO1kvhy9sQSFf+DWxetzjlfbTYSQ
	 3fFbpgaLheFtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F14060D6E;
	Mon, 29 Jun 2026 22:53:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CFFE42F3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 29 Jun 2026 22:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE36040B70
 for <intel-wired-lan@lists.osuosl.org>; Mon, 29 Jun 2026 22:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uoHsz-Zc52s6 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 29 Jun 2026 22:53:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C843D40B37
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C843D40B37
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C843D40B37
 for <intel-wired-lan@lists.osuosl.org>; Mon, 29 Jun 2026 22:53:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A444860008;
 Mon, 29 Jun 2026 22:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9011F000E9;
 Mon, 29 Jun 2026 22:53:44 +0000 (UTC)
Date: Mon, 29 Jun 2026 15:53:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Message-ID: <20260629155343.7fed8291@kernel.org>
In-Reply-To: <IA3PR11MB8986053B156CBA043045A525E5E82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
 <20260626054730.1126969-3-aleksandr.loktionov@intel.com>
 <20260626152636.1e48330f@kernel.org>
 <IA3PR11MB8986053B156CBA043045A525E5E82@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1782773624;
 bh=mQm2Cpdl7FUXTMgD3IZug5m2bpmaRdES+acA5DhlVW4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cLrLjUsmPAx7ouea3DL7B/uiISyRyGu/yohUtSjZxm+ui87QxAUY07QcQjR5/9gQK
 yZdMROLg5kPBQJhSdl4yqRvOfTgS+gBLjaJeZ5ER22d9U23qA9ZkSsR3fXohvIgTkW
 isdMP3VY97vwVLQGF+uzHGwU5EDoJxZTedQL3THu2gb5hFquDeE5L7/hPG9mDpUy3p
 If0rZpIHe3iJrMjpfu2RHcGFf0UW2G1fTJZphfhglXBsWb3DT6Hd2R/4lxJMCBQo4I
 b8L2ejeIy8pSI20BTJ8CV9yH7TJdrk3bR8sBlMuUhZ41IuzP0orlrt0/VvA69SbZpD
 yfZtthA7mbVXA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cLrLjUsm
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 2/2] ice: implement
 symmetric RSS hash configuration
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

On Mon, 29 Jun 2026 14:10:08 +0000 Loktionov, Aleksandr wrote:
> I understood on TEID; I will drop the ethtool core patch.
> 
> One question before respinning the ice feature patch: ice GTP RSS profiles
> include TEID in the hardware hash fields. Since TEID is not generally
> symmetric across UL/DL, should the driver:
> 
>   1. report RXH_GTP_TEID honestly and let the core reject symmetric-xor
>      when GTP flow types are part of the preflight check;
> 
>   2. hide RXH_GTP_TEID while symmetric-xor is enabled, even though that
>      misrepresents the hardware hash input;
> 
>   3. reject symmetric-xor for configurations where GTP profiles include
>      TEID; or
> 
>   4. change/program the ice GTP profile, if possible, to exclude TEID
>      under symmetric-xor?
> 
> My preference is (1) or (3), but I do not want to encode the wrong uAPI
> semantics.

Do you have access to any GTP experts?
If your customers want the TEID in the symmetric hash then they
probably know better what makes sense than me after reading about it
for 1 minute.
We may just need a better commit message on the first patch "TEID is
intrinsically symmetric" is not true.
Or maybe the driver / profiles are not doing the right thing.
Please dig deeper.
