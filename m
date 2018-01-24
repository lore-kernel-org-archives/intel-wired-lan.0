From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 23 Jan 2018 19:04:36 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <877es81d9e.fsf@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <20180118084227.GL1175@localhost> <877es81d9e.fsf@intel.com>
Message-ID: <20180124030436.sukodrg2t3ckazu6@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jan 23, 2018 at 01:22:37PM -0800, Vinicius Costa Gomes wrote:
> What I think would be the ideal scenario would be if the clockid
> parameter to the TBS Qdisc would not be necessary (if offload was
> enabled), but that's not quite possible right now, because there's no
> support for using the hrtimer infrastructure with dynamic clocks
> (/dev/ptp*).

We don't need hrtimer for HW offloading.  Just enqueue the packets.  I
thought we agreed that user space get the ordering correct.  In fact,
davem insisted on it, IIRC.

Thanks,
Richard
