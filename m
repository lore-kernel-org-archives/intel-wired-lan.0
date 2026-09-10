Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3334C79F9F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 19:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68A7C40B6D;
	Thu, 10 Sep 2026 19:00:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3g_RrQA38_fu; Thu, 10 Sep 2026 19:00:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C00DA40B6F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789066854;
	b=Eh4ofwHA6R6HFeOUec/h19JZZ6zHAUhcst70e0+KaOKTuF7PsAorp3R4WX03ZobJUNn2
	 l2lprAlXpvhSB2FO985VYzeJEJynloMHp6PldkBdTdglxLX7Qhf4EBoA9vUauOQkrxksq
	 St/4zXTpCN6ruBOGOoD7WKzqAqyCFGPLCnKzE8D2HjYNRZpoDfcbQ67ygUBoEwz2dFMW0
	 /OiK0CF8xEzZV5K2rYW5wgUpeiGKFJ3j8UXGqiHBP+0qTFawom/IhzYaoxiCkNshh1qtP
	 qGhhJMTA8E672v0IJwLIIYGzl2RfvmD8Mhn3mSnP4J0rUem/pQpdqzlrR8qGDXHlsfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789066854;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jpfKdfRhIDieddP8CnPCmiOpHujz9qF8RTfexgVbXU8=;
	b=p0OhjBv6jujMVsmm4oR9LXKnbNuG5v+LKSQkWlmJl+G6eYe4EyOuLsaJuRGNRou1tzbr
	 XJcjFRa4xEV32iVKZ33m2J2Oyl2hUEzJEXBmYWq7St0gzLY+fq5/yM0ihLM5eVVHvjLg0
	 RMKFCcegfyyGudIGhACl/MOKMXiHya5SvSmWv/38kqZG3CbXgje6RxA64aGWqGxBL3Ekm
	 s7R9S1ersKTvcH9FAAmyUhSTFv6LqXLVuIQ2Q7CyCSPeDJ4wVf04oIygu3XAC5I/t4Ypy
	 ouUsVAH5xA1bHRxaLltGKH8RT7Tn8HzCoA/TXSYxpZmgs2BXCc+UzZ3j7NvAx3LOnYA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789066854;
	bh=jpfKdfRhIDieddP8CnPCmiOpHujz9qF8RTfexgVbXU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=czAqsLtvbt7V5EsHOv4n0XaE99xZrUpqObfKv8ks0TODsyHu3hXx+NOC16ovTFksf
	 UYxriVdJgwMczR3ka+Rbk6WuUQ1cy4UUJIk+pKcaQZDTxicT3ndMpvuDb/mOtFsmge
	 F71c1lQy2LhQpr1wBB/hIaqkUaEl0pSeVDywU+ZPq4vLE7eSskTKd48UIMC1AvUTVS
	 AtPfjpayNDNrVZYNCCqi6slQngyCLroQpg2TqG+BgabPBVUusBmZDVJVPRiNlUnOcZ
	 GdS+6UB7qx10+Ph1Mdx/qSKzeXkb2F0mLj9ZKbKfBC2+9rgLjiwwftAFCB46nYIx37
	 0sCRH2WKwEAqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C00DA40B6F;
	Thu, 10 Sep 2026 19:00:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FFC929B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 17:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 766AF60B89
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 17:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zym3RE8uebdw for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 17:02:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BAFD36069C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:17d8:100::8b1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789059761;
 b=rUYLCXn9RAgZf3gl8OYoU4VQnkWKrr9E+V7CzXMzqJsgOHFnMVnNM+mD74OHSuHYOTOK
 LfpK7D90ahgA87Hm3Pip4nihHuJW6jGgmfaBvZ0x+oWgs4vKWhwfMxG0wraBRElQFeZ4d
 kjyj2hjjMaPy7pTMNHOgfnhMmOyzSWw28I/irGsLdgHRFGcyJmUXwm9nYBpyETWuezXgU
 ZUcUxHqh9j7oKQk1jhyCUmwjVA1gPfUjp5UaRRj2dagbHfH2E69jTYFSkgyBXFRUl0ja4
 W/5lDhbl1BaPIm3oOnW91z2VZy1LEzQ0pYEtCB/tA79/Pilp/mFHm5cbzOLtqCI1bBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789059761;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type;
 bh=jpfKdfRhIDieddP8CnPCmiOpHujz9qF8RTfexgVbXU8=;
 b=WY2sMzCyhJ5G3LRX8CtYiwgIzwLOd/4Di79m5rK/+3eRM5+hN1TkjfcOaK2ZqJOuq3XT
 u8TskmdwN1trIoKqs4tCXRbDV+mwkimRxSjPfQCQCxrM+40NQHnCnm+t5NZENSfnQ8CxG
 HU7fnOj1qWGVS8qrkcBsRYNqDHZgIM4UtvMv1wznOKyrJqPw0gLRdwPpYfNpo9MriynKj
 GZRwoFgO4XtMwzSC+59xFgiDvp9HrHOCoATSFy6eyK+R4vIUHw9V7B3m7aLOl3H04L0UL
 Sh1lM9WBKSb9/gM35gc2AvxFgSqmOnMlpvpmn7+xN8r3lmXK6E2rB68BcuOyEP+WksA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=narfation.org; 
 dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256
 header.s=20121 header.b=nwEXBdcA; 
 arc=none smtp.remote-ip="2a00:17d8:100::8b1"
X-Greylist: delayed 364 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 17:02:40 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=narfation.org header.i=@narfation.org
 header.a=rsa-sha256 header.s=20121 header.b=nwEXBdcA
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:17d8:100::8b1;
 helo=dvalin.narfation.org; envelope-from=sven@narfation.org;
 receiver=<UNKNOWN> 
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAFD36069C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 17:02:40 +0000 (UTC)
Received: by dvalin.narfation.org (Postfix) id 2356320394;
 Thu, 10 Sep 2026 16:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
 s=20121; t=1789059391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jpfKdfRhIDieddP8CnPCmiOpHujz9qF8RTfexgVbXU8=;
 b=nwEXBdcAy3Bpov4VOY4e9xQIUo1PQ2X9HlwxbfnLeQfMjABTkXF73qIcnksvyZ+lcbcS0g
 2rPkDRnl7UQZFmPrLPM9uczBVt0vyDhtL/31BVXskbZBb26AOMkMrYm6WaedfzaSpjh5hq
 RYBqqwgy91rok1+/oD3mlpj7KKJQqzg=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Fernando Fernandez Mancera <fmancera@suse.de>
Cc: horms@kernel.org, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, 
 davem@davemloft.net, Fernando Fernandez Mancera <fmancera@suse.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Elad Nachman <enachman@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Saurav Kashyap <skashyap@marvell.com>,
 Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, Nilesh Javali <njavali@marvell.com>,
 Manish Rangankar <mrangankar@marvell.com>, Varun Prakash <varun@chelsio.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, Johannes Berg <johannes@sipsolutions.net>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Julian Anastasov <ja@ssi.bg>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Allison Henderson <achender@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
 Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>,
 Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 Nicolai Buchwitz <nb@tipi-net.de>,
 Markus =?UTF-8?B?QmzDtmNobA==?= <markus@blochl.de>,
 Arnd Bergmann <arnd@arndb.de>, Heiner Kallweit <hkallweit1@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Qingfang Deng <qingfang.deng@linux.dev>,
 Julian Braha <julianbraha@gmail.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, Alyssa Ross <hi@alyssa.is>,
 Joel Granados <joel.granados@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
 linux-net-drivers@amd.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-s390@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
Date: Thu, 10 Sep 2026 18:56:26 +0200
Message-ID: <2927239.BEx9A2HvPv@ripper>
In-Reply-To: <20260910144914.8025-2-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-2-fmancera@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15836323.tv2OnDr8pf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Mailman-Approved-At: Thu, 10 Sep 2026 19:00:53 +0000
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
Errors-To: intel-wired-lan-bounces@osuosl.org

--nextPart15836323.tv2OnDr8pf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Sep 2026 18:56:26 +0200
Message-ID: <2927239.BEx9A2HvPv@ripper>
In-Reply-To: <20260910144914.8025-2-fmancera@suse.de>
MIME-Version: 1.0

On Thursday, 10 September 2026 16:48:26 CEST Fernando Fernandez Mancera wrote:
> diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
> index 58c408b7a7d9..60ad4b09be6e 100644
> --- a/net/batman-adv/Kconfig
> +++ b/net/batman-adv/Kconfig
> @@ -9,6 +9,7 @@
>  
>  config BATMAN_ADV
>         tristate "B.A.T.M.A.N. Advanced Meshing Protocol"
> +       depends on IPV4
>         select CRC32
>         help
>           B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is

This doesn't make a lot of sense to me IPV4 is not a requirement for 
batman-adv. Only very specific features will require symbols from IPv4:

* CONFIG_BATMAN_ADV_BLA

  - arp_create

* CONFIG_BATMAN_ADV_DAT

  - arp_create

* CONFIG_BATMAN_ADV_MCAST

  - ip_mc_check_igmp


Basically things which currently depend on INET in net/batman-adv/Kconfig

Or am I missing something here?

Regards,
	Sven
--nextPart15836323.tv2OnDr8pf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaqLhOgAKCRBND3cr0xT1
y0QVAQCluQcX0gr2MIQxC1VBX8WP3ecVDFqIOBKX04RTLEdoGQD+LCZ3LWDtGBbG
zKG3h3F96XOApdHINtJ4L0x6nSSviww=
=kxMI
-----END PGP SIGNATURE-----

--nextPart15836323.tv2OnDr8pf--



