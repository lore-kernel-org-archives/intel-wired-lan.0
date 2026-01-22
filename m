Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33398C44500
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Jan 2026 07:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9BE581318;
	Thu, 22 Jan 2026 07:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BpXt160id6md; Thu, 22 Jan 2026 07:50:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 058F58132C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769068204;
	bh=YfFJ1yYZBltGbYzcJ2fakwNTo9XP10WDXsi1mmhmUGI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bbWxGE+yLuiJ5glrJC58f8I4fnaapGJMIWtYmTKsIaHB+vddyViNzl/eWUhiI4BkV
	 /I4pENGw+JIlOgqTXZUfCF7KmiKYOVZ+G2wabagaMouK2W3nbhcewI9k+/Vq839hvl
	 1BGUY3anLnzx6+5Ry8jAusb+5p/+GvgF1U2fn3qwQCsbH8gB3wD4WcRMvAzNnA0qry
	 ABhmA2TtjPQPvfJ/v+At+slia/DmmctjadkNfEuM0TDRIrRj+9JJBWE+9uIUK/Rm4e
	 6HgEd1mU8G8tPdG5gKtpvGFlCGll5R9I+SEjNoxcUJweaM+H3yo0v4h/hZvqcU1+bE
	 OLkXwW8ikGOhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 058F58132C;
	Thu, 22 Jan 2026 07:50:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C72EA24D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 07:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C096940C33
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 07:50:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmJ2xD4_QnsX for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Jan 2026 07:50:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 36F3640079
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36F3640079
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36F3640079
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 07:49:59 +0000 (UTC)
Received: from ms-a2 (79.192.13.160.dy.iij4u.or.jp [160.13.192.79])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60M7nHV3064753
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 22 Jan 2026 16:49:17 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: aleksandr.loktionov@intel.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 kohei.enju@gmail.com, kohei@enjuk.jp, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, takkozu@amazon.com
Date: Thu, 22 Jan 2026 07:49:16 +0000
Message-ID: <20260122074916.119851-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <IA3PR11MB898633484D0CB77105D1B9A1E597A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB898633484D0CB77105D1B9A1E597A@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=YfFJ1yYZBltGbYzcJ2fakwNTo9XP10WDXsi1mmhmUGI=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1769068157; v=1;
 b=B9b09JukH2mSlRO6cJXSTzMCI1uk1eOuCgBwR72oaLu1k+Hijsgk/Wx5xCDKKhHK
 w35mDCJa57RqYgEpbep1p4jcQ19hSV6QtfZlT9ABmgysapBgt5LJUc5aUilY4gfo
 lTPVnqH76QScExojR4RZsPgaq68Ugxa9A2o2hn4fimEzpvvFO3XQYBGNUOw7wrdk
 5aKClQ+muU+VZp6dF0KTMLJ5oa2d5uDzCBVXWl120QwUoGvnRv65Xkxp32JZGaeV
 hJy+fDd0vXYJTvENUtINySqC44YO/VB2uU+mkccuSaW2bWF3PtM9nwEM6XP353fs
 c3Y0kOaOmKo2xfE1Wy8M2A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=B9b09Juk
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-next] igb: set skb hash type
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

On Thu, 22 Jan 2026 07:33:23 +0000, "Loktionov, Aleksandr" wrote:

> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Kohei Enju
> > Sent: Monday, January 19, 2026 6:58 PM
> > To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; kohei.enju@gmail.com; Takashi Kozu
> > <takkozu@amazon.com>; Kohei Enju <kohei@enjuk.jp>
> > Subject: [Intel-wired-lan] [PATCH v1 iwl-next] igb: set skb hash type
> > from RSS_TYPE
> >=20
> > igb always marks the RX hash as L3 regardless of RSS_TYPE in the
> > advanced descriptor, which may indicate L4 (TCP/UDP) hash. This can
> > trigger unnecessary SW hash recalculation and breaks toeplitz
> > selftests.
> >=20
> > Use RSS_TYPE from pkt_info to set the correct PKT_HASH_TYPE_*
> >=20
> > Tested by toeplitz.py with the igb RSS key get/set patches applied as
> > they are required for toeplitz.py (see Link below).
> >  # ethtool -N $DEV rx-flow-hash udp4 sdfn  # ethtool -N $DEV rx-flow-
> > hash udp6 sdfn  # python toeplitz.py | grep -E "^# Totals"
> >=20
> > Without patch:
> >  # Totals: pass:0 fail:12 xfail:0 xpass:0 skip:0 error:0
> >=20
> > With patch:
> >  # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
> >=20
> > Link: https://lore.kernel.org/intel-wired-lan/20260119084511.95287-5-
> > takkozu@amazon.com/
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> > If a Fixes tag is needed, it would be Fixes: 42bdf083fe70 ("net: igb
> > calls skb_set_hash").
> >=20
> > I'm not sure this qualifies as a fix, since the RX hash marking has
> > been wrong for a long time without reported issues. So I'm leaning
> > toward omitting Fixes.
> > ---
> >  drivers/net/ethernet/intel/igb/e1000_82575.h | 21
> > ++++++++++++++++++++
> >  drivers/net/ethernet/intel/igb/igb_main.c    | 18 +++++++++++++----
> >  2 files changed, 35 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h
> > b/drivers/net/ethernet/intel/igb/e1000_82575.h
> > index 63ec253ac788..a855bc10f5d4 100644
> > --- a/drivers/net/ethernet/intel/igb/e1000_82575.h
> > +++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
> > @@ -87,6 +87,27 @@ union e1000_adv_rx_desc {
> >  	} wb;  /* writeback */
> >  };
> >=20
> > +#define E1000_RSS_TYPE_NO_HASH		 0
> > +#define E1000_RSS_TYPE_HASH_TCP_IPV4	 1
> > +#define E1000_RSS_TYPE_HASH_IPV4	 2
> > +#define E1000_RSS_TYPE_HASH_TCP_IPV6	 3
> > +#define E1000_RSS_TYPE_HASH_IPV6_EX	 4
> > +#define E1000_RSS_TYPE_HASH_IPV6	 5
> > +#define E1000_RSS_TYPE_HASH_TCP_IPV6_EX	 6
> > +#define E1000_RSS_TYPE_HASH_UDP_IPV4	 7
> > +#define E1000_RSS_TYPE_HASH_UDP_IPV6	 8
> > +#define E1000_RSS_TYPE_HASH_UDP_IPV6_EX	 9
> > +
> > +#define E1000_RSS_TYPE_MASK		GENMASK(3, 0) /* 4-bits (3:0)
> > =3D mask 0x0F */
> 80columns violation, it's not critical, but I'd suggest just remove redunda=
> nt comment
> Otherwise, it smells like AI generated...
> #define E1000_RSS_TYPE_MASK		GENMASK(3, 0)

Ugh, somehow I missed the warning in checkpatch.pl. Thank you for
poiting out. TBH I copied that line from igc/igc.h with the comment, but
the comment is not necessary :)

I'll fix it in v2.

> 
> Everything else looks fine.
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
