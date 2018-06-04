From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 3 Jun 2018 19:32:19 -0700
Subject: [Intel-wired-lan] (bisected) ixgbe tx hang since 4.16-rc1
In-Reply-To: <778ed85f-2ccb-2179-cbd2-c354be47c2ad@tomt.net>
References: <24be0439-1b01-f577-1bab-eb166c8864ab@tomt.net>
 <f175e7ca-79fe-c6c2-98bc-8ced5ae88cc7@oracle.com>
 <778ed85f-2ccb-2179-cbd2-c354be47c2ad@tomt.net>
Message-ID: <CAKgT0UfcaS4JwXnkWU+XhMaU2nk8HCdS-tr2j8v2SAV6=sO50w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Jun 3, 2018 at 5:35 PM, Andre Tomt <andre@tomt.net> wrote:
> On 04. juni 2018 02:15, Shannon Nelson wrote:
>>
>> On 6/3/2018 12:55 AM, Andre Tomt wrote:
>>>
>>> Hello
>>>
>>> Since kernel 4.16-rc1 and including linus mainline git tree as of earlier
>>> today this Atom Denverton system with a X553 embedded network controllers
>>> has been unable to send packets until I kick the interface with a ethtool -r
>>> or leave it alone until it trips the TX Unit Hang watchdog.
>>
>>
>> Hi Andre,
>>
>> Thanks for your bug report and the bisection.  I'm not aware of any
>> differences in the x553 from the rest of the x5xx family, and I don't have
>> access to one, so I can't do any testing of my own.
>>
>> I can imagine how removing the call to ixgbe_ipsec_stop_engine() might
>> help, but since the driver is still advertising support for the IPsec
>> offload, I'm afraid there would still be other problems popping up if
>> someone tried to use the offload.  If this particular device, or family of
>> devices, is problematic, it might be better to simply filter them out at the
>> top of ixgbe_init_ipsec_offload() like we do for the 82598.
>
>
> Indeed, this was only a minimal semi-revert to verify the bisection result.
>
>> In order to help our friends at Intel do some further investigation, would
>> you please include the output from "lspci -s <pci-bdf> -nv" so we can know
>> for sure which device this is?
>
>
> Here it is, for one of the pci devices (they are all identical)
> root at ubuntu1804:~# lspci -s 05:00.0 -nv
> 05:00.0 0200: 8086:15e4 (rev 11)
>         Subsystem: 8086:0000
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Memory at 7b7f800000 (64-bit, prefetchable) [size=2M]
>         Memory at 7b7fa04000 (64-bit, prefetchable) [size=16K]
>         Expansion ROM at df680000 [disabled] [size=512K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>         Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
>         Capabilities: [a0] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Device Serial Number 00-00-c9-ff-ff-00-00-00
>         Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
>         Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
>         Capabilities: [1b0] Access Control Services
>         Kernel driver in use: ixgbe
>         Kernel modules: ixgbe
>
>
>> Jeff, can you get someone in your test group to take look at this?  It
>> would be good to know if IPsec offload on the embedded devices are going to
>> cause us problems.
>
>
>> Thanks,
>> sln

Did we ever try testing this on any parts that had the security
offloads disabled? The 82599, x540, and x550 have the option to
disable the security via a pin on the board as per section 4.6.12 of
their data sheets. In the case of 82599 I guess it was one of the
software defined pins, and then for x540 and x550 it became an
explicit pin. I'm wondering if what we are seeing is a part that has
security offload explicitly disabled and us messing with the registers
is somehow confusing it since we are attempting to update fields that
should be locked out.

Another possibility is that the link tweaking in ixgbe_ipsec_stop_data
is causing some sort of issue since the part in use here is a 1G part
if I understand the part number correctly. One thing we may want to
look at doing is just test and bail if the tx_rdy and rx_rdy bits are
already set before we check the link state. Really the code should
also probably be checking to see if we are even tweaking the security
mode before going through all this. Maybe a check to see if SECTX_DIS
is already set before we try to change things. That would help to take
care of the case I called out above where SECTX_DIS and TX_DIS can be
read-only on a system with these registers fused off.

Really I am not sure how safe that code is since enabling/disabling
loopback. Usually link changes like that are followed by a reset to
flush out the link setup. Doing this early in the setup after a reset
may be problematic at best and should be avoided if at all possible.
We might want to take a look at moving the ixgbe_init_ipsec_offload
call up from where it is currently to somewhere just after the
init_swfw_sync call but before the call to reset_hw. That may give us
enough leeway that we don't have to worry about the link issues since
from the sound of things all it takes is one reset and this issue goes
away anyway.

- Alex
