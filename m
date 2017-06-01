From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Thu, 1 Jun 2017 19:18:05 +0000
Subject: [Intel-wired-lan] [i40e] regression on TCP stream and TCP
 maerts, kernel-4.12.0-0.rc2
In-Reply-To: <1496312080.3758.7.camel@redhat.com>
References: <655ed9ab-853e-7497-9ea3-cc8d13f56043@redhat.com>
 <CAKgT0UcdJQWqr_zxxi36a6_3iMwBNow-YS723i7t6xsKvAqvCA@mail.gmail.com>
 <CAKgT0Ufb41o=WM=3DM9cwvrw9N5AFn-uL0p1gQB-m+D3BX3DKA@mail.gmail.com>
 <1496238507.22688.4.camel@redhat.com>
 <CAKgT0Ucg9wHrKDBjQXKH6gziuinwcK9MO-jRC=0q60Lm-8vFqA@mail.gmail.com>
 <1496312080.3758.7.camel@redhat.com>
Message-ID: <1496344683.27073.306.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2017-06-01 at 12:14 +0200, Adrian Tomasov wrote:
> On Wed, 2017-05-31 at 14:42 -0700, Alexander Duyck wrote:
> > 
> > On Wed, May 31, 2017 at 6:48 AM, Adrian Tomasov <atomasov@redhat.com>
> > wrote:
> > > 
> > > 
> > > On Tue, 2017-05-30 at 18:27 -0700, Alexander Duyck wrote:
> > > > 
> > > > 
> > > > On Tue, May 30, 2017 at 8:41 AM, Alexander Duyck
> > > > <alexander.duyck@gmail.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On Tue, May 30, 2017 at 6:43 AM, Adam Okuliar <aokuliar@redhat.
> > > > > com>
> > > > > wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > we found regression on intel card(XL710) with i40e driver.
> > > > > > Regression is
> > > > > > about ~45%
> > > > > > on TCP_STREAM and TCP_MAERTS test for IPv4 and IPv6.
> > > > > > Regression
> > > > > > was first
> > > > > > visible in kernel-4.12.0-0.rc1.
> > > > > > 
> > > > > > More details about results you can see in uploaded images in
> > > > > > bugzilla. [0]
> > > > > > 
> > > > > > 
> > > > > > [0] https://bugzilla.kernel.org/show_bug.cgi?id=195923
> > > > > > 
> > > > > > 
> > > > > > Best regards, / S pozdravom,
> > > > > > 
> > > > > > Adri?n Toma?ov
> > > > > > Kernel Performance QE
> > > > > > atomasov at redhat.com
> > > > > 
> > > > > I have added the i40e driver maintainer and the intel-wired-lan
> > > > > mailing list so that we can make are developers aware of the
> > > > > issue.
> > > > > 
> > > > > Thanks.
> > > > > 
> > > > > - Alex
> > > > 
> > > > Adam,
> > > > 
> > > > We are having some issues trying to reproduce what you reported.
> > > > 
> > > > Can you provide some additional data. Specifically we would be
> > > > looking
> > > > for an "ethtool -i", and an "ethtool -S" for the port before and
> > > > after
> > > > the test. If you can attach it to the bugzilla that would be
> > > > appreciated.
> > > > 
> > > > Thanks.
> > > > 
> > > > - Alex
> > > 
> > > Hello Alex,
> > > 
> > > requested files are updated in bugzilla.
> > > 
> > > If you have any questions about testing feel free to ask.
> > > 
> > > 
> > > Best regards,
> > > 
> > > Adrian
> > 
> > So looking at the data I wonder if we don't have an MTU mismatch in
> > the network config. I notice the "after" has rx_length_errors being
> > reported. Recent changes made it so that i40e doesn't support jumbo
> > frames by default, whereas before we could. You might want to check
> > for that as that could cause the kind of performance issues you are
> > seeing.
> > 
> > - Alex
> 
> There isn't MTU mismatch. Traffic path is : server -> switch ->
> server.?
> 
> 
> Output from switch:
> 
>     > show interfaces et-0/0/18????
>     Physical interface: et-0/0/18, Enabled, Physical link is Up
>     ? Interface index: 644, SNMP ifIndex: 538
>     ? Link-level type: Ethernet, MTU: 1514, Speed: 40Gbps, BPDU Error:
>     None, MAC-REWRITE Error: None, Loopback: Disabled, Source filtering:
>     Disabled, Flow control: Disabled, Media type: Fiber
>     ? Device flags???: Present Running
>     ? Interface flags: SNMP-Traps Internal: 0x4000
>     ? Link flags?????: None
>     ? CoS queues?????: 12 supported, 12 maximum usable queues
>     ? Current address: d4:04:ff:90:5a:4b, Hardware address:
>     d4:04:ff:90:5a:4b
>     ? Last flapped???: 2017-06-01 10:09:32 CEST (01:21:29 ago)
>     ? Input rate?????: 432 bps (0 pps)
>     ? Output rate????: 8336 bps (11 pps)
>     ? Active alarms??: None
>     ? Active defects : None
>     ? Interface transmit statistics: Disabled
> 
>     ? Logical interface et-0/0/18.0 (Index 552) (SNMP ifIndex 539)
>     ????Flags: SNMP-Traps 0x24024000 Encapsulation: Ethernet-Bridge
>     ????Input packets : 464041
>     ????Output packets: 209210
>     ????Protocol eth-switch, MTU: 1514
>     ??????Flags: Is-Primary, Trunk-Mode
> 
> 
> MTU is same for all et-0/0/x interfaces.?
> 
> - Adrian

One thing you might try try doing is toggling the legacy-rx flag using
the "ethtool --show-priv-flags/--set-priv-flags" command to see if that
has any impact. That will help to rule things out as the most
significant change I can think of is the recent update of the Rx path
to support XDP.

Also one other thing you might try would be to use a fixed interrupt
moderation rate by locking things down using "ethtool -C" to disable
adaptive interrupt moderation and lock the Rx usecs and Tx usecs at
some predefined values. I seem to recall there have been some interrupt
moderation changes made recently that might be impacting the
performance.

Beyond that is there any chance you would be able to bisect the issue?
Unfortunately we haven't be able to reproduce it internally so anything
that would help us to narrow down the problem would be useful.

Thanks.

- Alex
