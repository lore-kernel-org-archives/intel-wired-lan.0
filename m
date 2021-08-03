From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 3 Aug 2021 20:27:14 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <CO1PR11MB50892EAF3C871F6934B85852D6F09@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <20210802230921.GA13623@hoboy.vegasvil.org>
 <CAK8P3a2XjgbEkYs6R7Q3RCZMV7v90gu_v82RVfFVs-VtUzw+_w@mail.gmail.com>
 <20210803155556.GD32663@hoboy.vegasvil.org>
 <20210803161434.GE32663@hoboy.vegasvil.org>
 <CAK8P3a2Wt9gnO4Ts_4Jw1+qpBj8HQc50jU2szjmR8MmZL9wrgQ@mail.gmail.com>
 <CO1PR11MB50892EAF3C871F6934B85852D6F09@CO1PR11MB5089.namprd11.prod.outlook.com>
Message-ID: <CAK8P3a06enZOf=XyZ+zcAwBczv41UuCTz+=0FMf2gBz1_cOnZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 3, 2021 at 7:19 PM Keller, Jacob E <jacob.e.keller@intel.com> wrote:
> > On Tue, Aug 3, 2021 at 6:14 PM Richard Cochran <richardcochran@gmail.com> wrote:

> There is an alternative solution to fixing the imply keyword:
>
> Make the drivers use it properly by *actually* conditionally enabling the feature only when IS_REACHABLE, i.e. fix ice so that it uses IS_REACHABLE instead of IS_ENABLED, and so that its stub implementation in ice_ptp.h actually just silently does nothing but returns 0 to tell the rest of the driver things are fine.

I would consider IS_REACHABLE() part of the problem, not the solution, it makes
things magically build, but then surprises users at runtime when they do not get
the intended behavior.

      Arnd
