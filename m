Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714A3606A337
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=FJFKXOI9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNplFQEp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4941B80C41;
	Tue, 27 Oct 2026 06:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T-f_HObpF0RK; Tue, 27 Oct 2026 06:42:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A6F3A80C23
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793083330;
	b=hMyz5p0ndXUeFjlSNadUP5VS3XjgIppkRJvtlLGxirALhnWhk7Cga9hOWBALWUKfqInV
	 MKxSSwxYukTb7On1rLsUB32nyVSMmYz73+gUiTSE5JarjnV0G4nMvAOesU/Kn2NdA6gRG
	 YChgttwSeQ1BU0TL48U155+DsgvNgs73MDiUfqbVEZibGaB5PbPSyp08EohXZPrNsehL2
	 Ihw7w5tcM8U3HnwXHUWxnWX/0zf9mAy3IfaRWfwtIwmPWzXV1w4XmHQGwxBJr1/SU8+fC
	 U9+IPXQZuxraI8UuSChMvrxMIHmddjJi0QL8tANQ4dQiqnq/LZ/HDS2awV3J5MwmZKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793083330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yhV6Qi8oP3wsBHx8AcQx+K7PgSHJp9dJD4R1lrCW+YM=;
	b=ShvnS0foaWL8f6ZejqzR/MjfiksrML0Zpvq4K3zyk53vQm0HM/U8R18odqWm7/775FXC
	 aXUL4jY0u5a2GGfd464VLunNEJOzATzUFg7Y0VLPnywERtjrBpXsYosrZeT1f81G3YHPy
	 bjUZvEa6zx8pSwOHoqdK3m0KXFG5hSAtQ5SOrpGwSLsUslGMLSNZ2LRIQlJPBdhEB2DAP
	 XELhCC9U1uGFlkj8pgZjT5VjHQjI41IZxQUWxHt8vT3kK7MTHwHTg8AucJsx7ca+yEeri
	 aWmypPH0f9ViD5i1/iMirz96V0IiWbXeqLwCGrv5VhANwCY+fsaBNAqJWHwvlx6Fy/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793083330;
	bh=yhV6Qi8oP3wsBHx8AcQx+K7PgSHJp9dJD4R1lrCW+YM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FJFKXOI9AHcz6tL5NwnkGGh7eJtEykdBA/hBkgiSuHYQdOGPUKqlfV+HL8jfwHKoD
	 JTGs5hxXoNz53NHBrx2dKEOZzjZsJKwDqXhiSu9Mc6TVpQqlAyZFKCPOW5t5vrJ5q5
	 gbxxG2v9fSpD4J9SL4K73CEDYXiOROsxYdHXiY9V7dNPp7yHCUZeE+AVqUnd885itk
	 AKp+18jRJrH4IcUINGBlo9yE53qJGSi64l25U60Bi06R5JGYu2AYM8ljRX3PSLqUUm
	 oikEEXHuhmcGH4Rvyz1YWl1N+j859frycmUPlsP4j5GjZ+AscYzGghEP3HT7Zh1fh3
	 hdVx3T8QwrVGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6F3A80C23;
	Tue, 27 Oct 2026 06:42:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3653A120
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33A85400A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aO10dluc8Ed1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 06:42:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 92DDC40062
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793083328;
 b=Oq2KFthramU+AhauLhylLsyHGkYk+28HEx7/oemAT3QIG/P3v+G9GMFqTGSktqXtYMte
 QO83ckgmFo9eAMYn57UFPXTDIiAhSAdwzvO8tOk27ejkwx1L2u+KPHfBKj2PR/Q0PeGVA
 ws57xK9QyLWIOFwgO5q6KgB7AVMhffEc+XEn7Pdpe/gqNExPqaqPmHxoesYwW2ixq8HPq
 Wd36+dZvW6wC/+DO+bpQ59pYOaqN/6RPuk06aqpFNgWPOOWfuoE5QM3t6CjUwta568b8Z
 19fWxn6dmdjC75Mrip6NsIeDFDGUccBA/kGSrmCU9I3D3ohYREMgG3Nlf9vNFcp4wBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793083328;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=yhV6Qi8oP3wsBHx8AcQx+K7PgSHJp9dJD4R1lrCW+YM=;
 b=DoeHHv0+AI8ZzIPU2fFqlWOv61ImC+8fKmkycNgKIfbMRdSM8FV3gLJoyEQs0nzUffk5
 q3f1lDU0e+9OSrn16X909mGO+C9mRc0/0HDdp4Y+36MmscUhQDuohgYFRZfpmDznhc8HT
 uzRv4oCRda0VWbQ3yLShFDsMPurBFA3S8G/H2dyn9Ycm1LYWAVIv1j/9VbcJTTUEbfsH4
 hdeXblTSwYAm6UwfQZLY5/EPlh34o+aYXJe/F8pJJ6xZZcmXGfT1oNaAaY+7mhyCMG7BX
 L27liTt7xSKAJh3AmrnhNh8EXbXUf6mLYYPVdWL9wrH6ZiZMbj+gVJsLMsARn5hSBuw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MNplFQEp; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=edumazet@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MNplFQEp
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92DDC40062
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:42:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD90043FFE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C861F031E4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793083327;
 bh=yhV6Qi8oP3wsBHx8AcQx+K7PgSHJp9dJD4R1lrCW+YM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=MNplFQEptICEhgYJEua7ll4vbpkZ3U4mW5gzoB9k9tFiKtGPh1NUtHH2yKlqtqje6
 4CnEPm810ZP/xLDxZChQFFgEJk9TNsENn9fiq1yStPJcuTzBRMbVv02wuqRBwVbnBV
 HiQVkd8JF4JH9pigNWgf8Pw4QjW6+S1crroRxGUuHxY7LXqkK2LJY/vsSTgnG7U7BY
 KP+qDId99WGr3qW7C+BVHAD6hVzZ9BGYu/naGz1QCmLr2P2QY47yeVMvw6JN7ENQWK
 VZEvJl/PJE9HewuNCjAjnWdES2f0IOHTpcPoxcU3qjIxqgDIMIthmtfZAFk3eDoyKN
 4zvTgKXDoktrg==
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-70059e4dab6so2670260eaf.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 23:42:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzlrnUxm/DIqyHCgDzvsg6UZx9Pes39Mcjl1nWHmuFxVz9FAoLVJvEfbyak0NXExtekEFvKH4ReBsigntz5m5w=@lists.osuosl.org
X-Gm-Message-State: AFq9FYK/G8K9BvEkVBFQrpc7PL3D02SHjkZTv3N0McrPW0S4E4QMU/W+
 CpEyY9w+Mf/1dPNxEf6xW+2V8ixFXeFx9EEEYPce9ReK8OhxdsYN6j8utdFeItlVyJScQgbSYTZ
 BZdjPoy4t1fRalJatb6/8QrGzrOr3MGw=
X-Received: by 2002:a05:6820:616:b0:70b:a4a8:a32d with SMTP id
 006d021491bc7-70ba4a8b55amr4429661eaf.30.1793083326837; Mon, 26 Oct 2026
 23:42:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026091549.605810-1-p@1g4.org>
In-Reply-To: <20261026091549.605810-1-p@1g4.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 07:41:55 +0100
X-Gmail-Original-Message-ID: <CAL4WiirG9+kP8vTNgSC=NfWA7eqnoDHZ6UMJ4bBEYOF7oNg4NQ@mail.gmail.com>
X-Gm-Features: AclHuK-_ZepuWsPA_tB9v5pjt92BBzYdY9sMEaBbm3_-uA4NkNald1VGOO5yyE8
Message-ID: <CAL4WiirG9+kP8vTNgSC=NfWA7eqnoDHZ6UMJ4bBEYOF7oNg4NQ@mail.gmail.com>
Subject: Re: [PATCH net 1/3] igc: pad preemptible packets before reserving TX
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
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le lun. 26 oct. 2026 =C3=A0 10:16, Paul Moses <p@1g4.org> a =C3=A9crit :
>
> Preemptible queues require software padding so hardware includes the
> padding bytes in the mCRC. Padding currently runs after TX timestamp
> reservation takes an extra skb reference. If padding needs to expand
> the skb, pskb_expand_head() rejects the shared skb.
>
> Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
> pskb_expand_head()") replaced the BUG_ON() with -EINVAL, exposing the
> padding error path. skb_padto() drops one reference on failure, and
> out_drop drops another. This can free the skb while the pending TX
> timestamp still holds its pointer.
>
> Move padding before TX timestamp reservation and use __skb_put_padto()
> with free_on_error set to false so out_drop handles the skb release.
> Preserve the VLAN flags in first->tx_flags when adding timestamp flags.
>
> Fixes: 17643482e9ff ("igc: add preemptible queue support in taprio")
> Signed-off-by: Paul Moses <p@1g4.org>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
