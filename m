Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE373606C549
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0yPHhtqM;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOr+PLEa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A86440540;
	Tue,  3 Nov 2026 10:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HgjoRrM1BMuw; Tue,  3 Nov 2026 10:25:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9E9040507
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793701551;
	b=FII0lk9/gZnzXW008vH33UghmQo+Egm1dNf7pVbpmkgqIms8016KYE5MCpfmnIC/WlGP
	 S2ZZUNrojRYPo5Lhj90T9DUY3Dav1qGoCaW6a29YidfcV+tx/iBrFgoDiz91lcOaw0N5c
	 weoYO7ki7fWs1b+oTyX5RfQ3y7pNtoVueT8OxPCLLrWJ9cnUxSGE8ZIMtXViZdGIHhUqM
	 hWK/0G45pcUQfvmOoJzDOdfiKxkFDoCVZopVCtG3//1xJ1H4K1kO4ZYAOwiQDFa6F+gKw
	 WsnHOjUzFDG4r8AR+dp+EZhXoFz9TSQmDLWaD9BjcqPnUKecinTkAQ+AC2qt/laogjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793701551;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eVBfRz3fVnCcRJSsVqH9DYQP76908hbJkwajsue4xn4=;
	b=G4pw7jhxHD1xm8G+tfUT9km+ngFuawKWGLy/Flq1X56ByyGIa1ppa5g4nGmgcCNUwzck
	 2P2a6g+xrDEYdvZWrro/HchBazwoqxPJToSU7IR8vBpyYdb1AJc8sMW5UWatMDP6Cl881
	 XNU+rJ6Buqo0B3dmP/R097bYdoE78/TGOrADlYr8hod2bm+hWqzdXRSDMgZk+VQdJfN3k
	 XnF7HMSV2KJ5qkIHHa6UtZIYA94YpXCotrh4S/nDKHsfoCNbx3f5JAxP4ZEUch8nN4TGg
	 PUZrhVa2tIdgS0lzmJcnF4OVqvqH1lHQdyT4BgeaLkkFMsL39kYoQeYudNYzEpDCZoA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793701551;
	bh=eVBfRz3fVnCcRJSsVqH9DYQP76908hbJkwajsue4xn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0yPHhtqMjflfA3YIE8XjXgbofV4gSjYFEr7INMe+VM2AKQ2HfskYus412U3wr1Pq+
	 I6tj6LkhYiusIIFsDRsFI+hnYvF2FvKeJu5d6HI1bsAraEO6NoQ0iMlMNh+ddwftdm
	 2a3rC/UNlFosOEY45wafKAlZnQDYK6Yee2PFLAALQQjmEVFj10GbgTt1CBAH+bNT99
	 3RbCn6JzoT7006Zl9W2buld7MEn1vMJD1b04Bbdo0UNp7ndWX8IJuQle6IeQgb2TKw
	 c1RP9G9d10XB3XQDMA7KHXoF3aw1olRYFBLIQlUwI/5BGWolYagO3HnJ8ShI55R9Ah
	 S8tiD/RQ6in9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9E9040507;
	Tue,  3 Nov 2026 10:25:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0D21A15
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A267F606E6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vkj5-mUKySo1 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:25:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DFA75606A2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793701549;
 b=Wns9BR0OrH5mJEok7TyaX1Rp5Z2LFH5nY/gdK7/VQqYokyteu/PE9qQTj11wvsOWn1mu
 mlQPR3//6QDSouJ9f5t008padBxqf+ziiLN3jIVge+aEkSftytwAAoGdA7B6h/FKD06bA
 b8fqq2qc4SVTqhH8KRvk6q5NWif1FrWArBozh8qmQD6FM3dj6Ak0drDUQ5RH9Z9cCWvcG
 D4tAUjL/wNKdM/DdtrNv5UG2UdJ8C22OapmV06OxsoTOOcwhW4PyYaSAmeXwBoc2b8L+B
 BCvcO2SCR8H3h96cKvSNdq7JQLSSR6IBjwRZpA09hWLvaHXKbfP6Emmp4MKD/l19mxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793701549;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=eVBfRz3fVnCcRJSsVqH9DYQP76908hbJkwajsue4xn4=;
 b=PS6n1/TTKHwUm1e++T/IgKGcbbo+IrxOlsvEoMBV08btGGfScGeZrjETXHG5X3QwbxiE
 woPT3H4xl+nxnmXxPxmIqgECRmE7lTsNcg8282xPkvPSCAqYTYLmMje9z3/xrA6anRjAo
 5cUZgYSicScWuQwX1a96je29N5bL4DEXLKgFJWD7TlgYPluw2HtzZBCl5MgPdEzx3M7jg
 Q8t/GVF3QfBxZiuQ+TYJ1K+1VnBBX2sdRoZCJbeJDwPk9JCNvgDQdrnrptOOvY9Mir3EH
 lou61SsJOp1g7mIw3ufM8dcLfiTRjO2d2BVX7I2dTaw9j9NEE3Lsa8vUvzlRe3ebHVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OOr+PLEa; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=OOr+PLEa
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFA75606A2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:25:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B49BC43B5F;
 Tue,  3 Nov 2026 10:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37031F00919;
 Tue,  3 Nov 2026 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793701547;
 bh=eVBfRz3fVnCcRJSsVqH9DYQP76908hbJkwajsue4xn4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OOr+PLEan+GgFITMCObTWVGJcHeupjMJKX6wkkhl6yq8KJYZ1qRR0p2OjbdThK05y
 uNQ+H6wZNWOJMQU95+3NfBEFbjuCX/+6iOzLxAE+ZHKEpG7lD4uuA+DoyBFv0caF3X
 FPgL/c96MRtxhPcnTObVzPthB0Yk9WVsg970YAAAXqtOL2t2cU3AyDUed1BxV9CZrH
 nzd11OoHLxjCiua/k0ByAFjIfqx6jMb862TCwm4VHWURWY9kRayEFHzCSGKZyKLLih
 /EfqsoNioud1XBmlNlvGDRPzOWWe4e6Gzam0s4WQcvjp81BV2mvk5AojwJ5oxK01sk
 g6dJMjTTel5wg==
Date: Tue, 3 Nov 2026 11:25:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 intel-wired-lan@lists.osuosl.org, Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, stable@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH] ice: release the VF reference in the switchdev trust path
Message-ID: <20261103-gigantic-vulture-of-support-ffffa4@quoll>
References: <20261103100530.1309907-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103100530.1309907-1-vulab@iscas.ac.cn>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 03 Nov 2026 10:05:30 +0000, Wentao Liang wrote:
> ice_set_vf_trust() takes a reference on the VF with ice_get_vf_by_id()
> and then rejects the request when the PF is in switchdev mode without
> dropping that reference.
> 
> Return through the existing out_put_vf label so the VF reference is
> released on this path too.
> 
> Fixes: 1281b7459657 ("ice: Forbid trusted VFs in switchdev mode")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




