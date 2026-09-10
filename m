Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BE9C79F9F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 16:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DC7460B79;
	Thu, 10 Sep 2026 16:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M6JfFkrg1GU6; Thu, 10 Sep 2026 16:23:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7EE0A60B96
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789057397;
	b=rkpSkRV7B3ucBlcbBMPvaF4GMMLkqGTI6s44t+kB1Kt5KHm7WcF0lHU3Kv7yusbgTpqz
	 mtVcg0sELo30rR4iFtT8OYUGvjy2wChRfYMv90qN92OA/e0pbmo+hZ02ripitzEBaYsXD
	 FR/l9a0vkp24GSwfqLqPJ0+rhPntn28/j+Vs3vXBB5vrfwQqoEx2IZyHhEuHsJk/mrBSl
	 cltcQvaGkIff3qilYK3GA6Wew+bH9+1hLEujMYuCTh37yZnHWHSZtqXsGp2xlPa2UDeMM
	 UKuAQvNpoIRJ1HVL6+PHAzcXS3FXoWkqcHUMCqNLTDTOIEP/fBc/yfJGhsWq9zZPzqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789057397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kr4VsGry+oKuFNSODwNOT1epFYC6cWJFJntIrCTTAgc=;
	b=Go4q3d6frdjfvu/SMMx1HPPnH0cVchKKGOGb3tNjy3Nrm0KBfifBO84xOvnn4nS2DegQ
	 qkUnY9ye0yZOOq5dttMN8lPJx+u7Hx0WaXPR7B+Yagaa6vHe+iHtvA4I5ppIeSjrY4FIv
	 uzSK4Za4cW5QX1dNPYmWXpudVxfGLQyzHarNCrPlS1zQd4PB7qhYBTlX62U3XOfwNkp45
	 fEzAbCEOd5KAAwK33G4qRuGQZICl0fdb9xc87Kz4IjDLMd9DgTS0HvzbN/6mFS5b0OnYd
	 IB8qMtTuxEIsGMonfd9JDlqez9in2oyNnzktC+iKsPWWuYx2eObYKlneuDoJjRet1Tw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Di6J4ooq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2EKGAeF5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=v9LNypzg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iqVfo1Lk;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789057397;
	bh=kr4VsGry+oKuFNSODwNOT1epFYC6cWJFJntIrCTTAgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pbbog6M21fwZQ9pVdDBngxnP6PHEE864Lw+0klS8E087q/MDjXpPYvIjdmimNB1Z8
	 CA5eJi1fn1osgIJsyGnwTz/o9ae8cUNORIjsgZbNVYrzYwYc/h/vHYTLSASDKbc4oR
	 N2Y1rJ1s7aJMFOz5z0wl90ouCca9qfIfdodKhI9i1VWeZHXOZUVaalFRzVqAf9jrsp
	 eHBpf9VHPwNGdWAUkWkHHWXB9hBx2Cb/2ErBWW19nFh44TPxPJvuz2Pc/OBgubiSW/
	 7PH+4fBJ6IfDaM8LfWGQpsryoej6EO184jFEwAl7saVU7Q+Dy7jEa9B1aiq6QtlBF2
	 RbZz69FG9c1PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EE0A60B96;
	Thu, 10 Sep 2026 16:23:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C4E71268
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 16:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AAFD960B96
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 16:23:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vIcWCpluV7nl for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 16:23:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6FD3960B79
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789057395;
 b=EwIVLh0p1yY3mR6G2FrtJT5VHo1lFra6BZ7DxZ51pp9MRK7pUIT/zNEU9mhPkvTpqa9B
 +ESmUCfAvHxWNDyQ2QMN+4j1MsdLvNKbv2LkOgN67EWXNdaQeXsE1u4W8NZ0r04UJ7ifN
 RxWWaG6A+UCuqpJy2GFl6f5pKLy9Cl7rY7yndCs4tnW3rESYu6lafl6CEtVeIO6+fceix
 Ujkhc2wBbQmkHrefzAlhs2wjEPiWWTgTWMOyg/llZhpFNGzjysY46cmvCbrwNjlzzEEfe
 KQeCZ05CLT2WBJKg/lq6JcAbkYhfS4urzh6XTN89Qg2HYT9SC2yvrV1C6Ef8i8+m2qA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789057395;
 h=Received-SPF:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Spam-Level:
 X-Spamd-Result:X-Spam-Flag;
 bh=kr4VsGry+oKuFNSODwNOT1epFYC6cWJFJntIrCTTAgc=;
 b=gSJC57GNjS9x2d+H1Nmq4ceLFe+jsc9kvWpgq0BfnaaxO6Qaq5Kfb2sNf85Cg3H+OHcM
 bXQc2ejANI+v/BVm021+R2+aUbGkEr/HzIOEI1znMx8qjM22996wdgfFY1cMiaKvezwg8
 YAP9YkWJUX7n4aqaxPWICWR+LefS/EWi1Cg2XbvIlBwd0pq+S+0vc7OvYhfr30nRmIW5E
 yFd1KuGrhqJAjUvzxt9rbbTb4DxlAriIyyGMSqtd5OZdZICTj9mYgt76BgwOLG1TEair+
 ONwDmQy4Lxl93hxFB6B0BZVGdw9eIPTKW4Kfkg3H8JkwuqFEprN5+tpUIBOtdVcrDkQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=suse.de; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Di6J4ooq; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=2EKGAeF5; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=v9LNypzg; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=iqVfo1Lk; 
 arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=fmancera@suse.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Di6J4ooq; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=2EKGAeF5; 
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=v9LNypzg; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=iqVfo1Lk
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FD3960B79
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 16:23:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B753E1FE37;
 Thu, 10 Sep 2026 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789057387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kr4VsGry+oKuFNSODwNOT1epFYC6cWJFJntIrCTTAgc=;
 b=Di6J4ooqj0YNM6hFl2R0QAoPrCYY+xDjaKsB/WTlQC30AvF58wJ5hQ4YlqziTkzbp4Og/P
 8AcvpOg7/YbzCaNQKLMjJzQSURihPuWeFViFE2uYafcYTpIJsnzxU0jfqNtUgZDKRihBvk
 pYIPz0zwPXel13Wvwc81TgwYDG7qh4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789057387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kr4VsGry+oKuFNSODwNOT1epFYC6cWJFJntIrCTTAgc=;
 b=2EKGAeF5UM0IQsTGyBtJtEWymjFLkfNM5dLWFz+lLgh2k1z7sVyu3GnjZh/Iff2EshTqjl
 zkhxcxPvZmXVVUCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789057383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kr4VsGry+oKuFNSODwNOT1epFYC6cWJFJntIrCTTAgc=;
 b=v9LNypzgtLQ7CRKOmN6anD0VC81kX2iC2c1SQxxlO7XxDyaAXrKGQnx0CFuoDpq/1g1LaR
 hObqfjDhrjmgyzypfatp8LsaPwXkXxB2ihx1FCBkjtbMfwpf1V/hcaC8BtjYX60RUsjQj/
 bDSH8rzm6F/OyuAqSiUg6LmxSUgiqRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789057383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kr4VsGry+oKuFNSODwNOT1epFYC6cWJFJntIrCTTAgc=;
 b=iqVfo1LkEJDI3/oHuqx6Tkqp4cn5U3OeTC5em8w4cwZF+bn7rC/JxfARvjPvNOJVeIQ8TR
 9p+8O0KpqpnPZYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1530E137FD;
 Thu, 10 Sep 2026 16:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ehFfAmHZompxSgAAD6G6ig
 (envelope-from <fmancera@suse.de>); Thu, 10 Sep 2026 16:22:57 +0000
Message-ID: <bee1e0e0-6114-462b-975c-62ca2e448e8e@suse.de>
Date: Thu, 10 Sep 2026 18:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
To: netdev@vger.kernel.org
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
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
 Sven Eckelmann <sven@narfation.org>,
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
 <20260910144914.8025-2-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260910144914.8025-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:netdev@vger.kernel.org, m:pabeni@redhat.com,
 m:edumazet@google.com, m:davem@davemloft.net, m:jgg@ziepe.ca,
 m:anthony.l.nguyen@intel.com, m:przemyslaw.kitszel@intel.com,
 m:ecree.xilinx@gmail.com, m:maxime.chevallier@bootlin.com,
 m:mcoquelin.stm32@gmail.com, m:alexandre.torgue@foss.st.com,
 m:arend.vanspriel@broadcom.com, m:miriam.rachel.korenblit@intel.com,
 m:axboe@kernel.dk, m:sagi@grimberg.me, m:James.Bottomley@HansenPartnership.com,
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
 FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,ziepe.ca,lunn.ch,intel.com,marvell.com,nvidia.com,gmail.com,bootlin.com,foss.st.com,broadcom.com,kernel.dk,lst.de,grimberg.me,HansenPartnership.com,chelsio.com,zeniv.linux.org.uk,suse.cz,auristor.com,brown.name,oracle.com,talpey.com,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,blackwall.org,netfilter.org,strlen.de,nwl.cc,sipsolutions.net,ssi.bg,ovn.org,mojatatu.com,resnulli.us,linux.alibaba.com,linux.ibm.com,est.tech,secunet.com,gondor.apana.org.au,schaufler-ca.com,paul-moore.com,namei.org,hallyn.com,tipi-net.de,blochl.de,arndb.de,linux.dev,linuxfoundation.org,alyssa.is,vger.kernel.org,lists.osuosl.org,corigine.com,amd.com,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,lists.open-mesh.org,openvswitch.org,oss.oracle.com,lists.sourceforge.net];
 R_RATELIMIT(0.00)[to_ip_from(RLu5qefsf3rq4khkdydytudeq9)];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCPT_COUNT_GT_50(0.00)[133];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

On 9/10/26 4:48 PM, Fernando Fernandez Mancera wrote:
> Historically, the IPv4 protocol has been linked to the core INET
> subsystem. Because shared infrastructure like the TCP/UDP engine,
> routing or INET hashtables live inside net/ipv4/, it has been impossible
> to compile a kernel with only IPv6 support.
> 
> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
> 'def_bool y' for now. This does not allow to completely disable the
> IPv4 stack yet but it lays the necessary build-system work for that
> goal.
> 
> In addition, multiple subsystems Kconfig symbols across networking
> features like tunnels, drivers and filesystems have been adjusted to
> depend on IPv4. Keep on mind that follow-up work is required to convert
> the Kconfig symbol to bool and remove the dependency on IPv4 where it
> makes sense.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
FWIW, I just checked and the following symbols that are currently marked 
as "depends on IPV4" can already be compiled without IPV4:

IPV6_MIP6, IPV6_ILA and IPV6_MROUTE

They will be adjusted on the next revision of the series. A re-check for 
all the symbols will be performed.

Thanks,
Fernando.
