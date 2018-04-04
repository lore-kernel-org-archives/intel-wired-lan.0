From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 4 Apr 2018 10:02:32 -0700
Subject: [Intel-wired-lan] [iwl next-queue PATCH 03/10] macvlan: Use
 software path for offloaded local, broadcast, and multicast traffic
In-Reply-To: <a99a73c2-1216-30ba-9d86-9bb4626a8a81@oracle.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
 <20180403211609.7880.1015.stgit@ahduyck-green-test.jf.intel.com>
 <a99a73c2-1216-30ba-9d86-9bb4626a8a81@oracle.com>
Message-ID: <CAKgT0Ufs5x9s5tii+HvcsyLXOvm6qX1wGgUPOKmZJ5S9K3E5TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Apr 4, 2018 at 9:53 AM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> On 4/3/2018 2:16 PM, Alexander Duyck wrote:
>>
>> This change makes it so that we use a software path for packets that are
>> going to be locally switched between two macvlan interfaces on the same
>> device. In addition we resort to software replication of broadcast and
>> multicast packets instead of offloading that to hardware.
>>
>> The general idea is that using the device for east/west traffic local to
>> the system is extremely inefficient. We can only support up to whatever
>> the
>> PCIe limit is for any given device so this caps us at somewhere around 20G
>> for devices supported by ixgbe. This is compounded even further when you
>> take broadcast and multicast into account as a single 10G port can come to
>> a crawl as a packet is replicated up to 60+ times in some cases. In order
>> to get away from that I am implementing changes so that we handle
>> broadcast/multicast replication and east/west local traffic all in
>> software.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> ---
>
>
> [...]
>
>>   @@ -4225,6 +4226,13 @@ static void ixgbe_configure_virtualization(struct
>> ixgbe_adapter *adapter)
>>         vmdctl |= IXGBE_VT_CTL_REPLEN;
>>         IXGBE_WRITE_REG(hw, IXGBE_VT_CTL, vmdctl);
>>   +     /* accept untagged packets until a vlan tag is
>> +        * specifically set for the VMDQ queue/pool
>> +        */
>> +       vmolr = IXGBE_VMOLR_AUPE;
>> +       while (pool--)
>> +               IXGBE_WRITE_REG(hw, IXGBE_VMOLR(VMDQ_P(pool)), vmolr);
>> +
>
>
> It took me a bit to figure out what untagged packets have to do with macvlan
> config.  You might add to the comment that "no multicast or broadcast is
> configured for these queues".

Yeah. I can probably address that in the next round of patches.
Specifically here all we are accepting are untagged unicast packets.
We cannot perform the offload through a VLAN since it would require
passing the VLAN along with the L2 MAC address. It is something I plan
to address in the near future so that macvlan interfaces stacked on
top of a VLAN can still be offloaded.

> The driver part of this might be separated into a follow-on patch to make it
> clearer that this is done as a consequence of the macvlan.c changes.  Or
> just roll them into your 4/10 patch.
>
> sln

Actually part of the reason for keeping this all as one thing is
because if I split the macvlan bits from the driver bits then things
are broken until both patches are applied.

I had actually split patch 4/10 out from this patch since it is one of
the few things that could safely be pulled out in order to try and
reduce the overhead for this patch.
