From: Christopher Hall <christopher.s.hall@intel.com>
Date: Fri, 06 Nov 2015 18:15:21 -0800
Subject: [Intel-wired-lan] [PATCH v4 3/4] Add PTP_SYS_OFFSET_PRECISE for
 driver crosstimestamping
In-Reply-To: <20151013135925.GB5422@localhost.localdomain>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
 <1444675522-4198-4-git-send-email-christopher.s.hall@intel.com>
 <20151013135925.GB5422@localhost.localdomain>
Message-ID: <op.x7pkjvdk1774gr@chall-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Richard/Thomas:

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
> this struct too.  It costs us almost nothing, and having that value
> can be useful for characterizing the system oscillator.

Below is my proposal to implement your suggested changes adding monotonic  
raw to the PTP_SYS_OFFSET_PRECISE ioctl:

Move the reserved field to the end and add monotonic raw to
ptp_sys_offset_precise:

struct ptp_sys_offset_precise {
          struct ptp_clock_time dev;
          struct ptp_clock_time sys_real;
          struct ptp_clock_time sys_raw;
          unsigned int rsv[4];    /* Reserved for future use. */
};

In my previous patch, the getsynctime() prototype is:

int (*getsynctime64)(struct ptp_clock_info *ptp, struct timespec64 *dev,
struct timespec64 *sys);

To simplify the PTP callback arguments (not add an additional raw
argument), it seems better to replace all of the arguments with a single
argument:

int (*getsynctime)(struct ptp_clock_info *ptp, struct correlated_ts *cts);

This requires adding a device time field to the correlated timestamp
struct:

struct correlated_ts {
          int                     (*get_ts)(struct correlated_ts *ts);
          u64                     system_ts;
          u64                     device_ts;
          ktime_t                 system_real;
          ktime_t                 system_raw;
+       ktime_t                 device;
          void                    *private;
};

The device time field is filled out by the driver "on the way back"
(following completion of get_correlated_timestamp()) to the PTP driver.

The call flow:

PTP driver-> get_synctime() (Ethernet driver)-> get_correlated_timestamp()
(Timekeeping)->get_ts (Ethernet driver)

The timestamp argument is the same (type struct correlated_ts *) for all
of these calls.

Thanks,
Chris
