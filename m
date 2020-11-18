From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 17 Nov 2020 17:21:48 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20201117014926.GA26272@hoboy.vegasvil.org>
References: <20201114025704.GA15240@hoboy.vegasvil.org>
 <874klo7pwp.fsf@intel.com> <20201117014926.GA26272@hoboy.vegasvil.org>
Message-ID: <87d00b5uj7.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Richard Cochran <richardcochran@gmail.com> writes:

> On Mon, Nov 16, 2020 at 05:06:30PM -0800, Vinicius Costa Gomes wrote:
>> The PTM dialogs are a pair of messages: a Request from the endpoint (in
>> my case, the NIC) to the PCIe root (or switch), and a Response from the
>> other side (this message includes the Master Root Time, and the
>> calculated propagation delay).
>> 
>> The interface exposed by the NIC I have allows basically to start/stop
>> these PTM dialogs (I was calling them PTM cycles) and to configure the
>> interval between each cycle (~1ms - ~512ms).
>
> Ah, now I am starting to understand...
>
> Just to be clear, this is yet another time measurement over PCIe,
> different than the cross time stamp that we already have, right?
>

Not so different. This series implement the getcrosststamp() function in
the igc driver, the difference from e1000e (another NIC driver that
supports getcrosststamp()) is that e1000e uses the fact that it has more
or less direct access to the CPU clock. In my case the access is less
direct as it happens via standardized PCIe PTM.

> Also, what is the point of providing time measurements every 1
> millisecond?

I sincerely have no idea. I had no power on how the hardware was
designed, and how PTM was implemented in HW.

>
>> Another thing of note, is that trying to start the PTM dialogs "on
>> demand" syncronously with the ioctl() doesn't seem too reliable, it
>> seems to want to be kept running for a longer time.
>
> So, I think the simplest thing would be to have a one-shot
> measurement, if possible.  Then you could use the existing API and let
> the user space trigger the time stamps.

Agreed that would be easiest/simplest. But what I have in hand seems to
not like it, i.e. I have an earlier series implementing this "one shot" way
and it's not reliable over long periods of time or against having the
system time adjusted.

So I think I am stuck with proposing a new API, if I am reading this
right.

Something like PTP_EXTTS_REQUEST is what was suggested, so
PTP_CROSSTS_REQUEST?

struct ptp_crossts_request {
	unsigned int index;
        struct ptp_clock_time period; /* Desired period, zero means disable */
	unsigned int flags;
	unsigned int rsv[2]; 
};

And a new event type, something like:

struct ptp_extts_event {
	struct ptp_clock_time hostts;
	struct ptp_clock_time devicets;
	unsigned int index;      
	unsigned int flags;      
};


Cheers,
-- 
Vinicius
