From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Wed, 14 Aug 2019 07:47:26 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v4 2/8] xsk: add support for
 need_wakeup flag in AF_XDP rings
In-Reply-To: <1565767643-4908-3-git-send-email-magnus.karlsson@intel.com>
References: <1565767643-4908-1-git-send-email-magnus.karlsson@intel.com>
 <1565767643-4908-3-git-send-email-magnus.karlsson@intel.com>
Message-ID: <238E96EC-0BE7-461C-8FF8-509997EEBA31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 14 Aug 2019, at 0:27, Magnus Karlsson wrote:

> This commit adds support for a new flag called need_wakeup in the
> AF_XDP Tx and fill rings. When this flag is set, it means that the
> application has to explicitly wake up the kernel Rx (for the bit in
> the fill ring) or kernel Tx (for bit in the Tx ring) processing by
> issuing a syscall. Poll() can wake up both depending on the flags
> submitted and sendto() will wake up tx processing only.
>
> The main reason for introducing this new flag is to be able to
> efficiently support the case when application and driver is executing
> on the same core. Previously, the driver was just busy-spinning on the
> fill ring if it ran out of buffers in the HW and there were none on
> the fill ring. This approach works when the application is running on
> another core as it can replenish the fill ring while the driver is
> busy-spinning. Though, this is a lousy approach if both of them are
> running on the same core as the probability of the fill ring getting
> more entries when the driver is busy-spinning is zero. With this new
> feature the driver now sets the need_wakeup flag and returns to the
> application. The application can then replenish the fill queue and
> then explicitly wake up the Rx processing in the kernel using the
> syscall poll(). For Tx, the flag is only set to one if the driver has
> no outstanding Tx completion interrupts. If it has some, the flag is
> zero as it will be woken up by a completion interrupt anyway.
>
> As a nice side effect, this new flag also improves the performance of
> the case where application and driver are running on two different
> cores as it reduces the number of syscalls to the kernel. The kernel
> tells user space if it needs to be woken up by a syscall, and this
> eliminates many of the syscalls.
>
> This flag needs some simple driver support. If the driver does not
> support this, the Rx flag is always zero and the Tx flag is always
> one. This makes any application relying on this feature default to the
> old behaviour of not requiring any syscalls in the Rx path and always
> having to call sendto() in the Tx path.
>
> For backwards compatibility reasons, this feature has to be explicitly
> turned on using a new bind flag (XDP_USE_NEED_WAKEUP). I recommend
> that you always turn it on as it so far always have had a positive
> performance impact.
>
> The name and inspiration of the flag has been taken from io_uring by
> Jens Axboe. Details about this feature in io_uring can be found in
> http://kernel.dk/io_uring.pdf, section 8.3.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
