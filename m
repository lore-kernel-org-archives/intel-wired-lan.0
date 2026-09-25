Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5899CC9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 17:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1178A81314;
	Fri, 25 Sep 2026 17:23:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 25pRqyiQqfw7; Fri, 25 Sep 2026 17:23:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8257F81204
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790356996;
	b=OUXqj39UooxfeuCL9uXL1zSI868bj/0/wDzGGA1iHMvhxE1zr80jGX+AgVbL7RozWTqm
	 H3Cm0Sb+aiH9ejAZEtV/b0r+tJpzGkwMVvt16YOy+ItnFRZTVSTTaJlGez7y+BJh4aB2K
	 cJlNTa6hyhkdZ48zPPtrBo+XMyeWrFeSzAn2ZmvESt9dp6fy5h2x525Vug7Ue4f/UDrP/
	 HsOrjwB374iyjAePWktlcxREEB84pGWEBy9tUhWy5PPstCKkh+XMBePTcV3WF13q6b6oH
	 PG22+GzfmdRxV5D2APxonXYNATk0qvFuNWR3TDL52t3MYJg6juOn8v1H5x4fLRTXT4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790356996;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DTh7DNLRr+3CSPxIbFtt2TL5Gzzya7YGrc2URbuFKeY=;
	b=N6pqEGGvceYjgC432+Iyas+47tsSQ6Jid7GLu8jdzTNNVpl+eB3NgWnYutOU/KI7G4Ym
	 S/F8dHMpvDBb3RybdAIB64lNWAxthtntxAgvAshkRmBL9peUmNOmqtHOPV68YI4vYz9Fm
	 HmygoNVfM/kywEgz5ubBin120zAu7iKP/73Nm/CEozq0P3QMcRFFYW9jXzwpdtt6HS2Gy
	 MgsYnZKReo96NV+bUqrVl7nmHnyGKYZhDZ5jBGL/Of+ZEfvesAGtP1HbkEFopMdC71540
	 dPYoP8PvJdViQRXfpJ+r8m70Q+Zzr8wBOBtU/hzb4ihI7lTPMB7wl9yjCi78BLObDTg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790356996;
	bh=DTh7DNLRr+3CSPxIbFtt2TL5Gzzya7YGrc2URbuFKeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dhEjpMVA31W7r3U2IRiQVU8e30WkcKxAMg2fgkHG2tBOxeCCKZt1GFMrk2A/tS2I1
	 BVuDuHsmPmPaVr1AHUM6cCmCaG6oWMAd0XrRIDVI87tf7WNl37xwlWDkT97SYH5s83
	 2blCOaXIs2pRtja7wAqR8kbmD1cBdRV3/MMGjzwxiAzspZJ9tPayzs5P/4aKsgEs76
	 VydSPECvdGnme2EDvIDNvuf0Es4d28K1uB/2zXr+61Z0MLZyBba2hjHCGk84MP3ElC
	 TsA6RIgdaAY41YOstcA2r4dDekSR6Eclr8ta+jUriMFBpsi1worpDZF9QnVtg9Z/7b
	 U2vxJDj2RytRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8257F81204;
	Fri, 25 Sep 2026 17:23:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3C34F48
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5D1F400E0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:23:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wyBEPiSbwa_E for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 17:23:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 46C894049E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790356994;
 b=CjSikHAKtI8bwu6islNfqPIelTyouYkLfVlfXqrVyw3JB2sSlv/djg045Qzet3EAbmbZ
 YEK7GEavvZF54qXma7dStQmXg9BJXqjKsGHYPcPJkKmnipMkL/YRENG1hx5ZfC1uXiB/j
 PAksAx1XCzSHaPfZ3/YSifKIYIauRS/q94wmNNw69uZ1etbPfTLUGRfEZMaka+u4QfXzK
 A6OgDtxw1Y8t9biLSi701JvEc4/WMzx9I3aO/IY60SDS5btqcnACP+KOflJ3jvCDuT5AC
 WpVxc7GwNuxs/voGExXfo2bNArGXK+6i3MwB54mOuiFmQH3h9SxhhBIH/1axEWmkO8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790356994;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=DTh7DNLRr+3CSPxIbFtt2TL5Gzzya7YGrc2URbuFKeY=;
 b=cHTuehOWRdVNlrlHxna3W2WLlAQQI8NoP6XxxjxEwV/x4O3YmHyQDR2sMTLVk78h79he
 CK9Ip2FLqy9cNRyYOr7NGEEABeMnXPH3GtqFwFzaJb7mWonID/9PRIcJPqNH8inJs6NNw
 I64KLO6pToy5syOR4MZEF0voNsoguHZadIN86j7k6XqW8Y3Bl2bkvDx/1+fS5O9veHyrc
 PZxsosLKB3ooFl423A1xj07LIqDN6SXm38XPtSGGYXbBMidrOSw6j2zHQCtq0g1CK+wzH
 +Yjrt8K5Pqa4VCoyVUzpW25lhDZPzOLxuDe76eZ9p/6C7JTvfetdQoyqQd7LzQk5QsQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jM+Q2N7F; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jM+Q2N7F
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46C894049E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:23:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DED8E60136;
 Fri, 25 Sep 2026 17:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC05B1F000FF;
 Fri, 25 Sep 2026 17:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790356991;
 bh=DTh7DNLRr+3CSPxIbFtt2TL5Gzzya7YGrc2URbuFKeY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jM+Q2N7Fb+9d4JXOOtn53QTBZKoG67uwoulY9YOd8JU7gKKWo/hN299LZaFgmSLc0
 2UevsDahhyu+cvcnNim4Y/X+biqjblson2vAfq7zahpC8fxM2MUezud1mhEh/Eiw2E
 Z/OCsr5H9+8uf7NewWnaryB2GslngZMndvQcsE8JBHwXUVF5IC9yO7GFL7LKLe48q1
 o3sVmzkkYL1oXtFrzpWzPWKmf93C73QwzF2nYIIrftmCW40lYnJoSolhNpjN0q/RZp
 5yxENE1XAASg9HpYH3peu2v+4OTHyeBiC7k5HcCwKZIXLItUcIoxqCxz7jus7qY5/l
 GArDIEOpP6vqg==
Date: Fri, 25 Sep 2026 18:23:08 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 2/4] ixgbe: Fix FCoE refcount taking for
 unsupported adapters
Message-ID: <20260925172308.GT13925@horms.kernel.org>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
 <20260922113558.2288111-3-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922113558.2288111-3-sergey.temerkhanov@intel.com>
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

On Tue, Sep 22, 2026 at 11:35:56AM +0000, Sergey Temerkhanov wrote:
> ixgbe_fcoe_enable() increments the FCoE reference count before
> checking whether the device supports FCoE. The unsupported adapters
> shall not take a reference while the ones which have FCoE already
> enabled only need to skip hardware initialization.
> 
> Fixes: 27ab76065c0c ("ixgbe: add a refcnt when turning on/off FCoE offload capability")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

