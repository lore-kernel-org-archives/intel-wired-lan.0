Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89420606A331
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=z5BOrRRg;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nqQTH6bh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 470DC811EA;
	Tue, 17 Nov 2026 20:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLnvwkfEhM6Q; Tue, 17 Nov 2026 20:40:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A7353811D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794948011;
	b=k7T9DJTmJ77d9qxMXI3XKJ0qQSzxwe3tMEAFo+WmiHu6FG8fZMJklrEek3/xx/G2XUpn
	 Bei3c0vgcBS4YVDYAXfmlyEhkk/taEmkmZ7LyzEULA9ZHazijPRdRPPXQhv997UFbxUZq
	 oBfUmYVld11M3HSJfDSoTfx7KlcU0cxokJXwxqkMxjQUYXYc1+7UxXMQQyVHXqrpfnayA
	 fReEEMQY5h9/DN6RV5B5j6T7lzow9g1GtrXfUn6YIOYUzNjFG1gZMqM/xupJTEBpDBk8b
	 6CyWQA3shGU1S72JqlYAF8Jgy3qIxSWckL8qHqOtX5nGZ4DebPDyWXpG5hMfT+SfILw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794948011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+zkjXBeMkEDc7QufXqaSGB6NEDq0WBn2vnhWa4XM0nU=;
	b=sCjAyaqtVZPqP768yo63ZkSI5qDZZJ1FuMIgOuDt6MsT4RPa+H256pUPZUj6orGZBmbg
	 lRh3aKbjDiPb8JIqKXvStVxA6/1W+YPeouyOr7HbbJuAEF5n7BZIt0NYVrq8uCD+Mof2O
	 v0vcaqVAoTComB2utuARPAGr/mXzhNf3TvPUym1IeaXx6mGQKJTdbsuVKpdYHCB+SZBzv
	 SykbA0vrkCDhs67koJiNz7BSNuBmIqktFYpUcrtdE5vHra9pkH7Vifg+nLYW1u2Rs83W8
	 H4SwmBRHAvgOoW7w7m7KqUqlHyF9ERUl1A0vzimo5gIfqXcciMzP8HHJz4CebZhVhAQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794948011;
	bh=+zkjXBeMkEDc7QufXqaSGB6NEDq0WBn2vnhWa4XM0nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z5BOrRRg/pRGaEmbxCcLsenFC/wAJFpE6l0k5DCLaxq98ssCUy1tAqzfvGCB0TnWj
	 fepxPzPP2n19MU1XCWWDkFpYkm0Jz6lZQLvJ2NYe4zjFdbPBQRCOgV4u1EuFRd4ovl
	 b1knUxfSdIKf/FiXojxFkG+GW1c2kuhgF2xQ/KaW7d/ac7QM+brG/PqzrEm7D3nT2x
	 BsFSNt2olDMrHuvPM7SQAHf56HHMPQvpqqz/CZrDVCm7aGTratG1h/E9enDSYxAZMP
	 KeN5GzbUgRG84Y9thCIlGC8MG5nHNPfWsZI0Fn9I8X2an1iYjGyFrkBmgbSXIkfi/G
	 b6b1GyPOv5Yzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7353811D8;
	Tue, 17 Nov 2026 20:40:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F127A0E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 20:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9073409B9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 20:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lm2yiphAsLRf for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 20:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1624D40913
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com;
 envelope-from=daniel.zahka@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=nqQTH6bh
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1624D40913
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 20:40:08 +0000 (UTC)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-92106d5371dso1474646d6.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 12:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794948007; x=1795552807; darn=lists.osuosl.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+zkjXBeMkEDc7QufXqaSGB6NEDq0WBn2vnhWa4XM0nU=;
 b=nqQTH6bhtyyt6skMXHlg554REXkaLzcCGJ514VM0HmDXA1CIQy762M7hoMxZuL9vG2
 JR78WB7dLJZEXOFMJ3cv0Q3lwq6SO0vVQIdgmJ+OZxMZg3ji6QUiQE3N13Sw8gleBYnP
 2oAIrAe2JDOdgRXrC7blVgzXVfzONgsgkLr5DMiTDqJvykvq0H7RtYEYnubtPn1iQINd
 vO7lbtlXi6OC8tXmcC9Hpr8R5JBEfP4s/4aK7EolDkbqwFQQM3F8M1Axdi39y6Reo7hV
 PDwykN8mdfcZD5AQqurc6e9NhOCmaNPQXRF1+cW7PI97Ey6uRGa7BFcxCBVR76Gu9iiC
 vSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794948007; x=1795552807;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+zkjXBeMkEDc7QufXqaSGB6NEDq0WBn2vnhWa4XM0nU=;
 b=o8GAV0B5mDfFwW0r25NYn1lu2IDJc6w7+begt6rxND/lyxMQ4pO3oj6+ecJ55htbdG
 7T3BHrZaUztoIlAag/qMVYCAFhLGbu4TU+dzsn4H52YU+twxe3znIPk/OHzsj8BNw8s8
 7bXLUzbEwZy+wrcfvu4GjvDI7YRxcAuhH+0B/KxzgxJ7/wA4fWacegem3RqBm3DrhZr0
 cjCCLtEYgm5mE4H6vNyAI1g9g2J+De6P4ihCw883d6JBjotmo85pwPMKYyLlbZxULPSq
 IOj9jBHMIqi+KJOeLtFN6VTXT73xHpGzzli2+VXPu5Z41hAFGhtfy6wGjMwKCUguDO6J
 xW4g==
X-Forwarded-Encrypted: i=1;
 AL+hErHyRACjzu2WrOc5YKw81fHZQL+iWfWMOAKVFk+fcSfVDeEm4AZT5eoLTR8WHB2AHOSwoXIkYLsL9xNYWv6WONU=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+SXOnuAB44ABVmx6hTZ5CLZQyl2rmdhuxOxgtIhZSoe9mEeGYE
 tWxuMTzYHqJMNjbQn6641AuokKl3dAZ0XBsig5hscbX0DUty7Dv1tcNh
X-Gm-Gg: AZFdTZdCSyMjcJKwat3t++2xRB9qIA4fa+b6yUfvVqOVoYGfSFOXvlT3WZbXLbX3XjT
 AbAbAtz4weEdm280pzFSHBouQX0xbIgH1svzUuFpahpOULiGwDLZUFh0GpZgspF4Enyq+DUFAH2
 pV4tp3w8+05Atn6VAZSxy656q9NEoa1I9UmU8wfAdXG8MW6xbyBJGIGCF6ly2oevbQ4h41VU4mr
 VP9i7RPkLBKl1fX5lW3NTwJh/0+mPZoeIfYz89YYY4+13cMELHDmie4D2nZ9NVlC7f6lu1NWMo/
 Zq6mCx+FAVAiWKGk6ykWT0tuPghc0SmssbMWispMrMn3lXGuDW1zS0QCU8FiOvoPjKhETpclzsO
 PDoWv7XGo+bODGJJUsgP5IchF3JBed90F8GZ8n0aVOjCGWRdGOe6ZnlcRz+vktOW4/RMJBBrDEw
 S6fP+NITRoUHgV8nvgSnAd4gkqzPQ47UBzWweg+jWcnH8wLrUjLLStPhjgjdpY9CTaDi5CullJG
 p6KqX9tF2crZklHBn12264e3s7ayoJy4oGd9rYmm07VVJ01/78u9cPd4lo5VuijY+JYy1gLw5KW
 6bgYvLkBaA4B+GuGmhoI37zf7RzpbtUGqw==
X-Received: by 2002:a05:6214:449e:b0:917:8c2d:4283 with SMTP id
 6a1803df08f44-920fd36e10bmr57938796d6.22.1794948007115; 
 Tue, 17 Nov 2026 12:40:07 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92114db5db5sm2876646d6.43.2026.11.17.12.40.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 12:40:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 15:40:02 -0500
Message-Id: <DMXRYOOJPIXS.1DIGZP64RMRLW@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Stan Iliev" <stani@google.com>, "Tony Nguyen"
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 <intel-wired-lan@lists.osuosl.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, "Madhu Chittim" <madhu.chittim@intel.com>,
 "Emil Tantilov" <emil.s.tantilov@intel.com>, "Sridhar Samudrala"
 <sridhar.samudrala@intel.com>, "Brian Vazquez" <brianvv@google.com>, "Li
 Li" <boolli@google.com>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Daniel Zahka" <daniel.zahka@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH iwl-next 07/15] idpf: psp: add support for fips
 compliance status
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261117145522.1910636-1-stani@google.com>
 <20261117145522.1910636-8-stani@google.com>
In-Reply-To: <20261117145522.1910636-8-stani@google.com>
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 17, 2026 at 9:55 AM EST, Stan Iliev wrote:
> Add support for querying the FIPS compliance status of the crypto
> offload:
> - Introduce VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS (567) and
>   struct virtchnl2_get_fips_compliance_status_resp.
> - Implement idpf_send_get_fips_compliance_status(), called from
>   idpf_psp_init(), which logs the status as
>   "compliant@cmvp_cert_<a>_and_<b>" or "noncompliant". The status is
>   informational only: failing to read it doesn't disable PSP.
>
> Signed-off-by: Stan Iliev <stani@google.com>
> ---

[...]

> +
> +/**
> + * idpf_send_get_fips_compliance_status - Get the FIPS compliance status
> + * @adapter: Driver specific private structure
> + *
> + * Query the FIPS compliance status of the crypto offload with
> + * VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS and log it in the legacy
> + * "compliant@cmvp_cert_<a>_and_<b>" form, or as "noncompliant".
> + *
> + * Return: 0 on success, negative on failure.
> + */
> +int idpf_send_get_fips_compliance_status(struct idpf_adapter *adapter)
> +{
> +	struct libie_ctlq_xn_send_params xn_params =3D {
> +		.chnl_opcode	=3D VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS,
> +		.timeout_ms	=3D IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
> +	};
> +	const struct virtchnl2_get_fips_compliance_status_resp *resp;
> +	struct device *dev =3D &adapter->pdev->dev;
> +	char status[128];
> +	size_t reply_sz;
> +	u32 num_certs;
> +	int len, err;
> +	/* The request has no payload, but libie can't send empty messages */
> +	u8 dummy =3D 0;
> +	u32 i;
> +
> +	err =3D idpf_send_mb_msg(adapter, &xn_params, &dummy, sizeof(dummy));
> +	if (err)
> +		return err;
> +
> +	reply_sz =3D xn_params.recv_mem.iov_len;
> +	resp =3D xn_params.recv_mem.iov_base;
> +	if (reply_sz < sizeof(*resp)) {
> +		err =3D -EIO;
> +		goto release_rx;
> +	}
> +
> +	num_certs =3D le32_to_cpu(resp->num_certs);
> +	if (struct_size(resp, certs, num_certs) > reply_sz) {
> +		err =3D -EIO;
> +		goto release_rx;
> +	}
> +
> +	if (!num_certs) {
> +		dev_info(dev, "PSP FIPS compliance: noncompliant\n");
> +		goto release_rx;
> +	}
> +
> +	len =3D scnprintf(status, sizeof(status), "compliant@cmvp_cert_");
> +	for (i =3D 0; i < num_certs; i++)
> +		len +=3D scnprintf(status + len, sizeof(status) - len, "%s%u",
> +				 i ? "_and_" : "", le32_to_cpu(resp->certs[i]));
> +	dev_info(dev, "PSP FIPS compliance: %s\n", status);
> +

You should think about exposing this with a netlink uapi instead of
making userspace parse it from dmesg. Maybe PSP dev-get.

I would also suggest moving this to a series after the PSP
implementation. It doesn't make sense to have the PSP driver API
implemented over the span of two separate series when stuff like this is
in between.

> +release_rx:
> +	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
> +	return err;
> +}
