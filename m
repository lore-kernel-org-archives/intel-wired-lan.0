From: Jesse Gross <jesse@kernel.org>
Date: Sun, 15 Nov 2015 20:12:11 -0800
Subject: [Intel-wired-lan] [PATCH v5 2/7] net: Add a generic
 udp_offload_get_port function
In-Reply-To: <1447632175-9477-2-git-send-email-anjali.singhai@intel.com>
References: <1447632175-9477-1-git-send-email-anjali.singhai@intel.com>
 <1447632175-9477-2-git-send-email-anjali.singhai@intel.com>
Message-ID: <CAEh+42h4-m3e4mtn+DrPGrrG_tnGnRrTTQdms7rETGgWCMX4Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Nov 15, 2015 at 4:02 PM, Anjali Singhai Jain
<anjali.singhai@intel.com> wrote:
> The new function udp_offload_get_port replaces vxlan_get_rx_port().
> This is a generic function that will help replay all udp tunnel ports
> irrespective of tunnel type.
> This way when new udp tunnels get added this function need not change.
>
> Note: Drivers besides i40e are compile tested with this change.
>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>

I think you probably need to move this patch later in the series -
otherwise it won't compile on its own since it references
UDP_TUNNEL_VXLAN, which isn't defined until patch 4.

I somewhat wonder if udp_offload_lock should be converted to a mutex
instead of spinlock since we could potentially hold it while talking
to hardware, which might take a little while. However, this isn't a
new issue - the previous VXLAN lock held while doing this operation
was a spinlock and there shouldn't be too much contention on this
anyways.
