From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 13 Jan 2016 22:31:56 +0100
Subject: [Intel-wired-lan] [PATCH v6 8/9] Add PTP_SYS_OFFSET_PRECISE for
 driver crosstimestamping
In-Reply-To: <1452687149-11281-9-git-send-email-christopher.s.hall@intel.com>
References: <1452687149-11281-1-git-send-email-christopher.s.hall@intel.com>
 <1452687149-11281-9-git-send-email-christopher.s.hall@intel.com>
Message-ID: <20160113213156.GB20252@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 13, 2016 at 04:12:28AM -0800, Christopher S. Hall wrote:
> Currently, network /system cross-timestamping is performed in the
> PTP_SYS_OFFSET ioctl. The PTP clock driver reads gettimeofday() and
> the gettime64() callback provided by the driver. The cross-timestamp
> is best effort where the latency between the capture of system time
> (getnstimeofday()) and the device time (driver callback) may be
> significant.

Looks good to me.

Acked-by: Richard Cochran <richardcochran@gmail.com>
