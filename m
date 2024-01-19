Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCD4C47DD9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 19 Jan 2024 16:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5231942233;
	Fri, 19 Jan 2024 16:56:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5231942233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1705683387;
	bh=SQUKONGoWdAHVRsEe6eu+EyEXoZMs+WL+t1WEvot4Ok=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=1XUMfwb05Ow+8GxC5H5BN09ndERCZ5eLWxLosX2izJ6S/CxJRWItqYnoDvde2njR9
	 7it0eLZ3d+mTfRTnxee8e6voYp/dcncYEeUprTMWPTbF1DcfrFc0NWUS3QhqrzLM2f
	 4m+uI9OPZti83d4DbYHS83qfucpaFYvLURi+ZCs+ilquDOb7qrGchqyCvxwf7Y5xXX
	 VdzOF6ipB6teX+q6iH47Eo+R5N/qxx2FPtk0bzYDAc/IO614tNxr3slDYlWguG2yc1
	 Mrs05wTZD6Eg0ELolxrkRjamaXXJB+CI7BGdZFWF1WdJENEdr9lKgQ/nOuj7ajnCOZ
	 NcBwrdq9Bhc9w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nLs8FYWKhw9S; Fri, 19 Jan 2024 16:56:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88A984226A;
	Fri, 19 Jan 2024 16:56:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88A984226A
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 517711BF341
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 16:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 335AC42266
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 16:55:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 335AC42266
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PJDmm8EtniHk for <intel-wired-lan@lists.osuosl.org>;
 Fri, 19 Jan 2024 16:55:39 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9931242233
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 16:55:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9931242233
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D5A4961A0D;
 Fri, 19 Jan 2024 16:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2062BC433C7;
 Fri, 19 Jan 2024 16:55:36 +0000 (UTC)
Date: Fri, 19 Jan 2024 16:55:33 +0000
From: Simon Horman <horms@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Message-ID: <20240119165533.GH89683@kernel.org>
References: <20240108124717.1845481-1-karol.kolacinski@intel.com>
 <20240108124717.1845481-2-karol.kolacinski@intel.com>
 <20240115103240.GL392144@kernel.org>
 <CO1PR11MB50899045B5B747FC216134EAD6722@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB50899045B5B747FC216134EAD6722@CO1PR11MB5089.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1705683338;
 bh=zuZJZKU61xlL1EYFlogSl4Y/yFeVXu+b3DlM0oRVXpU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l8nYkOMXzmqavT++E3STkO2oLudpyFxMEKVL6E5xSgb+s+uKdG/25BACXS99GkWeY
 AXsB/CTSZzXzHpK4SsfdJsHxQQIMIhIPS5nXDnWlTY8+uMSB6pdk9B+Pe0fgCyA/3O
 7KBZ7XpmXk4528NzKbPyQgGQH8NkfDWs/ea1ngqlajBsPKmdKNdvwD/cjKzxhhZnNI
 g1XGgXgC0SvCiPv9C+HeSp46kUT6W84FleszYU/eKyiMWkFBRTxKIv6kZq/SjTxQrD
 0GBsFBbR8j684vlkQpssggm9nPrsXykoHo7KRI59/PUMDd8SnrZvCGVSIXeCXVLEVx
 Ts22fJF3HjxOg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=l8nYkOMX
Subject: Re: [Intel-wired-lan] [PATCH v5 iwl-next 1/6] ice: introduce PTP
 state machine
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
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski,
 Karol" <karol.kolacinski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jan 17, 2024 at 10:07:52PM +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Monday, January 15, 2024 2:33 AM
> > To: Kolacinski, Karol <karol.kolacinski@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> > <jesse.brandeburg@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>
> > Subject: Re: [PATCH v5 iwl-next 1/6] ice: introduce PTP state machine
> > 
> > On Mon, Jan 08, 2024 at 01:47:12PM +0100, Karol Kolacinski wrote:
> > 
> > Should there be a "From: Jacob" line here to
> > match the Signed-off-by below?
> > 
> > > Add PTP state machine so that the driver can correctly identify PTP
> > > state around resets.
> > > When the driver got information about ungraceful reset, PTP was not
> > > prepared for reset and it returned error. When this situation occurs,
> > > prepare PTP before rebuilding its structures.
> > >
> > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > 
> > Hi Karol and Jacob,
> > 
> > FWIIW, The combination of both a Signed-off-by and Reviewed-by tag from
> > Jacob seems a little odd to me. If he authored the patch then I would have
> > gone with the following (along with the From line mentioned above):
> > 
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > 
> > Otherwise, if he reviewed the patch I would have gone with:
> > 
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > 
> 
> It's a bit odd, because I authored the initial code and patches some time ago, and Karol has been working to rebase and re-organize the code, so in some sense he authored part of this. I think a Co-authored would be suitable here. Additionally, I reviewed the result before it was published here.

Understood. I agree Co-authored might be useful here.
