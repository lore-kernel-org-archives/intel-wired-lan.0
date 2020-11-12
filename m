From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 11 Nov 2020 16:38:16 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20201110180719.GA1559650@localhost>
References: <20201110061019.519589-1-vinicius.gomes@intel.com>
 <20201110061019.519589-4-vinicius.gomes@intel.com>
 <20201110180719.GA1559650@localhost>
Message-ID: <87imab8l53.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Miroslav Lichvar <mlichvar@redhat.com> writes:

> On Mon, Nov 09, 2020 at 10:10:19PM -0800, Vinicius Costa Gomes wrote:
>> i225 has support for PCIe PTM, which allows us to implement support
>> for the PTP_SYS_OFFSET_PRECISE ioctl(), implemented in the driver via
>> the getcrosststamp() function.
>
> Would it be possible to provide the PTM measurements with the
> PTP_SYS_OFFSET_EXTENDED ioctl instead of PTP_SYS_OFFSET_PRECISE?
>
> As I understand it, PTM is not cross timestamping. It's basically
> NTP over PCIe, which provides four timestamps with each "dialog". From
> the other constants added to the header file it looks like they could
> all be obtained and then they could be converted to the triplets
> returned by the EXTENDED ioctl.
>

There might be a problem, the PTM dialogs start from the device, the
protocol is more or less this:

 1. NIC sends "Request" message, takes T1 timestamp;
 2. Host receives "Request" message, takes T2 timestamp;
 3. Host sends "Response" message, takes T3 timestamp;
 4. NIC receives "Response" message, takes T4 timestamp;

So, T2 and T3 are "host" timestamps and T1 and T4 are NIC timestamps.

That means that the timestamps I have "as is" are a bit different than
the expectations of the EXTENDED ioctl().

Of course I could use T3 (as the "pre" timestamp), T4 as the device
timestamp, and calculate the delay[1], apply it to T3 and get something
T3' as the "post" timestamp (T3' = T3 + delay). But I feel that this
"massaging" would defeat the purpose of using the EXTENDED variant.

Does it make sense? Am I worrying too much?

[1] 
	delay = ((T4 - T1) - (T3 - T2)) / 2



Cheers,
-- 
Vinicius
