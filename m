From: Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu>
Date: Fri, 12 Jun 2015 17:34:25 -0400
Subject: [Intel-wired-lan] next-20150610 - repeated hangs at
	e1000e_phc_gettime+0x2e/0x60
In-Reply-To: <Your message of "Thu, 11 Jun 2015 22:57:48 -0400."
 <21937.1434077868@turing-police.cc.vt.edu>>
References: <21937.1434077868@turing-police.cc.vt.edu>
Message-ID: <30284.1434144865@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 11 Jun 2015 22:57:48 -0400, Valdis Kletnieks said:

> 0) next-20150603 works, so the problem landed in linux-next in the last week.
>
> 1) All 3 times happened while I was at home, using wireless, so
> the interface didn't have link and was ifconfig'ed down.

All 3 crashes happened at almost exactly 4 hours of uptime, but here
in my office I'm now at 6 hours on the same kernel while running with
the interface plugging in and doing traffic.

I have a fighting chance of mostly finishing a bisect over the weekend,
I'll let you know where that leads.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 848 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150612/d140802b/attachment-0001.asc>
