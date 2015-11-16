From: Jesse Gross <jesse@kernel.org>
Date: Sun, 15 Nov 2015 20:12:19 -0800
Subject: [Intel-wired-lan] [PATCH v5 6/7] net: Add geneve port offload
 support and refactor udp_offload
In-Reply-To: <1447632175-9477-6-git-send-email-anjali.singhai@intel.com>
References: <1447632175-9477-1-git-send-email-anjali.singhai@intel.com>
 <1447632175-9477-6-git-send-email-anjali.singhai@intel.com>
Message-ID: <CAEh+42j9gTifDKqo896xQt=54=UwgzVgr2pfnDUO3uE447P9VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Nov 15, 2015 at 4:02 PM, Anjali Singhai Jain
<anjali.singhai@intel.com> wrote:
> This patch moves the calls to ndo_add/del ops for vxlan tunnel
> into udp_add/del_offload call. This way the ndo_add/del ops get called
> for not only vxlan tunnels but for any udp based tunnel.
>
> Note: The patch needs an AF_INET check somewhere in the GRO ops to
> make it complete.
>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>

This looks great! Thanks a lot of doing this. I have just a couple
comments in this and the other patches but I think they are all really
minor.

I think we need to initialize the offload structure with IPv4/v6 for
both Geneve and FOU and the tunnel type for at least Geneve. I might
have missed it but it looks like we are doing this only for VXLAN (in
a previous patch). I think once we do that, it should be pretty easy
to have the check for AF_INET when we add or remove the port to the
GRO list.

One last thing that I noticed is that the UDP tunnel GRO registration
is not namespace aware but the callers in the various tunnel
implementations are per-namespace, potentially resulting in duplicate
entries in the list. This is not a new problem but it appears a bit
more pronounced because the interfaces to the UDP offload functions
now take the namespace as a parameter.
