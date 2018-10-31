From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 30 Oct 2018 19:30:56 -0700
Subject: [Intel-wired-lan] [PATCH v2 net] igb: shorten maximum PHC
 timecounter update interval
In-Reply-To: <20181026171300.12720-1-mlichvar@redhat.com>
References: <20181026171300.12720-1-mlichvar@redhat.com>
Message-ID: <20181031023056.zqb5zl3wgl5fbbju@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 26, 2018 at 07:13:00PM +0200, Miroslav Lichvar wrote:
> The timecounter needs to be updated at least once per ~550 seconds in
> order to avoid a 40-bit SYSTIM timestamp to be misinterpreted as an old
> timestamp.
> 
> Since commit 500462a9de65 ("timers: Switch to a non-cascading wheel"),
> scheduling of delayed work seems to be less accurate and a requested
> delay of 540 seconds may actually be longer than 550 seconds. Also, the
> PHC may be adjusted to run up to 6% faster than real time and the system
> clock up to 10% slower. Shorten the delay to 360 seconds to be sure the
> timecounter is updated in time.
> 
> This fixes an issue with HW timestamps on 82580/I350/I354 being off by
> ~1100 seconds for few seconds every ~9 minutes.

Acked-by: Richard Cochran <richardcochran@gmail.com>
