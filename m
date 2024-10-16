Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB78FD20688
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Oct 2024 00:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FF6A80F27;
	Wed, 16 Oct 2024 00:46:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PKMYJaKu0tUc; Wed, 16 Oct 2024 00:46:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8D3580F2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729039573;
	bh=zEjGwpg/IScQOaN7zCd5hwxzn8o9GQCIHOfkiXr5xnQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xeAnfRmbt5vkAQlGwHycwnf40A8LehmgWDDM8kGlyGkEiPJclK6KE/TjVJ5ixoO3a
	 L1HGVhR98k4idosiAKEKgTNwA5eFeWY3uzjhDeDjSqjYY053+Ff/yVCkuD3P301W0o
	 6DnGNmdLbPqxx2jAsrELgMID5H1ydy8DQA0Ecz1l8k+kDWNyHktSz+xV9mVJwLcZBC
	 Q9r4ao0s171dZC7LgcwESwOMWS3uGijlClNA6Xlkf/4QyJZ3ziZCgUypZ+h+3n+q/0
	 WsWpmbxJ1hme067Me746+K/fyF0lrLpQVoJapDU1so1ffy8nz0/moNOl5ECcMkteLY
	 rnZOTAOFkioQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8D3580F2A;
	Wed, 16 Oct 2024 00:46:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2919527F2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Oct 2024 00:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 096ED608A7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Oct 2024 00:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c2eHwOYsLRir for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Oct 2024 00:46:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AB7EE608A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB7EE608A3
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB7EE608A3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Oct 2024 00:46:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BBC7A5C06FF;
 Wed, 16 Oct 2024 00:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7562EC4CEC6;
 Wed, 16 Oct 2024 00:46:08 +0000 (UTC)
Date: Tue, 15 Oct 2024 17:46:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johnny Park <pjohnny0508@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <20241015174607.6c29bb8d@kernel.org>
In-Reply-To: <Zw2mTeDYEkWnh36A@Fantasy-Ubuntu>
References: <Zw2mTeDYEkWnh36A@Fantasy-Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1729039568;
 bh=gau4ljJEWPH7doucGrEEQmvS6b7hCt12v+vpbNEM5s4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uDh8HeFiuQthP6mtjKIwK1u1Ou9nr3VRU5GtpG/DbGeWKm3HCp/dehGuz1x4O5bYT
 +ocCNjnZ5NA4u6ynjg2rPbz1JGvUyh7Hv+Wckgk6jejhWH1SnD8AgHyi/qnuw5QsS1
 VxNTGl6zsWXsD2k+XL9+8dI9bV0Tewgdi7RLYee+xbBadEhUUylfE6xDWXPj8/LdP0
 v4dAsnQDqkhfF8DSSW89Gr1Hc5pChlHbLte04U71A+cckcT5EEGZZIXvayC2cdy4Qy
 dTLXmKFopLB+cviFtVtCSnAwM+BCTbspbvgERaNW9YoBo3uIs8FkftFITv4OOwjupt
 5blGzSBXipRDg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uDh8HeFi
Subject: Re: [Intel-wired-lan] [PATCH] igb: Fix styling in enable/disable
 SR-IOV
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

On Mon, 14 Oct 2024 17:16:29 -0600 Johnny Park wrote:
> This patch fixes the checks and warnings for igb_enable_sriov and
> igb_disable_sriov function reported by checkpatch.pl

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
