From: Dan Williams <dwilliams@nextdroid.com>
Date: Mon, 4 May 2020 09:58:31 -0400
Subject: [Intel-wired-lan] Does the 'igb` kernel module support setting
 2-Tuple filters (aka `--config-ntuple`) on a i210 NIC?
In-Reply-To: <87zhaswn5t.fsf@intel.com>
References: <CAGrNP8nfqAZnEoOBsrxrsvszw7T5pdKHG4mt6fVcKB6iigV_BA@mail.gmail.com>
 <87zhaswn5t.fsf@intel.com>
Message-ID: <CAGrNP8=qr3_ZPL7c4oWz0L6hzLSSHjh3iWa52VsUTmJjfUqxdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>
> > We have a computer logging a high rate of ethernet packets ( 25k
>> > packets/sec ~70 Mb/sec);   But we're having trouble convincing the
>> hardware
>> > to receive all of these packets, at a sustained rate -- specifically
>> we're
>> > dropping packets while processing through the kernel layers.    We're
>> > currently attempting to optimize the network stack,  but we're having
>> > trouble setting the driver parameters... which is what this message is
>> all
>> > about.
>>
>
> That's weird. That packet rate is not *that* high, the Linux kernel
> should be able to handle that fine.


> Can you give more details of the workload you are running?
>

Okay, in more detail: we have two groups of incoming streams:  (for the
minimum setup to cause a problem)
- 4x Camera Streams  each transmits a 3.2mb image every .1 s, split into
jumbo frames (mtu is set to the full 9000)
- Constant stream of data from a Lidar at 18k packets / sec.  Each packet
is 1206 bytes long.
- Both streams continue steady-state, indefinitely (we have verified
behavior out to 4 hours so far)

We receive all of these over ethernet, and routed to a single network port
on a single NIC.   The driver is the 'igb' kernel module, as supplied from
ubuntu.
The OS is Ubuntu 16.04 LTS with a 4.15.0-88-lowlatency kernel.

----
Biggest Problem:

Over time decay of packet processing.

We've been working on this for a couple of weeks; when the processes start
we're logging the full data rate (~24kpps) but over time, something slows
down, and our logging rate shrinks.
(on the order of 20 packets / second / minute, consistently falling over
hours. ... after the first hour, we've lost 500 pps, after the second hour,
1kpps... etc.)

Our user-land process simply isn't seeing the full count of packets -- we
have debug code that reads it from the OS, and then immediately drops the
buffer on the floor.  Generally, we see drops in netstat, but not in the
driver. (i.e. from `ethtool -S | grep rx_*`)
So, our tentative guess is that we want to tune some parameters, somewhere
in the kernel or network driver to help out the kernel.    Ideas welcome,
of course :)

( We are *also* dropping from the ring buffer, when both the lidar stream
and a camera stream are assigned to the same queue, but that looks like a
releated but separate issue)

Things we've tried / checked:
- irq alignment -- they're already reasonable set
- cpu assignment (via `taskset`)
- change processor task scheduling / priority (no effect)

Ideas:
- what is the default hash algorithm?  if we can't change it, maybe we can
work around it?
- is there any other way to set the queue settings on this network card?
Debug tool?  Rebuilding the kernel module with custom settings?
- Our hardware also has an 82579 NIC as well -- would you guys recommend we
use that NIC, instead?
- Do other network cards / chipsets have better support under linux?
Particularly when tuning input queues?


Daniel Williams  |  Software Engineer
dwilliams at nextdroid.com



On Thu, Apr 30, 2020 at 7:48 PM Vinicius Costa Gomes <
vinicius.gomes@intel.com> wrote:

> Dan Williams <dwilliams@nextdroid.com> writes:
>
> > Does the 'igb` kernel module support setting "2-Tuple filters" (aka
> > `--config-ntuple`, aka RFS) on a I-210IC NIC?
> > - Is this the appropriate mailing list?
> > - If not, which module *should* we be using instead?
> > - If so, how do we enable it in the 'igb' driver?
> >
> >
> > *.1. Context: *
> > Hey, all, we're running into a very perplexing configuration issue, while
> > trying to tune our 'igb' driver, and the documentation out there is
> > sparse.  All the examples we've found come up dry.  (either by throwing
> > errors with our setup, or emitting nothing but opaque error messages:
> > "Operation not supported"  "invalid argument")   Hopefully, someone on
> the
> > list can point us in the right direction.
> >
> > We have a computer logging a high rate of ethernet packets ( 25k
> > packets/sec ~70 Mb/sec);   But we're having trouble convincing the
> hardware
> > to receive all of these packets, at a sustained rate -- specifically
> we're
> > dropping packets while processing through the kernel layers.    We're
> > currently attempting to optimize the network stack,  but we're having
> > trouble setting the driver parameters... which is what this message is
> all
> > about.
>
> That's weird. That packet rate is not *that* high, the Linux kernel
> should be able to handle that fine.
>
> Can you give more details of the workload you are running?
>
> >
> > *.2. Platform Summary:*
> > Hardware:
> > Advantech 3500
> > <
> https://www.advantech.com/products/1-2jkd2d/ark-3500/mod_adb8f9a9-4b1b-4cf5-84ba-9e135c099c43
> >
> > CPU ($ lscpu):
> > Architecture:         x86_64
> > CPU family:          6
> > Model:                  58
> > Model name:        Intel(R) Core(TM) i7-3610QE CPU @ 2.30GHz
> > NIC ($ lspci -vs 02:00.0)
> > 02:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
> > Connection (rev 03)
> > Flags: bus master, fast devsel, latency 0, IRQ 18
> > OS ($ lsb_release -a)
> > Ubuntu 16.04.6 LTS
> > Kernel (`uname -r`):
> > 4.15.0-88-lowlatency
> > Kernel Module ($ modinfo igb)
> > filename:
> >
> /lib/modules/4.15.0-88-lowlatency/kernel/drivers/net/ethernet/intel/igb/igb.ko
> > version:        5.4.0-k
> > license:        GPL
> > Ethtool Version ($ ethtool --version)
> > ethtool version 4.5
>
> There had been a lot of improvements in the network stack in the last 4
> years, trying with a recent kernel, if possible, would be useful to know
> if the issue you are seeing persists.
>
> >
> > *.3. What have we tried so far:*
> > .3.a.  The NIC supports what we want to do:
> > The data sheet,
> > <
> https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=2ahUKEwj_nona25DpAhWPoHIEHfvYBWcQFjAAegQIARAB&url=https%3A%2F%2Fwww.intel.com%2Fcontent%2Fwww%2Fus%2Fen%2Fembedded%2Fproducts%2Fnetworking%2Fi210-ethernet-controller-datasheet.html&usg=AOvVaw1N7hqg0JJAaqXsomLAUhfB
> >
> > in section 7.1.2.4 "2-Tuple Filters", says:
> >
> >> The 2-tuple filters are configured via the TTQF (See Section 8.11.3),
> IMIR
> >> (See Section 8.11.1) and
> >> IMIR_EXT (See Section 8.11.2) registers as follows (per filter):
> >>
>
> The problem is that the NIC supports the 2-tuple filters, but support
> for using them in Linux was never added.
>
> >
> > Am I correct in assuming these are the mechanisms the 'igb' driver is
> > interfacing with?
>
> You are right.
>
> >
> > .3.b.   What is the flow table currenttly?
> >
> >> # ethtool --show-rxfh enp2s0
> >> RX flow hash indirection table for enp2s0 with 4 RX ring(s):
> >>     0:      0     0     0     0     0     0     0     0
> >>     8:      0     0     0     0     0     0     0     0
> >>    16:      0     0     0     0     0     0     0     0
> >>    24:      0     0     0     0     0     0     0     0
> >>    32:      0     0     0     0     0     0     0     0
> >>    40:      0     0     1     1     1     1     1     1
> >>    48:      1     1     1     1     1     1     1     1
> >>    56:      1     1     1     1     1     1     1     1
> >>    64:      1     1     1     1     1     1     1     1
> >>    72:      1     1     1     1     1     1     1     1
> >>    80:      1     1     1     1     1     2     2     2
> >>    88:      2     2     2     2     2     2     2     2
> >>    96:      2     2     2     2     2     2     2     2
> >>   104:      2     2     2     2     2     2     2     2
> >>   112:      2     2     2     2     2     2     2     2
> >>   120:      2     2     2     2     2     2     2     2
> >> RSS hash key:
> >> Operation not supported
> >>
> >
> > "Operation not supported" -- does this mean the NIC has RSS routing
> > hard-coded? And we cannot change the hash-function?
> > Or is RSS just hard-coded?
>
> IIRC the function and hash key cannot be changed, the only thing that
> can be changed is the indirection table, i.e. assigning different
> "target" queues to different hash values.
>
> >
> >
> > .3.c. Current "Hash flow" settings:
> >
> >> # ethtool -n  enp2s0 rx-flow-hash udp4
> >> UDP over IPV4 flows use these fields for computing Hash flow key:
> >> IP SA
> >> IP DA
> >> L4 bytes 0 & 1 [TCP/UDP src port]
> >> L4 bytes 2 & 3 [TCP/UDP dst port]
> >>
> >
> >
> >> # sudo ethtool -n enp2s0
> >> 4 RX rings available
> >> Total 0 rules
> >>
> >
> >
> > .3.d.  Enable ntuple features:
> >
> >> # ethtool --show-features enp2s0 | grep ntuple
> >> ntuple-filters: on
> >>
> >
> > .3.e. Add ntuple rule: Commands Tried:
> >
> >> # ethtool -U enp2s0 flow-type udp4 src-ip 192.168.3.43 dst-ip 0.0.0.0
> >> src-port 555 dst-port 2368 action -1
> >> rmgr: Cannot insert RX class rule: Invalid argument
> >> # ethtool -U enp2s0 flow-type udp4 src-ip 192.168.3.43 action 1
> >> rmgr: Cannot insert RX class rule: Invalid argument
> >>
> > # ethtool -U enp2s0 flow-type ip4 src-ip 192.168.3.43 action 1
> >> rmgr: Cannot insert RX class rule: Invalid argument
> >> # ethtool -U enp2s0 flow-type ip4 src-ip 192.168.3.43 action 1 loc 4
> >> rmgr: Cannot insert RX class rule: Invalid argument
> >>
>
> Right now, only filters for ethernet addresses, ethtype, VLAN ID and PCP
> are implemented. I agree that returning -EINVAL is not helpful.
>
> >
> > .3.f. More Interface info:
> >
> >> # ethtool -i enp2s0
> >> driver: igb
> >> version: 5.4.0-k
> >> firmware-version: 3.16, 0x800004ad
> >> expansion-rom-version:
> >> bus-info: 0000:02:00.0
> >> supports-statistics: yes
> >> supports-test: yes
> >> supports-eeprom-access: yes
> >> supports-register-dump: yes
> >> supports-priv-flags: yes
> >>
> >
> > # ethtool -t enp2s0
> >> The test result is PASS
> >> The test extra info:
> >> Register test  (offline) 0
> >> Eeprom test    (offline) 0
> >> Interrupt test (offline) 0
> >> Loopback test  (offline) 0
> >> Link test   (on/offline) 0
> >>
> >
> >
> >
> >
> >
> >
> > Daniel Williams  |  Software Engineer
> > dwilliams at nextdroid.com
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>
> --
> Vinicius
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200504/d47ddb4a/attachment-0001.html>
