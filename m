Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C272FC7EE24
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Jun 2023 07:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5124541606;
	Tue,  6 Jun 2023 07:08:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5124541606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686035291;
	bh=rLE+WNDsjLfHnklyo66eC7FcVyGvyg5gErJLemAx49A=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gIL5MZiylTG2Fh1P9ME/YrEvBG9iIaL/ugzy1zsH4yd/gZp+I1ihy3kYHrytjMRti
	 iJQuLOpqpHQgKYM5oJ49tA18V6/hCZHXhIF4RcioLTYg8ENWGfr7QwDCTmf+yhdzfJ
	 hkARC5qfyf1ayNb0CcDxH9Q26Z6fDf7ODOVk3b/GEj25VpR0oszHm5KYcZxxbGWXIJ
	 82zOUaNGRDOh6BLBFmc6f7g5EzPcW+AtrgKtTw132oFC+q4A78M5IdkUfzdkUezD9X
	 33ZGTwQHo2iQvNWR07SntdI/JINL1fA+NDr69rf1NO21SS5hxW0x+5IrDApoTriWQA
	 9Hylfawek8VHA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yipTw-Gfy2_b; Tue,  6 Jun 2023 07:08:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 168D5415C0;
	Tue,  6 Jun 2023 07:08:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 168D5415C0
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id B289E1BF312
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Jun 2023 07:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8871B415C0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Jun 2023 07:08:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8871B415C0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qd7i1776EURR for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Jun 2023 07:08:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E05C41558
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E05C41558
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Jun 2023 07:08:07 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-IUnCGvnPO0isETKcR10cVQ-1; Tue, 06 Jun 2023 03:08:03 -0400
X-MC-Unique: IUnCGvnPO0isETKcR10cVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96A368030CF;
 Tue,  6 Jun 2023 07:08:02 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 726CE40D1B68;
 Tue,  6 Jun 2023 07:08:01 +0000 (UTC)
Date: Tue, 6 Jun 2023 09:08:00 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Message-ID: <ZH7bUKKxocyhajad@localhost>
References: <20230606013325.602823-1-vinicius.gomes@intel.com>
 <20230606013325.602823-4-vinicius.gomes@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230606013325.602823-4-vinicius.gomes@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1686035286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m8rvFJHfEaNjTBoE3zCPCqqTq2duZYfUwZbHxDKzqL8=;
 b=SzFFomf8kSEdIsVqsVTDkvWHF81UgYhdhIU9UmLkSdE8czNoaAXshviQZzwWGf6XVfW1h4
 aulMUfZwxF9mnweEzcjSKZ2WNZXVBqkHNnYqoDMzyw4Ej8kuwR42uNZHRRTQ0t9Pclmsn0
 jeJRqz46cKy+tQhjccD/0DYTO8CIf/o=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SzFFomf8
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3 3/4] igc: Retrieve TX
 timestamp during interrupt handling
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
Cc: kurt@linutronix.de, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, vladimir.oltean@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jun 05, 2023 at 06:33:24PM -0700, Vinicius Costa Gomes wrote:
> After:
> 
> $ sudo ./ntpperf -i enp3s0 -m 10:22:22:22:22:21 -d 192.168.1.3 -s 172.18.0.0/16 -I -H -o -37
>                |          responses            |     TX timestamp offset (ns)
> rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
> 1000       100   0.00%   0.00%   0.00% 100.00%      -44      +0     +61     19
> 1500       150   0.00%   0.00%   0.00% 100.00%       -6     +39     +81     16
> 2250       225   0.00%   0.00%   0.00% 100.00%      -22     +25     +69     15
> 3375       337   0.00%   0.00%   0.00% 100.00%      -28     +15     +56     14
> 5062       506   0.00%   0.00%   0.00% 100.00%       +7     +78    +143     27
> 7593       759   0.00%   0.00%   0.00% 100.00%      -54     +24    +144     47
> 11389     1138   0.00%   0.00%   0.00% 100.00%      -90     -33     +28     21
> 17083     1708   0.00%   0.00%   0.00% 100.00%      -50      -2     +35     14
> 25624     2562   0.00%   0.00%   0.00% 100.00%      -62      +7     +66     23
> 38436     3843   0.00%   0.00%   0.00% 100.00%      -33     +30   +5395     36
> 57654     5765   0.00%   0.00% 100.00%   0.00%
> 86481     8648   0.00%   0.00% 100.00%   0.00%
> 129721   12972   0.00%   0.00% 100.00%   0.00%

Just a comment about this test. The reason why it goes from 100%
xleave to 100% basic is that the number of clients becomes larger than
the number of transmit timestamps that the server can hold. To keep
xleave working at higher rates and see the TX timestamp stats it is
necessary to increase clientloglimit in the server chrony.conf.

-- 
Miroslav Lichvar

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
