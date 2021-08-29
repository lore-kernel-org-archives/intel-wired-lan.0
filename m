From: Richard Cochran <richardcochran@gmail.com>
Date: Sun, 29 Aug 2021 08:10:17 -0700
Subject: [Intel-wired-lan] [RFC v2 net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <20210829080512.3573627-2-maciej.machnikowski@intel.com>
References: <20210829080512.3573627-1-maciej.machnikowski@intel.com>
 <20210829080512.3573627-2-maciej.machnikowski@intel.com>
Message-ID: <20210829151017.GA6016@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Aug 29, 2021 at 10:05:11AM +0200, Maciej Machnikowski wrote:
> This patch adds the new RTM_GETSYNCESTATE message to query the status
> of SyncE syntonization on the device.
> 
> Initial implementation returns:
>  - SyncE DPLL state
>  - Source of signal driving SyncE DPLL (SyncE, GNSS, PTP or External)
>  - Current index of Pin driving the DPLL
> 
> SyncE state read needs to be implemented as ndo_get_synce_state function.
> 
> This patch is SyncE-oriented. Future implementation can add additional
> functionality for reading different DPLL states using the same structure.

I would call this more "ice oriented" than SyncE oriented.  I'm not
sure there is even such a thing as "SyncE DPLL".  Does that term come
from 802.3?  To my understanding, that is one just way of implementing
it that works on super-Gigabit speed devices.

I have nothing against exposing the DPLL if you need to, however I'd
like to have an interface that support plain Gigabit as well.  This
could be done in a generic way by offering Control Register 9 as
described in 802.3.

Thanks,
Richard
