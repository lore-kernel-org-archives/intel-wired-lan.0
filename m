From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 22 Aug 2017 17:30:08 -0700
Subject: [Intel-wired-lan] [PATCH] e1000: changed some expensive calls
 of udelay to usleep_range
In-Reply-To: <1503435747-29639-1-git-send-email-matthew.tan_1@nxp.com>
References: <1503435747-29639-1-git-send-email-matthew.tan_1@nxp.com>
Message-ID: <1503448208.43048.12.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2017-08-22 at 16:02 -0500, nxf23276 wrote:
>     Calls to udelay are not preemtable by userspace so userspace
>     applications experience a large (~200us) latency when running on
> core
>     0. Instead usleep_range can be used to be more friendly to
> userspace
>     since it is preemtable. This is due to udelay using busy-wait
> loops
>     while usleep_rang uses hrtimers instead. It is recommended to use
>     udelay when the delay is <10us since@that precision overhead
> of
>     usleep_range hrtimer setup causes issues. However, the replaced
> calls
>     are for 50us and 100us so this should not be not an issue.
> 
> Signed-off-by: nxf23276 <matthew.tan_1@nxp.com>
> ---
>  drivers/net/ethernet/intel/e1000e/phy.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

First of all, your name is nxf23276?  Really??

Second, you titled your patch that you were makeding changes to e1000
driver, yet you are asking to modify e1000e.  Just based on these 2
needed changes, I am dropping your patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170822/082cc422/attachment.asc>
