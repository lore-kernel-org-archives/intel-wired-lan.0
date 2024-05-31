Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D39C25B7C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 May 2024 18:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BEE642426;
	Fri, 31 May 2024 18:18:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id og1W-QkKr016; Fri, 31 May 2024 18:18:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D86B42402
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717179493;
	bh=J5uvnBUMRA1oEXKbKaNzVV9Cs5B4SXdpBnapZkst04c=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=PwTpGZJSWvnrc6utAEv75DFXn8xQrhvwP2FfLEfYFOzJJakI1iIebo8i9lwUIZi+1
	 iA5oLCrcx93SfZBZO6q7ZxGm0XC/nB6y1MEtAxs2FyaTHYOK7AiCDLjNPO/Veg3J2J
	 ykoV2+g3N6TteHMkcO4eI/9oLOCN6E6tMf/ZiV6xvuO148a1yAG8MqK36bgvBsTPYK
	 EMTMsFLw8vsMXLuyjZtw08nzMNzAvKLZ8AGuccs06jY6SImJ/f1gNtnS89anOj7trV
	 vdHv3uOpXTkkCqAmALC32ILd49Q8CfpyScoUmUP7uQxtYX15Q+XBR2I5hqoFJ0p48A
	 8HdSqlDoGb3dg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D86B42402;
	Fri, 31 May 2024 18:18:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 76DAC1BF36D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61492400D1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:18:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZu29VNjkawe for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 May 2024 18:18:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 90A8640210
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90A8640210
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90A8640210
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:18:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8658BCE1C4A;
 Fri, 31 May 2024 18:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB895C2BD10;
 Fri, 31 May 2024 18:18:05 +0000 (UTC)
Date: Fri, 31 May 2024 19:18:03 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240531181803.GO491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-14-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-14-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717179488;
 bh=3D91g/xeI1LRPztWrq0QkS//sgRZFGWsOXXGLaURdJo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qLK6VLBJQvRBSt5Gqat0ByORiAnfGAwj5tVTFtH/7ufg2Qs57vSm422BoMSjv/Stz
 uLYUuvFCzOWdh+VSzUMPfW3wD/au3iAs5gBkU8wzSmygtOdvrbq+E1scV8GZGlfWuv
 tIOEugEKycnG44vzK18lAy/ZWvLtlExrXcl3EgGwcOkRbwDhum2xecIAtLIXN8UzxQ
 67q8sop9LvxOURRYnX8ei/wzig3g9xa+G2XJMfvxDqUunp9nLiuUQJSoCMShJn6lnd
 rjxTmU3JXDKQsl90ubv2W+M56mOzzBn3/O744DyVnSSRodQcL13qajYUA/SqITEGNI
 Y4MW5kH3xKrPg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=qLK6VLBJ
Subject: Re: [Intel-wired-lan] [iwl-next v3 13/15] ice: support subfunction
 devlink Tx topology
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
 kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
 intel-wired-lan@lists.osuosl.org, pio.raczynski@gmail.com,
 sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, May 28, 2024 at 06:38:11AM +0200, Michal Swiatkowski wrote:
> Flow for creating Tx topology is the same as for VF port representors,
> but the devlink port is stored in different place (sf->devlink_port).
> 
> When creating VF devlink lock isn't taken, when creating subfunction it
> is. Setting Tx topology function needs to take this lock, check if it
> was taken before to not do it twice.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

