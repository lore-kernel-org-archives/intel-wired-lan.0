Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF966CF042B
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Oct 2024 23:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9503B405F5;
	Tue,  8 Oct 2024 23:50:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nk-rr2cahY2H; Tue,  8 Oct 2024 23:50:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 592AA405E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1728431434;
	bh=0Jw+NMobWQEYMn9koalMCu9bxwr7TzxQ/pNnQTNpDao=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9wmUQHyL5wBy8R1yNlsVrpg/UGd3kcGGmLeP30konBt4jdhfivMYlvLiZBon+ZMKP
	 vQI3QaFqL6OxoNYi3AAB8/liPh/lmYHmNw8X88XQ/nmJP5cuWLyingFsmQbQoKDyOQ
	 NYQQfhtJuxax2mepS6QW7KP4Gn785NPTbrzG2ywnVZhmTnMGDONbS9mF2MsKuj7Fbe
	 /9ZdvYzwBVp/O3wWrYZIXeTsrzA1KCMEujUbXO90ASrdGARh4dRugcI987q2mm4bUy
	 govbA277yWfsf9VpFfjj7/UMqVTp01+x03sxHQNRM2P4LK/PPf3gqQo0C2sbJfr+R0
	 0iX0Ar5ZG8W3w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 592AA405E8;
	Tue,  8 Oct 2024 23:50:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 4B9691BF5AE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Oct 2024 23:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37C9A607EB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Oct 2024 23:50:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l9oNADA8mBnc for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Oct 2024 23:50:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 828B66059B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 828B66059B
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 828B66059B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Oct 2024 23:50:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 782255C575B;
 Tue,  8 Oct 2024 23:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50AEC4CEC7;
 Tue,  8 Oct 2024 23:50:30 +0000 (UTC)
Date: Tue, 8 Oct 2024 16:50:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Message-ID: <20241008165029.49b373f8@kernel.org>
In-Reply-To: <10ea3faabfd916e955be09a49ba729835e54a73d.1727704215.git.pabeni@redhat.com>
References: <cover.1727704215.git.pabeni@redhat.com>
 <10ea3faabfd916e955be09a49ba729835e54a73d.1727704215.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1728431431;
 bh=Kwpsba+zGI4pWzNF+c6mzhO6pqfbgMbCn60fKlZE3b8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OJb+tbkVhQRc/ZUxo3gUVwXVOtYl37cQv3daY1HFz1Agv1znwBJCw1DgaiGIfxTO+
 +/tROs545gn2hczHHEpnNo7evRex++scpeeRlR6GYDbZmbaU49rjL/KTI7pmmHw2Ow
 8ilmBvVR3mVx2YFtvZUD/flQ3NkcA5Q97fxilVrXEp4A/Uetd51phhjp6WLSiJCgMx
 GuzUjjZ/lx7hAuIEvClKI4ocOwSHr2D8L0h/5GonPHr3IXOqmjWWtX+ZdlaeVWI7KS
 AXpEyBXZZv9Jcs30dYotZGXXkuTZq147XpJTV9jfaWUDQEGDMBXNnK8NqPlWIf1Yj6
 RJDNh5amtJvtw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=OJb+tbkV
Subject: Re: [Intel-wired-lan] [PATCH v8 net-next 08/15] netlink: spec: add
 shaper introspection support
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
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 edumazet@google.com, Madhu Chittim <madhu.chittim@intel.com>,
 anthony.l.nguyen@intel.com, Simon Horman <horms@kernel.org>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Donald Hunter <donald.hunter@gmail.com>, intel-wired-lan@lists.osuosl.org,
 przemyslaw.kitszel@intel.com, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Stanislav Fomichev <stfomichev@gmail.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 30 Sep 2024 15:53:55 +0200 Paolo Abeni wrote:
> Allow the user-space to fine-grain query the shaping features
> supported by the NIC on each domain.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
