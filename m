Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C98606A323
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0PEraM/B;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=W7hZqgOK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21D60607A7;
	Wed, 25 Nov 2026 13:39:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v69iBgbtUEuk; Wed, 25 Nov 2026 13:39:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 21C8A606A0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795613986;
	b=npBa0Zn/ZeJNjgAKo4cArAR3DlVH5dFzixAEdIY2LocHQFFQFCnhsvQac8M5OTZptqC6
	 dsgle51B/Nmib8/IUYRDYv8KK3YSNat1FETIdDx5uHBXeJkd6lxvrf4PUORt5Kmj2xSXo
	 Aim0sTN3wV7HzjxP/QhX3p4jkE/vblrxlvN1JRRbikd34SxosgdwFxt18WsAn8pcQ5JRu
	 Ui6mMjNVI36fY/+Dj0wuPZpRNZ/GjU5ovgejA7s7MVM3pJibKuFuRbiPCkEbm55x7ocyI
	 MLLAFX8Tz+t/+EBh0LdJC54KxO3gkwPaerKEgEutYIvNe0RTl6Hyzc/asBz/T5IX23g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795613986;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k0XLbZ5M9INRCrfgtQEgGkLYc24AmJcFIXjSp0f6z04=;
	b=HUGZQEBlNoWMtxds1RLBv5q7bss7jw6F3YatMJLAXgWvgjoQd1Qz2gN58UlW28Q9Ds/u
	 buHKlW5fJKPexn14YQ+eqhHPgKvG0PcoCN9iJf5M0sBpi8bfrTndHhAfPh+8DQK5yP4sk
	 xTeP9vUyqa5t/NZLEWLzswylqwjXHVpEpwMXKDwqMFtXJGWuBUkPuSxP+Kf/xOhpS4vbQ
	 4p9ch92Vgm0K+7lHuOGTLVTzkcK76Tn2VlFg2Gsyw3M2gP6nkuorWJeHCZEAFLVa7S9sQ
	 UW93HUYkk2cmO+U8Pe7bA4hhhewJC0I+ojNj1YMJ+GP/i8FQYH6YExROItX7ZXXHQkQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795613986;
	bh=k0XLbZ5M9INRCrfgtQEgGkLYc24AmJcFIXjSp0f6z04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0PEraM/B/1RVk1JlNjMV8Qta9dBir0DV/gawIErO9mKP+A5CNl/nuxPy1LgLsu5GV
	 2Sy8a5RO+2NTaFmTqZi77wuHXkAUOy/upGJbSlw4MIA6j39kV9Sub3cS6jfEVDqCK+
	 ukyTeyghMaVyyAU62zubGL9YtP7wX4zGp8GlFsn/meJdIBAVOvTtiJvCYQdxE11ka7
	 rV+s0LbcwOzN2DLSb5CUWoLZ+9xrW7nWSW1nYfnBzKc2EBvG85PQkeakMhGXrdaEyE
	 alZT7Wh5pKchN/w0APnqoJNsC4Nfu8OX8IQ17SEY49KqKjv49WtgBT3YnIt/7TqB4H
	 PoTf7RGsnMqPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21C8A606A0;
	Wed, 25 Nov 2026 13:39:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 709C22F5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 13:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DDF5404F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 13:39:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UrTOwnzCiF85 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 13:39:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7056F4046C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=W7hZqgOK
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7056F4046C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 13:39:42 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c51a02ad3acso97088066b.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 05:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795613980; x=1796218780;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k0XLbZ5M9INRCrfgtQEgGkLYc24AmJcFIXjSp0f6z04=;
 b=W7hZqgOKT2ScTdbweQtFNSq6xznC0To3Rb7JYUrHSNF+TunNnBg/ZEox6SbGPYWadr
 XzjJEud1lBH97J0c9AiwvMu8x8+3semVnVmkWONOzkrGOsCuatyykc5/yyH3c8zwnvjY
 WdtCYCegMyZXp30DkFsx6cRZ536o2N5RsPC1QidZiqHF2OFsCZoIX9gbwhVxtMiRf81m
 cG29vZ+O+/HnIY9xkNNnC2Brg222cuORnuvnpD8CCi6iYVH62VJw+vSKI0Jhg4lOAP84
 U5k0eo2pk7AjFEILxfHmcOZSbqHVpQkOrFxWkWZGeWSsp9kbG3snosMgBpPiYOWlpqWN
 X+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795613980; x=1796218780;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k0XLbZ5M9INRCrfgtQEgGkLYc24AmJcFIXjSp0f6z04=;
 b=Qou00qIO9cjv4jV7V+IdVavKNdJZTnZex2VNj5uUKGjfrexHsloTq5wX0CA5sUZ/yR
 1c2M8xdh3MvJ6i/g0sX0VwfuOcxzsOwSXkLAoy9MlhgzcRl8MnQMJ3Pg9Qb4DULqSBqj
 S1mWFai3E4k3C0L5+qHtDP063dmTS0TKgd8DV7gwYG5m/9yfMyFO+Vmku8ETmxtNeDCq
 DK4e2WPYRnhSmIsDimVu0OaBFwiPZsoBbH9ztj8OCRml2FVxRA+4+Wat77vWcyHHHc2D
 x0NwtsVaF1KSAMGXt0ylbCRMYJv8jLTiwZUX6CYD8rMQENwfKOfFlE1bZw4eHOPYYTLZ
 SGcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHg5IVfIuYVer1ZewqgcaxivPfeYrtbHcwpjaZV5O33uuNKdPXmfoSgHoYq4Llb7lMUwpS3pzzO7HnDTQjtsPk=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+lp1Akpt+/2qd2zuu6LXDJhjbr8ivEKwcJhsRyi8vh6a5sq/XR
 qpDZt19inZ2R1ykYhAVBPoZ1VDtjZ60LI76e+iyrEGSHb91j0TMIgclP9HvbWyQ8B3g=
X-Gm-Gg: AZFdTZcoK90RT0IrAq779GR9a7mwyfr6XfInD28v8AXgVEnOzcx4fpKtl36MmQnoeT9
 sNt0Tp3bx8lXBRn7TglcDZIfjoBPaXHDkVRnbP27aha1jA0+1Vf0nelxk94Zg1CLuRei/6ThSPo
 hXy3Dot/sQPVmcrL50fbxJnSXrk8AwePUoLZzXn4aX10sp5HhWzNGrcS7fNAyxnsdpl2rI0iVbr
 O15+OE3Zt/9Q4uoXffu3gQZSmi0U1lP9njIQnp95pzs6efi5OXQRdqOrSF6uLth1hBCbouCvWtU
 YAwSw2ILq4rCxzbxkhTO5kwyStZnpCNTGsPMtr0G1Bgbz0PB2YlzpJhhNLzEQtNkFTCJeAIaA3l
 dirjvcIOAyG+RNM8ckEdytNOwUvVS1F3HVUi4JrPdnUNRbphUxuPmVCE3DsjnoYntYdBsydZ2O1
 dpZGfa6MTjtMSEXn2YeoDUiZr7vFLY2DU5EWrmQ+z9nAZ0m18QTIyIJEPN4rO3GPn9fNih0audL
 SGsrZ2cuGIMOgA01Y98UmtEMx0eIDgdhTvnkoqViPBzdE+ZLjDrAvicqDFxTarHhs1ThZ4IUEOi
 ncR5noGv2aHF4PTj3GBjRGcgO/VMcHKHNXhqZMIRgonLORo=
X-Received: by 2002:a17:907:6ea9:b0:c46:a5bb:5740 with SMTP id
 a640c23a62f3a-c513a3a656cmr1605152966b.5.1795613980473; 
 Wed, 25 Nov 2026 05:39:40 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae679e3sm637401166b.22.2026.11.25.05.39.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 05:39:40 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Alice Michael <alice.michael@intel.com>,
 Eric Joyner <eric.joyner@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev
Subject: Re: [PATCH net v2] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
Date: Wed, 25 Nov 2026 13:39:35 +0000
Message-ID: <20261125133935.36695-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <awbGK9v4k3Fh4U+H@boxer>
References: <20261125095201.98279-1-tianyi@cloudflare.com>
 <awbGK9v4k3Fh4U+H@boxer>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-25 at 12:27 +0100, Maciej Fijalkowski wrote:
> My ack was meant to say: let us get the behavior aligned to mlx5 and given
> that there is pending work regarding checksum capabilities in XDP,
> Alexander's concerns are meant to be addressed at -next kernel candidates.

Thanks for clarifying, and sorry for dropping it. I was not sure if the
ack still applied after the change moved to the control path. The
behavior in v2 is the same as in v1, aligned to mlx5. If you are fine
with v2, could you send your Acked-by again, or could I just bring it
back if there is a v3?

> If code has changed *so much* why have you kept the Suggested-by tag from
> Jesse?

The Suggested-by tag is mainly about what to fix rather than the code.
But Jesse and I also discussed the code itself before I sent v1 and v2,
so I kept it.

Thanks,
Tianyi
