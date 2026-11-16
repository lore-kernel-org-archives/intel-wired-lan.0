Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD4606A893
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=O7929I79;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLv5HJcf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F24E780F37;
	Mon, 16 Nov 2026 14:22:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HElhIrtz2mOm; Mon, 16 Nov 2026 14:22:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6E56080F20
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794838930;
	b=UVfqbzeWKyO8PkcpyMgu5n+l93bs8aWkNd9A9llN1lAclejrdTQwvzd9jxdZLdNhAU/5
	 k1l/44GR9ahNOTX5batt/d/gjJ3YzF3O4ulVpt728fEUBe+xkOZoJYw1O/E0uBiCz5hND
	 umZpi6gCb5SRS2a5zjVpIStn558EmD3XVw/4jR0kAu1GOyp2z620cQ/08AYvhGcZHXibV
	 O+tOQTny6VPIvaycTRGLlqGIqxqEGnFZezf17W8UIK8i8o6eh7FdeQNSxiylKf7dhwzd2
	 Q4JrhF/DJ2PBcJjBVQ6FMVbNa+gYF1FZS0gfMhrfLHvv2iAb0vbsM/F6WjUraoNnWng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794838930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
	b=UXEh3Ode6IgMX9fmIVlxOymr+ebs3wI0bak6t145nsdpilp6upKdvqNIFtJ1TH5BxLm3
	 YKNHcfh+0VyGvAm/qgNFCBdOw21htBWGZP+WG7KMpKIa33i/HBmcMmtvVFgzmdBE2xfsZ
	 waLAE9vNYCXWngaOZmfND4ZFo4c26fSVfLA4ti9FBeZa1p8h9lXL+tRsQ3rwco71tEMeW
	 hHqB2XUUX+GWsUv0XNZCUJ5GtX1jjZWcqxRn/4zSazSIWALAt8BFOsLVAsQq+H+gMg+Xp
	 NDuJL0fI1U4xACC9ByG9n9htlyK0UZ7DP5tTdpRFl8sVMnzWqQlkJ9E5w75OKPq8Tpw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794838930;
	bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O7929I79RKg1Lk0T/YJ3ZVNYORjBvwJuhmcjQluGtysEPR+PVZQCCH635a4Sf3hnC
	 Crb+ezhiIUf4fwc+3EnjLGqfxAkrPW1mo8PelaFiuvw1XgCRqnvFSk5vVg76LcNAEz
	 bM+0Q6lGpCGihfOvojwZ+TiRlX7jiO1sHI5MXSF5Ob/EjwW4NXc9pq3EqJf2jzNxSj
	 67U8qIQQTX7tlvHEt4VoyeGJnOo1/gHAAkFSQLaBX48LSBjgQRZKBamyoAoLdDDOMU
	 kG+o99KYFsOJAmaid1vE+KNowL2Toa8xaHz82j+OryXJIF2JmHJEyKu1Ti6/TgJ9L/
	 mNK2ZRtmBVv9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E56080F20;
	Mon, 16 Nov 2026 14:22:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A306528C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 14:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C1B660739
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 14:22:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oprbFeqHP6F5 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 14:22:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D8A4A6067D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QLv5HJcf
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8A4A6067D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 14:22:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3762E40723;
 Mon, 16 Nov 2026 14:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D8C1F000C5;
 Mon, 16 Nov 2026 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794838928;
 bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QLv5HJcf+2cLXkOHP0X1odcRBpzWX2N8sYeQ1d7lBsfQSC/qHIbBUyPQ6WS1Nchmb
 vNUlhnWzInmLZX7vcFKPMR9AYqs1ptyZSsRhDWDK5yYeeOmfVx8LkUyi9CJjuJMVaM
 q3WQjmC6/orYJaq9tBTsUvWnLp4Tk1iQZqjPSUelVVVMuUNKv6EwkbnlEGpUCtMjgy
 U6iXOCWdZcHHd6TAYVCvPqM4r3tY/mB+tvOrnAWkUmyGO+s6NV9mv/jlFb2PK0DePv
 3v8zPSZnEp4iqvK5hdAa1SqaBAEoCED+GVzYQc+j7u7ZX3hMULx5yNKCJlGjvBrp/E
 iYGGLJREa+waw==
From: netdev-bot+sinfo@kernel.org
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] igb: Fix potential I2C adapter leak on probe failure
Date: Mon, 16 Nov 2026 14:22:06 +0000
Message-ID: <179483892696.3291.3267390747514422182@kernel.org>
In-Reply-To: <20261116-c29ba55625-net-igb@mail.sdu.edu.cn>
References: <20261116-c29ba55625-net-igb@mail.sdu.edu.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
