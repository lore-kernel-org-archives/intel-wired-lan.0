From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 07 Dec 2020 14:29:54 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 8/9] igc: Add support for
 exposing frame preemption stats registers
In-Reply-To: <20201205095948.5e0eba28@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <20201202045325.3254757-1-vinicius.gomes@intel.com>
 <20201202045325.3254757-9-vinicius.gomes@intel.com>
 <20201205095948.5e0eba28@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Message-ID: <87v9ddz1ul.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue,  1 Dec 2020 20:53:24 -0800 Vinicius Costa Gomes wrote:
>> Expose the Frame Preemption counters, so the number of
>> express/preemptible packets can be monitored by userspace.
>> 
>> These registers are cleared when read, so the value shown is the
>> number of events that happened since the last read.
>> 
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
> You mean expose in a register dump? That's not great user experience..

I can agree with that, even after some formatting on the ethtool side:

Preemption statistics:
    TX Preemption event counter: 14070
    Good TX Preemptable Packets: 201957
    Good TX Express Packets: 32031
    TX Preempted Packets: 13259
    RX Preemption event counter: 0
    Good RX Preemptable Packets: 0
    Good RX Preempted Packets: 0
    Preemption Exception Counter:
        OOO_SMDC 0
        OOO_FRAME 0
        OOO_FRAG 0
        MISS_FRAME_FRAG 0

It's less than ideal, but useful for development/debugging.

>
> Are there any stats that the standards mandate?

I just took abother look at the standard, mainly at the MIBs, there are
no statistics related to frame preemption that I could find, only
configuration stuff.

>
> It'd be great if we could come up with some common set and expose them
> via ethtool like the pause frame statistics.

Agreed, will drop this patch, until this common set is agreed upon.


Cheers,
-- 
Vinicius
