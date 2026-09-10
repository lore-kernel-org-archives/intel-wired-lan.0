Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710B1C79FBF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 16:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2097340B55;
	Thu, 10 Sep 2026 16:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eDEQ4XUyr5Ja; Thu, 10 Sep 2026 16:31:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 46BDB40B4E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789057914;
	b=gBUKREkKmD7hW1dd3Bc8mEuiErSjxhGGyUfAw0WCsgI/pDfhuQyzx1QQN0SGRn1prBwv
	 qIXj3Xe/D9NKXN3K08akp5pYc1/f2FnUYGRlIvIyc8O1M394plzZgs+8QHqM83yr/ldsE
	 fhYY3RfMF6Qc8/ueorigprXmOzHbHrvTi0G75aZkVdqIJlpKoXW//LbfePYXxo7Bjb5KZ
	 eVHbiMF7RRs15GwopBjzUW7x5wpe3X43RxeWrCYXY5cGnljendqyc7P4i0xWND/ZoEjPv
	 fdtXqINX8cU1f3FYgJv46NUKnpSFySv3pj7hVtaWYgZeq4pvTyi5ssgoGsaj2qC508Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789057914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spamd-Result:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K0lYofAWqHa7ePB/bJxKmxDOeogYPK+nv0lM1u2sygM=;
	b=BdcDHiW0vyeCMR4M5dXzx3oBX6mit4ko7Mqx5EkBc5A6z9Pfop9YPFHC8gEIPgejWCrf
	 IlSoprP26BRP7hXbfhnm9kuIHBmH6PjPU0XcvUTBFzWGxj0rRwFnXzDEot8ylcusWyykL
	 WCKMaQu5Fg4LQkQladQJYpbH25nX6iSyeeE/2VeK5Mh16G0TTcG/9upuLyuT85gvWPV/i
	 bHvxfLZg031LDdKv+XcVjHnT72ATtvitrfhs14nBAxReBOFhiUr7htmpqSQD9tHSHRobT
	 AYcwRgHJ5pP7xS66JFT2mDbmYVnR6BtDmIBR4Bq5/wX3Enoiu5k37dYe6lQhkuiD/sQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789057914;
	bh=K0lYofAWqHa7ePB/bJxKmxDOeogYPK+nv0lM1u2sygM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jq15U2PCYxuaJxSTXJtoAHOU9/dmOJ/RYdhNCJr22wkIRk/+roIW6BnASDQpHzHTe
	 KgaOOIqiGuFc15/WGmN5MMp05PNjJYRnffGS5ux1XerbSE69f0zJymxU3NIxv74B8E
	 GhRh3k6XAvIe8H0ryxb2iG7fWWuFHVTVghQuuEwC/vd++lFjsi1ppEZIaLtREDS364
	 0T7kiTBYybpl9qvDFc3R5X+xeM47bJfxZAbnvaQ50JKY+B2opKomtHW6K4KSGju1h4
	 PP5fyAy0pZk7mzKqOUADwPbn2oIr1pere5JV0FwDdfq5IF1F3kDD9QcJcpdrGDlI6t
	 qwsi2q2gSllyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46BDB40B4E;
	Thu, 10 Sep 2026 16:31:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9699C49D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 16:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 883E360B9F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 16:31:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OX13xMe6eSLo for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 16:31:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 87B4D60B96
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789057908;
 b=TXHaT8yhn2wWxwaKxt1dFZeUpUAsqx8qzcDClXAF9j7QgwxvzJzwfL6pdm6JabgX8H+X
 J7G+ePLq8qOHMNjS7gpvWSgVr3XXr5ML15XUamCBVbWIP6Ls1i5fSir/+9SWtMi10XFbb
 b0dJYaOAjEXrm8fltbQOJLwlP9snod+xbYoP3CEylp9QXvD75OYY2yrjQtZCW54l9MjMD
 YKoVhTeevqH5zhyp5bFUWA7njYleIIRPa1lo+VFlPlp9hnGXstAYuwc6aX7+Oxi2p9ruE
 o6fRCpoht2Ag5jDokpjw6boz0qkrWsst/5xyCSnN4FW1TOob7FQUr4VV2dvXpfE65RA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789057908;
 h=Received-SPF:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Rspamd-Queue-Id:
 X-Rspamd-Server:X-Spam-Level:X-Rspamd-Action:X-Spamd-Result:
 X-Spam-Flag;
 bh=K0lYofAWqHa7ePB/bJxKmxDOeogYPK+nv0lM1u2sygM=;
 b=I9GGWXVv1PWmgbjIOAHs7u2+xoqGAyC/GDfOW7cvAluyYKcbpa4QPipJOkfAzdHWhgKg
 7908LDkjA0J62l46ONF+6gwk2XcjqlhzQlyQ4rz8MPTjDDZhfdbLMzcu797DAxrK31P6T
 Gyts9uSjqVK0+f7iTGhWE2J9engSDGMnSttmIaEnsmMmi+yBDXmyVGkQ60ifhyZvf/KgM
 jpZ4APQ3TXX26XsuW6u7HD2YqR7fptG9b5/lJrzWAQibf1oPzNdkNkr5IjhV7JQU0XBu+
 rbTKlxgksiSC0e9rCuds9K0W6SLe/PmWvJHulgFqnOvx3EpICnHQXHuAlpj4TW4NB+Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=suse.de; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=yQtRt462; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=LH324BSn; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=cYCiQcKe; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b="ImEU0/HI"; 
 arc=none smtp.remote-ip=195.135.223.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.223.131;
 helo=smtp-out2.suse.de; envelope-from=fmancera@suse.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=yQtRt462; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=LH324BSn; 
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=cYCiQcKe; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ImEU0/HI
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87B4D60B96
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 16:31:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7BD591FE33;
 Thu, 10 Sep 2026 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789057901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0lYofAWqHa7ePB/bJxKmxDOeogYPK+nv0lM1u2sygM=;
 b=yQtRt4622LZ6Zi4UvIWOPIjsnQFttLWbic0UbOJ/MktL5wrTGXBqQN6VGuGrXRhIlo/NeW
 mEztr0zz7AktV8m4uA1s3ZQ6UgnpG9dWJT2grEZj2W+OiQ8bJuPUunvGSejQ+jE1ZPWpKC
 TMxQGHoX9d9j13TmLvZ4K61GrFCE9hA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789057901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0lYofAWqHa7ePB/bJxKmxDOeogYPK+nv0lM1u2sygM=;
 b=LH324BSnk58hu9qiwIXwVhycJLjRA5a8tBmcWkTq5EUKnPJNyXh5hxQGh9zkZjY59lz4yV
 8q006bBLfAs0WTDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cYCiQcKe;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ImEU0/HI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789057897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0lYofAWqHa7ePB/bJxKmxDOeogYPK+nv0lM1u2sygM=;
 b=cYCiQcKeL+lNT5vXzUYXm2veHe3zr0mktCu+3rPmCBwrw2kTXo37AwFOyr1bYeWe0bmHdV
 1arZOiwul7owGD/gNEqP/XnSrf1owgb50cB3DU9jESucNN4UKtQMk8/5hHaj02PDghTAWf
 4mE3IjDeiQiY5bqZ7XKwd7ngXgaQAtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789057897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0lYofAWqHa7ePB/bJxKmxDOeogYPK+nv0lM1u2sygM=;
 b=ImEU0/HIDJ8BCgajwwBBxGIMxsn8h8Ik16/8D9zy28+7s2aEcSnL+JFiPuiMCS5WBdZZOG
 Rc066ADpK5HMSXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4ED913180;
 Thu, 10 Sep 2026 16:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3ywWNWLbomodUwAAD6G6ig
 (envelope-from <fmancera@suse.de>); Thu, 10 Sep 2026 16:31:30 +0000
Message-ID: <6cd59005-16b9-402f-896e-a031c1e0b20d@suse.de>
Date: Thu, 10 Sep 2026 18:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
From: Fernando Fernandez Mancera <fmancera@suse.de>
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
 <bee1e0e0-6114-462b-975c-62ca2e448e8e@suse.de>
Content-Language: en-US
In-Reply-To: <bee1e0e0-6114-462b-975c-62ca2e448e8e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7BD591FE33
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,ziepe.ca,lunn.ch,intel.com,marvell.com,nvidia.com,gmail.com,bootlin.com,foss.st.com,broadcom.com,kernel.dk,lst.de,grimberg.me,HansenPartnership.com,chelsio.com,zeniv.linux.org.uk,suse.cz,auristor.com,brown.name,oracle.com,talpey.com,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,blackwall.org,netfilter.org,strlen.de,nwl.cc,sipsolutions.net,ssi.bg,ovn.org,mojatatu.com,resnulli.us,linux.alibaba.com,linux.ibm.com,est.tech,secunet.com,gondor.apana.org.au,schaufler-ca.com,paul-moore.com,namei.org,hallyn.com,tipi-net.de,blochl.de,arndb.de,linux.dev,linuxfoundation.org,alyssa.is,vger.kernel.org,lists.osuosl.org,corigine.com,amd.com,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,lists.open-mesh.org,openvswitch.org,oss.oracle.com,lists.sourceforge.net];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLt8y6wi1bfiy5zg4r6hmh87bb)];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_GT_50(0.00)[133];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[netdev];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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

On 9/10/26 6:22 PM, Fernando Fernandez Mancera wrote:
> On 9/10/26 4:48 PM, Fernando Fernandez Mancera wrote:
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
> FWIW, I just checked and the following symbols that are currently marked 
> as "depends on IPV4" can already be compiled without IPV4:
> 
> IPV6_MIP6, IPV6_ILA and IPV6_MROUTE
> 

MIP6 depends on XFRM so it actually depends on IPV4 for now.

> They will be adjusted on the next revision of the series. A re-check for 
> all the symbols will be performed.
> 
> Thanks,
> Fernando.

