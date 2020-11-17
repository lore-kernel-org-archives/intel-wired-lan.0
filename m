From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 16 Nov 2020 17:06:30 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20201114025704.GA15240@hoboy.vegasvil.org>
Message-ID: <874klo7pwp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Richard,

Richard Cochran <richardcochran@gmail.com> writes:

> What is a PTM?  Why does a PTM have dialogs?  Can it talk?
>
> Forgive my total ignorance!

:-)

We are talking about PCIe PTM (Precise Time Measurement), basically it's
a PTP-like protocol running on the PCIe fabric.

The PTM dialogs are a pair of messages: a Request from the endpoint (in
my case, the NIC) to the PCIe root (or switch), and a Response from the
other side (this message includes the Master Root Time, and the
calculated propagation delay).

The interface exposed by the NIC I have allows basically to start/stop
these PTM dialogs (I was calling them PTM cycles) and to configure the
interval between each cycle (~1ms - ~512ms).

I also have access to four time stamps:
 - T1, when the NIC sends the Request message;
 - T2, when the PCIe root received the Request message;
 - T3, when the PCIe root sends the Response message;
 - T4, when the NIC receives the Response message;

Actually, I have T1 (on this cycle), T2 (on this and on the previous
cycle), 'T4 - T1' (on this and on the previous cycle) and 'T3 - T2' (on
the previous cycle).

Another thing of note, is that trying to start the PTM dialogs "on
demand" syncronously with the ioctl() doesn't seem too reliable, it
seems to want to be kept running for a longer time.

I think that's it for a "PCIe PTM from a software person" overview :-)


Cheers,
-- 
Vinicius
