Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDC6C88E4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 18:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9935560614;
	Fri, 11 Sep 2026 18:32:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c94miYHQ5ZrB; Fri, 11 Sep 2026 18:32:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B1F5E60616
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789151548;
	b=RZ+aO/WG75lr3T4aMKivX0nHZZzHZxuZ3a92vXn3ktT5mjJegbXCBYLWW3wggMQRLD9y
	 3k6XWF2CtDnxv+9YR6QwP6afADJS9rysfcwAe4rRYiG1Xhut5ksV3UOYFsq3fosd5r052
	 VkHjfgPAf75qEwOusApv4AOtJxWja3bCcJzMPCxh2RnY2EF4cO1DecvzQLPuiHN/R/aFK
	 vKJaUJY1OwIZ7b9b83604brOb8aXVlbgPCZ2XbZt7g+bVUqYE1Olz5fdKJeUudo4J9WZ5
	 89s1a8iLiDwG/aXzRMOIbvoBtvHDq7lYvN1qlcAg0VeChGpliPRK/zbp9eFf47s4vsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789151548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Action:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spamd-Result:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b3huHsOxzXu3WG732phakZA+zeD+7wCDwsZTRvWLdY4=;
	b=pKChUFhUli6OWg0CXvNPvcn4uAuUiqjTrm/YAHAdUlf3nw+VV+pgOjnisYR6BTLZrcLi
	 bHJ52PpcG1srNqrBQac7i8U285BOZ9DoS37SdndAwzCNDmvtb4v+7ikBuPDrrt8gpXTes
	 9z2ScepwWWXq1Vv5mahC8w1zzI+RepO2A0PCcevql1Ug2JBj/qL2k61qDzXl0vBdt4a9r
	 hCc1b+0IMomS+w4H6oD56uNfkvVaNHd6nq3Hgu4l7Y6bOFDfqRG6JEtnZ//11mZzZsRnq
	 kxMuYJr0AgG3dPHHlwhmMapnqm3hG/GzK7JsOqzcQdufMsWYzu1f1sUm6Le5iPtjMKQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789151548;
	bh=b3huHsOxzXu3WG732phakZA+zeD+7wCDwsZTRvWLdY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BGynbLVaQfsUQAwQ83gETpTJOsbDsAscExAgDkYD5RQjO8m6zeumQQA5fXSgDoyHM
	 yuNd0JWUImTqRaDyDLqOxNsj9cosvhwIKZT9dAA330atkPdEGui88OItjCzmb5gExq
	 GcvLGXwtAJYcL3WLXaIsGaGLg3diPhMxPf9zjtVNXSX56H4CP3GWCuYw/Efq0eXpzT
	 hkN7pkkAWfa5KxTYCas6Y3jwU/LlL5dyzK+fWas1oGLfUBVJJwNOuE5QYmS0Ss2Tjf
	 gZRjE8RgW3PlrpSF29xrqNQecIOrmYDxsMclIaM7+DcDL8cJ98KqKkZYS4qkYkTXz7
	 r2Ejld9AlmPcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1F5E60616;
	Fri, 11 Sep 2026 18:32:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 96B3372E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 18:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C8C7407ED
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 18:32:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id okC0YjsMlFwI for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 18:32:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2B59140752
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789151545;
 b=NObgbRLRUsficx45U8/q+VdSB1OuS9PfD3N3xv7RycFN9n+Odrr/J6YG9Z9lYxkvQsJm
 djK/hpnu9fkI/1qJpItscUCMAU4wnzMKICr1/fuHdjqe3hNK2OrQtzBALwUywDyB3yHUw
 i7XVIvnMFAkX8ZJmyQDBYQH6OjqrV+DPe2HfAnCk/n5SrP75mmJKRoqmD8wwIKgG7wl1+
 rbfOO91dYzz8DZr+WPYUBNoF2apwtSBci8MhgTcz1y0rDiZFSlo04yGeK1/zIuYd6KeGE
 CZjMt7OI8NuSm+qjSGYS2B93NKhPHCy1pMLj+9PuwOIUNFHikdoIAYubH/nyFrJbvJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789151545;
 h=Received-SPF:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Spam-Level:X-Rspamd-Action:
 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Spamd-Result:X-Spam-Flag:
 X-Spam-Score;
 bh=b3huHsOxzXu3WG732phakZA+zeD+7wCDwsZTRvWLdY4=;
 b=CKDmm+gH5GHaamjiH+Z3+YxydFFLCoRF/F0QoJB07Noxa8GQMWVcYj6k9fpPvgG1Sex+
 lKH22yo9MQpkJvDo1G+JRUPXEk6GtOJq2f/0Lkc2o6t9zthUlGxB08IJxbthuLrFlqoiA
 qXje9vTu3BS6Az1b94qlhUY9HNhPrOU243l/RGCHjSnHnf50SMQz/vls2GUMx0Y4Ws5iA
 l+QWuUxvSvlFG1vCMwb0+9rwFYYW+q+WtGUwodVf3R7+xH57KWBPgUHrjKDW7ih4XJAfb
 tnqiRddGGgraiBBpa9RZbE05wBRm1RgDZbAZY6EpjTHZqLIQpfsI3TVcIFAoG2yoFqw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=suse.de; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Rod0sU8Q; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=SIrVXAQ4; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=t9gvN2nl; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="FnLFXx/K"; 
 arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=fmancera@suse.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Rod0sU8Q; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=SIrVXAQ4; 
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=t9gvN2nl; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=FnLFXx/K
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B59140752
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 18:32:24 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE2791FEE6;
 Fri, 11 Sep 2026 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789151538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3huHsOxzXu3WG732phakZA+zeD+7wCDwsZTRvWLdY4=;
 b=Rod0sU8Qdbl2a9I9t1TH8nevi4QRfn3TPfcK74bX64NGYlK6IHkuzAhBL08HIKt63niSI/
 6veFNIqyotajC6UCFkeNjNmJezrJxBptWKdfl94tSQs8eHOgD9mU8KcO4CkQo1s/NpMwfn
 kmsnciPVbpHoeV5HykyGSvDyJ/flO3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789151538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3huHsOxzXu3WG732phakZA+zeD+7wCDwsZTRvWLdY4=;
 b=SIrVXAQ4ceuoB0fGrHOOtVO1/WzKntIfVXPqXNQPSKYuVdsXv8YzVUOSr+XNFJ/yIPVMhN
 zTZpSfo+uSEO1wDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t9gvN2nl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="FnLFXx/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789151534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3huHsOxzXu3WG732phakZA+zeD+7wCDwsZTRvWLdY4=;
 b=t9gvN2nlbxSG+QCJOr3Qwp0FANn+yCEqu4YHmsqlPzf0zjeumUAtcGLCZTbmav6JBEjAnm
 c41BWBSWq8AARidcMzA+ZhJfDP3iy28qnix3YpHWZbSEX+hx1j3W5/Dot4Ih4kiPxwIVpp
 7cHlpzVuqFt2y519+0+mCk4UCgw+K/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789151534;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3huHsOxzXu3WG732phakZA+zeD+7wCDwsZTRvWLdY4=;
 b=FnLFXx/K4kGWIzrUI6pjTmx6O95RSJHfUkFLZdB3yB4XYnlrurdCfLL7hNThqzkOntilHf
 8PYNspUtNK/EHXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A640132D3;
 Fri, 11 Sep 2026 18:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B8AjFydJpGrJdAAAD6G6ig
 (envelope-from <fmancera@suse.de>); Fri, 11 Sep 2026 18:32:07 +0000
Message-ID: <dfd9590c-e029-4432-9a13-c789f708cfee@suse.de>
Date: Fri, 11 Sep 2026 20:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
To: Casey Schaufler <casey@schaufler-ca.com>, netdev@vger.kernel.org
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
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>,
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
 <ee89e26c-3dad-450b-8861-badf19afa141@schaufler-ca.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <ee89e26c-3dad-450b-8861-badf19afa141@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EE2791FEE6
X-Spamd-Result: default: False [-1.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:casey@schaufler-ca.com, m:netdev@vger.kernel.org,
 m:pabeni@redhat.com, m:edumazet@google.com, m:davem@davemloft.net,
 m:jgg@ziepe.ca, m:anthony.l.nguyen@intel.com, m:przemyslaw.kitszel@intel.com,
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
 m:herbert@gondor.apana.org.au, m:serge@hallyn.com, m:vikas.gupta@
 broadcom.com,m:bhargava.marreddy@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:nb@tipi-net.de,m:markus@blochl.de,m:arnd@arndb.de,m:hkallweit1@gmail.com,m:florian.fainelli@broadcom.com,m:julianbraha@gmail.com,m:enelsonmoore@gmail.com,s:linux-afs@lists.infradead.org,s:linux-arm-kernel@lists.infradead.org,s:linux-nvme@lists.infradead.org,s:brcm80211@lists.linux.dev,s:bridge@lists.linux.dev,s:mptcp@lists.linux.dev,s:b.a.t.m.a.n@lists.open-mesh.org,s:intel-wired-lan@lists.osuosl.org,s:tipc-discussion@lists.sourceforge.net,s:coreteam@netfilter.org,s:dev@openvswitch.org,s:rds-devel@oss.oracle.com];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,ziepe.ca,lunn.ch,intel.com,marvell.com,nvidia.com,gmail.com,bootlin.com,foss.st.com,broadcom.com,kernel.dk,lst.de,grimberg.me,HansenPartnership.com,chelsio.com,zeniv.linux.org.uk,suse.cz,auristor.com,brown.name,oracle.com,talpey.com,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,blackwall.org,netfilter.org,strlen.de,nwl.cc,sipsolutions.net,ssi.bg,ovn.org,mojatatu.com,resnulli.us,linux.alibaba.com,linux.ibm.com,est.tech,secunet.com,gondor.apana.org.au,paul-moore.com,namei.org,hallyn.com,tipi-net.de,blochl.de,arndb.de,linux.dev,linuxfoundation.org,alyssa.is,vger.kernel.org,lists.osuosl.org,corigine.com,amd.com,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,lists.open-mesh.org,openvswitch.org,oss.oracle.com,lists.sourceforge.net];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 R_RATELIMIT(0.00)[to_ip_from(RLt8y6wi1bfiy5zg4r6hmh87bb)];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_GT_50(0.00)[133];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[netdev];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
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

On 9/11/26 7:46 PM, Casey Schaufler wrote:
> On 9/10/2026 7:48 AM, Fernando Fernandez Mancera wrote:
>> Historically, the IPv4 protocol has been linked to the core INET
>> subsystem. Because shared infrastructure like the TCP/UDP engine,
>> routing or INET hashtables live inside net/ipv4/, it has been impossible
>> to compile a kernel with only IPv6 support.
>>
>> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
>> 'def_bool y' for now. This does not allow to completely disable the
>> IPv4 stack yet but it lays the necessary build-system work for that
>> goal.
>>
>> In addition, multiple subsystems Kconfig symbols across networking
>> features like tunnels, drivers and filesystems have been adjusted to
>> depend on IPv4. Keep on mind that follow-up work is required to convert
>> the Kconfig symbol to bool and remove the dependency on IPv4 where it
>> makes sense.
>>
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   
> 
> ...
> 
> 
>>   security/smack/Kconfig                        |  1 +
>>   54 files changed, 126 insertions(+), 66 deletions(-)
>>
> ...
> 
>> diff --git a/security/smack/Kconfig b/security/smack/Kconfig
>> index 5a8dfad469c3..b4e6d0168bd1 100644
>> --- a/security/smack/Kconfig
>> +++ b/security/smack/Kconfig
>> @@ -3,6 +3,7 @@ config SECURITY_SMACK
>>   	bool "Simplified Mandatory Access Control Kernel Support"
>>   	depends on NET
>>   	depends on INET
>> +	depends on IPV4
>>   	depends on SECURITY
>>   	select NETLABEL
>>   	select SECURITY_NETWORK
> 
> Why would this make sense? You're introducing the capability to use
> IP6 by itself, which is admirable, but you're disallowing that configuration
> with the Smack LSM. It appears that you've done a mechanical lookup in the
> Kconfig files and applied the minimal change to make the kernel compile,
> which probably works for most cases. It does not work for Smack. Unless
> there's a strong argument that Smack with IPv6 and without IPv4 is and always
> will be a pointless configuration you have my NAK.
> 
> 

Right, that was kind of the point. The idea was to be able to compile 
core networking without IPv4. There are still plenty of modules that 
depends on IPv4. It does not mean that they will remain like that 
forever as I mentioned my idea was a follow-up on the series to avoid 
having a too long series.

Anyway, I can make Smack to do not depend on IPv4 on this series if that 
could grant an ACK.

Thanks,
Fernando.

