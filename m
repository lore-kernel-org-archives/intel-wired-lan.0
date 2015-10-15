From: Christopher Hall <christopher.s.hall@intel.com>
Date: Wed, 14 Oct 2015 19:47:32 -0700
Subject: [Intel-wired-lan] [PATCH v4 3/4] Add PTP_SYS_OFFSET_PRECISE for
 driver crosstimestamping
In-Reply-To: <20151013135925.GB5422@localhost.localdomain>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
 <1444675522-4198-4-git-send-email-christopher.s.hall@intel.com>
 <20151013135925.GB5422@localhost.localdomain>
Message-ID: <op.x6i0pip51774gr@chall-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 13 Oct 2015 06:59:26 -0700, Richard Cochran  
<richardcochran@gmail.com> wrote:

> On Mon, Oct 12, 2015 at 11:45:21AM -0700, Christopher S. Hall wrote:
>>
>> +struct ptp_sys_offset_precise {
>> +	unsigned int rsv[4];    /* Reserved for future use. */
>> +	struct ptp_clock_time dev;
>> +	struct ptp_clock_time sys;
>> +};
>> +
>
> Please put the reserved field at the bottom.  Also, since we reading
> the raw monotonic time under the hood, we might as well return it in

Good idea.

Thanks,
Chris
