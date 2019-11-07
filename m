From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 07 Nov 2019 11:10:44 -0800
Subject: [Intel-wired-lan] [net] igb/igc: use ktime accessors for
 skb->tstamp
In-Reply-To: <20191106171823.30554-1-jacob.e.keller@intel.com>
References: <20191106171823.30554-1-jacob.e.keller@intel.com>
Message-ID: <87k18btscr.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jacob Keller <jacob.e.keller@intel.com> writes:

> When implementing launch time support in the igb and igc drivers, the
> skb->tstamp value is assumed to be a s64, but it's declared as a ktime_t
> value.
>
> Although ktime_t is typedef'd to s64 it wasn't always, and the kernel
> provides accessors for ktime_t values.
>
> Use the ktime_to_timespec64 and ktime_set accessors instead of directly
> assuming that the variable is always an s64.
>
> This improves portability if the code is ever moved to another kernel
> version, or if the definition of ktime_t ever changes again in the
> future.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
