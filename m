Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16CEFD5F61
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 05:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6900E40FC6;
	Wed,  8 Apr 2026 05:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l_t5MYlRr1pK; Wed,  8 Apr 2026 05:46:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1AC1540FBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775627210;
	bh=tXgGblwJ6MWfOgQonI39yePcbLskYtFY5TKuv6vaijY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uucN1y15RXD5PPDDGGlZKwiDF1qU6kAKADTxXtofHs+amFASzGHNeAP1hlJ797d0a
	 VcCqr1fh08QExYoTyYL9DD73WYWVtFK0LwQWiXdLTsbl63pCiLqQDuEebDifosbDhK
	 S679SNAjlYMT3pUEKQgWdHQ8CkU/02skQKMk5bzLdSBO3ilgQNwnEnqwKw1hE+CLXX
	 cLOZSVV2+6WdAXSGqMk8QLzrjDj0eizDYaQqgmRX0WanD3ddEMPIolfusAmXL199GE
	 evsnLg+42/4i9eAnENxjRS6S81OpNi+/0zwRi6aYvltrloKvzAKA1/xDlDYuwSVs6S
	 CwFfVYfnyiB0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AC1540FBE;
	Wed,  8 Apr 2026 05:46:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CEBB51F6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 05:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABCF3400E2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 05:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nXbK-mkH_JGZ for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 05:46:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B544E4002D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B544E4002D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B544E4002D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 05:46:45 +0000 (UTC)
X-CSE-ConnectionGUID: 1HFE6tZJSwqoaR93WkEEvg==
X-CSE-MsgGUID: DAxOYscXRLKu6N0sKgP5tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76494675"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76494675"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 22:46:45 -0700
X-CSE-ConnectionGUID: cEu5HsZmT4eMX7SgNLPhug==
X-CSE-MsgGUID: lrYWmM22Q2qrL8itfzuw+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="232745623"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 22:46:41 -0700
Date: Wed, 8 Apr 2026 07:42:52 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>, stable@vger.kernel.org
Message-ID: <adXq3Nq15B1kIvdZ@mev-dev.igk.intel.com>
References: <20260406145641.1020623-1-jtornosm@redhat.com>
 <88c37486-70aa-4109-a5b1-ee74cce23bc5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c37486-70aa-4109-a5b1-ee74cce23bc5@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775627207; x=1807163207;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=E4uU7VhDySTu/ApRmmn1LxcYG6u2WBIH8FMFN4v/WNk=;
 b=HCybrsrFOflnTmFPRXG8nHbThaSdDxxfCVG1bq+dTEefIsm0CLjo6g4s
 Sq6S+Zz+LQRqairDPHoN3fhULS/uj0jpO/1Kpvd3bqiUY31WJgR8IOjjN
 InD6mZVFY+0uNzLyo4qLDhb+zNKRCGU+6Vt6JN0p7qOs6SBtRcC6lm8vP
 EgO3VGvOCH2/bZES/zb/8LnjeKxlATwyARYSaqBkTTQ+LqodTTx31qxzf
 qw1FCrWuLXgGUil+UMnW7NW1AJff2JJ4k0NQnh7b7kyjV7dRv6/rOb03K
 UVR3MK6j6RvZ7lV+xisTYwDebj/ptVMVGZ8y9UdmyPa0qeQfnoYrQR+Al
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HCybrsrF
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix VF queue configuration
 with low MTU values
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

On Tue, Apr 07, 2026 at 03:50:32PM -0700, Jacob Keller wrote:
> On 4/6/2026 7:56 AM, Jose Ignacio Tornos Martinez wrote:
> > The ice driver's VF queue configuration validation rejects
> > databuffer_size values below 1024 bytes, which prevents VFs from
> > using MTU values below 871 bytes.
> > 
> > The iavf driver calculates databuffer_size based on the MTU using:
> >   databuffer_size = ALIGN(MTU + LIBETH_RX_LL_LEN, 128)
> > 
> > where LIBETH_RX_LL_LEN = 26 (ETH_HLEN + 2*VLAN_HLEN + ETH_FCS_LEN).
> > 
> > For MTU values below 871:
> >   MTU 870: 870 + 26 = 896, aligned to 128 = 896 (< 1024, rejected)
> >   MTU 871: 871 + 26 = 897, aligned to 128 = 1024 (>= 1024, accepted)
> > 
> > The 1024-byte minimum seems unnecessarily restrictive, because the hardware
> > supports databuffer_size as low as 128 bytes (the alignment boundary),
> > which should allow MTU values down to the standard minimum of 68 bytes.
> > 
> > I haven't found the reason why the limit was configured in the commit
> > 9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message"), so
> > with no more information and since it is working, change the minimum
> > databuffer_size validation from 1024 to 128 bytes to allow standard low
> > MTU values while still preventing invalid configurations.
> > 
> 
> I dug through some of our internal history and found that there was no
> justification on why 1024 was chosen.

I can't remember why I choose 1024 and didn't mention it in commit
message. I agree that it is unnecessarily restrictive.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 
> I agree with your assessment that the value of 128 makes the most sense
> as it is the actual hardware minimum. I wonder if we used to always use
> data buffer sizes of 1024 before the conversion to libeth. Either way, I
> think it makes sense to allow smaller buffers since the modern iAVF will
> request them.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> > Fixes: 9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message")
> > cc: stable@vger.kernel.org
> > Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/ice/virt/queues.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
> > index f73d5a3e83d4..31be2f76181c 100644
> > --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> > +++ b/drivers/net/ethernet/intel/ice/virt/queues.c
> > @@ -840,7 +840,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
> >  
> >  			if (qpi->rxq.databuffer_size != 0 &&
> >  			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
> > -			     qpi->rxq.databuffer_size < 1024))
> > +			     qpi->rxq.databuffer_size < 128))
> >  				goto error_param;
> >  
> >  			ring->rx_buf_len = qpi->rxq.databuffer_size;
