From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 04 Apr 2019 17:04:36 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v1] igb: Fix limiting the
 number of queues to number of cpus
In-Reply-To: <20190404215632.9881-1-vinicius.gomes@intel.com>
References: <20190404215632.9881-1-vinicius.gomes@intel.com>
Message-ID: <461c66428b411644e78ad5a9a44c47442c9b6edf.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-04-04 at 14:56 -0700, Vinicius Costa Gomes wrote:
> We have seen some reports[1] of users complaining that they aren't
> able to use some queues when their machines have less than 4 cpus.
> This affects some TSN workloads, as different traffic classes are
> assigned different queues. The current behavior limits the number of
> traffic classes that can be reliably handled.
> 
> In practice, what is not working, it returns an invalid parameter
> error, in hosts with less than 4 cpus is something like this:
> 
> $ tc qdisc replace dev IFACE parent root mqprio \
>            num_tc 3 map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
>            queues 1 at 0 1 at 1 2 at 2 hw 0
> 
> Because changing the default logic of the allocation of queues could
> bring other effects, we propose adding a module parameter so expert
> users may override that decision.
> 
> [1] https://github.com/jeez/iproute2/issues/1
> 
> Reported-by: Bhagath Singh Karunakaran <bhagath@kalycito.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
> 
> A similar fix should also be needed for igc, even if I don't have the
> hardware to test, I can produce a patch, if others are able to test.
> 
> I am not totally sure that using a module parameter is the best
> solution, so, suggestions are welcome.
> 
>  drivers/net/ethernet/intel/igb/igb_main.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

A module parameter maybe fine for our out-of-tree driver, but not for the
kernel driver.

NACK on the basis that a new module parameter is being introduced for the
driver.  This is not acceptable by Dave Miller or myself.  As of now, I do
not have a alternative solution to propose unfortunately.

I will discuss the issue with my fellow developers and hopefully we can
come up with a kernel interface that all drivers can use to handle this
issue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190404/e209a11f/attachment.asc>
