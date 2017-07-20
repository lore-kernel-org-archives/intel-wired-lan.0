From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Date: Thu, 20 Jul 2017 10:00:27 -0400
Subject: [Intel-wired-lan] commit 16ecba59 breaks 82574L under heavy
	load.
In-Reply-To: <20170720000747.4jiadqubv7hg5esz@f1.synalogic.ca>
References: <20170718142109.GO18556@csclub.uwaterloo.ca>
 <20170718231435.64us7vu67wtp6pwe@f1.synalogic.ca>
 <20170719141953.GQ18556@csclub.uwaterloo.ca>
 <20170720000747.4jiadqubv7hg5esz@f1.synalogic.ca>
Message-ID: <20170720140027.GR18556@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jul 19, 2017 at 05:07:47PM -0700, Benjamin Poirier wrote:
> Are you sure about this? In my testing, while triggering the overrun
> with the msleep, I read ICR when entering e1000_msix_other() and RXO is
> consistently set.

I had thousands of calls to e1000_msix_other where the only bit set
was OTHER.

I don't know if the cause is overruns, it just seems plausible.

> I'm working on a patch that uses that fact to handle the situation and
> limit the interrupt.

Excellent.

Running in MSI mode rather than MSI-X seems to not have the problem of
unexpected interrupts, but has other issues (such as loosing the IRQ
affinity setting if you do ifconfig down;ifconfig up on the interface,
which does not happen in MSI-X's case.)  That's rather annoying as you
can't set the affinity before bringing up the interface which is rather
undesirable.

-- 
Len Sorensen
