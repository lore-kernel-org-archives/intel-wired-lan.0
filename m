Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FA5E9A02C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Feb 2026 01:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50BEA60B65;
	Thu, 19 Feb 2026 01:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id myWqXQjcafCf; Thu, 19 Feb 2026 01:47:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4460160B64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771465667;
	bh=/A9kCnxsZ/wdbZGeHzSUOd56ynX6731f0HRIToRSOjQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jQhIEtAMkChFI9lZJB2VQOtUxN66T5vO9NVZtiww++1DC1dQitzBg5zFasjBjvgBt
	 0j2Kgb8gorONrbVitRrO6LgpPcqV803jtb5/GozunpGWd1lS+d2o5Q40ZC+PAIFD8g
	 bhd5bRQB7MWuUZtZlj6NrS3/rZTE7dm9UgC2BsCjhXsI/2mClR0Go+guZFaXepuAlZ
	 pONDEi3N/Klo6biwbrQATuqFWBiAelhawTK9DcBqMcJJ5zOrZ77FsPFMMx5+L3KGmO
	 iN2vV1Aqh8SOCX1t4kVQ/WqSbGA1K88e8jQs2mYflRwQX4jLQbyLf7jkm8METiNIT9
	 Qg22qzwSp1zvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4460160B64;
	Thu, 19 Feb 2026 01:47:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FEBD183
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Feb 2026 01:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 019CE60B64
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Feb 2026 01:47:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EfMXJUqP3YDb for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Feb 2026 01:47:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 547F260B5F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 547F260B5F
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 547F260B5F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Feb 2026 01:47:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6628644314;
 Thu, 19 Feb 2026 01:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219B4C116D0;
 Thu, 19 Feb 2026 01:47:43 +0000 (UTC)
Date: Wed, 18 Feb 2026 17:47:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Message-ID: <20260218174742.62a4074f@kernel.org>
In-Reply-To: <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771465664;
 bh=/A9kCnxsZ/wdbZGeHzSUOd56ynX6731f0HRIToRSOjQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Sw4vWfpJjIO+b/19FsTFw7nUmnEZZ+P9/Rnov5xjkY4iNiEW8gOtqBJTUpfcxW0Ef
 Y7v5xO1VpK75Ntgb+GDs8IXp7HfsC3YfkJ6DOqkXA19uRISf00YIKHPErRrQD2q5zW
 epdWrTUXkQWTzn82IK2c0skkNMWul8T1w0NjQ2oG8bgWOEIslJhAHZ9n5DP46RdufZ
 aCjE+nPLLxa57F1kG3esUpmWK00qrtoO5XigA752N+DbyGrHUffg5mKSiBpE/FNrQ2
 sAffqp+HShkEia0hM4L97nys0TAvnrEpoRW8xw6G/9cEPUwV+bYVsTblTlg28LhF0H
 1PDqCeBA036WA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Sw4vWfpJ
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v3 1/5] netlink: specs: Add
 XDP RX checksum capability to XDP metadata specs
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

On Tue, 17 Feb 2026 09:33:56 +0100 Lorenzo Bianconi wrote:
> + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
> + * values are:
> + * ``XDP_CHECKSUM_NONE``
> + * ``XDP_CHECKSUM_UNNECESSARY``
> + * ``XDP_CHECKSUM_COMPLETE``
> + *
> + * In case of success, ``cksum_meta`` contains the hw computed checksum value
> + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE``

It's fairly common for NICs to report both csum complete and
unnecessary. Which one should the driver return in that case?
What if the user prefers the other one?..
