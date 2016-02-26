From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 25 Feb 2016 19:17:30 -0800
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use fm10k_stats structures
 for per-queue statistics
In-Reply-To: <1456444604-5597-1-git-send-email-jacob.e.keller@intel.com>
References: <1456444604-5597-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <CAKgT0UcSSq9sdAUHkmNuPPG0tLm2U21ZrOVz=y8V+w-g9GFwow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Feb 25, 2016 at 3:56 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> This will allow us numerous advantages, including
>
> (a) rework the per-queue stats to only display active queues, reducing
>     clutter on the output. This is important since we often don't have
>     all possible queues enabled.
>
> (b) use the new streamlined helper functions, reducing duplicate code
>     and increasing readability of the stats logic
>
> (c) add the additional per-tx and per-rx statistics when
>     debug-statistics is enabled, which may be helpful for future debug
>     work.
>
> The primary motivation for this change is (a), though (b) and (c) are
> useful additions which were noticed while developing the change.
>
> Note that this code currently assumes we have the same number of Tx and
> Rx queues which should be true of our driver pretty much always. Even if
> there are a non equal number of Tx and Rx queues, the only result will
> be a few extra statistics displaying 0s. This is better than the current
> setup which shows every disabled queue with all 0s.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

So how does this solve the possible race between changing the number
of queues and the various reads to get either the length of the stats,
the strings, or the actual stats themselves?  The original reason for
having to do the maximum number of queues every time was to account
for the fact that the queues could change between calls so we had to
keep the length fixed.  Was there a new function added that resolved
that or was this overlooked?
