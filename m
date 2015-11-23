From: Jesse Gross <jesse@kernel.org>
Date: Mon, 23 Nov 2015 10:11:57 -0800
Subject: [Intel-wired-lan] [PATCH 0/6] Generalize udp based tunnels and
 add geneve offload
In-Reply-To: <1448262224-71480-1-git-send-email-anjali.singhai@intel.com>
References: <anjali.singhai@intel.com>
 <1448262224-71480-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <CAEh+42j1dxdBydV6NLn8o_VdfnWZC69Z6+6F4razcrY8CsFLiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Nov 22, 2015 at 11:03 PM, Anjali Singhai Jain
<anjali.singhai@intel.com> wrote:
> This patch series generalizes the flow for udp_based tunnels for
> offload hooks. So that much of the frame work can remain common
> for any driver adding support for geneve or any other
> udp_based tunnel in future.
>
> This patch series also makes the driver calls to/from the stack
> independent of the tunnel modules. So it would be easier to remove
> module config parameters from the respective drivers for tunnel
> support. One such example is in i40e driver.
>
> This patch series also adds support for geneve offload in i40e driver.
>
> Much thanks to Jesse Gross for his valuable feedback in getting this
> done the right way.

This series looks nice to me. Thanks a lot for all your work!
