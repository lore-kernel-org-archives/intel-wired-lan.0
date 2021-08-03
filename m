From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 3 Aug 2021 08:55:56 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <CAK8P3a2XjgbEkYs6R7Q3RCZMV7v90gu_v82RVfFVs-VtUzw+_w@mail.gmail.com>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <20210802230921.GA13623@hoboy.vegasvil.org>
 <CAK8P3a2XjgbEkYs6R7Q3RCZMV7v90gu_v82RVfFVs-VtUzw+_w@mail.gmail.com>
Message-ID: <20210803155556.GD32663@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 03, 2021 at 08:59:02AM +0200, Arnd Bergmann wrote:
> It may well be a lost cause, but a build fix is not the time to nail down
> that decision. The fix I proposed (with the added MAY_USE_PTP_1588_CLOCK
> symbol) is only two extra lines and leaves everything else working for the
> moment.

Well, then we'll have TWO ugly and incomprehensible Kconfig hacks,
imply and MAY_USE.

Can't we fix this once and for all?

Seriously, "imply" has been nothing but a major PITA since day one,
and all to save 22 kb.  I can't think of another subsystem which
tolerates so much pain for so little gain.

Thanks,
Richard


> I would suggest we merge that first and then raise the question
> about whether to give up on tinyfication on the summit list, there are a few
> other things that have come up that would also benefit from trying less hard,
> but if we overdo this, we can get to the point of hurting even systems that are
> otherwise still well supported (64MB MIPS/ARMv5 SoCs, small boot partitions,
> etc.).
> 
>         Arnd
