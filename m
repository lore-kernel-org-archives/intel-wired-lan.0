Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F3510987A9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 16:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54AF261BAC;
	Fri, 20 Mar 2026 16:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u3CXB0UrWEd7; Fri, 20 Mar 2026 16:55:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9453361BA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774025731;
	bh=GWE7a9BsVv3lM+FOwmabC864qF5a1Tkom2fREJIkC5U=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W7miVFy1a9Pl07YSk+y1QYo9z3DY637svLGSDMlmJepbOOcjjDEYLdb7ApBJQX1yV
	 xftm5BjOmqK2u9udl+fO4wnrABbtdD0BLhs+5VYRpmXtQAQTGgT+NDgn5HcVc7oyZo
	 QW5qGREC+Bk6rByWqUeA9MCu/9EXB0vuKjQ8Tktsqqc2qoW0+2e/1hrLAoZkH1yFP4
	 aQ0hbP4GoaxObZnslwfWH4mTHlzo/pZEBvCHDcBur5gPyuT0Z79DTSh7w/j5IqEmR1
	 BqdAFH5H6y3XaTtmbdo0Nh6IC9CEhhS90Y0FNfY/aReyZRBr3nyvcLCHqJSdwPjqQk
	 qKI9cLurPuGGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9453361BA9;
	Fri, 20 Mar 2026 16:55:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 95928265
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 16:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B14A61BA9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 16:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hf7dfd86a5oJ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 16:55:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 94FE961BA7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94FE961BA7
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94FE961BA7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 16:55:28 +0000 (UTC)
Received: from x1 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62KGt2Qj017124
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 21 Mar 2026 01:55:03 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Sat, 21 Mar 2026 01:55:01 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <ab148uuvjby_nMMW@x1>
References: <20260320160707.3047815-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320160707.3047815-1-bvanassche@acm.org>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=GWE7a9BsVv3lM+FOwmabC864qF5a1Tkom2fREJIkC5U=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1774025703; v=1;
 b=MpmmoCibtMchXyW21Pse9JiCYr0v+KsnOYGbx2vMx9DrWPaO7nQfVuXgZZlFYnP5
 pOg4V4/ynGdePAAOTvXub7OTJCONgwYoCr2x+AEXx8oubc6wEP9sFZOxTcQ1YxCy
 FKsDrqS5SU1dRbIqT6veLVbrqAAJ7YLU5SILueM9FEQuTUimME6kyrIkGSVJ+3gb
 +7Wq9S2DWc45/Z0WP5ntbL9ggrqKWOskpxqvAsuw8BpWP3JWM9WvN8Ayb8rpPq6m
 qjueE3JrGuF9U3cyr4ZNXIEPGmrPulMo526jecGkM7yncg7pBYbv2BpsW/osBH7C
 u0VtPFfXPiuBkjSKnBLnmQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=MpmmoCib
Subject: Re: [Intel-wired-lan] [PATCH] iwl-net: ice: fix locking in
 ice_dcb_rebuild()
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

On 03/20 09:07, Bart Van Assche via Intel-wired-lan wrote:
> Move the mutex_lock() call up to prevent that DCB settings change after
> the first ice_query_port_ets() call. The second ice_query_port_ets()
> call in ice_dcb_rebuild() is already protected by pf->tc_mutex.
> 
> This also fixes a bug in an error path, as before taking the first
> "goto dcb_error" in the function jumped over mutex_lock() to
> mutex_unlock().
> 
> This bug has been detected by the clang thread-safety analyzer.

nit:
I believe the subject should be 
  [PATCH iwl-net] ice: fix locking in ice_dcb_rebuild()
since iwl-net is the target tree name.
