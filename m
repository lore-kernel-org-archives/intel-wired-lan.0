Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD6AC88E53
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 18:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE22C60632;
	Fri, 11 Sep 2026 18:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HqYGipQ36l0r; Fri, 11 Sep 2026 18:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2DEF460616
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789152009;
	b=qyw9wSrcXckFr7ZYSurUUqEQ8C3CY0X3PBfoj5McEwUY9zEEWxEZPwVQJP3HTNt0cDGl
	 T0n6wPxoPtPQ4rrJNsCsn/Tuy4QwEcRa8040M6rDEVNx26VWGTYKpHOjYWhB+ICyoG3eP
	 ZCxrpjVhH8/GP7HecT3NC2X4HnSAh0lQ4nKFvJbn1PylDjn+lL4C+EZ0OhTL0exvZjToa
	 KBvH/QHO6Dqi/TitGDepzh+kBbMG5T+9i5Ev1NFdUBupJt2vF4AioX/i6enAuRGtzKMnz
	 NAFWz5NzBkQnOyouIkoxm0p/qRvuV92d9BdeGVRb+tp8u4pfHTZRI933Y3YmVMAojQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789152009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
	b=aX88Pw1LpHjIB0eGT/+RQkEpEf8hDUThBO7C4ucVM9O7FmCtoLrs21tDDBC7jUR9yN5k
	 UZ/HcOUNhjmXUEvnoS7arJJsCUZAgOm8J6Gea/+EW/kRUpZzbyAM0GijNedvCdtgDUOjX
	 kBjaJt0wS3uUDeBTc1kSw2S94TJv5UJYeG9Rlfhxh//E+DfKqKZMeoPJRdRosxOeJVFR8
	 z7aw2x0RXIdBbzjLwGFUMVWGQUzlDki6oxq7AOlOTr31xoIvNqQ48m4nVQOOkc+yevEEn
	 IP0Ht++j40Jgj7FjBOqbEIFXelD8lz8mkWJe4jXFODhX044HI23qi2JE1tbQIZ4P8mQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="jQvT/hNL";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LjXuC2zN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ul8oYidE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CSmkM9nN;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789152009;
	bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RAxLaJkJ6hJU632h+QyF+AzX2s2akkv2dORv/4EDpg5jwf+oZIMFCCAlYePgpVQ7v
	 w/gZaLPHOkE9UysmDrefofpbdbwqCNGUOIeVtkrISsspUi4LaeknwXh3zpYsq/MbYx
	 +ikot+0vYr8APnHS0ZHTLiLHHnbXoKPbWvkpmKD/ts2FkSB20BvCJz5pq9hEBxMA2i
	 q1a1FadWjWk9KACPgJpwqrzIafM4cqBwsiiYBto6teMHclL3FxuueRUP8mWNh4BX5v
	 2WMQ3tqd3rPQUK7HNYGWB2v20++d1Lbk3IPPNoNn8VLtdxVumjlACHMqMxPklwL4Ok
	 MBXbdYxrvYbZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DEF460616;
	Fri, 11 Sep 2026 18:40:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF9A172E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 18:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 955F760616
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 18:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3WbhMjle5Yw2 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 18:40:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5827F605C9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789152006;
 b=h7Y5IxipPn0lEdfN+nWhcIFQu2SrOwgUv3uJBsaWTdz5ZCRiMW6HUJOhU4e/leJWTVaY
 jPq3VmVOBx/d5ouf6lxPnIqODCB8mq7huVKKh+08cU0B1eZVIMyXvm8fp7ix1PfTL+8Vv
 qry0n7k8k9swWASSPmvt4+o1b+iZ+5HbH1E+vsmpRjhdNLr4CgK7+uw9trN0v1g3AUb2a
 vqITqZKLXr6w8OcKQ3Q11WQtRan4gImQfZOywciFwkDgBKL2qyhJuPgJRmadKadodTnwN
 DUpDFYZylhqAY2EBfOMiOih9w0BMSOhw+4L9orw0JeoQp4ULGEdXFU8B/JzhKIQaocw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789152006;
 h=Received-SPF:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Spam-Level:
 X-Spamd-Result:X-Spam-Flag;
 bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
 b=U7cpVFxbn+oFA7cK3oCR9IWw9Bm92YULc/cR2FcTj2/uYSCfPJVIvsfM1gr3U1p8vbsi
 e4deQkBHkBxcGivSXbaV5hG1iwVmGbiQu4KWfUiRNHJHrNEXsrk5KrQXE4R/o8MpHQkPE
 sKdHOIy5Xn0vDX7A4UqL5Y56LT8q9+m1BhsKKrwkiLvQUJcY7EPTaPp2n0gbHA85Ip5C1
 A4mANH33nIRPM0jheV0noYyZvAu0wUCI+sVkJpeJFojfH1X8P/+2QsF8iUjjE3kdC9J15
 O0v+FYmOYlCW8WBilCGrLoDbgVI09ajaybp5LBsl2aA/wQBOuTS1oq2TsKJnYkbHipw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=suse.de; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="jQvT/hNL"; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=LjXuC2zN; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=ul8oYidE; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=CSmkM9nN; 
 arc=none smtp.remote-ip=195.135.223.130
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.223.130;
 helo=smtp-out1.suse.de; envelope-from=fmancera@suse.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=jQvT/hNL; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=LjXuC2zN; 
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=ul8oYidE; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=CSmkM9nN
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5827F605C9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 18:40:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A02A721D73;
 Fri, 11 Sep 2026 18:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789151999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
 b=jQvT/hNLseNTOBEemFSNARlCXWKP2e4so8AW5lBP7Od/oZfcMhnGuBXX45mpo2ZC9ZQcIq
 nyh7In5EcGcTuubSALewLCrx7qgYTPhsNpExEBudSfp9VDoUCrTIQExSUn7hNcAjodDbMU
 TemTPkxHYqjXxuvN0STISPcLWS3ZbEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789151999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
 b=LjXuC2zNVa0kAgOsGh9AysxRDEQhs0Jmi+qRz8BHgyBxLrnJ/bqb45O7323NdYHfnzktFY
 5JmFVUzXVx8H0nCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789151995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
 b=ul8oYidEl3s5A8NRIfwyKcVcj0SGx+WsBh3+UE9Dccx6gY+zohi+x+e6hwh8jSXE+gObAd
 NV75uaDsxqR0UY6CPfLl8YJhnVXKDDsXko24VKloUVa0DirbQIUHSuHhrfhkVmpbdaxA3K
 VMm1v3qsN1COmnh1eBjSb3oDODbJyJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789151995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mP56pOa4KGNcQ6l0ipS7wSf0GWV8mz2Zhv5wIhH4rVY=;
 b=CSmkM9nNI3cKI3Y5Y7JZBmKSl5oJhrB8oMTDovxD6JbikM1s63ZS0E//l7OLojSiSKX7Ve
 tHVAwdauixCBz0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10D7B132D3;
 Fri, 11 Sep 2026 18:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KIZRAfVKpGqufAAAD6G6ig
 (envelope-from <fmancera@suse.de>); Fri, 11 Sep 2026 18:39:49 +0000
Message-ID: <986c5a6c-b904-477d-bb41-186b66f4b258@suse.de>
Date: Fri, 11 Sep 2026 20:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
To: Sven Eckelmann <sven@narfation.org>, netdev@vger.kernel.org
Cc: horms@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
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
 Manish Rangankar <mrangankar@marvell.com>, Varun Prakash
 <varun@chelsio.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
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
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen
 <tung.quang.nguyen@est.tech>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, =?UTF-8?Q?Markus_Bl=C3=B6chl?=
 <markus@blochl.de>, Arnd Bergmann <arnd@arndb.de>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Qingfang Deng <qingfang.deng@linux.dev>, Julian Braha
 <julianbraha@gmail.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
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
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-2-fmancera@suse.de> <2927239.BEx9A2HvPv@ripper>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <2927239.BEx9A2HvPv@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:netdev@vger.kernel.org, m:pabeni@redhat.com,
 m:edumazet@google.com, m:davem@davemloft.net, m:jgg@ziepe.ca,
 m:anthony.l.nguyen@intel.com, m:przemyslaw.kitszel@intel.com,
 m:ecree.xilinx@gmail.com, m:maxime.chevallier@bootlin.com,
 m:mcoquelin.stm32@gmail.com, m:alexandre.torgue@foss.st.com,
 m:arend.vanspriel@broadcom.com, m:miriam.rachel.korenblit@intel.com,
 m:axboe@kernel.dk, m:sagi@grimberg.me, m:James.Bottomley@hansenpartnership.com,
 m:varun@chelsio.com, m:viro@zeniv.linux.org.uk, m:jack@suse.cz,
 m:dhowells@redhat.com, m:marc.dionne@auristor.com, m:neil@brown.name,
 m:okorniev@redhat.com, m:tom@talpey.com, m:sw@simonwunderlich.de,
 m:razor@blackwall.org, m:fw@strlen.de, m:johannes@sipsolutions.net,
 m:ja@ssi.bg, m:aconole@redhat.com, m:echaudro@redhat.com, m:jiri@resnulli.us,
 m:marcelo.leitner@gmail.com, m:lucien.xin@gmail.com, m:jmaloy@redhat.com,
 m:tung.quang.nguyen@est.tech, m:steffen.klassert@secunet.com,
 m:herbert@gondor.apana.org.au, m:casey@schaufler-ca.com, m:serge@hallyn.com,
 m:vikas.gupta@
 broadcom.com,m:bhargava.marreddy@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:nb@tipi-net.de,m:markus@blochl.de,m:arnd@arndb.de,m:hkallweit1@gmail.com,m:florian.fainelli@broadcom.com,m:julianbraha@gmail.com,m:enelsonmoore@gmail.com,s:linux-afs@lists.infradead.org,s:linux-arm-kernel@lists.infradead.org,s:linux-nvme@lists.infradead.org,s:brcm80211@lists.linux.dev,s:bridge@lists.linux.dev,s:mptcp@lists.linux.dev,s:b.a.t.m.a.n@lists.open-mesh.org,s:intel-wired-lan@lists.osuosl.org,s:tipc-discussion@lists.sourceforge.net,s:coreteam@netfilter.org,s:dev@openvswitch.org,s:rds-devel@oss.oracle.com];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[netdev]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,ziepe.ca,lunn.ch,intel.com,marvell.com,nvidia.com,gmail.com,bootlin.com,foss.st.com,broadcom.com,kernel.dk,lst.de,grimberg.me,hansenpartnership.com,chelsio.com,zeniv.linux.org.uk,suse.cz,auristor.com,brown.name,oracle.com,talpey.com,mailbox.org,simonwunderlich.de,mandelbit.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,sipsolutions.net,ssi.bg,ovn.org,mojatatu.com,resnulli.us,linux.alibaba.com,linux.ibm.com,est.tech,secunet.com,gondor.apana.org.au,schaufler-ca.com,paul-moore.com,namei.org,hallyn.com,tipi-net.de,blochl.de,arndb.de,linux.dev,linuxfoundation.org,alyssa.is,vger.kernel.org,lists.osuosl.org,corigine.com,amd.com,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,lists.open-mesh.org,openvswitch.org,oss.oracle.com,lists.sourceforge.net];
 R_RATELIMIT(0.00)[to_ip_from(RLu5qefsf3rq4khkdydytudeq9)];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCPT_COUNT_GT_50(0.00)[133];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

On 9/10/26 6:56 PM, Sven Eckelmann wrote:
> On Thursday, 10 September 2026 16:48:26 CEST Fernando Fernandez Mancera wrote:
>> diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
>> index 58c408b7a7d9..60ad4b09be6e 100644
>> --- a/net/batman-adv/Kconfig
>> +++ b/net/batman-adv/Kconfig
>> @@ -9,6 +9,7 @@
>>   
>>   config BATMAN_ADV
>>          tristate "B.A.T.M.A.N. Advanced Meshing Protocol"
>> +       depends on IPV4
>>          select CRC32
>>          help
>>            B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
> 
> This doesn't make a lot of sense to me IPV4 is not a requirement for
> batman-adv. Only very specific features will require symbols from IPv4:
> 
> * CONFIG_BATMAN_ADV_BLA
> 
>    - arp_create
> 
> * CONFIG_BATMAN_ADV_DAT
> 
>    - arp_create
> 
> * CONFIG_BATMAN_ADV_MCAST
> 
>    - ip_mc_check_igmp
> 
> 
> Basically things which currently depend on INET in net/batman-adv/Kconfig
> 
> Or am I missing something here?
> 

Yes, you are right. I must re-check all the symbols again. So thank you!

> Regards,
> 	Sven

