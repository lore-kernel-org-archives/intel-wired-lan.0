Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1568DC6FA8F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Aug 2023 13:07:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D3EE41503;
	Thu, 24 Aug 2023 13:07:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D3EE41503
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692882445;
	bh=ztCt3d0AxpSa4riapGMa9cbDE9nv6XvIAGR11zMWvBE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n2yNkxICST4P+pRpwHYz8iz3zY94NiJO8MEK4xAIr9YZchSy5eIjbRrcRxztuDmWk
	 ThJdzz84vZXwI7ZXC1MHQkK/Kzb4rD1FfZCvM/6J0dQpMk8aywaHPSN1QrMatPTDM8
	 Ev6TYuHYthwf0/em7hVpt88lj4aYt//ejK0rEt6nr/o+7O44hNx28lJIamqYqJSjPA
	 usYAqylAa/gRKrTFRT9PMNrxZ7Iq4X4M01vX3h+07M7++bFks6+htO43ps4i5dFaiy
	 THPjkqfFPjfSYflsTknFyfLSANZocjYdFYBCQb6j2yBKR9y/hFVjBXGTA1xSjvOt1w
	 taiHLVDW2YLZA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6QzSRz8KSOip; Thu, 24 Aug 2023 13:07:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2C5441518;
	Thu, 24 Aug 2023 13:07:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2C5441518
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 3EE491BF350
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 13:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 246CF41518
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 13:07:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 246CF41518
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6zUlJzxfzNOj for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Aug 2023 13:07:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE35941503
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 13:07:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE35941503
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-VSJHMx4oOSuBZJPCHD69qA-1; Thu, 24 Aug 2023 09:07:15 -0400
X-MC-Unique: VSJHMx4oOSuBZJPCHD69qA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E208B85306A;
 Thu, 24 Aug 2023 13:07:14 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.193.96])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8F7B140E962;
 Thu, 24 Aug 2023 13:07:14 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 840CCA80D37; Thu, 24 Aug 2023 15:07:13 +0200 (CEST)
Date: Thu, 24 Aug 2023 15:07:13 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org
Message-ID: <ZOdWAdHNJzDs5ss7@calimero.vinschen.de>
Mail-Followup-To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org
References: <20230824091603.3188249-1-vinschen@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230824091603.3188249-1-vinschen@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1692882440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1e2gcSKM0RWJFngfRKh1E1DqSYSdDGZTpOJKj7pdFlo=;
 b=SpG9Xzj0J0VWkUq/vVmsOsDMgaR0RnqCVaYCTCe9WFTafUL7jT3STxRqeTDMIZmoWs/UDV
 vdD3CX4/G9k3g+Xmr/O4OCe6Q7vuHgw6y5+GZcHPDiKPcPLX247arZwHt6cUxDK9k8BD+V
 T5yJ9Xtr2BeSqgITrWb2SNY1+KhbYF4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SpG9Xzj0
Subject: Re: [Intel-wired-lan] [PATCH net] igb: clean up in all error paths
 when enabling SR-IOV
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Question to the Intel folks:

On Aug 24 11:16, Corinna Vinschen wrote:
> After commit 50f303496d92 ("igb: Enable SR-IOV after reinit"), removing
> the igb module could hang or crash (depending on the machine) when the
> module has been loaded with the max_vfs parameter set to some value != 0.
> 
> In case of one test machine with a dual port 82580, this hang occured:
> [...]
> The reproducer was a simple script:
> 
>   #!/bin/sh
>   for i in `seq 1 5`; do
>     modprobe -rv igb
>     modprobe -v igb max_vfs=1
>     sleep 1
>     modprobe -rv igb
>   done
> 
> It turned out that this could only be reproduce on 82580 (quad and
> dual-port), but not on 82576, i350 and i210.  Further debugging showed
> that igb_enable_sriov()'s call to pci_enable_sriov() is failing, because
> dev->is_physfn is 0 on 82580.

Along these lines, isn't the first and foremost bug that igb_enable_sriov()
has been called for this NIC at all?  In terms of patches, shouldn't the
guard expression in igb_probe_vfs()

        /* Virtualization features not supported on i210 family. */
	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211))
		return;

get changed to:

        /* Virtualization features not supported on i210 and 82580 family. */
	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211) ||
	    (hw->mac.type == e1000_82580))
		return;

or, to make it independent of the actual HW:

        /* Virtualization features not supported? */
	if (!pdev->is_physfn)
		return;


Thanks,
Corinna

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
