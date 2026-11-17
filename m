Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC97606A32C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=b+3bQl3F;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ejKgEVWH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 767C440838;
	Tue, 17 Nov 2026 20:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MtnVFZAtxKXM; Tue, 17 Nov 2026 20:57:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C787D40881
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794949043;
	b=C4CHJopVBsfxWzOYflt5Ah1nI5a7sDmzFsm0KpTu7pRbWuZlI6tCToY6AmmVqWSTBdXA
	 6bcuBa01wsGxMuzxDachxguZ3h/Tq3RdF7DGL/bTfvXXV+gmKbrSc4gBu/jYbvIV0mqbz
	 vJoBlU7l1I0sDZUuTXns+2uossJwDIaDXMhxGesyEFGS/ifcRUT4aW9Qkbukzd58lBJGc
	 XEPrWagv+96AeaWfVRmsC8Gao6SS9ICpFMcBcLB14bbPB9w6vCUv9Bi47u3dnfy/kB60s
	 6GmeRbrxT0K575ypF6XAUtEMsxXprGIukKP/OCamkF6G7yoArUkpymy7tWK+67SS2Tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794949043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xJYRSoH4guj+EsNxTlD3hMwy4BVgc6CPsDY4Mrde2lU=;
	b=IAHxoiAiSy6nNemCxGkxjM1VqD0iH2LBBux7VuY556Kh0cOEDQ1EIeHavDXuFo9NBRsT
	 txWW5IPXPPZpTSQY1HCGPJdE9O42lDdVneppTGKRN3x+ZKU34TAy2dEpUzfcWjGaxVdWR
	 xZJ/8Q/wrlPStWnLW0ZMfpp5B+1dY2Xi9FMqOjDQxOhAPBe09K6ING19TrEZpMbZxWgTX
	 ffwE1DVwV3LbkZpRm80NperZlDpzj9HhcaZ5WRzsnKX3AKAhufsBTkI9QLeeFDU4Y/ZPM
	 aRtT1YOSOzr5RPIOVUwlMOlgWUkWCkIubtyRIsWUV/bTOT2WGz1NKk35Azoh/WcK+Ug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794949043;
	bh=xJYRSoH4guj+EsNxTlD3hMwy4BVgc6CPsDY4Mrde2lU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b+3bQl3FPgFq4rPh/Uwwjn1erp8n8Q2MNzEvYVl6mPEzc9art+AQos6+MvV9cyVMW
	 +GZ2pVcpF7uAguyihF/FrRhCG1NXuA7ckKARFTj3io/veFlaV9VL1SDSIhKugunKCQ
	 U4ESNOftNSc/qxWETJNjod2M8nBsVxn7CzIaqNWkTMjiQnjDf++LOofSaTtfBhctMG
	 r4QEmKZoB6Cj+RzldwwL0aAxYRskEEBzBD/1VgsYQUGxd+syxJFNfHeAUF5GyOUPAC
	 EjUi3n7GwEmusYL0Wd2AyABxjS8LvulliQj3R4w7S1fz+kCZ2DgDoOxbkLe9fPEukH
	 ZDbYBg5/oFtnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C787D40881;
	Tue, 17 Nov 2026 20:57:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB7909F8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 20:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD36E4030C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 20:57:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id erpC11h_7GQk for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 20:57:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E6CBE4005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com;
 envelope-from=daniel.zahka@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ejKgEVWH
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6CBE4005D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 20:57:21 +0000 (UTC)
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-91f2b826fe9so1393786d6.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 12:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794949040; x=1795553840; darn=lists.osuosl.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xJYRSoH4guj+EsNxTlD3hMwy4BVgc6CPsDY4Mrde2lU=;
 b=ejKgEVWH5qTBMOtnWNRVZ0/c41kh6nVb0wEPNA9o6C4UNxXSp3AbLaqIP0iA5NQQcA
 PDJX9FYgD1TsLUfI654YKJZqDs0A84KeIb7CVtTgiTGufAB/kaKXsyod6OtIugyYvQjh
 cEoBF2Q+viEuA/rGLMaCFiQR0ieyCFKo/dRruHoua63IQkOrhkqOCjHngNBdYYqqBjrr
 myCqKgwm+fttwv6kL3eyNa3UWu1VHDYY97U3RZSSMbqRLPEZ4XQ+XqQ1MS85eTlfyMhS
 Ajq5YMNXYhsxCPEroiU9Rf/TXTDkHLvNWc3qSAb9L61H5ZIeloEgatPfFm52IKMPH25q
 UqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794949040; x=1795553840;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xJYRSoH4guj+EsNxTlD3hMwy4BVgc6CPsDY4Mrde2lU=;
 b=zU4HIikurO8VmErxVfRfW0rtAORtkledZhNsYl1GEsTL5auagtDPEvU4ICCkp0wx8x
 i33PI1pNLmOz2W+2DlDoZnGSO9zj5TqRvq7glJrluduFWuZBsXCPBHf4ZZPkZWku+Qrt
 gphn5Fdo5NPWVtIQ2JZPJdyDDGjwOg6iPx200cAj7B61/bPTBbnEBohULEjc3962nb5G
 xEaERShhf8zU9F7TsE/ahzPSEDUpzILOEwXw57qL0sqVoemrrc4jBAuVL642PmT76qZ3
 91j19vZCZWoTsiao20g3Zlb2p9JlJIfGTR35BNoklDAgQCJ3wsOx20WsjFMD03+qIz7m
 6LBA==
X-Forwarded-Encrypted: i=1;
 AL+hErH6WI6rgo6q/84p/7NN5FycIsRbARd024wUbHRiDVr941S+iuHGYR94ERlJmc/VxWXnqp+phRWDNhrNhi4vT44=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8NajpSjrVk+B3nwOZD03pGRugLZZfUHzkXz49MZcmh5Oh73xBk
 rW4C6fbP8p3DijHyVcQAZXP8GnkTyXp8eehcg+i6PPKlh+Ic1Tq543bu
X-Gm-Gg: AZFdTZeLpwVCtu7lBC9jHZGkjVk1E2FNVXwHFIH0wtEEZS+DQox3LUVa6JINDYYfPm4
 pM+U8ChtDOisJcoIbVaHMnyENhPQVX44UuXTcxw4uAuls6HY3dSeHHyGrDgHrl7gnxsWY1xbPQm
 gC6xpGoBfIbMrp5iWABJgbnelFgM1Ukg7DEECdhuoREeNhCpjTD9ii37AAE6yu9aBGi0MAdRjOV
 gbNhith4EjOQRkrbhJeRJQyTV/MI6E2qcOvTKGGfmfmix4Evohssl35E4z+IinwO7RC676Si+bB
 rLaCqckGkOk09psA6ZmPH0+6Yx5CCI3KSw1VH8x+/av++CFy4GMzfhx1S2kyrD3E+gkge66WFS6
 kjIo5Wkb7TTalwVP9tm+8l6iturB1r9DpHIHyko7sflKW9cGD5MFGHS3JwcRX1Ww3JLk1vUxnoq
 6gfep1AqzDa666PR2y0sox+rcgkTjK7TuTiyg4w4MZ03Plyhl0zCCnv511lV322Q7zWnz+CbSHQ
 1bOClUBppxyhNE6q8Zm4EyvLHWFuH59vKajtF0Me0S/av5GX1YhBPzczwmU1Vtc4ofJIhN+P1vC
 m9wWl9xlbuZP5ce5b+03chJ4r97GOmTaEUYJQ/jYThgUwN+nZKiv6Uk=
X-Received: by 2002:a05:6214:262e:b0:91c:7c53:152d with SMTP id
 6a1803df08f44-92114dd31d4mr7334636d6.29.1794949039986; 
 Tue, 17 Nov 2026 12:57:19 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92114d70c5csm3329646d6.31.2026.11.17.12.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 12:57:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 15:57:17 -0500
Message-Id: <DMXSBWB0425F.1NVVQK5JZ4IIW@gmail.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, "Madhu Chittim" <madhu.chittim@intel.com>,
 "Emil Tantilov" <emil.s.tantilov@intel.com>, "Sridhar Samudrala"
 <sridhar.samudrala@intel.com>, "Brian Vazquez" <brianvv@google.com>, "Li
 Li" <boolli@google.com>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Daniel Zahka" <daniel.zahka@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH iwl-next 08/15] idpf: psp: add support for psp rx key
 allocation
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Stan Iliev" <stani@google.com>, "Tony Nguyen"
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 <intel-wired-lan@lists.osuosl.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261117145522.1910636-1-stani@google.com>
 <20261117145522.1910636-9-stani@google.com>
In-Reply-To: <20261117145522.1910636-9-stani@google.com>
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
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 17, 2026 at 9:55 AM EST, Stan Iliev wrote:
> Add support for allocating PSP RX keys on demand:
> - Introduce VIRTCHNL2_OP_PSP_ALLOCATE_KEYS (560),
>   enum virtchnl2_psp_allocate_response_flags,
>   struct virtchnl2_psp_allocate_keys_request/_response and
>   struct virtchnl2_allocate_psp_key_v0/_v1.
> - Implement idpf_send_allocate_psp_key(), which allocates one V0 RX
>   key with a synchronous request, validates the reply (key type,
>   keys_size_bytes, length, and an SPI with a key ID, which the PSP core
>   requires) and wipes the key from the mailbox buffer. The key, its SPI
>   and its master key generation are returned in struct idpf_psp_rx_key.
> - Implement the rx_spi_alloc PSP device op. It gets the adapter from
>   the netdev of the PSP device, as the vports can be freed while the
>   PSP device is registered.
> - Keep a copy of the vport ID in adapter->psp.vport_id, for the same
>   reason.
> - Wipe the RX keys of late replies, which libie passes to
>   idpf_recv_event_msg() after the request timed out.
>
> Signed-off-by: Stan Iliev <stani@google.com>
> ---

[...]

> +int idpf_send_allocate_psp_key(struct idpf_adapter *adapter,
> +			       struct idpf_psp_rx_key *key)
> +{
> +	struct libie_ctlq_xn_send_params xn_params =3D {
> +		.chnl_opcode	=3D VIRTCHNL2_OP_PSP_ALLOCATE_KEYS,
> +		.timeout_ms	=3D IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
> +	};
> +	const struct virtchnl2_psp_allocate_keys_response *vc_reply;
> +	struct virtchnl2_psp_allocate_keys_request key_req =3D { };
> +	const struct virtchnl2_allocate_psp_key_v0 *v0_key;
> +	size_t reply_sz;
> +	u32 spi;
> +	int err;
> +
> +	BUILD_BUG_ON(sizeof(key->key) !=3D sizeof(v0_key->v0_key));
> +
> +	key_req.vport_id =3D cpu_to_le32(READ_ONCE(adapter->psp.vport_id));
> +	key_req.num_keys =3D cpu_to_le32(1);
> +	key_req.key_type =3D VIRTCHNL2_PSP_KEY_TYPE_V0;
> +	/* key_req.domain stays zeroed: VIRTCHNL2_PSP_DOMAIN_NONE */
> +
> +	err =3D idpf_send_mb_msg_stack(adapter, &xn_params, &key_req);
> +	if (err)
> +		return err;
> +
> +	reply_sz =3D xn_params.recv_mem.iov_len;
> +	vc_reply =3D xn_params.recv_mem.iov_base;
> +	if (reply_sz < sizeof(*vc_reply) + sizeof(*v0_key) ||
> +	    vc_reply->key_type !=3D VIRTCHNL2_PSP_KEY_TYPE_V0 ||
> +	    le32_to_cpu(vc_reply->keys_size_bytes) !=3D sizeof(*v0_key)) {
> +		net_warn_ratelimited("%s: invalid reply of %zu bytes\n",
> +				     __func__, reply_sz);
> +		err =3D -EIO;
> +		goto release_rx;
> +	}
> +
> +	v0_key =3D (const struct virtchnl2_allocate_psp_key_v0 *)vc_reply->keys=
;
> +	spi =3D le32_to_cpu(v0_key->spi);
> +	if (!(spi & PSP_SPI_KEY_ID)) {
> +		net_warn_ratelimited("%s: invalid SPI %#x\n", __func__, spi);
> +		err =3D -EIO;

nit: seems a bit defensive not to trust the fw to provide a valid SPI.
No issues with keeping it around though.=20

> +		goto release_rx;
> +	}
> +
> +	key->spi =3D cpu_to_be32(spi);
> +	key->generation =3D le32_to_cpu(vc_reply->master_key_generation);
> +	memcpy(key->key, v0_key->v0_key, sizeof(key->key));
> +	atomic_inc(&adapter->psp.keys_allocated);
> +
> +release_rx:
> +	/* Don't leave the RX key in the recycled mailbox buffer */
> +	memzero_explicit(xn_params.recv_mem.iov_base, reply_sz);
> +	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
> +	return err;
> +}
> +
