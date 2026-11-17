Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C56606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=KxCxpFtQ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qw1BFsUA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDCE8810DF;
	Tue, 17 Nov 2026 17:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJ73y1bZzlln; Tue, 17 Nov 2026 17:34:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3FC2B810F4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794936869;
	b=BVNi0QF+NR+h+WhvYPfzBiroP8s/LerKLhM1V6niDDih099UUQvHwdzhhkUZr9a8hL9c
	 WmRdD/CnoJhrA851J3v0bLnDYTXSMGK9Rusfdze1D2mMfERHYJST8UklgrbfyGCybD6Iv
	 KgWk2mMwaO4ivzdTOonnoniB43uYe7nvcf01ffvOjNxfV95TyvWskWUangjUOyaOiFKIU
	 h02HAEi6/uSEfkiG11/RDPgVAl3YFs0W1sCbN0aOICLFloPJfgWIkQk1VXknwnbiFVF8U
	 w2WQEcfpTAQuGRw41itIB/BKLdrknGpNNsDtwsjTHSiLPEUqx6Vt2SKa3iE6ac/FJuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794936869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pVxrfzsOkS8R/UI8C/+4VKwcJVz62eWVYB27WSqCUBg=;
	b=OhpxKeCMz6puwPC5qmXEMxWPwk6c+76qo82wyqGTlEq4ufdeIK2RuZuuWDXKCSPm3rm6
	 OEwhBVXalPcI/PaLolcGSkB5WBhAba88I1a5QwbAOxb5WVe0n4/vqDJtbhN9/2rvvST7V
	 C3Tg5kKPUDn9ymchP+UmmQL8C+bLp626t4CdxM/DJU/AqCf+5d72zMBfXo2vL35k9xWao
	 K9RHhNq7E59Bok0MPCH0R3Tln7zDdbbe/ZPBqa0OpLhmAVFwf+rTSe1++9Ytr5UF+9Wh6
	 XmCa4547TxZkItk27mCPUUMajnWLSS0nZ/Bo0b3LcYDhQuUrhfKB9CXtnIIrzwr4Ftg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794936869;
	bh=pVxrfzsOkS8R/UI8C/+4VKwcJVz62eWVYB27WSqCUBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KxCxpFtQMUrqRxNqbp7euM+55ROcB1EysHwBgwEsd1v+Sq+ujpqJlszUDy0bYcRDW
	 bM5/73f5ycKXb+CRobXRHKqhw05reRer7MmGHHh/K1vwWjLhzcen+7fzNJ8mqQExi+
	 wZwOzJMcdH014wAhNDM3vcl69ZEukaAlL6cRLhRkQs5NmC/s2yUcn3n8gtU/g3dTLU
	 eEyEPpXJxpOzAKDZ7NJu7ROc1eoGeKy3SHW4oSIrZnHhiHmuB0vNdA+ZmGNi5lQmZh
	 g/5tYsMyFCNkSQAG1Y/wrSYZZlVVb3E4tqD0+cl0JbxK0t935jjl9JFoCOKHeAUS8e
	 llS3C1SlzFk0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FC2B810F4;
	Tue, 17 Nov 2026 17:34:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 59415105
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 17:34:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 498EB6077B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 17:34:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pxeobXePX_Ud for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 17:34:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 87ADB605F4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::732"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::732; helo=mail-qk1-x732.google.com;
 envelope-from=daniel.zahka@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=qw1BFsUA
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87ADB605F4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 17:34:26 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-93f3c616c84so8639385a.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794936865; x=1795541665; darn=lists.osuosl.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pVxrfzsOkS8R/UI8C/+4VKwcJVz62eWVYB27WSqCUBg=;
 b=qw1BFsUAxWFEZ0648TsbMY8sJi8sk/OvnpYARqezSGFCgX8gysdmsUm76RChHeHUwd
 ct7rxdn5nYrNJeOgdSS5BBy1ItRXExq254fy7RXehFEeCW5yvsVS8oAwTP5fJHsr9/SR
 xc9OIgk7lLjw6RVC/YQtizcopDn/NBJqgmmohXKHN9cVA83cIDzY4nWesuT8KSeY44E+
 /mI0yDF5rlMXNluiLaclzF000wzP0vY5ZQbDLgeyjpMu9k9aIdsOR9KLyAjRRfMQkFUz
 vKU93nVZCWFXZRznfIzyqBH46WA6sXb3p8fX1a68vwvjW98ofaWS+bPAPybCio02O093
 71Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794936865; x=1795541665;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pVxrfzsOkS8R/UI8C/+4VKwcJVz62eWVYB27WSqCUBg=;
 b=c+cI6K+OG8YaKyLzqh8WXkwWmep3jTmkN6aVakLqEj5XGhGbsuEBDUxO8XMun95DjV
 rgvUEPPP1JzmPeYUi8MR0rL2qL5GLoefCxOr3jCKQwO9jdcML8REnVk3r9CgyGW6pmMd
 eQSDnxIfEuWJE67Qr76802Vzs2fE6di4jqx8s7Ru3Sl7D5rWdGa/DBpkX0ZeanFKqopa
 CaQamU5z7CWJEeW5D5MwaWeX4rN7blFrJX7xFv2DL+FMW8S8Hp98cAq8NE7lwb1yjTb7
 AtYBcC/5g3QH1Gr/JqvlI0iwbwPkBWMX5F1gtFAFOZVdS5Uw9haivDrswQwUJXpltyLc
 CT8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErF5uFmxpkbLNjDd7KoUy+/AibGW68zCAB+Oywp8FiD37tqaIk+/y47Yh3brp3j7WnUh2HAdTNMo8RcF1Yn0bgs=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8PCNF1/3L6Td81/9vRwIKRH9lobLftPt7LWbWbyv/oVLd+F9eX
 9t4IpMHGmzF319aYNhZ/9APvH0qlzEtnznPmC7EsLwLyFJBjZCauMjRO
X-Gm-Gg: AYBFou0gzNwNS3jrzpn8NDJy511CJaqPoY8uECKIi7Xz3usL1pyRGiDV0X2UA3aKxGB
 tww3oDctRXhYqn6mtoM+VEPc2BIywcEG5XV/5jbRD0+xWX+Cm41yO07bicNY8I0/VI/NiOND7dJ
 gP+PCYZx6du0Q87K7FzzFXgcIAG/NY3VAwswVlFDZUDqVKgQ0+qfTQHOFEnoiXr6RBQI45dBphZ
 jggRLlJxYfTzmenTLKfp5BoQDGXjYL4uIYHkTe03fRKQU/d3sCrPaeCkQseOKGISna1AN+sMh76
 pg5B6xYThb7a7sMYW+2DzccU8N0t+nBC5vEwJOGwumCiyJNla4aQeIvLXTsxWbtPU0lxF0H/0ac
 t0SvZSKHePVEbvGBbTZJMMfXBNpLGj3rkhAOp859zt1SVFJ1owhVkAXTbZqUSAfJ375rYi0y04s
 dNedUKs8pMqj9OTbQLtX+li/J/yN2SkBnRgzAwKwtjK7PiEqdIHrKaqjHMlu6e8/XmSuqXT7f/A
 dRKj3aEZ1ZMT0EQe55Wd9FqZ3SWxxuCAXYYOmyf9XKRy8b+aDvc7IrAfzY1bno5OSKZamIrQgYF
 9aDhXht3a2pVAcoy+A==
X-Received: by 2002:a05:620a:1714:b0:949:73f3:83c with SMTP id
 af79cd13be357-94999572b95mr73032085a.21.1794936864878; 
 Tue, 17 Nov 2026 09:34:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::7:5db8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c831b7dsm1139318185a.20.2026.11.17.09.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 09:34:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 12:34:23 -0500
Message-Id: <DMXO0JIUCNYA.1940X1XHRX6SF@gmail.com>
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
Subject: Re: [PATCH iwl-next 04/15] idpf: psp: add psp offload initialization
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261117145522.1910636-1-stani@google.com>
 <20261117145522.1910636-5-stani@google.com>
In-Reply-To: <20261117145522.1910636-5-stani@google.com>
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
> Add the PSP offload initialization:
> - Introduce VIRTCHNL2_CAP_CRYPTO (bit 26 of the other capabilities)
>   and request it in VIRTCHNL2_OP_GET_CAPS if CONFIG_INET_PSP is
>   enabled.
> - Add struct idpf_adapter_psp to struct idpf_adapter.
> - Implement idpf_psp_init(), called from idpf_vc_core_init() on each
>   core init, including after a hard reset, and idpf_psp_free(), called
>   from idpf_remove(). PSP is enabled if VIRTCHNL2_CAP_CRYPTO was
>   granted, see idpf_is_psp_ena(). A failure disables PSP instead of
>   failing the core init.
> - Add the PSP device ops with idpf_psp_set_config(), and
>   idpf_psp_register()/idpf_psp_unregister(). The PSP device is
>   registered in a later patch, once all mandatory PSP device ops and the
>   datapath are implemented.
> - Build idpf_psp.c only with CONFIG_INET_PSP, with static inline stubs
>   in idpf_psp.h otherwise.
>
> Signed-off-by: Stan Iliev <stani@google.com>
> ---
> +
> +/**
> + * idpf_psp_set_config - Set the PSP device configuration
> + * @psd: PSP device
> + * @conf: new configuration
> + * @extack: netlink extended ack for error reporting
> + *
> + * The configuration is applied by the PSP core.
> + *
> + * Return: 0.
> + */
> +static int idpf_psp_set_config(struct psp_dev *psd, struct psp_dev_confi=
g *conf,
> +			       struct netlink_ext_ack *extack)
> +{
> +	return 0;

this is supposed to enable/disable PSP Rx on the device. It should
probably either do something or have a TODO or comment explaining that
the HW doesn't support disabling parsing packets as PSP.
