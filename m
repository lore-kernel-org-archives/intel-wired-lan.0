From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 13 Oct 2015 15:59:26 +0200
Subject: [Intel-wired-lan] [PATCH v4 3/4] Add PTP_SYS_OFFSET_PRECISE for
 driver crosstimestamping
In-Reply-To: <1444675522-4198-4-git-send-email-christopher.s.hall@intel.com>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
 <1444675522-4198-4-git-send-email-christopher.s.hall@intel.com>
Message-ID: <20151013135925.GB5422@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 12, 2015 at 11:45:21AM -0700, Christopher S. Hall wrote:
>  
> +struct ptp_sys_offset_precise {
> +	unsigned int rsv[4];    /* Reserved for future use. */
> +	struct ptp_clock_time dev;
> +	struct ptp_clock_time sys;
> +};
> +

Please put the reserved field at the bottom.  Also, since we reading
the raw monotonic time under the hood, we might as well return it in
this struct too.  It costs us almost nothing, and having that value
can be useful for characterizing the system oscillator.

Thanks,
Richard
