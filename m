Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB59E7717D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Dec 2024 11:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BDFB606C2;
	Fri, 13 Dec 2024 11:55:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xR2xsA3lVm6e; Fri, 13 Dec 2024 11:55:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C080660748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1734090903;
	bh=cbo1W35ng9YDc/PilUhjYQTcd1BqISPzfxkwMSDjyMg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CLDHlL5OCi8FSwoCEQjttiGMg2fNd2XWlX8IZYCggq9ztjUILgIo+0zMuxUKUkTwP
	 oF4jPwr77yJHKzrMt401hgWFRPvop+xV31kKsvSk6sFb+KB5XsLO8SJ1X0j3OIJSB5
	 ugJuK1FyisviPsBYl+sN7ZwO0kMZFv4h3W2qcL+iPV364TxRUqsjaqpWK7Bg/CkKiU
	 HUXU0dnFi1AFZHM+TJfuZtzEcqF3T8I/OO5cYFjB5vN2Mjxmg9E7azFDx97qKvfgGK
	 nVNZosBPBZfscG7V1ICs08mbidyHVuwAltVr5Ao3l8VvaoDUIVUP2F7CJ9Sj7v44zk
	 2V8AeL1+U7Cow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C080660748;
	Fri, 13 Dec 2024 11:55:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7580BECD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Dec 2024 11:55:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F47A405BE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Dec 2024 11:55:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Bf7ZVmYSezo for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Dec 2024 11:55:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7209540003
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7209540003
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7209540003
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Dec 2024 11:55:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5CE535C6AA1;
 Fri, 13 Dec 2024 11:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2C1C4CED0;
 Fri, 13 Dec 2024 11:54:58 +0000 (UTC)
Date: Fri, 13 Dec 2024 11:54:56 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Message-ID: <20241213115456.GQ2110@kernel.org>
References: <20241212153417.165919-1-mschmidt@redhat.com>
 <20241212153417.165919-2-mschmidt@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212153417.165919-2-mschmidt@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1734090900;
 bh=yerIgJaV5A6Rde5kjoCtHKFrLDMP5haBZrIi+LOjhWw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t3oGSOBYXGFvw/H33jRiRJvt5B00lfqnqAkvb7tOu/YojDdnm2YUsyB5tw/k6xSFm
 0rSGRIqFl++x0PkeMFjrvNhX5XNW37h2vBI7PG+lNmrtxNkeVGMhIA705gHU2K/i0p
 64Kk8MxvuZzD4G7x6kvUoGeW1VHlow2Zbfz4D2McRG5clzMbc7MjLzkIb+Q7Tyqvk8
 DQkgWjyED3z+Mkwdom9xGvx+gEHlfqK2Q8DKIfj+tTAPLaSSQRootijEWktot38DJf
 CkrQ/EC6gGEZkXMtFy/RtLMv1eN9aY5Z202wz/52viyZKf46jfIe5pcpTOUroChrdn
 0m1rS24nun5uw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=t3oGSOBY
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/3] ice: downgrade warning
 about gnss_insert_raw to debug level
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

On Thu, Dec 12, 2024 at 04:34:15PM +0100, Michal Schmidt wrote:
> gnss_insert_raw() will reject the GNSS data the ice driver produces
> whenever userspace has the gnss device open, but is not reading it fast
> enough for whatever reason.
> 
> Do not spam kernel logs just because userspace misbehaves.
> 
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

