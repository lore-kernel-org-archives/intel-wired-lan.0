From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 3 Aug 2021 13:54:55 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <CAK8P3a2Wt9gnO4Ts_4Jw1+qpBj8HQc50jU2szjmR8MmZL9wrgQ@mail.gmail.com>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <20210802230921.GA13623@hoboy.vegasvil.org>
 <CAK8P3a2XjgbEkYs6R7Q3RCZMV7v90gu_v82RVfFVs-VtUzw+_w@mail.gmail.com>
 <20210803155556.GD32663@hoboy.vegasvil.org>
 <20210803161434.GE32663@hoboy.vegasvil.org>
 <CAK8P3a2Wt9gnO4Ts_4Jw1+qpBj8HQc50jU2szjmR8MmZL9wrgQ@mail.gmail.com>
Message-ID: <20210803205455.GA3517@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On Tue, Aug 03, 2021 at 07:00:49PM +0200, Arnd Bergmann wrote:

> If you turn all those 'select' lines into 'depends on', this will work, but it's
> not actually much different from what I'm suggesting.

"depends" instead of "select" works for me.  I just want it simple and clear.

> Maybe we can do it
> in two steps: first fix the build failure by replacing all the 'imply'
> statements
> with the correct dependencies, and then you send a patch on top that
> turns PPS and PTP_1588_CLOCK into bool options.

Sounds good.

Thanks,
Richard
