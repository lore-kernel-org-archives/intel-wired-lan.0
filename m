From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Mon, 16 May 2016 18:23:49 +0000
Subject: [Intel-wired-lan] Panic on next-queue i40e when rebooting
In-Reply-To: <CAKgT0UdGQJEs+pGKEeq0bGP81jZxKABwSkpv0M=CemzQDOdhfg@mail.gmail.com>
References: <CAKgT0UdGQJEs+pGKEeq0bGP81jZxKABwSkpv0M=CemzQDOdhfg@mail.gmail.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B626501D9877@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, May 16, 2016 11:07 AM
> To: e1000-devel at lists.sourceforge.net; intel-wired-lan <intel-wired-
> lan at lists.osuosl.org>
> Subject: [Intel-wired-lan] Panic on next-queue i40e when rebooting
> 
> I'm seeing the trace below every time I reboot after having run a
> performance test of some sort between the PF and VFs.  I didn't see it
> for a brief period, but it came back.
> 
> I'm suspecting the issue is pseudo-intermittent but now i am seeing it
> more often then not.  This was captured on the latest next-queue pull
> as of this morning.
> 
> Note I have a serial console running to this system and that is the
> only way I am able to see it.  If I use a screen the message is wiped
> before it can be seen due to the reboot.
> 
Thanks Alex, we're looking at it.

Carolyn
