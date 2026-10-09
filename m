Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF213CA9EC1
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D7BB81479;
	Fri,  9 Oct 2026 21:04:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Ddk1buJd58Z; Fri,  9 Oct 2026 21:04:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A013A8146E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791579843;
	b=oyG/4wdi8q1nFHWc8RSRJd0dd2m+hEg2Bs6taSYAuKmYfM6IYw6g3/CKQk0awNCXSSaQ
	 +MWak0eEEdvcv4tKqicKRq7JdlnmAqs86iGZtm74sXj9df1xwImtini8j0kgKujFuLIjD
	 lYa7fKjT8G6opxqGh+irf0pY0i0bry5NHuRGfbNOHpX0PzwCNTspdUkIkbSUPrg30mvoL
	 q/xNiz6p3hxCt6tEniGT/BGJpYs67KmhmnfCQ0Vg1LVMU2uHSckGLkvFF83xul7V6ysVQ
	 GEjerctf2UAJdAqv0pfMAMn7rZxz/otEExbsY5WXyOf+WERYY9VYY0wNxqAdJ69MbXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791579843;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=HbOV/Z5pLiDjPPUOUEyFt80mPqyKA2kHXAVR/LIjCD0=;
	b=qCjeZZ+D+NtUkPyw4rcqtQae4WvSVPC57q4kE3yAjYkxqBCQv3OxuhUd57AozpL6h7VE
	 cmAhA9sQHRtb9mEm4mfIH377MpfAGRYdgLKrlYFVOeGaeC7deIUixwqtJ7J2DVlKrwB6q
	 oOjEgcEmCJDCfp0gEXfcaLuykDL5P9nflQhLIeOvvk3wU/rnsxtac/7H3FOBzCAuVpwEk
	 8Q7hcmJzntaLVOOMyDml4aifPU/Fs0T2D0bwHfuWligUGRNwdVbLFW1Se2fCksPVwJZBg
	 TH4hTX+voNkl/SCGpXSX8zbbNOYkeoOZ2ZjlhG9RL+rv+XTO9v8pH5fdScroLWbjOfg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791579843;
	bh=HbOV/Z5pLiDjPPUOUEyFt80mPqyKA2kHXAVR/LIjCD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NWS6HyBItkbDa2Cc5BRcJqMfGpBiyJyToOzipHs5OsNMKFf2x0HVdjNlb7ii1frn5
	 DrWg26YhM0KiKA9bIg/1sq+lz+zC1nfDWJTcLZ9kEIeNGsKNZ7o93panz5ABFPOG5+
	 R/Yubs6Zn9OD2eEGHXAUQxI4hPr4L26+JVQpye5BffiX/N7WQHEBV51ji6qD08DjM6
	 WGoRMIb0pj9/INdrfiCxu2MTE8tNANvMfI55FeTFC+psu+XK8i58zQMFv6QvlhLnhF
	 DxhlTrpd9sPFvgajuJVw5HcRHxHIpOj+n4CcwxogBE5FghrMMD42DayYns88xOVRGX
	 ty01CFilHUxfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A013A8146E;
	Fri,  9 Oct 2026 21:04:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D4C975
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FE7340080
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Pawgj9lm2io for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:04:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D71C740053
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791579840;
 b=GnQEDx2iHlzFK1fhTU4MkJ3jBPVk7TCGVJK8ICgUyPc7X6AB+j7o7JSGkOgYRIYV6qxI
 UuRHj7vqCB8Fat1tyvUesVHYYHNyviJnGstTdT9xihf+JCt7tFIBcRmQLzQhBABvnDR+t
 QTO0LmJJ/NfoJc4DyqzlME8vpZX6+f0IPY4AxtdtpC90p21xs8dBrZxco7kIRbOAZronV
 XyrON4ecMPUFjtpq25ldyt1LyN4FvrAAVWjJxiCijtQG92SaS6w3PmSS5yA3qZePQXk1Q
 hSzsZ7JelbNV44WHLCWX609VH5fsdYrnU+lvp/EzrQtn1fPuEkEqkvVKRWs3yvIBdHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791579840;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=HbOV/Z5pLiDjPPUOUEyFt80mPqyKA2kHXAVR/LIjCD0=;
 b=SJPokvtlQzjHoC57mvDkCIScAgXtphgHaBwKma7gVywT8GoHOLlJrPhwBHVI8LvfF6in
 3GuGrCBVKngetWzG9wMnN1XOs5vQFzRBX2HuIMnzcJCNLmDgHMEuEQNIuh0FXag0YB8FA
 QiMSUqeZ4212IyZYESKZFvDJl3Ay3QVsNXZisVnum5kovoCUPk14NNRE0EqldOKnGrnE0
 hQtBGD0XCELfCh76dyC5zAsUA/SP6cdVCHfmO6CDxPdS9I2WviSdE528iiqlyDxVPwNcI
 NJYWxwsQBEAbdYHu7bwnV9NMmTndev8L1N0NVsjqPOgxTjNhxXKh1E2Fzvb3gzdnN8w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oWeRs6ig; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oWeRs6ig
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D71C740053
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:03:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D1B460202;
 Fri,  9 Oct 2026 21:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118C31F000FF;
 Fri,  9 Oct 2026 21:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791579838;
 bh=HbOV/Z5pLiDjPPUOUEyFt80mPqyKA2kHXAVR/LIjCD0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oWeRs6igzYXkAciQ7GoVth6K6wPG3OmdhT95lyZBvlyrO7kKjMB8L54+JmvtJw7gL
 nTcXE2fpRqu9/lF306F+gA7hF4i3l6xAPydumT52Iu7Mc6iq4e1giGLEJpkcUsqsWU
 tVETzmnMCgzNehF/g/4HoGIEbjGWbMZ89b5IpAIyfFIXM2FuFUXzeQFGg7FDhzw+DN
 u8rTvjMrwUi1Hfc9uXeS4mORX1sQSifHvh0O7loLoZ4MiyYD+2eweJdhsNCr812b3K
 x0RDXWk5RIAn+qII49bg+DkgIjutCKMTDZ0nDgygRre0shNqIaiuYdtxdem041ia0k
 /Oe+eqH+iJ0UA==
Message-ID: <sashiko-outbox-166070@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 05/10] xen/netfront: check for failure when
 pulling in xennet_fill_frags()
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-5-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-5-8f2bd9bee138@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:03:57 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] netfront: memory leak of head skb in xennet_poll() when xennet_f=
ill_frags() fails
--

commit f1df1b5218b129f50d5ffc52995e379ca9e3fc59
Author: Josef Bacik <josef@toxicpanda.com>

xen/netfront: check for failure when pulling in xennet_fill_frags()

When the skb already has MAX_SKB_FRAGS frags, xennet_fill_frags() calls
__pskb_pull_tail() to free up a frag slot.  That frees slots in two
ways: it pulls the start of the packet into the head, and it releases
empty frags, even when there's nothing left to pull.

Use pskb_may_pull() followed by skb_drop_empty_frags(), and take the
error path explicitly if either fails.  pskb_may_pull() does nothing if
the head already holds pull_to bytes, so the BUG_ON() for pull_to <
skb_headlen(skb), which protected the subtraction, can go.

> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index 2ed673649c488..007fa3bbc9e66 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -1174,18 +1174,15 @@ static int xennet_fill_frags(struct netfront_queu=
e *queue,
> =20
>  		RING_COPY_RESPONSE(&queue->rx, ++cons, &rx);
> =20
> -		if (skb_shinfo(skb)->nr_frags =3D=3D MAX_SKB_FRAGS) {
> -			unsigned int pull_to =3D NETFRONT_SKB_CB(skb)->pull_to;
> -
> -			BUG_ON(pull_to < skb_headlen(skb));
> -			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
> -		}
> -		if (unlikely(skb_shinfo(skb)->nr_frags >=3D MAX_SKB_FRAGS)) {
> -			xennet_set_rx_rsp_cons(queue,
> -					       ++cons + skb_queue_len(list));
> -			kfree_skb(nskb);
> -			return -ENOENT;
> -		}
> +		/* Out of frag slots: pull the start of the packet into the
> +		 * head and drop empty frags to make room.
> +		 */
> +		if (skb_shinfo(skb)->nr_frags =3D=3D MAX_SKB_FRAGS &&
> +		    unlikely(!pskb_may_pull(skb, NETFRONT_SKB_CB(skb)->pull_to) ||
> +			     skb_drop_empty_frags(skb, GFP_ATOMIC)))
> +			goto err;
> +		if (unlikely(skb_shinfo(skb)->nr_frags >=3D MAX_SKB_FRAGS))
> +			goto err;

[Severity: Medium]
When xennet_fill_frags() returns an error here, the execution jumps to the =
err
label in xennet_poll() where it leaks the head skb:

drivers/net/xen-netfront.c:xennet_poll() {
...
		skb =3D __skb_dequeue(&tmpq);
...
		if (unlikely(xennet_fill_frags(queue, skb, &tmpq)))
			goto err;
...
err:
			while ((skb =3D __skb_dequeue(&tmpq)))
				__skb_queue_tail(&errq, skb);
...
}

Because the while loop unconditionally overwrites the head skb variable wit=
hout
freeing it or queuing it to errq, does this code permanently leak the head
packet?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-pskb-pu=
ll-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com?part=3D5
