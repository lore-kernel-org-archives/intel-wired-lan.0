From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 6 Mar 2018 21:28:49 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 00/18] Time based packet
 transmission
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307052849.droj77rqa7epqvfe@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 06, 2018 at 05:12:12PM -0800, Jesus Sanchez-Palencia wrote:
> Design changes since v2:
>  - Now on the dequeue() path, tbs only drops an expired packet if it has the
>    skb->tc_drop_if_late flag set. In practical terms, this will define if
>    the semantics of txtime on a system is "not earlier than" or "not later
>    than" a given timestamp;
>  - Now on the enqueue() path, the qdisc will drop a packet if its clockid
>    doesn't match the qdisc's one;
>  - Sorting the packets based on their txtime is now an option for the disc.
>    Effectively, this means it can be configured in 4 modes: HW offload or
>    SW best-effort, sorting enabled or disabled;

While all of this makes the series and the configuration more complex,
still I like the fact that the interface offers these different modes.

Looking forward to testing this...

Thanks,
Richard
