From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 22 Mar 2021 08:47:54 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20201110180719.GA1559650@localhost>
References: <20201110061019.519589-1-vinicius.gomes@intel.com>
 <20201110061019.519589-4-vinicius.gomes@intel.com>
 <20201110180719.GA1559650@localhost>
Message-ID: <875z1jkx5h.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Miroslav Lichvar <mlichvar@redhat.com> writes:

> On Mon, Nov 09, 2020 at 10:10:19PM -0800, Vinicius Costa Gomes wrote:
>> i225 has support for PCIe PTM, which allows us to implement support
>> for the PTP_SYS_OFFSET_PRECISE ioctl(), implemented in the driver via
>> the getcrosststamp() function.
>
> Would it be possible to provide the PTM measurements with the
> PTP_SYS_OFFSET_EXTENDED ioctl instead of PTP_SYS_OFFSET_PRECISE?

Sorry for the long delay.

About PTP_SYS_OFFSET_EXTENDED, I did play with it a bit, but I didn't
like it too much: because I don't have access to all the timestamps from
the same "cycle", I ended up having to run two cycles to retrieve all
the information.

So, the new version will expose the timestamps via
PTP_SYS_OFFSET_PRECISE, later we can think of PTP_SYS_OFFSET_EXTENDED.

>
> As I understand it, PTM is not cross timestamping. It's basically
> NTP over PCIe, which provides four timestamps with each "dialog". From
> the other constants added to the header file it looks like they could
> all be obtained and then they could be converted to the triplets
> returned by the EXTENDED ioctl.
>
> The main advantage would be that it would provide applications with
> the round trip time, which is important to estimate the maximum error
> in the measurement. As your example phc2sys output shows, with the
> PRECISE ioctl the delay is 0, which is misleading here.
>
> I suspect the estimate would be valid only when the NIC is connected
> directly to the PTM root (PCI root complex). Is it possible to get the
> timestamps or delay from PTM-capable switches on the path between CPU
> and NIC? Also, how frequent can be the PTM dialogs? Could they be
> performed synchronously in the ioctl?
>
> -- 
> Miroslav Lichvar
>


Cheers,
-- 
Vinicius
