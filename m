From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Mar 2018 06:49:21 -0800
Subject: [Intel-wired-lan] [PATCH 1/2] Revert "e1000e: Separate
 signaling for link check/link up"
In-Reply-To: <20180306015553.10441-1-bpoirier@suse.com>
References: <20180306015553.10441-1-bpoirier@suse.com>
Message-ID: <CAKgT0UeuFy4CHZc0TinvFdMPPzBPY_T7bgNk29FiPAktgjm_=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 5, 2018 at 5:55 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> This reverts commit 19110cfbb34d4af0cdfe14cd243f3b09dc95b013.
> This reverts commit 4110e02eb45ea447ec6f5459c9934de0a273fb91.
> This reverts commit d3604515c9eda464a92e8e67aae82dfe07fe3c98.
>
> Commit 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
> changed what happens to the link status when there is an error which
> happens after "get_link_status = false" in the copper check_for_link
> callbacks. Previously, such an error would be ignored and the link
> considered up. After that commit, any error implies that the link is down.
>
> Revert commit 19110cfbb34d ("e1000e: Separate signaling for link check/link
> up") and its followups. After reverting, the race condition described in
> the log of commit 19110cfbb34d is reintroduced. It may still be triggered
> by LSC events but this should keep the link down in case the link is
> electrically unstable, as discussed. The race may no longer be
> triggered by RXO events because commit 4aea7a5c5e94 ("e1000e: Avoid
> receiver overrun interrupt bursts") restored reading icr in the Other
> handler.
>
> Link: https://lkml.org/lkml/2018/3/1/789
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Personally I am not a fan of the !mac->autoneg causing us to return an
error, but that is how the code was before and the error return code
will be ignored anyway.

Thanks for doing all this.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
