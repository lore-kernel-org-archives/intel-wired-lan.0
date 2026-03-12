Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9C2106703C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Mar 2026 14:42:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B097844F0;
	Thu, 12 Mar 2026 14:42:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9xA8nuh-HXv; Thu, 12 Mar 2026 14:42:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C6A4844BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773326550;
	bh=nUpI4Bhk2+1zo7sVNjOjuTz5Qtpuxb58ibO8tnQWaWI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T5UfZDbFHkv6sRpwWELA6UL9CzBY8wa6PUUD1o+af1GwNod75dn9JUquk0Vt3Bcws
	 j8PpH4YVBdOp0nSABGYfob0CIoge4WP17mN9K0ner4ON1wYJ3GP/QfBRGYjK8eiabD
	 OS07Qb/Y6tvL3Gnn0aMqclB1D+1mUaL609bz3p630sk8hktOLjZhpQkuViGvarnwSp
	 hNCJacLPfJsEpuOG2zCnJVPFe5Lh3jsvVfiUon7GGNNe8lof+pWVDmr6Ws6b2GQTVq
	 arL3qFVKwdO/1ZoV3nzvVzU5VtobSWpiLKqkb/Q8tw14CcCDZpjU0DI1olmtSebFwN
	 x+l84CGH93L4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C6A4844BF;
	Thu, 12 Mar 2026 14:42:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AFEEF228
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 14:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95A33410D8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 14:42:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dxqdrs_l_UnL for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Mar 2026 14:42:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C461F410D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C461F410D4
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C461F410D4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 14:42:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E900943665;
 Thu, 12 Mar 2026 14:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919D0C4CEF7;
 Thu, 12 Mar 2026 14:42:26 +0000 (UTC)
Date: Thu, 12 Mar 2026 07:42:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com
Message-ID: <20260312074225.27a4a7b3@kernel.org>
In-Reply-To: <20260312093101.1589970-2-aleksandr.loktionov@intel.com>
References: <20260312093101.1589970-1-aleksandr.loktionov@intel.com>
 <20260312093101.1589970-2-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773326546;
 bh=6Qr5Lqzt2TKO4ndBM40+Rf8eOWfEXXbUKDK6Jz+dC7Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bpMxmg5UOAiMC6OE7QbjMoUeH54aXEm+/rIn7I67Jte7+lCVTSt8PNv/SK/2PgcJ1
 7NnqyTBM3or2V3JebBnKcKwo9q4AFoIUKqKNTvuAThRp9F3MmA6LpsRhyniNBCkxnd
 a8EPBFNOG3M34p9mANm+KD3SRHwncDo0Umyp3ZBBQMgLk+DrOcKZein6OEVjdmVxoK
 Wxs70TUQvDOL3fYvT+C9Bp4X9YvAK+si0DtWrPjV/QOBvQDs18CvxZIHGOEoDAsCtS
 afLceEvdHAJ9NExeK9ptPZhHzoj4Ts+IytMXDssGBM24hQ6fCQrG7amoWN0ZV1t7SU
 qPo5WmV+bZ/4Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bpMxmg5U
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 1/2] ethtool: treat
 RXH_GTP_TEID as intrinsically symmetric
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

On Thu, 12 Mar 2026 10:31:00 +0100 Aleksandr Loktionov wrote:
> +	/* Strip TEID before checking - it carries no src/dst asymmetry */
> +	rxfh &= ~(u64)RXH_GTP_TEID;

No need for the u64 cast.
