From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 12 Oct 2018 07:05:30 -0700
Subject: [Intel-wired-lan] [PATCH] igb: shorten maximum PHC timecounter
 update interval
In-Reply-To: <20181012111339.1361-1-mlichvar@redhat.com>
References: <20181012111339.1361-1-mlichvar@redhat.com>
Message-ID: <20181012140530.6mjxkb2co3nhl5pf@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 12, 2018 at 01:13:39PM +0200, Miroslav Lichvar wrote:
> Since commit 500462a9d ("timers: Switch to a non-cascading wheel"),
> scheduling of delayed work seems to be less accurate and a requested
> delay of 540 seconds may actually be longer than 550 seconds. Shorten
> the delay to 480 seconds to be sure the timecounter is updated in time.

Good catch.  This timer wheel change will affect other, similar
drivers.  Guess I'll go through and adjust their timeouts, too.

Thanks,
Richard

