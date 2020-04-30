From: Dan Williams <dwilliams@nextdroid.com>
Date: Thu, 30 Apr 2020 15:22:02 -0400
Subject: [Intel-wired-lan] Does the 'igb` kernel module support setting
 2-Tuple filters (aka `--config-ntuple`) on a i210 NIC?
Message-ID: <CAGrNP8nfqAZnEoOBsrxrsvszw7T5pdKHG4mt6fVcKB6iigV_BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Does the 'igb` kernel module support setting "2-Tuple filters" (aka
`--config-ntuple`, aka RFS) on a I-210IC NIC?
- Is this the appropriate mailing list?
- If not, which module *should* we be using instead?
- If so, how do we enable it in the 'igb' driver?


*.1. Context: *
Hey, all, we're running into a very perplexing configuration issue, while
trying to tune our 'igb' driver, and the documentation out there is
sparse.  All the examples we've found come up dry.  (either by throwing
errors with our setup, or emitting nothing but opaque error messages:
"Operation not supported"  "invalid argument")   Hopefully, someone on the
list can point us in the right direction.

We have a computer logging a high rate of ethernet packets ( 25k
packets/sec ~70 Mb/sec);   But we're having trouble convincing the hardware
to receive all of these packets, at a sustained rate -- specifically we're
dropping packets while processing through the kernel layers.    We're
currently attempting to optimize the network stack,  but we're having
trouble setting the driver parameters... which is what this message is all
about.

*.2. Platform Summary:*
Hardware:
Advantech 3500
<https://www.advantech.com/products/1-2jkd2d/ark-3500/mod_adb8f9a9-4b1b-4cf5-84ba-9e135c099c43>
CPU ($ lscpu):
Architecture:         x86_64
CPU family:          6
Model:                  58
Model name:        Intel(R) Core(TM) i7-3610QE CPU @ 2.30GHz
NIC ($ lspci -vs 02:00.0)
02:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
Connection (rev 03)
Flags: bus master, fast devsel, latency 0, IRQ 18
OS ($ lsb_release -a)
Ubuntu 16.04.6 LTS
Kernel (`uname -r`):
4.15.0-88-lowlatency
Kernel Module ($ modinfo igb)
filename:
/lib/modules/4.15.0-88-lowlatency/kernel/drivers/net/ethernet/intel/igb/igb.ko
version:        5.4.0-k
license:        GPL
Ethtool Version ($ ethtool --version)
ethtool version 4.5

*.3. What have we tried so far:*
.3.a.  The NIC supports what we want to do:
The data sheet,
<https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=2ahUKEwj_nona25DpAhWPoHIEHfvYBWcQFjAAegQIARAB&url=https%3A%2F%2Fwww.intel.com%2Fcontent%2Fwww%2Fus%2Fen%2Fembedded%2Fproducts%2Fnetworking%2Fi210-ethernet-controller-datasheet.html&usg=AOvVaw1N7hqg0JJAaqXsomLAUhfB>
in section 7.1.2.4 "2-Tuple Filters", says:

> The 2-tuple filters are configured via the TTQF (See Section 8.11.3), IMIR
> (See Section 8.11.1) and
> IMIR_EXT (See Section 8.11.2) registers as follows (per filter):
>

Am I correct in assuming these are the mechanisms the 'igb' driver is
interfacing with?

.3.b.   What is the flow table currenttly?

> # ethtool --show-rxfh enp2s0
> RX flow hash indirection table for enp2s0 with 4 RX ring(s):
>     0:      0     0     0     0     0     0     0     0
>     8:      0     0     0     0     0     0     0     0
>    16:      0     0     0     0     0     0     0     0
>    24:      0     0     0     0     0     0     0     0
>    32:      0     0     0     0     0     0     0     0
>    40:      0     0     1     1     1     1     1     1
>    48:      1     1     1     1     1     1     1     1
>    56:      1     1     1     1     1     1     1     1
>    64:      1     1     1     1     1     1     1     1
>    72:      1     1     1     1     1     1     1     1
>    80:      1     1     1     1     1     2     2     2
>    88:      2     2     2     2     2     2     2     2
>    96:      2     2     2     2     2     2     2     2
>   104:      2     2     2     2     2     2     2     2
>   112:      2     2     2     2     2     2     2     2
>   120:      2     2     2     2     2     2     2     2
> RSS hash key:
> Operation not supported
>

"Operation not supported" -- does this mean the NIC has RSS routing
hard-coded? And we cannot change the hash-function?
Or is RSS just hard-coded?


.3.c. Current "Hash flow" settings:

> # ethtool -n  enp2s0 rx-flow-hash udp4
> UDP over IPV4 flows use these fields for computing Hash flow key:
> IP SA
> IP DA
> L4 bytes 0 & 1 [TCP/UDP src port]
> L4 bytes 2 & 3 [TCP/UDP dst port]
>


> # sudo ethtool -n enp2s0
> 4 RX rings available
> Total 0 rules
>


.3.d.  Enable ntuple features:

> # ethtool --show-features enp2s0 | grep ntuple
> ntuple-filters: on
>

.3.e. Add ntuple rule: Commands Tried:

> # ethtool -U enp2s0 flow-type udp4 src-ip 192.168.3.43 dst-ip 0.0.0.0
> src-port 555 dst-port 2368 action -1
> rmgr: Cannot insert RX class rule: Invalid argument
> # ethtool -U enp2s0 flow-type udp4 src-ip 192.168.3.43 action 1
> rmgr: Cannot insert RX class rule: Invalid argument
>
# ethtool -U enp2s0 flow-type ip4 src-ip 192.168.3.43 action 1
> rmgr: Cannot insert RX class rule: Invalid argument
> # ethtool -U enp2s0 flow-type ip4 src-ip 192.168.3.43 action 1 loc 4
> rmgr: Cannot insert RX class rule: Invalid argument
>

.3.f. More Interface info:

> # ethtool -i enp2s0
> driver: igb
> version: 5.4.0-k
> firmware-version: 3.16, 0x800004ad
> expansion-rom-version:
> bus-info: 0000:02:00.0
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: yes
>

# ethtool -t enp2s0
> The test result is PASS
> The test extra info:
> Register test  (offline) 0
> Eeprom test    (offline) 0
> Interrupt test (offline) 0
> Loopback test  (offline) 0
> Link test   (on/offline) 0
>






Daniel Williams  |  Software Engineer
dwilliams at nextdroid.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200430/d221c541/attachment.html>
