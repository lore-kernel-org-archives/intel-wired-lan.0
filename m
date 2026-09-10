Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC17FC88E40
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 19:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96F0860BB7;
	Thu, 10 Sep 2026 19:00:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fH8ZaSjZoXk; Thu, 10 Sep 2026 19:00:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AD30A60BCE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789066855;
	b=j9ux4zM4pVZ9sbC2oy65zIIyXES9GEkDlBPObc09kRrm/Fo4LRBGJ8xZwNfMjHXymju9
	 qikEPa8gjGYGcDysCoDyO9gweKKIpdeclQQFhM3Qevn67FubY3gritqxTBYjqOzO5LT+O
	 jGzeolLqlWVnh7lkqTrdMw2ldA8nGPyjdupY4ATjuoCilaYvgJcE2lhJU25807Uk6+9+m
	 1y/l5x99BnN6K2BNKNvIJU+BNjOD491kju1b33S6V7LlJuun7X/W3SbemRTris4dvx3Yu
	 Fiy26Nr/TuNokwpsa073yrtlThbKOH0HOttUOVTrbl8hkorTElGoiETu0caQ6IBER8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789066855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CrpBp6UrC3ldEa5GcKmmPo3oz74G2RAnpQBvJ2o9k1k=;
	b=T6hc65MBQ7K/y0UfuozqF0RSvBBnJhs6tBlvuzk/csY0vtSpvfZ04xdh3ao+2ydrVIFs
	 HVmjKd3RMeRJ2JzG0hkHIHZiMcXrmjh0Y9vu/wqHtDIsdaqCPsJnfEMzJ5/VD9TGY+3xM
	 /Eq9hd6Osv5ROcAgEJtBXrIdHkNBztdBDjOoH9PLiJlB5cQPyoKxkheFF2kfe9rFC6dA9
	 gu8so9S/GTb3yFr+9PQ6DA47bWj0NHtBPC7SX3mkcWVJ2PDa4kLJ7/LrzA/O32FODLFKE
	 4tL+nBawkR5H6uO4GWRUrc2zPNIldbI6XVmPU7khqy9tPW1UQObgX2Exh8VDBwGpIIQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789066855;
	bh=CrpBp6UrC3ldEa5GcKmmPo3oz74G2RAnpQBvJ2o9k1k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J7CfWAHDcZ4Di60HGTkUbbP2nIJ9DI9wwBIXnsXYnL1IfEST8ky1FPT7Jel5OPnMg
	 fk4H9xLcJUa8WyDhS7zCmG1vWAPDcb+0Syw/hzm7geHaXFuqiP7gLWifKFUXVA2tM6
	 aU0LVrx5R/UAcXpkX2tbixrDT+uIhcgNgPNYZpC7t6z6BkfIPDF/3GVtc1l8/exCH7
	 iqKmnavFGTojh/hKpukocNxcjFto/SItqEFUNQoKC5zmBPpD7+kqNMTQsu8RR/6ow8
	 hToObbU/GEsLC9IMdbd5CFg2JN8JYKP0Ry3w0VYIA2HYsEkLokvkYXlJnKmdyk8wdH
	 2wGyDDEUTzJkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD30A60BCE;
	Thu, 10 Sep 2026 19:00:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CE07949D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 18:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3D7D4038B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 18:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6nOuoYLOPR6t for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 18:55:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C0D5B40387
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789066546;
 b=maFdpxPURLSC2n4tAFxdkE6DEZ4RFqWZCy/a3crBPOtdttL2deQ397GI48y+3QjzwTUM
 85MzzRu9fWxFvhKzh4fOf313Kfqsl5SCHuymPiCNKFlKWoUbuBlDxQn6o0jyx9/MWlXjy
 eEhbSrJm5Cd8U9W7lyjwxiOfMAYgaEH+xIrLN5xZNmp05yxwZVxfl/S02WJVLSeHrriap
 4gFzPyf4gGorusLTM6pcNKNa4AV45jYaqpGGUyU+vUghjBudhr1jG21g6ajbkKKeY/vVL
 N5zqM6t7zNlYTqz/INLt1zS3Q+k/AEGuABRmGBke/wtPDpoB4SoHeCIyv7Rsq5lAMVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789066546;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:Received:
 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
 References:Subject:Content-Type:Content-Transfer-Encoding;
 bh=CrpBp6UrC3ldEa5GcKmmPo3oz74G2RAnpQBvJ2o9k1k=;
 b=bTslkXXDzpZbMbSaBiMlSjlAnUJWHWUDmLYMXEuhhdkiIXbTasnj2OIdddiFIazLmGfM
 tW3Opsn+yiHU63dfwQWNRWugb9XJD0aXjokMXEk1f3795wwx2xcNvJ2A4QDsK6N/634Q2
 eZBNxLlDVa6bTDk/m0hfRpRbrWLk6ATjizdHMlWARwiIrF6LhT6OF5KGilN5wSWUUj3c5
 XxQeJiS7Smj2xOUrPOlk+0wQS92ASMBAve3TdL0s2CRrLkMIOdNM7ZmrOCk54EUsKf95t
 4a3M9tzV6gf02AuVfKs+hfdVe+pq094g6tP17jD3kMLc/OXBpYCYh5UHYH6oAwpq33w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SUzKykjd; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=cel@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SUzKykjd
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C0D5B40387
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 18:55:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6ECCA447E2;
 Thu, 10 Sep 2026 18:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE43C1F008A7;
 Thu, 10 Sep 2026 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789066545;
 bh=CrpBp6UrC3ldEa5GcKmmPo3oz74G2RAnpQBvJ2o9k1k=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=SUzKykjdvV+5mb7+BixcB80g7+i+u+nBUwfb9eta7h9ErBD3kHVouipLrFNBXHDo7
 Uyw4TEjlpn2m6IR6OTAmJKxDBIrJhtxYk9WyN6/cCJECIUZ0OaGP5pFuWeEzz9jfiY
 Z8sTU5HwMpjruRlLh9s0Bx+p9piEZO0ceRs4l+vY877XvU3dSiGQlKgiCq1cmrIX5s
 jcPDoCtGxJkAPjQjpe/F3DiFGiqirkyyCJA79XjucJKL4pVuQNqMz2IWjOt4PnUT/c
 OxOpmwwOjbn3eepxYYTNMlO67QQOAOsXAp4rj/SK5E0QFMKw/iOnkIVWPTUVGKPkKk
 g0bNHWFwxKWvw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfauth.phl.internal (Postfix) with ESMTP id CFE21F4006C;
 Thu, 10 Sep 2026 14:55:42 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
 by phl-compute-10.internal (MEProxy); Thu, 10 Sep 2026 14:55:42 -0400
X-ME-Sender: <xms:Lv2iaplfbQ631YFOzCGpJasjLjWIwQT3JrRVk3LS9MkCgPR1g1eugA>
 <xme:Lv2iavr9DxNpwTN2WBDYnlnGtcos9ihLSRkWiANMTxQZahPdAPSJkGAMCtQD9uGmu
 CvlIzaCLaPaXqkiswOybV3mvL_461fEaLOySRiUpr08YCVAogsBrjk>
X-ME-Proxy-Cause: dmFkZTE4zEfUt91Vh8wMjr6L/WUBy21uDOI31KgY6OiMy0jiDAiO+GFbZriSZgXS8OAWnu
 /3wZfwktsQy09207CvYDKSXzOlYx9ZdBx1LSo/kQEdWNYp1yKeuEWfRKk9ojXejFncjkBt
 KckJanJNrOVpIib2/f6VXeIYgIP4I/6znBINkeaBLD8q/h8tTagpKFEVt2qYqixiI7+8ya
 Qck60jclUtx0SBvHLjTkr0/GBYxsUlspQBzQH7cLVb8Cy4QOwtBOR6sJv/73LrNH/Rr2dG
 XLu8xXR7kBokf4Hy6yKlXpCqB+DsgyF+8XmuyIzmr/OJYZPyvmv/ip/XfvhUk8ogZaQ3pr
 hOFjwJEFCJjQ6WJ8p5KgTILYUUvbu+1iKa4pw9oVNnHgKi7hTmmtu7k8vw99W8cd3eu808
 zZ7dnzk0LARYbX8HAqHV3buYMe4o9iEMKJwKob6lss0LOl/7XhQIypSm7GAf45lexb+g54
 Xm6bRAfY7SdS7p0rbeG51YU3sEYNWG/Mol7x0fZihE8QLC4ptqicNhJxDtyBLdDEX4yY0L
 NxeSjxo00rxMp4bke3nbLsmzErPZaLCX6BE+kz3nXYadZaNZFzWiOvWSaxkl2nI1wPMwGu
 qksNgPs3kj+c5Ft0oAb3U6+T7q0gnx/W3XYreb4vehHpxvHId3daxUMn3wkg
X-ME-Proxy: <xmx:Lv2iau4uQgwZ5ZSX77NXUK00CupYfPLJ--mL7W6WyoCrnFXJ28AYqg>
 <xmx:Lv2iaqX7SMcL8hmfn1O5CVsW6yS7vTTV6bHzj9JKszswq-uSObcxfw>
 <xmx:Lv2iarJEeotBEMJbbVfbMSQaUwMqTvxtXIvy4a3GKPkLyANW62-8MQ>
 <xmx:Lv2iaqQcxmN0cokbQxX3YL090yzt-HrXiCbr35zWHqVENYQgqslXjg>
 <xmx:Lv2iauC5ue_eshF6QAwcEWN4h9uxzHMXtUdgP-v3O2VblTSkZDFa_bSI>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 8F75E7811F0; Thu, 10 Sep 2026 14:55:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AHIlAaKAQArc
Date: Thu, 10 Sep 2026 14:55:20 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>, netdev@vger.kernel.org
Cc: "Simon Horman" <horms@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, edumazet@google.com,
 davem@davemloft.net, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Leon Romanovsky" <leon@kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Tony Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 "Elad Nachman" <enachman@marvell.com>,
 "Saeed Mahameed" <saeedm@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Mark Bloch" <mbloch@nvidia.com>, "Ido Schimmel" <idosch@nvidia.com>,
 "Petr Machata" <petrm@nvidia.com>, "Edward Cree" <ecree.xilinx@gmail.com>,
 "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Arend van Spriel" <arend.vanspriel@broadcom.com>,
 "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Saurav Kashyap" <skashyap@marvell.com>,
 "Javed Hasan" <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>,
 "Nilesh Javali" <njavali@marvell.com>,
 "Manish Rangankar" <mrangankar@marvell.com>,
 "Varun Prakash" <varun@chelsio.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Marek Lindner" <marek.lindner@mailbox.org>,
 "Simon Wunderlich" <sw@simonwunderlich.de>,
 "Antonio Quartulli" <antonio@mandelbit.com>,
 "Sven Eckelmann" <sven@narfation.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>,
 "Pablo Neira Ayuso" <pablo@netfilter.org>,
 "Florian Westphal" <fw@strlen.de>, "Phil Sutter" <phil@nwl.cc>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Matthieu Baerts" <matttbe@kernel.org>,
 "Mat Martineau" <martineau@kernel.org>,
 "Geliang Tang" <geliang@kernel.org>, "Julian Anastasov" <ja@ssi.bg>,
 "Aaron Conole" <aconole@redhat.com>,
 "Eelco Chaudron" <echaudro@redhat.com>,
 "Ilya Maximets" <i.maximets@ovn.org>,
 "Allison Henderson" <achender@kernel.org>,
 "Jamal Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>,
 "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
 "Xin Long" <lucien.xin@gmail.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 "Dust Li" <dust.li@linux.alibaba.com>,
 "Sidraya Jayagond" <sidraya@linux.ibm.com>,
 "Mahanta Jambigi" <mjambigi@linux.ibm.com>,
 "Tony Lu" <tonylu@linux.alibaba.com>, "Wen Gu" <guwen@linux.alibaba.com>,
 "Jon Maloy" <jmaloy@redhat.com>,
 "Tung Quang Nguyen" <tung.quang.nguyen@est.tech>,
 "Steffen Klassert" <steffen.klassert@secunet.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Casey Schaufler" <casey@schaufler-ca.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Vikas Gupta" <vikas.gupta@broadcom.com>,
 "Bhargava Marreddy" <bhargava.marreddy@broadcom.com>,
 "Rajashekar Hudumula" <rajashekar.hudumula@broadcom.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>,
 "Arnd Bergmann" <arnd@arndb.de>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Qingfang Deng" <qingfang.deng@linux.dev>,
 "Julian Braha" <julianbraha@gmail.com>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Neal Cardwell" <ncardwell@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Alyssa Ross" <hi@alyssa.is>,
 "Joel Granados" <joel.granados@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 oss-drivers@corigine.com, linux-net-drivers@amd.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-nvme@lists.infradead.org,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-s390@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-security-module@vger.kernel.org
Message-Id: <ff6ff699-e942-455f-8816-49af24afb370@app.fastmail.com>
In-Reply-To: <20260910144914.8025-2-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-2-fmancera@suse.de>
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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



On Thu, Sep 10, 2026, at 10:48 AM, Fernando Fernandez Mancera wrote:
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

> diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
> index e7808e5714dc..58e6f6db3100 100644
> --- a/net/sunrpc/Kconfig
> +++ b/net/sunrpc/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config SUNRPC
>  	tristate
> -	depends on MULTIUSER
> +	depends on MULTIUSER && IPV4
> 
>  config SUNRPC_GSS
>  	tristate

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
