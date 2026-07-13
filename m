Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C85C44501
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Jul 2026 15:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B085408FD;
	Mon, 13 Jul 2026 15:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oKPWUX_jvvH3; Mon, 13 Jul 2026 15:16:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABA844090D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783955793;
	bh=vcWXpKMSq59reI46D3PoMFlhf4bMsFOmDLO8bdkAy90=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nZtd4OKMhiooNCSXSgviZJD0ujgRi+pbm+TfjwIcg0oq7EQQpCx1VcHzxL5cVRVox
	 Kmo3spUKj9RzSbvSVCbjovmBCRuxzw0Mj76vMh/7He+7Clr3p7JbwtkunfULp0bDdD
	 LJtLBxK6rchy/yJhxt2k7WwIS4YfX/3NFyvLrRdAx0YpFDggmjCjSLfIrJdV6XuSFL
	 pUnlDlAb5PbMFy28I4KiBXXO6JDtXVsiN7pmxybWF0310CjEtzkuWorbGAeny1/11G
	 wDXo4JJpIGV09MrJSHTbk0pcpzMwdZ9P1kUZDB2DdoKK7e/EkuNbqjvMeX6Au6XZYj
	 dd0mBGtHpCgLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABA844090D;
	Mon, 13 Jul 2026 15:16:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 632922EE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Jul 2026 14:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E99A80E82
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Jul 2026 14:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1hLCEuGgpcSA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Jul 2026 14:00:59 +0000 (UTC)
X-Greylist: delayed 130838 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 13 Jul 2026 14:00:58 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 18DC580E7A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18DC580E7A
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=fmancera@suse.de; receiver=<UNKNOWN> 
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18DC580E7A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Jul 2026 14:00:58 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83FB63E12;
 Mon, 13 Jul 2026 14:00:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40CF3779AE;
 Mon, 13 Jul 2026 14:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RWCfDZPvVGoTEQAAD6G6ig
 (envelope-from <fmancera@suse.de>); Mon, 13 Jul 2026 14:00:51 +0000
Message-ID: <2256daf4-d03c-4a57-9d72-7a388d823f18@suse.de>
Date: Mon, 13 Jul 2026 16:00:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Arnd Bergmann <arnd@arndb.de>, Netdev <netdev@vger.kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Elad Nachman <enachman@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Saurav Kashyap <skashyap@marvell.com>,
 Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>,
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
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 Jon Maloy <jmaloy@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 Justin Chen <justin.chen@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Nicolai Buchwitz <nb@tipi-net.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>,
 Yao Zi <me@ziyao.cc>, Yanteng Si <siyanteng@cqsoftware.com.cn>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Julian Braha <julianbraha@gmail.com>, Joey Lu <a0987203069@gmail.com>,
 Shangjuan Wei <weishangjuan@eswincomputing.com>,
 Chen-Yu Tsai <wens@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Qingfang Deng <qingfang.deng@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Biggers <ebiggers@kernel.org>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, Ard Biesheuvel
 <ardb@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Alyssa Ross <hi@alyssa.is>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 linux-net-drivers@amd.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-2-fmancera@suse.de>
 <12ffac6a-649a-4e4a-8d12-0b48171e1d95@app.fastmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <12ffac6a-649a-4e4a-8d12-0b48171e1d95@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:arnd@arndb.de, m:netdev@vger.kernel.org,
 m:davem@davemloft.net, m:edumazet@google.com, m:pabeni@redhat.com,
 m:jgg@ziepe.ca, m:anthony.l.nguyen@intel.com, m:przemyslaw.kitszel@intel.com,
 m:ecree.xilinx@gmail.com, m:mcoquelin.stm32@gmail.com,
 m:alexandre.torgue@foss.st.com, m:arend.vanspriel@broadcom.com,
 m:miriam.rachel.korenblit@intel.com, m:axboe@kernel.dk, m:sagi@grimberg.me,
 m:James.Bottomley@hansenpartnership.com, m:varun@chelsio.com,
 m:viro@zeniv.linux.org.uk, m:jack@suse.cz, m:dhowells@redhat.com,
 m:marc.dionne@auristor.com, m:neil@brown.name, m:okorniev@redhat.com,
 m:tom@talpey.com, m:sw@simonwunderlich.de, m:razor@blackwall.org,
 m:fw@strlen.de, m:johannes@sipsolutions.net, m:ja@ssi.bg, m:aconole@redhat.com,
 m:echaudro@redhat.com, m:i.maximets@ovn.org, m:jiri@resnulli.us,
 m:marcelo.leitner@gmail.com, m:lucien.xin@gmail.com, m:jmaloy@redhat.com,
 m:steffen.klassert@secunet.com, m:herbert@gondor.apana.org.au,
 m:vikas.gupta@broadcom.com, m:rajashekar.hudumula@broadcom.com,
 m:justin.chen@broadc
 om.com,m:bhargava.marreddy@broadcom.com,m:nb@tipi-net.de,m:florian.fainelli@broadcom.com,m:hkallweit1@gmail.com,m:rmk+kernel@armlinux.org.uk,m:me@ziyao.cc,m:siyanteng@cqsoftware.com.cn,m:maxime.chevallier@bootlin.com,m:julianbraha@gmail.com,m:a0987203069@gmail.com,m:weishangjuan@eswincomputing.com,m:inochiama@gmail.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,s:qingfang.deng@linux.dev,s:gregkh@linuxfoundation.org,s:linux-afs@lists.infradead.org,s:linux-arm-kernel@lists.infradead.org,s:linux-nvme@lists.infradead.org,s:brcm80211@lists.linux.dev,s:bridge@lists.linux.dev,s:mptcp@lists.linux.dev,s:b.a.t.m.a.n@lists.open-mesh.org,s:intel-wired-lan@lists.osuosl.org,s:tipc-discussion@lists.sourceforge.net,s:coreteam@netfilter.org,s:dev@openvswitch.org];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,ziepe.ca,lunn.ch,intel.com,marvell.com,gmail.com,foss.st.com,broadcom.com,kernel.dk,lst.de,grimberg.me,hansenpartnership.com,oracle.com,chelsio.com,zeniv.linux.org.uk,suse.cz,auristor.com,brown.name,talpey.com,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,blackwall.org,netfilter.org,strlen.de,nwl.cc,sipsolutions.net,ssi.bg,ovn.org,mojatatu.com,resnulli.us,linux.alibaba.com,linux.ibm.com,secunet.com,gondor.apana.org.au,tipi-net.de,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,bootlin.com,eswincomputing.com,bp.renesas.com,linux.dev,linuxfoundation.org,alyssa.is,vger.kernel.org,lists.osuosl.org,corigine.com,amd.com,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,lists.open-mesh.org,openvswitch.org,oss.oracle.com,lists.sourceforge.net];
 TO_DN_EQ_ADDR_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 R_RATELIMIT(0.00)[to_ip_from(RLot4zeipb4y6kxqkujfrfqztj)];
 TO_MATCH_ENVRCPT_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_GT_50(0.00)[134];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[netdev,kernel];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 83FB63E12
X-Mailman-Approved-At: Mon, 13 Jul 2026 15:16:30 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.de; s=susede2_rsa; 
 t=1783951256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcWXpKMSq59reI46D3PoMFlhf4bMsFOmDLO8bdkAy90=;
 b=H4n/nlOzSbC6kEf08Mt5PCFch2SnG8tyBuOt05AtDFm3Sezfdg5yX593HaKA6aTuamPcwD
 htbNFckzP54JbOfP4QSOBVCw/FrvgILSk8fo38hIutmTDtgGvUw8lBAOJFoO8skDLsbz9y
 32wqjJELZLybOJ5KxnKomeAhyZCck9E=
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=suse.de; s=susede2_ed25519; t=1783951256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcWXpKMSq59reI46D3PoMFlhf4bMsFOmDLO8bdkAy90=;
 b=UDB1CXcHnCErcMegyp3uKFCagjRC+Png4e+SXpAjIKzmoie60e4uuOQZJlcwnWORqsY78F
 7F2WW9VZXXdIhlCw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.de; s=susede2_rsa; 
 t=1783951256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcWXpKMSq59reI46D3PoMFlhf4bMsFOmDLO8bdkAy90=;
 b=H4n/nlOzSbC6kEf08Mt5PCFch2SnG8tyBuOt05AtDFm3Sezfdg5yX593HaKA6aTuamPcwD
 htbNFckzP54JbOfP4QSOBVCw/FrvgILSk8fo38hIutmTDtgGvUw8lBAOJFoO8skDLsbz9y
 32wqjJELZLybOJ5KxnKomeAhyZCck9E=
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=suse.de; s=susede2_ed25519; t=1783951256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcWXpKMSq59reI46D3PoMFlhf4bMsFOmDLO8bdkAy90=;
 b=UDB1CXcHnCErcMegyp3uKFCagjRC+Png4e+SXpAjIKzmoie60e4uuOQZJlcwnWORqsY78F
 7F2WW9VZXXdIhlCw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=suse.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=H4n/nlOz; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=UDB1CXcH; 
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=H4n/nlOz; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=UDB1CXcH
X-Mailman-Original-Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="H4n/nlOz";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UDB1CXcH
Subject: Re: [Intel-wired-lan] [PATCH 01/13 RFC net-next] net: ipv4:
 introduce CONFIG_IPV4 to decouple the IPv4 stack
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 7/12/26 1:01 PM, Arnd Bergmann wrote:
> On Sun, Jul 12, 2026, at 03:38, Fernando Fernandez Mancera wrote:
>> Historically, the IPv4 protocol has been linked to the core INET
>> subsystem. Because shared infrastructure like the TCP/UDP engine,
>> routing or INET hashtables live inside net/ipv4/, it has been impossible
>> to compile a kernel with only IPv6 support.
>>
>> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
>> 'def_bool y' for now. This does not allow to completely disable the
>> IPv4 stack yet but it lays the necessary build-system work for that
>> goal.
> 
> I expect this will cause additional (trivial) build regression in the
> next step when randconfig builds run into obscure corner cases, either
> with INET=y IPV4=n IPV6=y or with INET=y IPV4=n IPV6=n.
> 
> I can probably give your patch (with IPV4 visible or disabled) an
> early go on the randconfig tree to find these more quickly.
> If I run into regressions, should I just add more 'depends on IPV4',
> or do you have other plans?
> 

Yes, I have a job running randconfig and verifying nothing breaks. If 
something breaks and it isn't core networking stack I would just make 
the Kconfig symbol depend on IPv4.

Then later we will have more time to write a dedicate patch so it does 
not depend on IPv4.

> Should we have some logic to ensure that at least one of IPV4 or
> IPV6 is enabled? I think this would work
> 
> config IPV4
>        bool "The IPv4 protocol" if IPV6
>        default INET
> 
> which only allows turning IPV4 off if IPV6 has enabled.
> 

I do wonder, should we? I mean, I didn't try it off but I don't see why 
we should not allow a pure L2 system..

Thanks,
Fernando.
