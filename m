From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 16 Aug 2021 16:54:38 -0700
Subject: [Intel-wired-lan] [RFC net-next 2/7] selftests/ptp: Add usage
 of PTP_DPLL_GETSTATE ioctl in testptp
In-Reply-To: <20210816160717.31285-3-arkadiusz.kubalewski@intel.com>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
 <20210816160717.31285-3-arkadiusz.kubalewski@intel.com>
Message-ID: <20210816235438.GB24680@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 16, 2021 at 06:07:12PM +0200, Arkadiusz Kubalewski wrote:
> Allow get Digital Phase Locked Loop state of ptp enabled device
> through ptp related ioctl PTP_DPLL_GETSTATE.

So I think this should go into ethtool instead.

Thanks,
Richard
