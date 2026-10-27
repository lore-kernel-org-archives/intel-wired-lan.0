Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0FB606A323
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=s3WcLN3I;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeyLHW12
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40E5980C4E;
	Tue, 27 Oct 2026 06:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ZWWnbd1bSrw; Tue, 27 Oct 2026 06:43:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ADC1D80C2A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793083417;
	b=ib6uHQVRafA0aXgYljC5LU5I8nAnsnjSlScPcmc8hQA4D7qBdXAt2lRLTTWKYlYMOLPH
	 ogpDrtSkBYxymc1B/2TCMVNiGa56fSwcNkR66xa0orwLuGHVXlDVSKIFfwn+Vz5exCNHB
	 wbnV95UsZhC8KIAiP2ddASZ4YlV4ZahVglBEJ8HL8+eYfPIr4/2o4PbaS66VUIhEpNRnq
	 EJlzwGNYj5roZBLt0+aJInBftIn3DopGbgGAGP+Snu7vlMyS21EZqEMaglw1dkHlAUuKx
	 +ELIh2aK8ahBLiMe+BsVy4bUjcgqtG9ZnIbPbT7AQHNb9GI6RhsLvnJpXWDcWZzhJcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793083417;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1rV7sJ5OuvWmQzcl5Y+LhIg6Y4llgh/mlRpgtM99hK0=;
	b=TpeMj5tiyq38cFMIc3D2summq2wsscsqhFXN7d+PVaR5qofd4uZ1Ra+Rv69qRjEzlmMp
	 p1hVH8CNAaEqfXYTb5mSQGS7w3lbvsNNgFPMmQFwbSKzq2OkqbwplHgALaA60sMRi6e1O
	 Dd54Gs4lsCTUr5jt7TbTqV+w0ujOubiC6oWOfv5/AK1y7ijvS2CnnLKw6foF2H3t0l/ph
	 geb7GBcoi1K2gJwipoLXTSSGdIy2bq+4DMoBOOgzKILfeSukV+UOAYAUk0hPSGxxg2n44
	 NiByJF4LGW0sV4BdJvYxaDCT1K1+PYPYSONv4KODBXmkpaPK6FvCxykmUJU/1gMrG6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeyLHW12;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793083417;
	bh=1rV7sJ5OuvWmQzcl5Y+LhIg6Y4llgh/mlRpgtM99hK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s3WcLN3I31GUept3zge6ojJRGKoJUapgwmqR34s7dGQbyJJy1j4JVxRjvlKCaqx60
	 NoX71UypVGC7J/zikomxi9mCWGrwqfi6R57fYh4aGDH+d9xM9mN4ynFTFdmWm4IE1f
	 ZPNZmW7Z/UUDDUn/YLZaFTa22NXXY5S2KZkwuDjQaBgEiKJXvx/ZFQbKszzTijBWcn
	 cHGjUAN4jDpfqCUngKthCuYHJ+a7b2O1FrE9vGOPUbzI6OJ8ICH2hgZZzn+UkfAlCq
	 gmhV5Xkz8ESd3ITpDhBjtGBNoHxiLTdUDiaAyb8dgwwiKUvTEwTnUeMy0Hukmcpr/X
	 DLEkUQbcy8eXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADC1D80C2A;
	Tue, 27 Oct 2026 06:43:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4919D4BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B07380C12
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:43:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DuowSixysCSi for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 06:43:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D8E680BB7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793083415;
 b=rX5AiiXm+XL0dLnBew29zhOMn3Thd5O2Do2S5p5dviHMtXb5HgZvDsHrLdpSWPB1etMS
 CfDFdGA+XhMXRkgf35tQyuYir3gtN9qSAtvzZ7fWyDYi2K0pMmnPDDzTKJga1Z/MR6E/H
 wxJkMB9Tofxn6zjwey1+iQyW2RmQDW98qi1ySczGCkZybiMQypAwBbuiyQCBk2H1b9+Dd
 uHlQ39rrcMR/0qWsNLS+gYLNiFIASFl3SM/epEW0cLAJE1R0GEyG9udSOb8YJa3Jxxy3C
 jibp4e4OsaQ7ZPBENWTh7nYnCZ/nNg0Lk4uAP8K8OEIpakSCdqUU93I1+6VoSvm7vbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793083415;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=1rV7sJ5OuvWmQzcl5Y+LhIg6Y4llgh/mlRpgtM99hK0=;
 b=hZP9srwWbYY1hqAGBbNRZsj8Vm1vONyWj5Mv6NGhagpHGo252B9SY1yBl+slx2xxZpAO
 7h8TwqW0mYigYRrY3PLNXUBox6u+3ls1oXDG5GtXY5KH7DrbdM3En5lKEHO0kOFGlztGX
 cT1SJZWGCiyofpikblbPUIwQxVZgzVSsv+X0GMkn5YmwMV4na2IHMS5gW+WH5hTssaTfU
 0MGjps8uiqSkswrRs3H6MRcTATOd71tyX9ppcecOVob1JVR5adC+/KnihO5V0znShBhOA
 YRzi0xWia5FhT31cG5jq0PghKpQbNgaB0m/JAc9FO2fjURnpKn2JnS7agPlBsp40AKw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oeyLHW12; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=edumazet@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oeyLHW12
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D8E680BB7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:43:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70AFC60213
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA9C1F031ED
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793083413;
 bh=1rV7sJ5OuvWmQzcl5Y+LhIg6Y4llgh/mlRpgtM99hK0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=oeyLHW12ZBVJE6WwsG5A6uwis/ZOX7lxJXy+K6wLdbIGwF5dWUB7rRaEIA2sOn484
 KEbamJPaydrLoq1Vo0IljG+Srs4rgLh9IaAnlw+HVuHY+mZXRMVsXdp3zfmn8Kb112
 5mifVnj/u5mFKtH47GvCltgVRGPlXKvHccHv5zRgknF6rxSgxUIdYgJ3jJ+NPWp4aP
 fs7r2yLCNDTnTn72pKo6w41h8TUnttVlWG57bPK6kHWwk1zruD4Gy5SW1BDZWws8aw
 QuE+d7omHnJ64LXfWtKiZOm4e8pfJ2lvjvygxhS6zK5Wx9SePtpSZAjFEgZpBtZTu6
 9NccuSBZLvfkw==
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-53ec92375d2so1703654b6e.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 23:43:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBz16/qqGH8yJXqOIDpDJvktoKvI6P5fqiIhATJROXafZf9EfEsOc1sb1yX8dQG8zjnousoxywb2TS+0txgYbmA=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKTYtyw5/LhZFpRh7+14KYKibbnBOHC+Ut316pA4WlpxD1noCc7
 pQ49SwQqoVWyz2h2SyqM+a+C+Y426Avi4TaaensEjAlQxbsdnyU+exofkXLx/2dEPA8QentDXQz
 aJBMJVGCF1XEbSeN3IGtltkknp8s1j2I=
X-Received: by 2002:a05:6808:220a:b0:4ed:7045:d3bc with SMTP id
 5614622812f47-55c002d9ed3mr5982970b6e.32.1793083412383; Mon, 26 Oct 2026
 23:43:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026091549.605810-1-p@1g4.org>
 <20261026091549.605810-3-p@1g4.org>
In-Reply-To: <20261026091549.605810-3-p@1g4.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 07:43:21 +0100
X-Gmail-Original-Message-ID: <CAL4WiiredhAG-x2Ls8moMLprzOt2Ua0E-eDSXk7Che0QHQ3E0g@mail.gmail.com>
X-Gm-Features: AclHuK8M6VbpWDO_HbzkaGdWK1HEj-x4xPb3ExTmDRcyeOQYYZiLPbtFqH9A-VI
Message-ID: <CAL4WiiredhAG-x2Ls8moMLprzOt2Ua0E-eDSXk7Che0QHQ3E0g@mail.gmail.com>
Subject: Re: [PATCH net 3/3] igb: prepare TSO and checksum offloads before TX
 timestamps
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, 
 chwee.lin.choong@intel.com, faizal.abdul.rahim@linux.intel.com, 
 horms@kernel.org, vinicius.gomes@intel.com, sasha.neftin@intel.com, 
 matthew.vick@intel.com, aduyck@mirantis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le lun. 26 oct. 2026 =C3=A0 10:16, Paul Moses <p@1g4.org> a =C3=A9crit :
>
> igb_xmit_frame_ring() takes an extra skb reference for TX timestamping
> before transmit preparation. For GSO packets, igb_tso() calls
> skb_cow_head(), which can reach pskb_expand_head() with a shared skb
> when the header is cloned. Commit c7d8bc3dd511 ("net: skbuff: don't BUG()
> on bad arguments to pskb_expand_head()") replaced the BUG_ON() with
> -EINVAL, causing TSO preparation to fail and the packet to be dropped.
>
> For non-GSO packets with CHECKSUM_PARTIAL, igb_tx_csum() falls back to
> skb_checksum_help() for unsupported checksum offsets. This can also
> reach pskb_expand_head() through skb_ensure_writable(). igb_tx_csum()
> ignores the error, allowing transmission to continue without completing
> the checksum.
>
> Move TSO and checksum preparation before taking the timestamp reference.
> Add the timestamp bit to first->tx_flags without overwriting the offload
> flags.
>
> Fixes: 1f6e8178d685 ("igb: Prevent dropped Tx timestamps via work items a=
nd interrupts.")
> Fixes: 6e033700887b ("igb: Add support for generic Tx checksums")
> Signed-off-by: Paul Moses <p@1g4.org>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
