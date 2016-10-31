From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 31 Oct 2016 14:30:24 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: handle race between close
 and suspend on shutdown
In-Reply-To: <20161031200034.4729.18959.stgit@localhost6.localdomain6>
References: <20161031200034.4729.18959.stgit@localhost6.localdomain6>
Message-ID: <CAKgT0UckEekjeSPY3nt-nVJKG5RU0YCv9+09kEDYUoHckxmm9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 31, 2016 at 1:00 PM, Emil Tantilov <emil.s.tantilov@intel.com>
wrote:

> When an interface is part of a namespace it is possible that
> ixgbevf_close() may be called while ixgbevf_suspend() is running
> which ends up in a double free WARN and/or a BUG in free_msi_irqs()
>
> This patch introduces a new adapter->state bit that will allow us
> to handle this rate atomically. The idea is that ixgbevf_close() should
> not run if ixgbevf_suspend is in session.
>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
>

I'm pretty sure this isn't the correct fix for this.  You still have the
two technically race against each other because the close could get caught
behind the rtnl lock and then flow through trying to free the interrupt
from it's side.  Also there are scenarios where this can leak interrupts
and such since suspend could set the bit, close could run through take the
rtnl lock, see the bit set so it doesn't free anything, then suspend
resumes and netif_running returns false so you never free the ring
resources.

I think the correct fix for this is to move the rtnl_lock/unlock so that
they are outside of the netif_device_detach() and
ixgbevf_clear_interrupt_scheme() calls that are a part of ixgbevf_suspend.
That way you shouldn't race with close.

It also looks like there is a similar bug in
the ixgbevf_queue_reset_subtask().  It should be taking the rtnl_lock
before checking netif_running, and releasing it at the end of the
function.  You could also add a call to netif_device_present to
ixgbevf_close and if it returns false then just return since the rtnl_lock
will guarantee that if it is set then suspend will have already freed the
resources.

- Alex
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161031/ae8fc41e/attachment.html>
