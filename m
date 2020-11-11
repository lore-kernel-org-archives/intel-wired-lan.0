From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Wed, 11 Nov 2020 10:33:46 +0100
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <871rh19gm8.fsf@intel.com>
References: <20201110061019.519589-1-vinicius.gomes@intel.com>
 <20201110061019.519589-4-vinicius.gomes@intel.com>
 <20201110180719.GA1559650@localhost> <871rh19gm8.fsf@intel.com>
Message-ID: <20201111093346.GE1559650@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 10, 2020 at 11:06:07AM -0800, Vinicius Costa Gomes wrote:
> Miroslav Lichvar <mlichvar@redhat.com> writes:
> > I suspect the estimate would be valid only when the NIC is connected
> > directly to the PTM root (PCI root complex). Is it possible to get the
> > timestamps or delay from PTM-capable switches on the path between CPU
> > and NIC? Also, how frequent can be the PTM dialogs? Could they be
> > performed synchronously in the ioctl?
> 
> Reading the PTM specs, it could work over PCIe switches (if they also
> support PTM).

I saw some "implementation specific means" mentioned in the spec, so
I'm not sure what and how exactly it works with the existing CPUs,
NICs and PCIe switches. But even if the reported delay was valid only
for directly connected NICs, I think that could still be useful as
long as the user/application can figure out whether that is the case.

> The NIC I have supports PTM cycles from every ~1ms to ~512ms, and from
> my tests it wants to be kept running "in background" always, i.e. set
> the cycles to run, and only report the data when necessary. Trying to
> only enable the cycles "on demand" was unreliable.

I see. It does makes sense if the clocks need to be are synchronized.
For the case of this ioctl, I think it would be better if it we could
just collect the measurements and leave the clocks free running.

> (so for the _EXTENDED case, I would need to accumulate multiple values
> in the driver, and report them later, a bit annoying, but not
> impossible)

I think you could simply repeat the sample in the output up to the
requested number.

I suspect a bigger issue, for both the PRECISE and EXTENDED variants,
is that it would return old data. I'm not sure if the existing
applications are ready to deal with that. With high clock update
rates, a delay of 50 milliseconds could cause an instability. You can
try phc2sys -R 50 and see if it stays stable.

The minimum 1ms cycle you mentioned would probably work better for the
applications.

-- 
Miroslav Lichvar

