From: Jochen Henneberg <jh@henneberg-systemdesign.com>
Date: Fri, 14 Oct 2016 13:24:33 +0200
Subject: [Intel-wired-lan] Bug with 'igb: Remove GS40G specific
 defines/functions'
In-Reply-To: <1749CC13-EEFE-4EEB-B74E-40B563D7230C@vectranetworks.com>
References: <77C85CBC-39FD-40B4-9456-56A3FEE3544A@vectranetworks.com>
 <1570773976.567827.1476303559656.JavaMail.zimbra@xes-inc.com>
 <20F028E5-EC20-4F65-8889-3F254196ABF8@vectranetworks.com>
 <133564642.602581.1476305193640.JavaMail.zimbra@xes-inc.com>
 <F267652D-6FE2-4808-BFE7-013510C5A733@vectranetworks.com>
 <1476349095.18484.15.camel@maxwell>
 <1749CC13-EEFE-4EEB-B74E-40B563D7230C@vectranetworks.com>
Message-ID: <1476444273.23813.23.camel@maxwell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Do, 2016-10-13 at 13:56 +0000, Chris Arges wrote:
> Jochen,
> 
> Thanks for this update. I tested this patch and it fixes my issue!
> If there are no other ill effects from this patch perhaps it would be
> a good
> candidate for mainline and stable.

The patch is hacky, it does neither use the phy-ops.write_reg() nor does
it check for the correct chip before it applies the write.
I will try to prepare a clean fix and send a patch.

Regards
-Jochen

> 
> --chris

-- 
Henneberg - Systemdesign
Jochen Henneberg
Loehnfeld 26
21423 Winsen (Luhe)
--
Fon: +49 4174 668 773
Mobile: +49 172 160 14 69
Fax: +49 321 210 761 64
www: www.henneberg-systemdesign.com



