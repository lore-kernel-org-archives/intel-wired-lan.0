From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 16 Nov 2020 17:49:26 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <874klo7pwp.fsf@intel.com>
References: <20201114025704.GA15240@hoboy.vegasvil.org>
 <874klo7pwp.fsf@intel.com>
Message-ID: <20201117014926.GA26272@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 16, 2020 at 05:06:30PM -0800, Vinicius Costa Gomes wrote:
> The PTM dialogs are a pair of messages: a Request from the endpoint (in
> my case, the NIC) to the PCIe root (or switch), and a Response from the
> other side (this message includes the Master Root Time, and the
> calculated propagation delay).
> 
> The interface exposed by the NIC I have allows basically to start/stop
> these PTM dialogs (I was calling them PTM cycles) and to configure the
> interval between each cycle (~1ms - ~512ms).

Ah, now I am starting to understand...

Just to be clear, this is yet another time measurement over PCIe,
different than the cross time stamp that we already have, right?

Also, what is the point of providing time measurements every 1
millisecond?

> Another thing of note, is that trying to start the PTM dialogs "on
> demand" syncronously with the ioctl() doesn't seem too reliable, it
> seems to want to be kept running for a longer time.

So, I think the simplest thing would be to have a one-shot
measurement, if possible.  Then you could use the existing API and let
the user space trigger the time stamps.

Thanks,
Richard
