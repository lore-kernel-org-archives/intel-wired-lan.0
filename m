Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39ACC27C79
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Jun 2024 12:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60B5240555;
	Fri, 14 Jun 2024 12:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rs8m1s6Hee18; Fri, 14 Jun 2024 12:43:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A835F40325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718369034;
	bh=0DMyL3V1ZSVMOJPbQmUYCLeOkZtyGVsIEMb6jDQdJjg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=T6HLSTuxJYV1GKJWnaPB3WbjrN3envXpq8ncLOBxIlac/KgdpzkXMGR4Iq4Nv0YEz
	 U8c0F/FWMFOyBChJaFiSVsITNFFrYTYcrysdFMwiCad0/JsWqD/LvE9EXDB20Q2MVe
	 6MSqDEOz0EbLa4p/WPqO3XD10UkBfVXNBeMnK6uk1v7p5kqumgTb6Fb+9Vzk6q2pSv
	 b9j7u3wWaB2OdPwVVyEgKCPYkRNCAwSWfDtqhyLRMPQmUqryHMQqHv/abhYwirdiwZ
	 2j5y1oEb4Lrjf8ulcYbO08pIb0NcSQJMpeQXEC/hrD+H9OLg4RMmi2dd0iM5b9Mnu9
	 ShPVZR8M7Ol3A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A835F40325;
	Fri, 14 Jun 2024 12:43:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 003B91BF33C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 12:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED88540325
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 12:43:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x-NVlL6NyyjI for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Jun 2024 12:43:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 14BEE4023C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14BEE4023C
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14BEE4023C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 12:43:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BEA88CE2AFF;
 Fri, 14 Jun 2024 12:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D3CC2BD10;
 Fri, 14 Jun 2024 12:43:47 +0000 (UTC)
Date: Fri, 14 Jun 2024 13:43:45 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240614124345.GM8447@kernel.org>
References: <20240610074434.1962735-1-michal.swiatkowski@linux.intel.com>
 <20240610074434.1962735-2-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610074434.1962735-2-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1718369030;
 bh=eHbspLPsRwN/mbeaXgB2lqHgAnRpJhQXTP9RTxxZ5eU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=baqVZebJYB6JQRjG1TbqtNy8NAJUp4PDkrD0TKpQa+gXFDIkLDXBtCgUECynQnNyq
 qq87MdlwMi8aOASAawHo4ZUAem3bCrB9zqjnywz62m6wFsygIQ60Vix1/EdaLHcFS+
 XyHDsFrLorhaC2AV1b5jhtGhDNSJU56fKK1JGwaM0K9l7SHAA5buumxAQ2aWPDCHOQ
 9XVTDQ/hGNNWF4pSILD/vGeNQidbiUDH/KqrYfDO/PqHvt4Tw/70PTH65Jw5RhVqm0
 Dxa4XILV7BSGLV3wL/vA72RhnV8AtYsJVw1PwUnVwdXDUsiizpkbyDm7A2+bwz2Ozt
 exNqhLNlzU+XA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=baqVZebJ
Subject: Re: [Intel-wired-lan] [iwl-next v3 1/4] ice: store representor ID
 in bridge port
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
Cc: shayd@nvidia.com, maciej.fijalkowski@intel.com,
 mateusz.polchlopek@intel.com, netdev@vger.kernel.org, jiri@nvidia.com,
 kuba@kernel.org, michal.kubiak@intel.com, intel-wired-lan@lists.osuosl.org,
 pio.raczynski@gmail.com, sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jun 10, 2024 at 09:44:31AM +0200, Michal Swiatkowski wrote:
> It is used to get representor structure during cleaning.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

