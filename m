Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DC0FB44D9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Apr 2026 08:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35B7642360;
	Fri, 24 Apr 2026 08:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ze4KkldVHG_7; Fri, 24 Apr 2026 08:32:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B49B842367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777019551;
	bh=VJsfL0ZYr6ksiH6VKINKLh9cflWXlJdEnCTwwmMW534=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OYMuqsi9yX7sekg8bu7D5LdGocWxyuC/cxLXM2re4VHx37CoA/20hn8CIVuv4U1qv
	 BJLonvABbkFooa3oO/r2nfpofe7ehqYV/wbd+P19FRKtA65dMzIG7558cDeHn7XPGU
	 PsLyZQGIOXF+8ImHWshr4BsA2ZF6eI03+mfNC+jMzwZAfuFsbA17zcGN9MBR6aoOw6
	 SKF/gg3XJLkgPVITLMpq67QoQKiX7LQjeb/i0n4MFVhx6Lbw+5S9S/hEiwhpusGNKc
	 U3YcBfiroIe59hEVGXKHA3iYbdXGI3aZNW0HMUAnu2tnEsa9osVwV7eybO4n+GXtxp
	 Wbtv7EQO0gOSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B49B842367;
	Fri, 24 Apr 2026 08:32:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 08EB2231
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 08:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EED9242367
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 08:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1uEjz1HBCay for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Apr 2026 08:32:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=vinschen@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4246742360
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4246742360
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4246742360
 for <intel-wired-lan@osuosl.org>; Fri, 24 Apr 2026 08:32:24 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-ewUZX9sePIKYDg19RBQe5A-1; Fri,
 24 Apr 2026 04:32:19 -0400
X-MC-Unique: ewUZX9sePIKYDg19RBQe5A-1
X-Mimecast-MFC-AGG-ID: ewUZX9sePIKYDg19RBQe5A_1777019538
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB87E1800578; Fri, 24 Apr 2026 08:32:17 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.44.32.45])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68CDB19560AB; Fri, 24 Apr 2026 08:32:17 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C0469A80BFD; Fri, 24 Apr 2026 10:32:14 +0200 (CEST)
Date: Fri, 24 Apr 2026 10:32:14 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@osuosl.org, stable@vger.kernel.org,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 netdev@vger.kernel.org, Corinna Vinschen <vinschen@redhat.com>
Message-ID: <aesqjovwYNeLlfX4@calimero.vinschen.de>
Mail-Followup-To: Simon Horman <horms@kernel.org>,
 intel-wired-lan@osuosl.org, stable@vger.kernel.org,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 netdev@vger.kernel.org
References: <IA3PR11MB898664A49E614F197D4FED6EE52C2@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260421111236.875379-1-vinschen@redhat.com>
 <20260423185530.GI900403@horms.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260423185530.GI900403@horms.kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ikc8P_SL9paTEYabDM3FOaJ4wMMZgf-gSrQfZSEAoCQ_1777019538
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1777019543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VJsfL0ZYr6ksiH6VKINKLh9cflWXlJdEnCTwwmMW534=;
 b=BguoAUtS9RwjeXVxIdyJ7uYL9emrpcDsP8J4JmAo6n2WAaNBSE5gYhN62lRykutzKGXcCN
 /FSjHQfXhFGRByWfrLEfc31W4/d7MWOlm/U5j09bxRqejXFKY9PFHSD8vj0A96PgYSPuDa
 yjNUFZm+tbGEYDgF1iOCgIFKmBrHhS4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=BguoAUtS
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: iavf_virtchnl_completion:
 drop duplicate ether_addr_equal() test
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

On Apr 23 19:55, Simon Horman wrote:
> On Tue, Apr 21, 2026 at 01:12:36PM +0200, Corinna Vinschen wrote:
> > This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
> > waiting for response from PF in set mac") introduced a duplicate
> > ether_addr_equal() check, so the current code tests the new MAC twice
> > against the former MAC.
> > 
> > Remove the outer ether_addr_equal() test, remnant of commit c5c922b3e09b
> > ("iavf: fix MAC address setting for VFs when filter is rejected")
> > 
> > Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> > Fixes: 35a2443d0910f ("iavf: Add waiting for response from PF in set mac")
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > ---
> > Added CC: stable@vger.kernel.org
> 
> Hi,
> 
> This feels more like a cleanup for net-next (without a Fixes tag)
> than a fix for net. I'm missing where the bug is here.

Yeah, it's not a bug, the "Fixes" tag was just supposed to point out the
patch introducing the duplicate test.

Shall I create a v3 or is it ok as is and just goes to net-next instead
of net?


Thanks,
Corinna

