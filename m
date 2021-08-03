From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 3 Aug 2021 08:59:02 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <20210802230921.GA13623@hoboy.vegasvil.org>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <20210802230921.GA13623@hoboy.vegasvil.org>
Message-ID: <CAK8P3a2XjgbEkYs6R7Q3RCZMV7v90gu_v82RVfFVs-VtUzw+_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 3, 2021 at 1:09 AM Richard Cochran <richardcochran@gmail.com> wrote:
>
> On Mon, Aug 02, 2021 at 07:54:20PM +0000, Keller, Jacob E wrote:
> > So go back to "select"?
>
> Why not keep it simple?
>
> PTP core:
>    Boolean PTP_1588_CLOCK
>
> drivers:
>    depends on PTP_1588_CLOCK
>
> Also, make Posix timers always part of the core.  Tinification is a
> lost cause.

It may well be a lost cause, but a build fix is not the time to nail down
that decision. The fix I proposed (with the added MAY_USE_PTP_1588_CLOCK
symbol) is only two extra lines and leaves everything else working for the
moment. I would suggest we merge that first and then raise the question
about whether to give up on tinyfication on the summit list, there are a few
other things that have come up that would also benefit from trying less hard,
but if we overdo this, we can get to the point of hurting even systems that are
otherwise still well supported (64MB MIPS/ARMv5 SoCs, small boot partitions,
etc.).

        Arnd
