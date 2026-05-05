Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237B2FF885A
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 May 2026 04:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BABF840632;
	Tue,  5 May 2026 04:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xxz8VVcABCjz; Tue,  5 May 2026 04:39:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B989E40514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777955945;
	bh=xjptxPH5mc2qFYTi30/3QW6mxgIAIPTdu0ZXTaRaqaU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Re8SRuc384lwx6jv3R5h6ZmBLovwFeusNV4NllYf6sAU9tSq2D0CtB/oB5cRc7ba0
	 Lv+nkzpXe/eggKixslCq/x6iZKYTUffEz39WOk9iRF1eVTjdn+2PTg3hUM0L2XoxnA
	 UvSad8+a2Q+p6pun5Xsp/ppzyXr9g1V77cIekk24nL/6hQg7ZT5Y/3IbQaczsB+45P
	 nqbSpu/RLqUu8+yZ2HFq5kmWj9ciJigpT8pZrmThR8yq5+jTbwtd+PjFdmBYDqENBZ
	 MeqieNRT15XRXsZIzjTUyfERg+z7jrwWMPljfdJUhV2w38JWC4UCdAKeU51lrkHx9K
	 x4pp2iaik6AeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B989E40514;
	Tue,  5 May 2026 04:39:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5A592DF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 May 2026 04:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E31A460793
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 May 2026 04:39:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VoqTguX7ZZEe for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 May 2026 04:39:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AC44E606F7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC44E606F7
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC44E606F7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 May 2026 04:39:03 +0000 (UTC)
X-CSE-ConnectionGUID: wxMrVUpkQ8+GVSLb3Rv12g==
X-CSE-MsgGUID: ks7JIVU7TImSl5suktzFAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89124589"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="89124589"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 21:39:03 -0700
X-CSE-ConnectionGUID: Zp/RDczkSni7GBS1NKqqlw==
X-CSE-MsgGUID: gUFZaRRZTXaFArHJjVG8Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="259369989"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 21:39:00 -0700
Date: Tue, 5 May 2026 06:35:04 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jramaseu@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com
Message-ID: <aflzeKTaOUBy2Xsn@mev-dev.igk.intel.com>
References: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
 <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
 <44623db1-8b86-4e8e-82a3-46d65b055ebc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44623db1-8b86-4e8e-82a3-46d65b055ebc@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777955944; x=1809491944;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=c1HpKxmZh/vDAAxMnUvYiCbMKTHqUgCr6R7N3XfmFAQ=;
 b=BgQJUcizWTno6HSxJmVBeE9XYe16d3vKg3l/OAjJuSkOFd8UqgmSPl8i
 Y29pctp0LNqjoFtxQD+4dwmT9s8bqyBE12u0Kpsld0ftz/d1AInUkcS06
 Lp08H+dwS94KntiMywpncCxXps4I7cUO76GNhV351Cob0PfyGxCceqbIL
 tFd6ZRd96KN3NNRaZVslsYTl1huWlT6tvBPNHd6fWXHDE7o5fG4QcH8iB
 yjTxhZda8bf3YbF2YRMSWrBNp0K1qKtUqVHzcib0gKP3GP7jq566Frlzg
 uxrubY5jG6zHYD5pBF5gHxpPeFk9EjrYLC0EwHH2t7ZyFfzddOomP5s+D
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BgQJUciz
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 2/2] ice: use
 NETIF_F_HW_CSUM instead of IP/IPV6
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

On Mon, May 04, 2026 at 04:53:12PM -0700, Jacob Keller wrote:
> On 4/28/2026 12:06 AM, Michal Swiatkowski wrote:
> > The hardware is capable of calculating checksum for IPV6 packets with
> > extension header. To not drop such packets switch from IP/IPV6 checksum
> > to HW_CSUM.
> > 
> > HW_CSUM is also used in previous generation (i40e).
> > 
> > Previously HW_CSUM was used to indicate that hardware supports general
> > checksum. Drop it assuming that if the hardware supports it, it is used.
> > 
> > Disabling offload for E830 in case of TSO isn't needed anymore as the
> > check for TSO is done in Tx path just before preparation of the special
> > GCS descriptor.
> > 
> > The commit from Fixes didn't introduce a bug, it just shown that the
> > driver is doing sth wrong with the checksum features.
> > 
> > Suggested-by: Jakub Ramaseuski <jramaseu@redhat.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Fixes: 04c20a9356f2 ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> Am I correct in thinking that this supersedes (really, properly fixes)
> the patch "ice: enable NETIF_F_HW_CSUM for GSO packets" at
> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260310150557.1138437-1-jramaseu@redhat.com/
> ?
> 
> Thanks,
> Jake

Yes, exactly. I think I linked it in cover letter, but maybe I should do
it also here.

Thanks
