From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 16 Aug 2021 16:54:01 -0700
Subject: [Intel-wired-lan] [RFC net-next 1/7] ptp: Add interface for
 acquiring DPLL state
In-Reply-To: <20210816160717.31285-2-arkadiusz.kubalewski@intel.com>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
 <20210816160717.31285-2-arkadiusz.kubalewski@intel.com>
Message-ID: <20210816235400.GA24680@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 16, 2021 at 06:07:11PM +0200, Arkadiusz Kubalewski wrote:
> Previously there was no common interface for monitoring
> synchronization state of Digital Phase Locked Loop.
> 
> Add interface through PTP ioctl subsystem for tools,
> as well as sysfs human-friendly part of the interface.
> 
> enum dpll_state moved to uapi definition, it is required to
> have common definition of DPLL states in uapi.

This has nothing to do with PTP, right?

So why isn't it a RTNL feature instead?

Thanks,
Richard
