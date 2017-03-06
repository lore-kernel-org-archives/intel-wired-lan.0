From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Date: Mon, 06 Mar 2017 13:03:16 +0100
Subject: [Intel-wired-lan] 4.11-rc1 regression: e1000e "BUG at
	drivers/pci/msi.c" on unplugged suspend+resume
In-Reply-To: <87bmten48r.fsf@miraculix.mork.no> (=?utf-8?Q?=22Bj=C3=B8rn?=
 Mork"'s message of "Mon, 06 Mar 2017 10:28:36 +0100")
References: <87bmten48r.fsf@miraculix.mork.no>
Message-ID: <8760jmipdn.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bj?rn Mork <bjorn@mork.no> writes:

> This is new with v4.11-rc1, so I strongly suspect commit 7e54d9d063fa
> ("e1000e: driver trying to free already-free irq"), which looks more
> than suspicious in this context.  Haven't had time to test a revert
> yet.  Just wanted to give an advance warning in case this isn't known.

Now tested.  I can confirm that reverting commit 7e54d9d063fa ("e1000e:
driver trying to free already-free irq") fixes the issue.

Further testing also shows that "netif running" is irrelevant.  The BUG
happens consistently on revery system resume, regardless of the e1000e
link state.  Which sort of indicates that this change to the driver's
freeze callback wasn't tested with system suspend.  Which seems.... odd?

Well, whatever.  Please revert commit 7e54d9d063fa.



Bj?rn
