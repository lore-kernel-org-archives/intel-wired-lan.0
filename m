Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEA0CC6B0E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 07:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61D0A606EB;
	Tue, 13 Oct 2026 07:31:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o0Zcd1gaLBkm; Tue, 13 Oct 2026 07:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92643606C1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791876673;
	b=AaYfZzR72qSbKua8Iw0j2VhNmiD6chHcvcjhEw8k5UPn1HN42basnFqh70TkUNoTj7Wj
	 XHhwI3/YhYMzL+Cp8H7sKiqd9FDOMg3J0HxsWVm8r9lAR+urJ5EPwqZ1jKKLGViCzjUnf
	 /cUYOTONhD4Hd8oKh8n57AakzmhSdbpc5GVeARg5o36MmaVFlIXRM1QlKPmAqRJKN0ZIf
	 RuuEOqNH+WMN402ADrGCbEQFpxnPuWKYiPS2kIDrneMQdMq4wnVW1MoIQ6LnTWQhNcaXE
	 nff+Rw72Mq9l6F7zb3E/8lMtLRoItgJ4zieJCA6Dm1Q5xhReybx006DWdAd8b68jWpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791876673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=g9oprUMbuCZa2Yy+rjY1RMkgE/Au1idVVNFLgNNSoMk=;
	b=dC58MvpRQPSUAuQazZH3vIqJL6iTr/JDIPt3RroKn7v6YHiQvAFISIo/8yPu9ruGlUhp
	 9gzA50ocHtJr6zwh4sexVgZ2KUPnOr4gwDshgXegVLwgsIYOQq7OkiP8xyT9dfGi+0FzM
	 AFtU6ZJaQRlgkHZCogdsnPN6MaseZTlFDJzqFovFWWtb+3aNe47tGNRYEE341dDMSmZGE
	 aN2NKNRd3bhsdp7AHBLtsZ243VeB9KA45CMzs3zmofwbcXdzwrfyqGmdP2Bdc1vmD7S1f
	 YBgCVKecxR+WVJXXxCe06GLYGPfDwkz/RQ9cUTpdY6Br2F8Os4YHtKvT6ZL7/hWzc7A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791876673;
	bh=g9oprUMbuCZa2Yy+rjY1RMkgE/Au1idVVNFLgNNSoMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=XIYy+dLCQVMcW8dCwKC4zl2YBLw366jxJXAihZr+S5E0CkvQbmbxyfdLzCSjP1J35
	 01iBjuI08B67ya76uKUTTSjtbsato/UklA8w8gX6pm2ykwi14J2+ej5YbFISpAh6e3
	 Y4zNNC9qp8dUvqlgPRtGx0udAZ5y0W8KIj+faHt8hkz5hNjvEolMqcKeDKxhbhgSe0
	 m3GrIay6KWJEtL8rLqKA68jpZN9SAPbCQjr2QCV8TisdBAZSEKtEzx/cU4oB8aonE1
	 f8+JykTD9PURE7juGWYQ1cUVPVmybslNRPegspTsbTB7zk2LWeSu/07Tm+O8GM8Mxj
	 6UYJHTMPfg2OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92643606C1;
	Tue, 13 Oct 2026 07:31:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F00E8788
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 07:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0450400AA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 07:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x5YHI-bFNosj for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 07:31:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DA9AB40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791876671;
 b=U15+XQhmz3AfGFmGH01gR0yaOl3yooUqPKePL5zgwPAsRzAqBVEbjAi1/oPLZzVBnvY7
 4jHJvdpxC6sTBcGx2+2uTnIJRuoBXU46inryvms8x7eZnnE31A/eBBqwdbYs/Y61SjtnT
 wzd+eAW67wxImR0zvdYP3vXno0CWA7rPcPVJ3coxoFwazToaZPEaMlB2Lvtuoat59coPP
 n4zKMrqOvaxXOA3xRVzibYXxjBuB1uBghBn0nrWoZaxDuSok+zkL56jEh2RlfeVL5dGQU
 jPPSiYoLhUjJvIc/qTDwqcENM/Iv8b8VeDbtINkKu2Kr8wYVtI5ZD5oiL0LDrjVD3aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791876671;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=g9oprUMbuCZa2Yy+rjY1RMkgE/Au1idVVNFLgNNSoMk=;
 b=pwnwqHDpHdm3lg0jhGTzn3ZKJdpUVdyMb0oPKp4c4rHf63yksC/guSfJTTInqDer7zt7
 PKznzrjArE492NkP85b2VlYBkQmqo/3kMBGwUcHg8+6DSSHQLmaekRO/NVM1ERHKxltoT
 QWLpfvRlulcTvNoPSd9XHabatjPPd2W0w+pscRrRT60dCSjNb7fsQCpRYzvcflFI1/T0O
 2Zh81oYOrJy9ScDPgUDNPccQUmRPWCvtfu6bn+QVun3ATwXlNTm03EQ8/ZO8/XJSZ5Q8G
 0sNnVsHkwJiZQzEF4JuaaRKsIINefU+zznOibw+78rKYYETtHtN44Yj6hRMI98Z/miQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TX2gvUl8; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TX2gvUl8
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA9AB40068
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 07:31:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2859443352;
 Tue, 13 Oct 2026 07:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E138E1F000FF;
 Tue, 13 Oct 2026 07:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791876668;
 bh=g9oprUMbuCZa2Yy+rjY1RMkgE/Au1idVVNFLgNNSoMk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TX2gvUl8NpOIARIQioZIyXfLshHAeEBVvP+8Yxrjs4uiatXmWAfV4eBbNIYefiw/V
 +Ll4hbYB7q/Jjr9NqyacHk9AtpXie78qBfEyyWZyD9rvprZ9kNHJhMhcUdODBrtvQN
 mXFK3xI8f6G+zwPbNlFk0TgQv5iCY5RKOhgfmh5ZAi2vkLlGv1r4JIL+j7FbcAkjdW
 ee5voAY5KpQmgVkgVI9ZBqQSROW6HA7JaXTXDRD2cpIFeohwfk9oed2IaIfxxwlVjE
 YErd3xAMkeeEZFGK4fhMUQe94WbYoMgQvX3zgdh7ewQpuXr3WD6aE564UE2rmVq970
 o6RxKsGrCJa6g==
Message-ID: <sashiko-outbox-169189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net] ice: wait for in-flight Rx polls before freeing
 a representor
To: "Linkui Xiao" <xiaolinkui@126.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261012072959.254206-1-xiaolinkui@126.com>
References: <20261012072959.254206-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 07:31:07 +0000
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
- [High] ice: UAF in RX path due to premature rcu_read_unlock and shared NA=
PI
--

commit 85b479dcdaa34d1d1340c09f178fce9d7d04ceda
Author: Linkui Xiao <xiaolinkui@kylinos.cn>

ice: wait for in-flight Rx polls before freeing a representor

This commit adds an explicit RCU read-side critical section in the Rx path
when looking up a representor netdev. It also adds a synchronize_net() call
in the detach path to wait for the Rx path to complete before tearing down
the representor.

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/e=
thernet/intel/ice/ice_eswitch.c
> index c32d6b201369b..0e5b98a05981d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -566,6 +566,13 @@ static void ice_eswitch_detach(struct ice_pf *pf, st=
ruct ice_repr *repr)
> =20
>  	xa_erase(&pf->eswitch.reprs, repr->id);
> =20
> +	/* The Rx path looks the representor up by its id and dereferences the
> +	 * result without holding a reference to it. Nothing can find it in the
> +	 * xarray anymore, so wait for the polls that picked it up before the
> +	 * erase to finish before the representor is torn down.
> +	 */
> +	synchronize_net();
> +

[Severity: High]
Does this synchronize_net() return too early?

Since the explicitly added RCU read lock is dropped in
ice_process_skb_fields(), the packet is passed to napi_gro_receive()
outside of the RCU critical section:

ice_clean_rx_irq()
  ice_process_skb_fields()
    rcu_read_unlock()
  napi_gro_receive()

This means the packet can be queued in the uplink VSI's NAPI GRO hash.

Because the representor shares the uplink VSI's NAPI, unregistering the
representor will not flush this GRO hash.

Could synchronize_net() return while the packet is still held in the uplink
VSI's GRO hash because the RCU lock was already dropped, leading to the
premature freeing of the representor netdev?

>  	if (xa_empty(&pf->eswitch.reprs))
>  		ice_eswitch_disable_switchdev(pf);

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/=
ethernet/intel/ice/ice_txrx_lib.c
> index 19307086c238f..e0712db9273cd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -235,6 +243,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>  		 */
>  		__skb_push(skb, ETH_HLEN);
>  		skb->protocol =3D eth_type_trans(skb, netdev);
> +		rcu_read_unlock();

[Severity: High]
Is it safe to drop the explicitly added RCU read lock here?

It seems this leaves skb->dev unprotected from being freed while the
packet is still being processed and passed up the stack in
ice_clean_rx_irq(). Should the lock be held longer to ensure the packet
safely traverses the stack or gets flushed from the GRO hash?

>  	}
> =20
>  	ice_rx_csum(rx_ring, skb, rx_desc, ptype);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012072959.2542=
06-1-xiaolinkui@126.com?part=3D1
