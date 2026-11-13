Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B6606BD09
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=XQQgRzd3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiMnETWV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF72D60D6E;
	Fri, 13 Nov 2026 17:43:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MnXRYnqd-CRg; Fri, 13 Nov 2026 17:43:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48F1560D79
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794591782;
	b=Bj/sl9NsHL3VNfXiE6HC/szTReeyFLPYly1PKo36ZFAZlQYyRiizGEvO76lLFbwCO7Po
	 Ti5c5ckKHUTZl4857tm0EfLfByYrbxTULrBY0sclClZFyq3cLFmKp7t4OjYxjDhsX/fHP
	 14Tqyi5TPpEaYX+HAkGwhICSIEGdF5heTINrQbdVFwJ2s/ptoJWDIsO1cXoQJDeahQTDs
	 XNcmXHgMqBKbPlm8cp7ckicV9JEvCYoY93vHJxKjgbdSPk94H5w6vtFDn5tL9Is2zWLxh
	 477DCnTpT3gC3lKcU0U1EDizNaLppQvkMjOU7Wco6HoilX3sWIH++J5J1lCbHHPRxMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794591782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IYvcfGb/slu58PM/m4e+Yc8z7FJ8K/oScmbq+QLPvBU=;
	b=U82uj+paAuzB1Dvp+xoa/W52D4fnDkNZ/dTeOdQoAqrlkoeApKP+PKIIhI7wEpi+3oYU
	 Ysr+sHMtoKj8jTIUMFOvg2qLQS5X1f0ecD0qKbRSmw9mpjnEEaC1PNGrgQxIEfBsGPznY
	 QmvWQ9nSjurbg/PQoBJeZ1t3wVqPCElxPTyIlEoaAystRZmmVYBde6hNhTpUsJGlTQ/MO
	 H0Io5J8WhNv6w7UFaSXH1Tgcz1006tDSdUZy5vm9DM61KTT05DaVMm7lTF5nD6waKUZny
	 Wond1MiQTETpqffBZbidd+/zkSoYRVXkFR0rR7iU+wwck3VauUBy+d3KpjlcOUlKCzQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794591782;
	bh=IYvcfGb/slu58PM/m4e+Yc8z7FJ8K/oScmbq+QLPvBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XQQgRzd3TrxzJM8FDgoqvvmyF4SsjOBJmRX9jkSRALsdRUjR5lpsFeO4/lyeFaYux
	 E+SidD7RUL2QSTzhMZNNqBQ67Ab+YkiFQ3/sZdDcF+6SaWFw6K3VpXBbXWETlF72SP
	 JI7N/+KnMLBEwAhggetJK6wtMcqa3Ine4fCMWdyVQQpIkoC3XXtftLLpDeR4jojkXw
	 Q2S/tJms7mDX4zIOyyAcCXRSGzEdoM8EntvH3zVYxI8RDgpf6Q1pBOp2u+AsjJeHjV
	 JQ7Y6mj0a/1BhrJz4M4B9yhJYaGVTA4DKL4SszFsWELU5V+cfo1moYtKoY0FtwyRCQ
	 zk3d5bcUCVN4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48F1560D79;
	Fri, 13 Nov 2026 17:43:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 954882E5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 17:43:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7ADC940D94
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 17:43:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kTmNX7J9QdSz for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 17:43:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D6A3E40D82
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OiMnETWV
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6A3E40D82
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 17:42:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DCCE635B1;
 Fri, 13 Nov 2026 17:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A971F000C4;
 Fri, 13 Nov 2026 17:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794591777;
 bh=IYvcfGb/slu58PM/m4e+Yc8z7FJ8K/oScmbq+QLPvBU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OiMnETWVNrC+PUULxWlaoousk14+Ub0hS1/4hS6n6AToB34KRUeMJKSvRmUMvWrmB
 ddKR+DwvFNgpkWG9r2uoJ2nCkxuPw/zDoUqP9oXW0VjfYGH8c8Oz8Z9HDhYUmlmtrG
 U4GIoU9jVkvSyKqCalob3PFhgDCres5WEX65I14+1d27QmqILveEcgOQQb3O08S8AZ
 v7WUpK8SNAB+Rn/emnt+9SupVYCDhr+bwKCeoINC1vZGdaJECLLAsamI/5zQW1upRa
 JlZUglx99ghE9WhA9FFabMiLsCf5f1A8lRz4NtFIA1rbPMfk5OJcevD6fyhvgYpqQF
 8nnDlffKCYUnw==
Date: Fri, 13 Nov 2026 17:42:51 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, Alan Brady <alan.brady@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Willem de Bruijn <willemb@google.com>,
 Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Phani Burra <phani.r.burra@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] idpf: reset mb_wait_count once the mailbox is up
Message-ID: <20261113174251.GA18859@horms.kernel.org>
References: <20261109-idpf-mb-wait-count-v1-1-c6584754df78@debian.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-idpf-mb-wait-count-v1-1-c6584754df78@debian.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 06:43:27AM -0800, Breno Leitao wrote:
> idpf_vc_core_init() retries a failed virtchnl version and capabilities
> handshake up to IDPF_MB_MAX_ERR times before it gives up on the device.
> Each failure increments adapter->mb_wait_count, but nothing ever clears
> it, so the limit is shared by every initialization in the lifetime of
> the adapter, including the one done by each reset.
> 
> A device that fails the first handshake after a reset, and then
> recovers on the retry, leaves one count behind per reset. Once 20 have
> accumulated, the next failure is final, and the device stays down until
> the driver is reloaded. This is seen in Meta's fleet on hosts with
> recurring Tx timeouts:
> 
>   [ 2176.496801] idpf 0016:01:00.0 eth1: Detected Tx timeout: Count 21, Queue 11
>   [ 2176.508763] idpf 0016:01:00.0: Device HW Reset initiated
>   [ 2237.412541] idpf 0016:01:00.0: Transaction timed-out (op:1 cookie:9800 vc_op:1 salt:98 timeout:60000ms)
>   [ 2237.412578] idpf 0016:01:00.0: Failed to establish mailbox communications with hardware
> 
> Clear mb_wait_count once the handshake succeeds, so the limit applies
> to consecutive failures only.
> 
> Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>

Tony, maybe this should be routed via the iwl tree?
