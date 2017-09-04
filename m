From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 4 Sep 2017 18:36:02 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: changed some expensive calls
 of udelay to usleep_range
In-Reply-To: <1503503985-3869-1-git-send-email-matthew.tan_1@nxp.com>
References: <1503503985-3869-1-git-send-email-matthew.tan_1@nxp.com>
Message-ID: <fd5c453e-bd2e-3dc7-5f93-5af0ca216fd8@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Matthew,


On 08/23/17 17:59, Matthew Tan wrote:
>      Calls to udelay are not preemtable by userspace so userspace
>      applications experience a large (~200us) latency when running on core
>      0. Instead usleep_range can be used to be more friendly to userspace
>      since it is preemtable. This is due to udelay using busy-wait loops
>      while usleep_rang uses hrtimers instead. It is recommended to use
>      udelay when the delay is <10us since@that precision overhead of
>      usleep_range hrtimer setup causes issues. However, the replaced calls
>      are for 50us and 100us so this should not be not an issue.

Is there a reason for indenting the paragraph. (I guess, you did `git 
show` or `git log -p` and copied the message?) Anyway, please remove 
whitespace in the front, if there is no reason.

Also, it looks like you ran benchmarks, so what is the delay for 
userspace applications with your changes?

> Signed-off-by: Matthew Tan <matthew.tan_1@nxp.com>
> ---
>   drivers/net/ethernet/intel/e1000e/phy.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

[?]


Kind regards,

Paul
