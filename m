Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5C60A3826
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=pcgL8pKw;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SpNJgNFE;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SpNJgNFE;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SpNJgNFE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2964080965;
	Fri, 23 Oct 2026 07:03:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kn1ukwOSJqxv; Fri, 23 Oct 2026 07:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD8F6811AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792739020;
	b=SKQONMTSoc+GgGGS374cf5mmgnnRsDJcIFMjlbZIKViouvajHMWgL4dwHJWD2sc88tek
	 hSLtiE3amDUw+2Bthx+d4P/6R5GefmXLR11QCq0NYEpw4NdWB88BknlZP7yKmnSxiljY3
	 B9IEehkSAYFrevT0XWYzdkokFcLuSACCborlQMZ4+xCY6/HwEEug1B269dd3O6t1nsamj
	 XE811kdMD/pYVGeFiZakjko2r9vxeBMpmdV7upq+F4W5H0jhwFRkJufAKfcPE/PnFvACK
	 s22ZwdD3WLvI5klCKeoveg8HWJnlZElHhE3B1olu2iNqM8QN8CVBQLU4cVQvQlDnd9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792739020;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B3shNEDjuUwcpKjXRsnXS7RhQC6J74iRWt0CSQLzqFg=;
	b=Sxzwtsb6qjKpCNoCER6+qkCtT3WQzaqIJT3Yfruvnm7eeqHZrAygvVxU/wFeaInRMmrf
	 CDy6n+txIsqQXe3N0U9Yzd35tuV5DFjoSRgOItA4az9zxhmMjXXa4CbF1dujC+TJOZNwj
	 SrzFozqQ0CV1i8b9bMNuFuo2h+ii20QBPdIqVhKH9tgcDKtd5ISHwRWycA57V5l4rktHs
	 +mJB7YQBPwBL/+EJP341sQE5XUdQ5JrbdlNtVZsyUzwcWiT1oESF5dGWjjHqsYVIFQzf5
	 ivdjX8pojYqCPEB8qpk6y1I2pgiqen5Z3DrYCqTyEa39rirxloo1d0yl+fyLRwNVL/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792739019;
	bh=B3shNEDjuUwcpKjXRsnXS7RhQC6J74iRWt0CSQLzqFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pcgL8pKwfzle6EUTlbTeZdf9ZtjPkWEjJXqkVGEotF3A2pt1JapyCIDS0pYEMKUTi
	 Ko7/1eXWPkWUPxQwYw3I5A688ZWTrJqGm0n/7ydlF76HKbt5I+F4LP5QYTFIY0BSyL
	 Bqgs9CQpK2nz/ndYDAuzrg97meFLCa09sSzlHAqagSSn/tdS6ltL+aWfMp4Pgm+sVS
	 J6vTCzr0LghFPpg6Npm1aiYS9BMDV5TL8noURMwuUlkgtpV/diWy7+t1Lw8ahnAZXL
	 KrhyCzq/OtxsKGdkqzUZPA6JPjgDPlu1ryytjcX9DCI6zAZqoq+d7PXOOwr+ITUaak
	 eBaSXu5tZFQvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD8F6811AD;
	Fri, 23 Oct 2026 07:03:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C9DCA3C1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B04E7400D0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5lS4ytvdwNu for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 07:03:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4F71D400AD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792739016;
 b=eivtKjt5AAOaIeJdaGSzRhEOHhBTrUqdoxWFIKg9OpQGW3TWjtjZUxKHEzs76s8PQFSQ
 rkHGRnkD/Zhh6Hhij/p6k0OGuLOXUDJszt5MUip7jl/11NDOHeFsgZsDXuGszy3F9vJ70
 /edP3BaSQ6mbmvLTqCyJSQT3V1prp6A2e/XdF3TnNoWx9jSh4ppdzrG1+v3zVhm0BTNgv
 6IXg0DAcHdlhxjS1sGQxFQnuizYA4rswMPSWkUhUHJJa0FvUyqtBhLYRdUL6l2xS3QSgA
 MczpZVCqGX59pVh2THBEGmAasgIot+feDD0tFBG31D6Q+mQpjaCiFNny7pcxcRYmghg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792739016;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:
 X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=B3shNEDjuUwcpKjXRsnXS7RhQC6J74iRWt0CSQLzqFg=;
 b=OBdRW0EN2c3Z1QhS3hH2/USpAgS47cg+2I7pGDMb24pXWGT2Put4DEkPCjCINAuDApS4
 bA5+Ua73c+vQ+lqnmWdMZIeTTtG14YSJ1QJemtZG1dgs20XVJ01+QbJ3ObIvTwfmZ3C5m
 5YdcqXrd9KdvO/5g3UXyus9ZdwJX8jIkzoN7JUWDZ9ZYpw7uEBQXgecU4F9nIFDD66j0d
 epkNsIb6W9IVTX2SMUMxNTSmSm8KWjOS0s277ZqIklwWTGE2Z/rHH0sQMpKwnFQEhsUYC
 8kcMz2zAmpwoQ5b3Z1U1Et3UmniQ3LuVngid2KFMqTsmuICoGnU7TEs5xvcrjwn8xvA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=SpNJgNFE; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=SpNJgNFE; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=SpNJgNFE; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SpNJgNFE; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SpNJgNFE; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SpNJgNFE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F71D400AD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792739014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3shNEDjuUwcpKjXRsnXS7RhQC6J74iRWt0CSQLzqFg=;
 b=SpNJgNFEDAU5+FqpMeM68+EwsXhFI0amJ9K6RpUV3EgJcTjtVmxiqnwvB8kv7EaSQMHUW7
 xkJUeACjrND4nRRUaShOlAnOl4qUNOZIvfoybEU8jJ85BhsAtbBzY5DZ9/dcNzXpQaZkLX
 D74/9MfozjFOFMgjYdmQ7iOftQxefhc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792739014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3shNEDjuUwcpKjXRsnXS7RhQC6J74iRWt0CSQLzqFg=;
 b=SpNJgNFEDAU5+FqpMeM68+EwsXhFI0amJ9K6RpUV3EgJcTjtVmxiqnwvB8kv7EaSQMHUW7
 xkJUeACjrND4nRRUaShOlAnOl4qUNOZIvfoybEU8jJ85BhsAtbBzY5DZ9/dcNzXpQaZkLX
 D74/9MfozjFOFMgjYdmQ7iOftQxefhc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792739014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3shNEDjuUwcpKjXRsnXS7RhQC6J74iRWt0CSQLzqFg=;
 b=SpNJgNFEDAU5+FqpMeM68+EwsXhFI0amJ9K6RpUV3EgJcTjtVmxiqnwvB8kv7EaSQMHUW7
 xkJUeACjrND4nRRUaShOlAnOl4qUNOZIvfoybEU8jJ85BhsAtbBzY5DZ9/dcNzXpQaZkLX
 D74/9MfozjFOFMgjYdmQ7iOftQxefhc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-fu1ueY5fOzam0k5vJFb-qA-1; Fri,
 23 Oct 2026 03:03:28 -0400
X-MC-Unique: fu1ueY5fOzam0k5vJFb-qA-1
X-Mimecast-MFC-AGG-ID: fu1ueY5fOzam0k5vJFb-qA_1792739005
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 691AC1956094; Fri, 23 Oct 2026 07:03:25 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92C6E1800347; Fri, 23 Oct 2026 07:03:20 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Dave Ertman <david.m.ertman@intel.com>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 Leon Romanovsky <leon@kernel.org>,
 Rafal Rogalski <rafalx.rogalski@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: [PATCH iwl-net v2 3/5] ice: avoid RTNL deadlock when notifying the
 RDMA auxiliary driver
Date: Fri, 23 Oct 2026 09:02:55 +0200
Message-ID: <20261023070258.730168-4-poros@redhat.com>
In-Reply-To: <20261023070258.730168-1-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: yHoZkctx-xm82NmifcjWtq8lFVoHR8NRzGVf9RpQq1E_1792739005
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_send_event_to_aux() blocks on the auxiliary device lock, and the
dcbnl callers reach it with the RTNL lock held. The RDMA auxiliary probe
takes the two in the opposite order, because __driver_attach() holds the
auxiliary device lock across ib_register_device(), which needs the RTNL
lock:

  systemd-udevd   state:D
    really_probe                  <- holds device_lock(&adev->dev)
    icrdma_probe
    irdma_ib_register_device
    ib_register_device
    setup_device
    irdma_roce_port_immutable
    ib_query_port
    irdma_query_port
    ib_get_eth_speed              <- blocks on rtnl_lock()

  lldpad          state:D
    rtnetlink_rcv_msg             <- holds rtnl_lock()
    dcb_doit
    dcbnl_ieee_set
    ice_dcbnl_setets
    ice_pf_dcb_cfg
    ice_send_event_to_aux         <- blocks on device_lock(&adev->dev)

Everything else that needs the RTNL lock piles up behind lldpad and the
boot never completes. The probe side cannot be changed, so take the
auxiliary device lock with device_trylock() around the event and let the
caller decide what to do when it is contended.

The DCB reconfiguration sends IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, on which
the RDMA driver suspends its queue pairs, and
IIDC_RDMA_EVENT_AFTER_TC_CHANGE, on which it resumes them. Neither can be
dropped, the first would change the traffic classes behind the RDMA
driver's back and the second would leave its queue pairs suspended. So
ice_pf_dcb_cfg() takes the locks once before the first event, keeps them
across the whole reconfiguration and sends the second event before
releasing them. The driver core holds the lock while it binds, unbinds or
suspends the auxiliary device and in a few of its sysfs handlers, and the
request is then refused with -EBUSY. The RTNL lock is taken before the
auxiliary locks also for the callers that did not hold it, so every path
takes the two in the same order, and the first event is delivered with
the RTNL lock held on those paths too, as it already was for the dcbnl
callers. The second event is now sent on the error paths too, which used
to leave the queue pairs suspended after a failed commit.
ice_pf_dcb_recfg() still sends the second event on its own for the LLDP
MIB change path, which sends no first event, so a dropped one is ignored
by the RDMA driver there.

ice_pf_dcb_recfg() runs the fallback for non-contiguous traffic classes
only when the caller does not hold the locks. That fallback is a nested
ice_pf_dcb_cfg() and would block on pf->adev_mutex, so ice_pf_dcb_cfg()
runs it after it has released the locks. The other caller that passes
locked, ice_vsi_recfg_qs(), already held pf->adev_mutex there and would
have deadlocked the same way through ice_send_event_to_aux().

ice_pf_dcb_cfg() already returns -EBUSY when the custom Tx scheduler is
enabled, so the refused request takes the same path through its callers.

The critical error and MTU change events are sent from the service task,
which consumes their pending bits before sending, so those are re-armed
instead. The critical error event takes the locks before it consumes
pf->oicr_err_reg, so a contended lock leaves the register value to the
next run instead of merging it back underneath the interrupt handler.

Fixes: 348048e724a0 ("ice: Implement iidc operations")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- hold the auxiliary device locks across the whole DCB reconfiguration
  and send AFTER_TC_CHANGE under them instead of fire and forget
- take the RTNL lock before the auxiliary locks also for the callers
  that did not hold it
- send AFTER_TC_CHANGE on the error paths of ice_pf_dcb_cfg() too
- add ice_aux_dev_trylock() and ice_aux_dev_unlock(), the callers of
  ice_send_event_to_aux() hold the locks
- take the locks before consuming pf->oicr_err_reg in the service task
  instead of merging the value back when the lock is contended
- run the fallback for non-contiguous traffic classes after the locks
  are released, it is a nested ice_pf_dcb_cfg()

v1: https://lore.kernel.org/all/20261019065301.3983537-2-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 46 ++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_idc.c     | 48 ++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_idc_int.h |  2 +
 drivers/net/ethernet/intel/ice/ice_main.c    | 14 ++++--
 4 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 0bc6dd37568792..9916bd408071c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -5,6 +5,9 @@
 #include "ice_dcb_nl.h"
 #include "devlink/devlink.h"
 
+static bool ice_dcb_tc_contig(u8 *prio_table);
+static int ice_dcb_noncontig_cfg(struct ice_pf *pf);
+
 /**
  * ice_dcb_get_ena_tc - return bitmap of enabled TCs
  * @dcbcfg: DCB config to evaluate for enabled TCs
@@ -352,11 +355,16 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 	struct ice_aqc_port_ets_elem buf = { 0 };
 	struct ice_dcbx_cfg *old_cfg, *curr_cfg;
 	struct device *dev = ice_pf_to_dev(pf);
+	struct iidc_rdma_priv_dev_info *privd;
+	struct iidc_rdma_core_dev_info *cdev;
 	struct iidc_rdma_event *event;
 	int ret = ICE_DCB_NO_HW_CHG;
 	struct ice_vsi *pf_vsi;
+	bool noncontig = false;
+	bool dcb_ena;
 
 	curr_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
+	dcb_ena = test_bit(ICE_FLAG_DCB_ENA, pf->flags);
 
 	/* FW does not care if change happened */
 	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
@@ -405,16 +413,21 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 		goto free_cfg;
 	}
 
-	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
-	ice_send_event_to_aux(pf, event);
-	kfree(event);
-
 	/* avoid race conditions by holding the lock while disabling and
 	 * re-enabling the VSI
 	 */
 	if (!locked)
 		rtnl_lock();
 
+	if (!ice_aux_dev_trylock(pf)) {
+		assign_bit(ICE_FLAG_DCB_ENA, pf->flags, dcb_ena);
+		ret = -EBUSY;
+		goto unlock_rtnl;
+	}
+
+	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
+	ice_send_event_to_aux(pf, event);
+
 	/* disable VSIs affected by DCB changes */
 	ice_dcb_ena_dis_vsi(pf, false, true);
 
@@ -441,13 +454,28 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 		goto out;
 	}
 
-	ice_pf_dcb_recfg(pf, false);
+	ice_pf_dcb_recfg(pf, true);
+	noncontig = !ice_dcb_tc_contig(curr_cfg->etscfg.prio_table);
 
 out:
+	cdev = pf->cdev_info;
+	if (cdev) {
+		privd = cdev->iidc_priv;
+		ice_setup_dcb_qos_info(pf, &privd->qos_info);
+	}
+	clear_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
+	set_bit(IIDC_RDMA_EVENT_AFTER_TC_CHANGE, event->type);
+	ice_send_event_to_aux(pf, event);
+	ice_aux_dev_unlock(pf);
+
 	/* enable previously downed VSIs */
 	ice_dcb_ena_dis_vsi(pf, true, true);
+	if (noncontig)
+		ice_dcb_noncontig_cfg(pf);
+unlock_rtnl:
 	if (!locked)
 		rtnl_unlock();
+	kfree(event);
 free_cfg:
 	kfree(old_cfg);
 	return ret;
@@ -761,7 +789,8 @@ void ice_pf_dcb_recfg(struct ice_pf *pf, bool locked)
 			 */
 			if (!ice_dcb_tc_contig(dcbcfg->etscfg.prio_table)) {
 				tc_map = ICE_DFLT_TRAFFIC_CLASS;
-				ice_dcb_noncontig_cfg(pf);
+				if (!locked)
+					ice_dcb_noncontig_cfg(pf);
 			}
 		} else if (vsi->type == ICE_VSI_CHNL) {
 			tc_map = BIT(ice_get_first_droptc(vsi));
@@ -796,7 +825,10 @@ void ice_pf_dcb_recfg(struct ice_pf *pf, bool locked)
 			return;
 
 		set_bit(IIDC_RDMA_EVENT_AFTER_TC_CHANGE, event->type);
-		ice_send_event_to_aux(pf, event);
+		if (ice_aux_dev_trylock(pf)) {
+			ice_send_event_to_aux(pf, event);
+			ice_aux_dev_unlock(pf);
+		}
 		kfree(event);
 	}
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 102d63c3018b1f..018e7f4d46ae9a 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -30,34 +30,62 @@ ice_get_auxiliary_drv(struct iidc_rdma_core_dev_info *cdev)
 			    struct iidc_rdma_core_auxiliary_drv, adrv.driver);
 }
 
+/**
+ * ice_aux_dev_trylock - take the locks that guard the RDMA AUX driver
+ * @pf: pointer to PF struct
+ *
+ * Return: true when the locks are held, false when the auxiliary device lock
+ * was contended and nothing is held.
+ */
+bool ice_aux_dev_trylock(struct ice_pf *pf)
+{
+	struct iidc_rdma_core_dev_info *cdev = pf->cdev_info;
+
+	mutex_lock(&pf->adev_mutex);
+	if (cdev && cdev->adev && !device_trylock(&cdev->adev->dev)) {
+		mutex_unlock(&pf->adev_mutex);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * ice_aux_dev_unlock - release the locks taken by ice_aux_dev_trylock()
+ * @pf: pointer to PF struct
+ */
+void ice_aux_dev_unlock(struct ice_pf *pf)
+{
+	struct iidc_rdma_core_dev_info *cdev = pf->cdev_info;
+
+	if (cdev && cdev->adev)
+		device_unlock(&cdev->adev->dev);
+	mutex_unlock(&pf->adev_mutex);
+}
+
 /**
  * ice_send_event_to_aux - send event to RDMA AUX driver
  * @pf: pointer to PF struct
  * @event: event struct
+ *
+ * The caller holds the locks taken by ice_aux_dev_trylock().
  */
 void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *event)
 {
+	struct iidc_rdma_core_dev_info *cdev = pf->cdev_info;
 	struct iidc_rdma_core_auxiliary_drv *iadrv;
-	struct iidc_rdma_core_dev_info *cdev;
 
 	if (WARN_ON_ONCE(!in_task()))
 		return;
 
-	cdev = pf->cdev_info;
+	lockdep_assert_held(&pf->adev_mutex);
+
 	if (!cdev)
 		return;
 
-	mutex_lock(&pf->adev_mutex);
-	if (!cdev->adev)
-		goto finish;
-
-	device_lock(&cdev->adev->dev);
 	iadrv = ice_get_auxiliary_drv(cdev);
 	if (iadrv && iadrv->event_handler)
 		iadrv->event_handler(cdev, event);
-	device_unlock(&cdev->adev->dev);
-finish:
-	mutex_unlock(&pf->adev_mutex);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_idc_int.h b/drivers/net/ethernet/intel/ice/ice_idc_int.h
index 17dbfcfb6a2aff..4cccb4764271ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc_int.h
+++ b/drivers/net/ethernet/intel/ice/ice_idc_int.h
@@ -9,6 +9,8 @@
 
 struct ice_pf;
 
+bool ice_aux_dev_trylock(struct ice_pf *pf);
+void ice_aux_dev_unlock(struct ice_pf *pf);
 void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *event);
 
 #endif /* !_ICE_IDC_INT_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8693ca285d5f1e..9de375f5c4deb5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2313,13 +2313,16 @@ static void ice_service_task(struct work_struct *work)
 		struct iidc_rdma_event *event;
 
 		event = kzalloc_obj(*event);
-		if (event) {
+		if (event && ice_aux_dev_trylock(pf)) {
 			set_bit(IIDC_RDMA_EVENT_CRIT_ERR, event->type);
 			/* report the entire OICR value to AUX driver */
 			swap(event->reg, pf->oicr_err_reg);
 			ice_send_event_to_aux(pf, event);
-			kfree(event);
+			ice_aux_dev_unlock(pf);
+		} else {
+			set_bit(ICE_AUX_ERR_PENDING, pf->state);
 		}
+		kfree(event);
 	}
 
 	/* unplug aux dev per request, if an unplug request came in
@@ -2336,11 +2339,14 @@ static void ice_service_task(struct work_struct *work)
 		struct iidc_rdma_event *event;
 
 		event = kzalloc_obj(*event);
-		if (event) {
+		if (event && ice_aux_dev_trylock(pf)) {
 			set_bit(IIDC_RDMA_EVENT_AFTER_MTU_CHANGE, event->type);
 			ice_send_event_to_aux(pf, event);
-			kfree(event);
+			ice_aux_dev_unlock(pf);
+		} else {
+			set_bit(ICE_FLAG_MTU_CHANGED, pf->flags);
 		}
+		kfree(event);
 	}
 
 	ice_clean_adminq_subtask(pf);
-- 
2.56.0

