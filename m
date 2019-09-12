From: Jakub Jankowski <shasta@toxcorp.com>
Date: Thu, 12 Sep 2019 12:09:09 +0200
Subject: [Intel-wired-lan] [E1000-devel] i40e X722 RSS problem with
 NAT-Traversal IPsec packets
In-Reply-To: <20190610190141.77k6gbrefm2mr6lb@csclub.uwaterloo.ca>
Message-ID: <77e940d7-552b-7724-0971-828bdb28add7@toxcorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

[I'm replying to an old thread, hoping my email client won't screw up 
references too much - sorry in advance if it does]

 >On Mon, 10 Jun 2019, Lennart Sorensen wrote:
 >>On Fri, Jun 07, 2019 at 10:08:31PM +0000, Fujinaka, Todd wrote:
 >> Just a quick update with the response I got and I'll make sure this 
is in our internal bug database.
 >>
 >> Here's what I got back, and it looks like you guys have tried this 
already:
 >>
 >> Have they tried these steps to configure RSS:
[...]
 > With potentially 10000 ipsec connections, we don't even want to look at
 > creating manual flow entries.? There isn't enough room for that.? We just
 > wanted RSS to do its job the way it does on every other NIC in the past.
 > After years of using mostly intel NICs that just worked, this one has
 > been quite the surprise.
 >
[...]
 > Already tried with 4.19 kernel which is essentially identical to the
 > latest out of tree driver (I diffed them and found no functional
 > differences at all) and it didn't help.? Well it was essentially 
identical
 > to the latest out of tree a few weeks ago.? It seems there is now a
 > newer one with some changes although nothing in the list of changes
 > sound relevant.
 >
 > We do not want to use the out of tree driver and even trying it out is
 > a lot of work.? We used to use it in the past for some NIC types but
 > stopped due to the hassle of maintaining the integration.? If any 
problems
 > exist in the in kernel driver we will patch it, but so far that does not
 > appear to be the problem.? The tests we did so far indicate the firmware
 > isn't applying an RSS value to certain packet types.? Even mapping every
 > RSS value to queue 7 still saw these packets arrive on queue 0 which
 > should of course be impossible if the firmware was working. Now if
 > there is anything in the out of tree driver that you think can explain
 > this problem, I will look at it and consider trying it, but so far I
 > see nothing that makes that worth the effort.? It just doesn't look like
 > a driver problem.? If someone has access to a S2600WFT board (or some
 > other C612 based board) it should be simple enough to try replaying
 > the captured packet and see what RSS queue it hits (with ATR disabled
 > of course).

Was there any progress here?

As X722 is getting more and more ubiquitous, it's getting harder and 
harder to avoid it. Problems like this, SFP EEPROM readout I reported 
[1], or the recently announced NetCAT issue [2] (X722 seems to support 
iWARP/RDMA) make it really hard to recommend X722 for production use.

[1] 
https://www.mail-archive.com/e1000-devel at lists.sourceforge.net/msg12550.html
[2] https://www.vusec.net/projects/netcat/

Regards,
 ?Jakub.

