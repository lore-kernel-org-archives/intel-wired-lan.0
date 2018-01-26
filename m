From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 25 Jan 2018 18:12:24 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <87607qzxhb.fsf@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <20180118084227.GL1175@localhost> <877es81d9e.fsf@intel.com>
 <20180124030436.sukodrg2t3ckazu6@localhost>
 <87607qzxhb.fsf@intel.com>
Message-ID: <20180126021224.cfu632wbghf6blik@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 24, 2018 at 02:46:24PM -0800, Vinicius Costa Gomes wrote:
> The only robust way that we could think of about keeping the the packets
> in order for the device queue is re-ordering packets in the Qdisc.

Right, but you cannot afford the overhead of the timerqueue when using
HW offload, when the HW device sits on a PCIe bus.  Many serious TSN
applications (like industrial controls) will want to have just one
packet queued, readying the next one just in time for the next
deadline.  The control loops are sensitive to the feedback interval.
 
> Even if we reach a decision that the Qdisc should not re-order packets
> (we wouldn't have any dependency on hrtimers in the offload case, as you
> pointed out), we still need hrtimers for the software implementation.

Fine.
 
> So, I guess, the problem remains, if it's possible for the user to
> express a /dev/ptp* clock, what should we do? 

Thinking a bit more, it doesn't make sense to have a user choice for
the HW offloading case.  The clock should implicitly be the device
clock, always.  Using any other clock would make no sense.

Thanks,
Richard
