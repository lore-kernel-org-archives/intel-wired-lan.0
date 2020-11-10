From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 10 Nov 2020 11:06:07 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20201110180719.GA1559650@localhost>
References: <20201110061019.519589-1-vinicius.gomes@intel.com>
 <20201110061019.519589-4-vinicius.gomes@intel.com>
 <20201110180719.GA1559650@localhost>
Message-ID: <871rh19gm8.fsf@intel.com>
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

That's a very interesting idea. I am liking it, need to play with it a
bit, though.

The only "annoying" part would be retrieving multiple samples, see
below.

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

I see your point, in my head the delay being 0 made sense, I took it to
mean that both timestamps were obtained at the same time.

>
> I suspect the estimate would be valid only when the NIC is connected
> directly to the PTM root (PCI root complex). Is it possible to get the
> timestamps or delay from PTM-capable switches on the path between CPU
> and NIC? Also, how frequent can be the PTM dialogs? Could they be
> performed synchronously in the ioctl?

Reading the PTM specs, it could work over PCIe switches (if they also
support PTM).

The NIC I have supports PTM cycles from every ~1ms to ~512ms, and from
my tests it wants to be kept running "in background" always, i.e. set
the cycles to run, and only report the data when necessary. Trying to
only enable the cycles "on demand" was unreliable.

(so for the _EXTENDED case, I would need to accumulate multiple values
in the driver, and report them later, a bit annoying, but not
impossible)

So, no, on my experiments triggering the PTM dialogs and retrieving
information from potentially multiple cycles synchronously with the
ioctl don't seem like it would work.


Cheers,
-- 
Vinicius
